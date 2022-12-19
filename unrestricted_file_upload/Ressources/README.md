# Unrestricted File Upload

## Trouver la faille :

Sur la page `http://<ip>/?page=upload`, on a un formulaire qui permet d'envoyer une image. En essayant d'uploader plusieurs types de fichiers, on en conclue que l'on ne peut envoyer que des fichiers JPG.

On va donc tenter d'uploader un script php à la place d'une image. On teste plusieurs méthodes (uploader un fichier `malicious.php.jpg`, renommer le fichier lors de l'envoi, ...) qui s'avèrent infructueuses.
Une méthode fonctionne cependant : changer le type de fichier directement lors de l'upload. On fait croire au formulaire qu'il reçois un fichier JPG au lieu d'un fichier PHP !

Le formulaire est de la forme suivante :

```
<input name="uploaded" type="file">
<input type="submit" name="Upload" value="Upload">
```

La commande CURL :

`curl -F "uploaded=@test.php;type=image/jpeg" -F Upload=Upload "http://192.168.86.43/?page=upload" | grep "flag"`

Explications :

- `-F` : indique que l'on veut interagir avec un champ du formulaire.
- `"uploaded=@test.php;type=image/jpeg"` : `uploaded` correspond au `name` de l'input de type file. On lui indique le fichier que l'on veut "lier" à ce champ avec `@test.php`, "@" indiquant que c'est un fichier local. Le `type=image/jpeg` sert à "tricher" et faire croire au formulaire qu'il s'agit d'un fichier de type jpeg.
- `Upload=Upload` : Le premier `Uploaded` correspond au `name` du champ de type submit. Le second `Uploaded` correspond à sa valeur. Sans ce paramètre, le formulaire ne pourrait jamais se submit !

On obtiens le flag suivant : 46910d9ce35b385885a9f7e2b336249d622f29b267a1771fbacf52133beddba8

![alt text](https://github.com/ssumodhe/Darkly/blob/master/images/unrestricted-file-upload.png)

## S'en prémunir :

Plusieurs pistes s'offrent à nous pour nous protéger efficacement de ce type de faille. On peut lister, entre autre :

- Mettre une whitelist des extensions autorisées
- Passer un "Content-Type" dans le Header avec le ou les types autorisé(s)
- Utiliser un détecteur de types de fichiers
- Renommer les fichiers uploadés (pour évites les attaques avec des fichiers du style `malicious.php.jpg`)

En savoir plus :

- https://www.owasp.org/index.php/Unrestricted_File_Upload
- https://openclassrooms.com/fr/courses/2091901-protegez-vous-efficacement-contre-les-failles-web/2680177-la-faille-upload
