# Brute Force Signin

## Trouver la faille :

Sur la page `[adresse_ip]/?page=signin`. On a été mis sur cette piste grace à une des table trouvée lors des injection SQL : Member_Brute_Force

### Méthode fastidieuse:

On sait que l'utilisateur `root` existe.
On rentre alors "root" en tant que login.

Pour le mot de passe on consulte les mots de passe les plus couramment utilisés : https://en.wikipedia.org/wiki/List_of_the_most_common_passwords

En les rentrant manuellement un par un on obtiens le flag avec le mot de passe `shadow`. Et Voilà !! 🎉

### Méthode par brute force :

On lance un conteneur Docker avec kali-linux afin d'avoir des outils de hacker 😎
Le conteneur contient le package `hydra`, ainsi qu'une worldlist de mots de passe.

Build le conteneur avec la commande suivante :
`docker build --tag darkly .`

Run le conteneur avec la commande suivante :
`docker run -it darkly`

Une fois connecté au conteneur, la commande suivante nous permet de chercher le bon mot de passe pour se connecter en tant que root. Nous allons la décortiquer :

`hydra 192.168.1.12 -l root -P /usr/share/wordlists/rockyou.txt -F -V -I http-get-form "/index.php:page=signin&username=^USER^&password=^PASS^&Login=Login:S=FLAG"`

- `hydra` : le nom du package qui nous sert à brute force
- `192.168.1.12` : l'adresse IP sur laquelle est disponible le site web à hacker
- `-l root` : le nom d'utilisateur. Ici nous savons qu'il y a un utilisateur root, mais on aurait aussi pu passer une wordlist de noms d'utilisateurs fréquents
- `-P /usr/share/wordlists/rockyou.txt` : Le fichier à utiliser en tant que wordlist (mots de passe à tester)
- `-F` : S'arrêter dès qu'un mot de passe valide est trouvé. Sinon ça peut prendre des heures !
- `-V` : Mode verbose
- `-I` Skip le restore si on a déjà lancé hydra auparavant. Sinon c'est 10 secondes d'attente entre chaque essai !
- `http-get-form` : Le service à utiliser, ici c'est un formulaire en http et en méthode GET, donc on utilise `http-get-form` !
- `"/index.php:page=signin&username=^USER^&password=^PASS^&Login=Login:S=FLAG"` : < url de la page >:< arguments >:< référence pour une tentative échouée >. Pour connaître les arguments à passer, il suffit de faire sur le site web une tentative de connexion qui échoue, et de regarder dans l'URL les paramètres passés. On obtiens par exemple : `?page=signin&username=root&password=test&Login=Login`. On passe donc les arguments dans la requête, en suivant bien les recommandations de la doc (le username devient `^USER^`, le password devient `^PASS^`). En dernier argument on doit indiquer à quel moment la connexion est considérée comme étant un échec. Généralement c'est un texte dans la page (ex : "login / mot de passe incorrect"), mais dans notre cas on a une image. C'est donc un peu plus tricky. La doc nous indique que l'on peut aussi passer un texte qui fait référence en cas de tentative réussie. On peut la passer avec la lettre `S`. On imagine qu'en se connectant on aura un flag, on indique donc `S=FLAG`.

On lance la commande, et on obtiens le résultat suivant :

![alt text](https://github.com/ssumodhe/Darkly/blob/master/images/brute-force-users-hydra.png)

On teste, et le mot de passe est bien `shadow` ! 🎉

```
The flag is : b3a6e43ddf8b4bbb4125e5e7d23040433827759d4de1c04ea63907479a80a6b2
```

## S'en prémunir :

Le principe est simple : un hacker crée un script avec lequel il essaie toutes les combinaisons de mots de passe possibles et imaginables à injecter dans le formulaire/url.

Plusieurs solutions pour s'en prémunir:

**1 - Ralentir le processus**

L'attaque par force brute est une technique relativement courante, mais qui nécessite beaucoup de temps d'exécution.

En ralentissant l'exécution du formulaire en ajoutant une pause de 1 seconde, le pirate sera drôlement embêté ! Alors qu'un utilisateur normal ne verra presque pas la différence.

Cette méthode ralenti tellement qu'il faudrait des milliers d'années avant de trouver un mot de passe basique. Mais il est possible d'exécuter plusieurs formulaires à la fois et le pirate pourra se servir d'un réseau botnet.

C'est donc une bonne technique, mais elle ne vaut pas grand choses si elle est utilisée seule. Bien qu'il ne s'agisse que d'une petite seconde, cela va monopoliser un thread pendant une seconde. Sur un site qui possède un faible trafic, cela ne posera pas trop de problème. Mais si le serveur doit gérer simultanément plusieurs centaines de connexion, cette technique ruine les performances du serveur.

**2 - Le bannissement d'IP**

Cette méthode consiste à limiter le nombre de tentatives par personne et par jour. L'astuce consiste donc à créer une table qu'on appellera connexion et dans laquelle on enregistrera toutes les tentatives ratées de connexions au site.

On y enregistrera alors l'IP de la personne. Au-delà d'un certain nombre de tentatives, l'accès au compte avec cet IP devient impossible pendant un certain temps.

Ou alors, on peut utiliser le service `Fail2ban` qui lit les fichiers de log comme /var/log/pwdfail ou /var/log/apache/error_log et bannit les adresses IP qui ont obtenu un trop grand nombre d'échecs.

**3 - Le captcha**

Une methode consiste à insérer un captcha de vérification dans vos formulaires. C'est presque imparable pour être certain qu'on a à faire à un humain et non à un script (petites cases avec des lettres déformées que vous devez recopier pour confirmer que vous êtes un humain).

## Ressources

> Se proteger de l'attaque par brute force
> https://openclassrooms.com/fr/courses/2091901-protegez-vous-efficacement-contre-les-failles-web/2680183-lattaque-par-force-brute
