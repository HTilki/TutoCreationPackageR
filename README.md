# Le notebook peut être visualisé en cliquant [ici](https://htmlpreview.github.io/?https://github.com/HTilki/TutoCreationPackageR/blob/main/TutoCreationPackageR.html) ! 

## Introduction

### Pourquoi créer un package ?

Créer un package sur R présente plusieurs avantages :

-   **Accessibilité des fonctions** : Les utilisateurs peuvent facilement accéder aux fonctions que vous avez développées en chargeant simplement le package.

-   **Facilité de chargement** : Ne plus avoir à utiliser la fonction `source()` pour charger des fonctions individuelles, simplifiant ainsi le processus.

-   **Documentation** : La possibilité d'ajouter une documentation complète pour les fonctions et les paramètres, facilitant ainsi leur utilisation et leur compréhension.

-   **Partage facile** : Permet de partager facilement votre travail avec des collègues ou la communauté R, favorisant ainsi la collaboration et la reproductibilité.

### Dépendances nécessaires

Avant de commencer à créer un package, assurez-vous d'avoir installé les packages suivants, qui sont indispensables pour le processus :

-   **devtools** : Pour faciliter le développement et le déploiement de packages R.

-   **roxygen2** : Pour générer automatiquement la documentation à partir des commentaires dans le code source.

-   **usethis** : Pour automatiser plusieurs tâches liées au développement de packages, telles que la création de fichiers et la gestion des dépendances.

-   D'autre packages existent, à vous de les découvrir !

### MonPremierPackage
Le dossier *MonPremierPackage* a été créé à partir du code présenté ci-dessous et dans le fichier *script.R*. Il s'agit d'un court exemple de ce que l'on peut faire avec les différentes libraries disponibles.  

## Inititalisation du package

L'initialisation d'un package sur R est une étape cruciale pour commencer un projet de développement. Pour ce faire, on peut utiliser une série de fonctions facilitant la création et la configuration de la structure du package.

Tout d'abord, on peut utiliser la fonction `create_package()` pour créer un dossier dédié au package. Ce dossier comprendra un sous-dossier "R" contenant les fichiers de code, ainsi qu'un fichier "DESCRIPTION" contenant les métadonnées importantes du package.

Ensuite, pour une gestion de version efficace et une collaboration simplifiée, on peut initialiser un dépôt GitHub en utilisant la fonction `use_git()`. Cela permettra de versionner le code et de le partager facilement avec d'autres personnes.

Pour assurer une clarté et une accessibilité maximales pour les utilisateurs du package, on peut générer un fichier README prérempli en utilisant la fonction `use_readme_md()`. Ce fichier README servira de point d'entrée pour les utilisateurs, leur fournissant des informations importantes sur l'installation, l'utilisation et les fonctionnalités du package.

Enfin, pour définir la licence de votre package, on peut utiliser la fonction `use_..._license()`. Cela garantira une utilisation appropriée du code par d'autres utilisateurs.

En utilisant ces fonctions d'initialisation, on peut rapidement mettre en place la structure du package R et commencer le développement en toute confiance.

## Le contenu d'un package

### Les fonctions

Dans cette partie, nous allons commencer à créer notre package en développant des fonctions.

Créons une fonction simple permettant de réaliser le produit entre deux nombres.

On va créer un fichier produit.R avec le package `usethis` qui va contenir la fonction suivante :

```{r}
usethis::use_r("produit.R") # Pour créer le fichier produit.R
```

Dans ce fichier on écris la fonction suivante :

```{r}
produit <- function(a, b) {
  return(a * b)
}
```

En tant normal si l'on veut utiliser une fonction présente dans un autre fichier R on peut utiliser la fonction `source("nom_du_fichier.R")`, qui va tout simplement executer le code R présent dans le fichier. Le code et tout ce qu'il contient (objets, fonctions...) se retrouve finalement dans l'environnement globale ou chargée (pour les packages).

Cette méthode, bien qu'utile dans certains cas, ne possède pas les avantages d'un package comme la documentation.

### La documentation

D'ailleurs en parlant de documentation, comment la renseigne t-on ?

Pour documenter une fonction, on peut utiliser la syntaxe Roxygen2 dans le code source de la fonction. Voici un exemple de documentation pour la fonction `produit` :

```{r}
#' Calculer le produit de deux nombres
#'
#' Cette fonction prend deux nombres en entrée et retourne leur produit.
#'
#' @param a Le premier nombre à multiplier
#' @param b Le deuxième nombre à multiplier
#'
#' @return Le produit de \code{a} et \code{b}
#'
#' @examples
#' produit(2, 3) # Renvoie 6
#' produit(5, -4) # Renvoie -20
#'
#' @export
produit <- function(a, b) {
  return(a * b)
}
```

Dans cette documentation Roxygen2 :

La première ligne est une sorte de titre pour la fonction. La deuxième correspond à la description de la fonction.

-   `#'` est utilisé pour indiquer le début d'un commentaire de documentation Roxygen2.
-   Les lignes qui commencent par `#' @` sont des balises Roxygen2 qui définissent différents aspects de la documentation.
-   `\code{}` est utilisé pour indiquer du texte en code dans la documentation.
-   `@param` est utilisé pour décrire les paramètres de la fonction.
-   `@return` est utilisé pour décrire la valeur renvoyée par la fonction.
-   `@examples` est utilisé pour fournir des exemples d'utilisation de la fonction.
-   `@export` indique que la fonction doit être exportée pour être accessible à partir du package.
-   Il en existe bien d'autres !

