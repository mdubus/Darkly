# Modif Value Select Survey

## Trouver la faille :

Sur la page `[adresse_ip]/?page=survey` On sélectionne une des options du select. On inspect l'option séléctionnée et on modifie la valeur de celle-ci.

On obtient le flag après avoir soumit le formulaire. Et Voilà !! 🎉

```
The flag is : 03a944b434d5baff05f46c4bede5792551a2595574bcafc9a6e25f67c382ccaa
```

## S'en prémunir :

Le souci ici est la gestion de données reçues.

**Verifier les données reçues**

Il ne faut JAMAIS avoir confiance dans les données qu'on reçoit et TOUJOURS vérifier ces données du coté serveur.
