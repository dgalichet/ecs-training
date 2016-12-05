# Initiation à Docker et ECS/ECR

## Préparation du livrable
dans le répertoire `hello-scala` :

```sbt clean compile stage```

Cette opération compile l'application et la package dans le répertoire `target/universal/stage`

## Création d'un repository Docker
Dans la console ECS, choisir le lien ECR et ajoutez un repository

Sur votre instance, récupérez les credentials pour le docker registry ECR via la commande:
```eval `aws ecr get-login --region eu-west-1````

## Création d'un container
Dans le répertoire `training-demo` nous allongs créer le container hello-scala
 ```docker build -t <your-company>/hello-scala:1.0 .```

## Test du container
Utilisez la commande suivante pour vous assurer que le container démarre correctement
```docker run -p 9000:9000 <your-company>/hello-scala```

Vérifiez ensuite que le container fonctionne comme prévu à l'aide d'un curl
```curl 'http://localhost:9000'```

## Publication du container dans ECR
faire un tag pour rattacher le container à ECR
```docker tag <your-company>/hello-scala:1.0 123456789012.dkr.ecr.eu-west-1.amazonaws.com/hello-scala:latest```

```docker push 123456789012.dkr.ecr.eu-west-1.amazonaws.com/hello-scala:1.0```


