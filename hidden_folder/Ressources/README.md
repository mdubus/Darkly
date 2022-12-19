# Hidden Folder

## Trouver la faille :

Aller sur `[adresse_ip]/robots.txt` On trouve 2 informations importantes :

```
Disallow: /whatever
Disallow: /.hidden
```

En allant sur `[adresse_ip]/.hidden`, on découvre une arborescence de dossiers avec plusieurs README.

On fait un `wget -m -A * -pk -e robots=off http://[adresse_ip]/.hidden/` . On obtient alors un dossier au nom de l'adresse ip, en allant dans le sous-dossier '.hidden' on peut alors faire un `grep -R -E '[0-9]{5,}' .`. On obtient alors la route du fichier où se trouve le flag : `./whtccjokayshttvxycsvykxcfm/igeemtxnvexvxezqwntmzjltkt/lmpanswobhwcozdqixbowvbrhw/README:99dde1d35d1fdd283924d84e6d9f1d820`

```
99dde1d35d1fdd283924d84e6d9f1d820
```

## S'en prémunir :

Sur un site internet, on a souvent envie de bloquer l'utilisation de certaines pages aux clients comme la page admin par exemple

Plusieurs solutions pour s'en prémunir:

**1 - .htaccess**

Afin d'empêcher que n'importe qui accède à des pages on peut très facilement créer une protection par login/mot de passe qui empêche l'accès à tous les fichiers du dossier.

C'est le fichier .htaccess qui permet de dire au serveur qui a le droit d'y accéder ou non.

**2 - Vérifier le role de l'utilisateur**

En effet, au travers des roles définis, des tokens ou des sessions il est facile d'identifier si un utilisateur a accès ou non à une page.
