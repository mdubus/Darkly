# Faille XSS

## Trouver la faille :

En allant sur la page Feedback (`?page=feedback`), on dispose d'un formulaire permettant d'uploader des commentaires. Après quelques tests, on se rend compte que le formulaire n'est pas protégé et qu'il est donc vulnérable aux failles XSS. On décide alors d'uploader un script bidon pour essayer, et cela fonctionne ! On a notre 3ème flag !

Script : `<script>alert(123)</script>`

![alt text](https://github.com/ssumodhe/Darkly/blob/master/images/xss.png)

```
THE FLAG IS : 0FBB54BBF7D099713CA4BE297E1BC7DA0173D8B3C21C1811B916A3A86652724E
```

## S'en prémunir :

C'est une faille permettant l'injection de code HTML ou JavaScript dans des variables mal protégées.

Pour s'en prémunir:

**Les fonctions**

Il ne faut JAMAIS avoir confiance dans les données qu'on reçoit et TOUJOURS vérifier ces données du coté serveur.

Certaines fonctions permettent d'échapper les symboles du type <, & ou encore ", en les remplaçant par leur équivalent en HTML.
