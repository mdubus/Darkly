# Cookie

## Trouver la faille :

Depuis n'importe quelle page du site, on ouvre les cookies et on y trouve un cookie `I_am_admin` avec un hash `68934a3e9455fa72420237eb05902327` comme contenu.

Lorsque l'on rentre le hash dans `https://md5hashing.net/` on obtient 'false' en md5. Toujours sur ce site, on cherche alors le hash md5 de la valeur 'true' et on obtient `b326b5062b2f0e69046810717534cb09`.

On retourne sur notre site, sur la page `/index.php?page=signin` par exemple où on peut écrire une fonction setCookie en JS pour réécrire le cookie avec cette fois le hash de la valeur true. On peut alors soumettre le formulaire du signin avec n'importe quelle valeur et BINGO !! 🎉

```
Good job! Flag : df2eb4ba34ed059a1e3e89ff4dfc13445f104a1a52295214def1c4fb1693a5c3
```

## S'en prémunir :

Un cookie est un petit fichier texte, qui est stocké par un site web sur votre disque dur. Ce stockage est réalisé par votre navigateur. Cela est utilisé par le site web que vous visitez pour vous "reconnaître" ou stocker des informations vous concernant.

Il est placé dans l'entête HTTP de la requête (dans le champs Cookie, en clair) qui permet au serveur de traiter les données.

Plusieurs solutions pour s'en prémunir:

- Ne jamais stocker les informations concernant l'authentification de l'internaute en clair ou encodé.  
  -Si vous utilisez un ID de session, ne jamais faire un ID incrémenté "simplement".
- Utilisez un ID de session aléatoire. En effet, là où un simple hash n'est pas sécurisé, crypter plus efficacement les cookies empechera un hacker de découvir les données.
- Utilisez un ID de session à chaque requête HTTP.
- Utiliser un système de dé-login qui efface le cookie.
- Vérifiez que vos cookies ne sont pas sensible à une replay attack (qu'une autre personne puisse utiliser les cookies d'un utilisateur).
- Chiffrer les cookies : Un cookie peut être chiffré en partie ou en totalité. Mais attention, utilisez un chiffrement fort !
- Utilisez des protocoles sécurisés comme HTTPS.
- En aucun cas, un cookie ne doit être utilisé pour reconnaître automatiquement un internaute. Au mieux, un internaute devra, à chaque visite de votre site, s'authentifier pour recevoir un nouveau cookie.
- Httponly permet d'eviter les manipulations Javascript du cookie

## Ressources :

> Les cookies et sécurité
> https://www.securiteinfo.com/conseils/cookies.shtml

> HttpOnly
> https://www.owasp.org/index.php/HttpOnly
