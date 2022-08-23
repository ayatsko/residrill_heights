# libraries 
library(dplyr)
# figure out what stems to sample for stem variation project 
# working at two savanna sites - pennyweight and station creek 

# /pennyweight/
#   * Eucalyptus cullenii (Myrtaceae)
#   * Melaleuca stenostachya (Myrtaceae)
# 
# /station creek/
#   * Eucalyptus cullenii (Myrtaceae)
#   * Corymbia clarksoniana (Myrtaceae)

### PREVIOUSLY RESIDRILLED
# read in file that shows what has been residrilled as part of the stem damage paper 
trees_measured <- read.csv("/Users/abbeyyatsko/Downloads/stem_damage.csv")

# filter only those previously residrilled for stem damage at STATION CREEK
trees_measured_stck <- subset(trees_measured, site =="stck")
write_csv(trees_measured_stck, "downloads/station_creek_residrilled_x.csv")

# filter only those previously residrilled for stem damage at PENNYWEIGHT
trees_measured_pnw <- subset(trees_measured, site =="pnw")
write_csv(trees_measured_pnw, "downloads/pennyweight_residrilled.csv")

### OVERALL SITE LIVE BIOMASS 
# read in file that is all of the biomass at STATION CREEK (from live biomass survey)
livebiomass_stck <- read.csv("/Users/abbeyyatsko/Downloads/wtf_livebiomass - Station Creek.csv")

# count of all species at station creek
table(livebiomass_stck$species)

# filter out 2 target species: 
#   * Eucalyptus cullenii (Myrtaceae)
#   * Corymbia clarksoniana (Myrtaceae)

livebiomass_stck <- subset(livebiomass_stck, species == "Eucalyptus cullenii" | species == "Corymbia clarksoniana")

# read in file that is all of the biomass at PENNYWEIGHT (from live biomass survey)
livebiomass_pnw <- read.csv("/Users/abbeyyatsko/Downloads/wtf_livebiomass - Pennyweight_redone.csv")

# count of all species at pennyweight
table(livebiomass_pnw$species)

# filter out 2 target species: 
#   * Eucalyptus cullenii (Myrtaceae)
#   * Melaleuca stenostachya (Myrtaceae)

livebiomass_pnw <- subset(livebiomass_pnw, species == "Eucalyptus cullenii" | species == "Melaleuca stenostachya")

### CROSS REFERENCE RESIDRILLED TREES WITH OVERALL LIVE BIOMASS 
# station creek 

trees_measured_stck$coord <- paste(trees_measured_stck$x_coord, trees_measured_stck$y_coord, sep=",")
livebiomass_stck$coord <- paste(livebiomass_stck$x_coord, livebiomass_stck$y_coord, sep=",")

common_stck <- intersect(trees_measured_stck$coord, livebiomass_stck$coord)  

# pennyweight

trees_measured_pnw$coord <- paste(trees_measured_pnw$x_coord, trees_measured_pnw$y_coord, sep=",")
livebiomass_pnw$coord <- paste(livebiomass_pnw$X_coord, livebiomass_pnw$Ycoord, sep=",")

common_pnw <- intersect(trees_measured_pnw$coord, livebiomass_pnw$coord)  


    