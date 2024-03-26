## code pour nettoyer/créer la base par exemple

nom_voiture <- dplyr::as_tibble(mtcars |> rownames()) |> dplyr::rename(nom = value)
usethis::use_data(nom_voiture)
