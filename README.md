# README:
Determining differences in body size variability between pseudergate and true worker species in termites

## Author:
Mary Goldman

### Overview
This data was composed from videos obtained in the Mizumoto termite behavioral lab. Head width and body length data was collected from 20 different termite species. Three different frames were captured for 20 different replicates of each species. In each from, both male and female termites were arranged in a manner that head and whole body were visible, in a straight line, and not climbing the walls of the enclosure. Each fram captured was at least 10 seconds apart.

#### File organization
dataset_R.csv - dataset used for analysis with the data of head width and body length
tandemvideodata.csv - the original data set with information of: original video location, genus, species, colony info, access, dish size, cropped resolution, conversion factor, all medians, and all originall data inputs before converted from pixels to mm. 

##### Variable Definitions
Cropped resolution is how the video was croped this value determined the conversion factor. 
NA - this means a measurement was not able to be taken. This could be because the individiual exited the arena, sex could not be differentiated, there was only one sex in the arena, or their bodies where irregular and unable to be measured. 
Note - explains why measurement could not be taken 

###### Notes
There were some termites that could not be measured. In these instances, "NA" was used as a placeholder. In order for analysis to occur, the data with "NA" was removed from the dataset when statistical analysis took place. 
