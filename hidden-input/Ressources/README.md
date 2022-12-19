# Hidden input

## Trouver la faille :

En allant sur la page de récupération de mot de passe (`?page=recover`), on voit un bouton Submit. Au click dessus, on nous indique `wrong answer`. On décide alors de revenir sur la page avec le bouton submit, et d'inspecter le code (click droit -> inspecter élément).
On voit alors le code suivant :

```
<input type="hidden" name="mail" value="webmaster@borntosec.com" maxlength="15">
<input type="submit" name="Submit" value="Submit">
```

Il y a bien un input, mais qui était caché à cause du `type="hidden`. On décide de remplacer sa value par n'importe quoi d'autre, et de submit.
On obtiens notre deuxième flag !

![alt text](https://github.com/ssumodhe/Darkly/blob/master/images/hidden-input.png)

```
THE FLAG IS : 1D4855F7337C0C14B6F44946872C4EB33853F40B2D54393FBE94F49F1E19BBB0
```

## S'en prémunir :

Comme pour get_param, le souci ici est la gestion de données reçues.

Plusieurs solutions pour s'en prémunir:

**1 - Verifier les parametres**

Il ne faut JAMAIS avoir confiance dans les données qu'on reçoit. Il faut donc tout le temps tester la presence des paramètres, à défaut de quoi il faudra mettre en place une gestion d'erreur (redirection, message d'erreur, ...)

**2 - Controler les parametres**

En effet, au delà de la présence des paramètres il faut également vérifier le type de ceux-ci.

**3 - Limiter l'utilisation des type hidden**

L'utilisation des input type hidden peut être très pratique mais il faut les utiliser avec beaucoup de méfiance et ne surtout pas les utiliser pour des informations importantes.