Une fois la documentation bien renseigné, il suffit d'executer la fonction `roxygen2::roxygenise()` ou la fonction `devtools::document()` qui est un wrapper de la fonction issue de `roxygen2`.
Ces fonctions analysent les commentaires de documentation Roxygen2 présents dans votre code source, situé dans le dossier *R*, et génèrent automatiquement les fichiers de documentation au format Rd (R documentation) dans un dossier *man*. 


### Les tests de fonctions

Avant de rédiger des tests, on peut utiliser les fonctions du package sans les importer dans l'environnement global à l'aide de la fonction `load_all`.

On peut tester nos fonctions à l'aide du package testthat qui est très bien construit et documenté !

Voici un exemple ici sur la fonction produit :

```{r}
testthat::test_that(desc = "multiplication fonctionne", 
                    code = {
                      A = 2
                      B = 5
                      testthat::expect_equal(produit(A, B), 10)
                    }
)
```

Une fois que l'on a fini d'écrire le test, on peut vérifier qu'il fonctionne bien en le testant !

Pour ce faire, la fonction `test()` exécute tous les tests situés dans le dossier tests/testthat. Toute modification apportée au code doit être suivie de l'exécution de `test()` pour s'assurer que l'on ne casse pas les fonctionnalités existantes.

### Inclure une base de données

Il existe plusieurs façon d'intégrer des bases de données à un package R mais la plus communément utilisé est la suivante :

Avoir un fichier R dans un dossier data-raw qui contient le code permettant de créer / obtenir / nettoyer la base finale. Par exemple :

```{r}
nom_voiture <- mtcars |> rownames() |> dplyr::as_tibble() |> dplyr::rename(nom = value)
usethis::use_data(nom_voiture)
```

La fonction use_data permet de créer un dossier data et de stocker la base data_nom_voiture dans un fichier *.rda* portant le même nom.

On peut penser que l'on en a fini avec cette base de données mais on peut (et il est aussi recommandé) de la documenter afin d'améliorer l'expérience des utilisateurs. Le tout en utilisant le même principe qu'avec une fonction R.

Dans le dossier R, on a un fichier data.R qui contient :

```{r}
#' Noms des voitures
#'
#' Ce jeu de données contient les noms des voitures à partir du jeu de données mtcars.
#'
#' @format Un data frame avec une seule colonne :
#'   \describe{
#'     \item{nom}{Le nom de la voiture.}
#'   }
#' @source mtcars dataset
#'
#' @examples
#' head(data_nom_voiture)
#'
#' @keywords datasets
"data_nom_voiture"

```

Une fois la documentation renseignée, on peut à nouveau et de la même manière qu'avec un script de fonction, executer la fonction `devtools::document()` afin de mettre à jour la documentation du package.

### La description du package

La section "DESCRIPTION" dans un package R est cruciale car elle fournit des informations essentielles sur le package, telles que son nom, sa version, son auteur et sa licence. Le fichier DESCRIPTION est l'endroit où ces informations sont stockées. En utilisant des fonctions telles que `edit_file("DESCRIPTION")`, vous pouvez facilement créer ou modifier ce fichier. Il est également recommandé d'utiliser des fonctions telles que `use_package()` pour ajouter des dépendances et `use_author()` pour spécifier les informations sur l'auteur. En résumé, le fichier DESCRIPTION et les fonctions associées sont essentiels pour maintenir la structure et la qualité du package.

```{r}
edit_file("DESCRIPTION") # Pour créer ou modifier le fichier DESCRIPTION
use_package("dplyr", type = "Imports") # Pour ajouter des dépendances
use_author(
  given = "Prénom",
  family = "Nom",
  role = c("aut", "cre"),
  email = "monmail@example.com"
)
```

## Exporter le package

Après avoir effectué des vérifications avec `check()` et confirmé l'absence de warnings ou d'erreurs, l'utilisation de `devtools::build()` est nécessaire pour construire et exporter le package dans un fichier tar.gz. De plus, il existe d'autre option pour le déploiement du package. On peut en effet les déployer sur le CRAN, ou sur Github.

## Utiliser le package

Il existe plusieurs méthodes pour importer un package. Tout d'abord, on peut l'installer à partir d'un fichier tar.gz ou directement depuis le CRAN en utilisant la fonction `install.package('nom_du_package', ...)`. Alternativement, on peut l'installer à partir de GitHub en utilisant la fonction `devtools::install_github("nomdurepos")`. Ces options offrent une flexibilité dans l'installation des packages, permettant à chacun de choisir la méthode qui lui convient le mieux en fonction de ses besoins et de ses préférences.

Pour l'utiliser ensuite, on peut soit l'importer avec `library('nomdupackage')` ou en ne chargeant pas le package en entier, mais en utilisant une fonction spécifique avec `package::fonction()`.

## Maintenir le package

[![](https://r-pkgs.org/diagrams/workflow.png)](https://r-pkgs.org/)

Après avoir ajouté de nouvelles fonctionnalités, il est essentiel de tester le package en utilisant `load_all` et `check()`. Ensuite, on peut ajouter une documentation détaillée avec `document` pour guider les utilisateurs sur l'utilisation du package. Pour mettre à jour le package, on peut aussi actualiser le dépôt GitHub ou reconstruire le package avec `build`. On peut également utiliser `usethis` pour créer des notes de version et effectuer des mises à jour mineures ou majeures. Les possibilités de création, personnalisation, modification, test et maintenance d'un package sur R sont pratiquement infinies. Cet aperçu a résumé les fonctionnalités essentielles pour bien démarrer, mais je vous recommande de consulter la [documentation officielle](https://r-pkgs.org/code.html) pour plus de détails.
