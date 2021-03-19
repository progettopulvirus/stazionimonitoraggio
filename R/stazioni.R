#' Anagrafica delle stazioni di monitoraggio
#'
#' @format Un tibble co 822 righe e 27 colonne
#'
#' @description 
#' Le colonne o3, co, no2, nox, pm10, pm25, c6h6 forniscono informazioni sulla completezza delle serie. IN particolare: 
#' serie complete solo 2020 sono serie che rispettano i criteri di completezza mensile nel periodo gennaio - maggio 2020
#' serie complete 2016 - 2020 sono le serie che rispettano i criteri di completezza per tutto il periodo 2016 - 2020
#' Tutte le altre voci specificano il motivo per cui una serie non e' considerata completa. NA compare per le serie che non hanno dati per lo specifico inquinante.
#' 
#' @usage
#' stazioni
"stazioni"

