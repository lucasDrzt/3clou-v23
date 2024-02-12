Voici comment faire le déploiment avec un VPC 

il faut copier le fichier vpc mettre les droits d'exécution avec :

`chmod +x ./nom_du_fichier`

sur le fichier "mk_sshconf" 

puis faire les commandes suivante :

```
make init 
make plan 
make apply
```
et pour suprimer le déploiment :

`make destroy`

Une fois  cela fait récupérer l'IP attribuer au loadbalencer et conecter vous decu via une interface web
