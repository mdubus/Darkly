# Get param

## Trouver la faille :

Sur la page d'accueil, lorsque l'on cherche les `href` dans le code source on repere plusieurs route, notamment:

- ?page=[qqchose] (DEAD END)
- ?page=redirect&site=[redirection]

Sur cette deuxième route, lorsque l'on remplace la redirection par 'admin' (`?page=redirect&site=admin`): on trouve un flag!! 🎉

```
GOOD JOB HERE IS THE FLAG : B9E775A0291FED784A2D9680FCFAD7EDD6B8CDF87648DA647AAF4BBA288BCAB3
```

## S'en prémunir :

Le souci ici est la gestion des parametres dans l'URL

Plusieurs solutions pour s'en prémunir:

**1 - Verifier les paramètres**

Il ne faut JAMAIS avoir confiance dans les données qu'on reçoit. Il faut donc tout le temps tester la presence des parametres, à defaut de quoi il faudra mettre en place une gestion d'erreur (redirection, message d'erreur, ...)

**2 - Controler les paramètres**

En effet, au delà de la présence des paramètres il faut également vérifier le type de ceux-ci.
