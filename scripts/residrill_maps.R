library(readxl)
library(tidyverse)
library(ggforce)
library(viridis)
library(clhs)
library(ggpubr)
set.seed(90109)

# STATION CREEK
station_creek <- read_excel("/Users/abbeyyatsko/Downloads/stck_totalbiomass.xlsx",sheet = 1,trim_ws = TRUE)

station_creek %>%
  count(species) %>%
  mutate(rank_abundance=rank(-n,ties="first"))->rank

station_creek %>%
  mutate(radius_cm= dbh_cm/2,
         area_cm2=pi*radius_cm^2,
         basal_area = ((pi * (dbh_cm/2))^2/144), rank_basal_area= cume_dist(basal_area)) %>%
  left_join(rank) -> station_creek

#sampling with a latin hypercube design
station_creek %>%
  select(dbh_cm, n) -> sc
res <- clhs(sc, size = 32, iter = 2000, progress = FALSE)
station_creek$samples <- ifelse(row.names(station_creek) %in% res, yes ="S", no = "")
station_creek$samples[station_creek$n == 1] <- "S"

stck <- ggplot(station_creek,aes(x= x_coord, y= y_coord,colour= fct_reorder(species,rank_abundance)))+
  geom_jitter(aes(size=area_cm2))+
  labs(title = "Station Creek")+
  scale_colour_viridis_d(option = "D")+
  #geom_point(aes(size=radius_cm))+
  #scale_radius(range=c(0,30))
  geom_text(aes(label= samples), colour ="red", size =5)+
  scale_size_area()+
  theme_linedraw()+
  theme(panel.grid = element_line("black",size = 5))
#geom_circle(aes(x0=x_coord, y0=y_coord, r= radius_cm))

ggsave(filename = "downloads/station_creek_live_biomass.pdf",plot = stck, width = 9.03, height = 6.37)

# station_creek %>%
#   select(species, x_coord, y_coord, dbh_cm, samples,notes) %>%
#   arrange(y_coord,x_coord)-> station_creek
# write_csv(station_creek, "output/station_creek_live_biomass.csv")

# PENNYWEIGHT 
# Pennyweight redone (subsection of pennyweight)
pnw <- read_excel("/Users/abbeyyatsko/Downloads/pnw_totalbiomass_redone.xlsx",sheet = 1,trim_ws = TRUE)

pnw %>%
  rename(species = 'Sp.') %>%
  count(species) %>%
  mutate(rank_abundance=rank(-n,ties="first"))->rank

pnw %>%
  rename(species = 'Sp.') %>%
  mutate(dbh= Circ_cm/pi,
         radius_cm= dbh/2,
         area_cm2=pi*radius_cm^2,
         basal_area = ((pi * (dbh/2))^2/144),
         rank_basal_area= cume_dist(basal_area)) %>%
  left_join(rank) -> pnw

#sampling with a latin hypercube design
pnw %>%
  select(dbh, n) -> sc
res <- clhs(sc, size = 32, iter = 2000, progress = FALSE)
pnw$samples <- ifelse(row.names(pnw) %in% res, yes ="S", no = "")
pnw$samples[station_creek$n == 1] <- "S"


pnw <- ggplot(pnw,aes(x= X_coord, y= Ycoord,colour= fct_reorder(species,rank_abundance)))+
  geom_jitter(aes(size=area_cm2))+
  labs(title = "Pennyweight")+
  scale_colour_viridis_d(option = "D")+
  scale_y_continuous(breaks = seq(0,50, 10))+
  scale_x_continuous(breaks = seq(0,100, 10))+
  geom_text(aes(label= samples), colour ="red", size =5)+
  #geom_point(aes(size=radius_cm))+
  #scale_radius(range=c(0,30))
  scale_size_area()+
  theme_linedraw()+
  theme(panel.grid = element_line("black",size = 5))

#geom_circle(aes(x0=x_coord, y0=y_coord, r= radius_cm))
ggsave(filename = "downloads/PNW_live_biomass.pdf",plot = pnw, width = 9.03, height = 6.37)

# station_creek %>%
#   select(species, X_coord, Ycoord, dbh, samples,notes) %>%
#   arrange(Ycoord,X_coord) -> station_creek
# write_csv(station_creek, "output/pnw_live_biomass.csv")

# Pennyweight complete (entire of pennyweight)
pnw_total <- read_excel("/Users/abbeyyatsko/Downloads/pnw_totalbiomass_full.xlsx",sheet = 1,trim_ws = TRUE)
table(pnw_total$species)

pnw %>%
  count(species) %>%
  mutate(rank_abundance=rank(-n,ties="first"))->rank

pnw_total %>%
  mutate(dbh= Circ_cm/pi,
         radius_cm= dbh/2,
         area_cm2=pi*radius_cm^2,
         basal_area = ((pi * (dbh/2))^2/144),
         rank_basal_area= cume_dist(basal_area)) %>%
  left_join(rank) -> pnw_total

#sampling with a latin hypercube design
pnw %>%
  select(dbh, n) -> sc
res <- clhs(sc, size = 32, iter = 2000, progress = FALSE)
pnw$samples <- ifelse(row.names(pnw) %in% res, yes ="S", no = "")
pnw$samples[station_creek$n == 1] <- "S"


pnw <- ggplot(pnw_total,aes(x= x_coord, y= y_coord))+
  labs(title = "Pennyweight")+
  scale_colour_viridis_d(option = "D")+
  scale_y_continuous(breaks = seq(0,50, 10))+
  scale_x_continuous(breaks = seq(0,100, 10))+
  #geom_point(aes(size=radius_cm))+
  #scale_radius(range=c(0,30))
  scale_size_area()+
  theme_linedraw()+
  theme(panel.grid = element_line("black",size = 5))


