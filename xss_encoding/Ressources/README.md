# XSS Encoding

## Trouver la faille :

En étant sur la home et en cliquant sur l'image de la NSA, on arrive sur une page `http://192.168.1.64/?page=media&src=nsa`. 
On essaie donc de jouer avec les paramètes, notamment le `src` en passant des paths, du texte, etc... 

En regardant la doc de l'OWASP, on se rend compte qu'on peut faire des failles XSS directement avec l'`alert` encodé et le passer en tant que contenu dans une URL (https://www.owasp.org/index.php/Cross-site_Scripting_(XSS)). 

On va donc tenter d'injecter une `alert` dans le src :

`http://192.168.1.64/?page=media&src=url=data:text/html;base64,PHNjcmlwdD5hbGVydCgnSmUgc3VpcyB1bmUgaGFja2VyIScpPC9zY3JpcHQ+`

Ça fonctionne ! !

The flag is : `928D819FC19405AE09921A2B71227BD9ABA106F9D2D37AC412E9E5A750F1506D`

## S'en prémunir :

C'est une faille permettant l'injection de code HTML ou JavaScript dans des variables mal protégées.

Pour s'en prémunir:

**Les fonctions**

Il ne faut JAMAIS avoir confiance dans les données qu'on reçoit et TOUJOURS vérifier ces données du coté serveur.

Certaines fonctions permettent d'échapper les symboles du type <, & ou encore ", en les remplaçant par leur équivalent en HTML.

## Ressources

> https://www.ibm.com/developerworks/library/se-prevent/index.html
> https://www.we45.com/blog/preventing-xss-with-base64-encoding-the-false-sense-of-web-application-security