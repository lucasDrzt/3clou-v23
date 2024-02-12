Voici comment procéder au déploiement avec un VPC :

Il faut copier le fichier VPC et mettre les droits d'exécution avec :

chmod +x ./nom_du_fichier

sur le fichier mk_sshconf.

Puis exécuter les commandes suivantes :

```
make init 
make plan 
make apply
```
et pour suprimer le déploiment :

`make destroy`

Une fois cela fait, récupérez l'IP attribuée au load balancer et connectez-vous dessus via une interface web
