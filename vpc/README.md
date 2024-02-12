Voici comment faire le déploiment avec un VPC 

il faut copier le fichier vpc mettre les droits d'exécution avec :

`chmod +x ./nom_du_fichier`

sur le fichier "mk_sshconf" 

puis faire les commandes suivante :

`
make init
make plan
make apply
`
