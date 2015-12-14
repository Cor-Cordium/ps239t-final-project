This is a template you can use for your final project. Fill in each section with information on your own project.

## Short Description

For my final project, I used textual analysis in R to examine three volumes of American modernist poetry. After preprocessing, I analyze each collection for term frequency and visualize the data with a bar plot in ggplot and a word cloud. I also created .csv files of each collection. For the second part of my project, I measured distinctiveness for each volume. I measured distinctiveness two ways: diadically, by comparing one volume to each other, and then each as a proportion to all the collections. 
Next I explored regular expressions in R with the aim of writing regular expressions that could semi-automate the identification of similes in each volume. I wrote regular expressions to recognize every instance of "as" and "like" in the collections, grab the line the instance is contained in, and write it into a list. I now have three lists, one list for each collection. In the future, I plan to return to these expressions to modify them and make them more sophisticated. 
Finally, I used POS-tagging to measure the grammatical entropy of each collection.

## Dependencies

1. R, version 3.1

## Files

### Data

All poetry collections were sourced from the gutenberg online archive.
H.D. Sea Garden.txt
HD_SeaGarden.csv
Pound Personae.txt
Pound_Personae.csv
Eliot_Prufrock.csv
TSEliot_Prufrock.txt

### Code

1. Final Project - Cory Merrill.Rmd: pre-processes the poetry collections and analyzes each for term frequency, and produces the visualizations found in the results directory.
2. Final Project II - Distinctiveness.Rmd: Analyzes the poetry collections for distinctiveness
2. Final Project III - Cory Merrill.Rmd: Runs regular expressions to generate lists of the instances of "as" and "like" in the collections + the line they are contained in. POS tagging code analyzes the grammatical entropy of each collection.

### Results

All results are saved as PDFs.
1. Word clouds of each poetry collection (3 in total)
2. Bar graphs of the most frequent terms in each collection (3 in total)
3. POS plots for two collections (2 files total) 

## More Information

Fur further questions or inquiries, I can be contacted at cory.merrill@berkeley.edu. 
