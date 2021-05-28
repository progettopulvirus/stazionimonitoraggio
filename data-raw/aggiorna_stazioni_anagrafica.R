#crea colonne sulla completezza in  dataframe stazioni, pacchetto stazioniMonitoraggio utilizzando i file stazioniValide e stazioniNonValide...csv creati dallo script R "completezzaSerie.R"
#sostituisce nel dataframe stazioni le colonne degli inquinanti e salva un oggetto RDS con la nuova anagrafica. Questa deve sostituire la vecchia anagrafica
rm(list=objects())
library("tidyverse")
library("stazioniMonitoraggio")

list.files(pattern="^stazioniNonValide.+csv")->ffile


purrr::map_dfr(ffile,.f=function(nomeFile){
  
  

  read_delim(nomeFile,delim=";",col_names = FALSE)->dati
  names(dati)<-c("station_eu_code","completezza","regione")
  
  str_remove(str_remove(nomeFile,"stazioniNonValide_"),"\\.csv")->inquinante
  
  dati$inquinante<-inquinante
  
  dati
  
})->datiNonValidi

list.files(pattern="^stazioniValide.+csv")->ffile_valide


purrr::map_dfr(ffile_valide,.f=function(nomeFile){
  
  

  read_delim(nomeFile,delim=";",col_names = FALSE)->dati
  names(dati)<-c("station_eu_code","regione")
  dati$completezza<-"completa 2016-2020"
  str_remove(str_remove(nomeFile,"stazioniValide_"),"\\.csv")->inquinante
  
  dati$inquinante<-inquinante
  
  dati
  
})->datiValidi


bind_rows(datiNonValidi,datiValidi) %>%
  tidyr::spread(key=inquinante,value=completezza)->info_completezza


stazioni[,((names(stazioni) %in% names(info_completezza[,! names(info_completezza) %in% c("station_eu_code","regione")])))]->nomiInquinanti



left_join(stazioni[,!names(stazioni) %in% names(nomiInquinanti)],info_completezza)->nuoveStazioni
saveRDS(nuoveStazioni,"stazioni_new.RDS")