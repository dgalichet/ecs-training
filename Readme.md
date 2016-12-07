# Initiation à Docker et ECS/ECR

## 1. Préparation du livrable
dans le répertoire `hello-scala` :

```sbt clean compile stage```

Cette opération compile l'application et la package dans le répertoire `target/universal/stage`.
*Cette compilation peut prendre un peu de temps. Passez à l'étape suivante pendant la compilation.*

## 2. Création d'un repository Docker
Dans la console ECS, choisir le lien ECR et ajoutez un repository (par exemple : `hello-ecs`).

Ajoutez une custom IAM Policy afin de pouvoir accèder à votre Registry ECR depuis votre instance EC2:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:BatchGetImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:PutImage"
            ],
            "Resource": "arn:aws:ecr:eu-west-1:<account_id>:repository/<repository_name>"
        }
    ]
}
```

Sur votre instance, récupérez les credentials pour le docker registry ECR via la commande:
```eval `aws ecr get-login --region eu-west-1````

## 3. Création d'un container
Dans le répertoire `training-demo` nous allongs créer le container hello-scala
 ```docker build -t <your-company>/hello-scala:1.0 .```

Vous pouvez constater que votre image à bien été créé:
```docker images```

## 4. Test du container
Utilisez la commande suivante pour vous assurer que le container démarre correctement
```docker run -d -p 9000:9000 <your-company>/hello-scala:1.0```

Vérifiez ensuite que votre container est démarré (notez le container_id dans la première colone):
```docker ps```

Vérifiez ensuite que le container fonctionne comme prévu à l'aide d'un curl
```curl 'http://localhost:9000'```

Stoppez enfin votre container:
```docker stop <container_id>```

## 5. Publication du container dans ECR
faire un tag pour rattacher le container à ECR
```docker tag <your-company>/hello-scala:1.0 <account_id>.dkr.ecr.eu-west-1.amazonaws.com/hello-scala:1.0```

```docker push <account_id>.dkr.ecr.eu-west-1.amazonaws.com/hello-scala:1.0```

Vérifiez enfin dans la console ECR que la version à bien été ajouté.

