library(usethis)
library(dplyr)

# https://r-pkgs.org/code.html très bonne documentation !

path <- file.path("C:/Users/Hassa/Desktop/Repos/TutoCreationPackageR", "MonPremierPackage")
create_package(path) # Pour créer un dossier pour créer un package
# Le dossier contiendra un dossier R, un fichier DESCRIPTION. 
use_git() # Pour créer un repos GitHub

use_mit_license("Mon Nom de package")
use_readme_md() # Pour créer un fichier readme prérempli
use_test("produit") # Pour créer un fichier de test
edit_r("R/produit.R") # Pour créer un fichier

devtools::load_all() # Pour charger les fonctions comme si on chargeait un package pour les tester.
# La fonction ne sera pas présente dans l'environment global.

devtools::check() # Pour vérifier s'il manque des choses comme de la documentation etc..

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

nom_voiture <- mtcars |> rownames() |> as.data.frame()
use_data_raw()
use_data(nom_voiture)

# Il faut documenter la base pour les utilisateurs !

use_roxygen_md()
devtools::document() # == roxygen2::roxygenise()

testthat::test_that(desc = "multiplication fonctionne", 
                    code = {
                      A = 2
                      B = 5
                      testthat::expect_equal(produit(A, B), 10)
                    }
)

edit_file("DESCRIPTION")
use_package("dplyr", type = "Imports")
use_author(
  given = "Mon",
  family = "Blaze",
  role = c("aut", "cre"),
  email = "monmail@example.com"
)


devtools::build() 

devtools::install() # installer un package en developpement en local

