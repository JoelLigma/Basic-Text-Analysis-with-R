# Basic Text-Analysis-with-R

Date: Nov 2019

Source: https://www.gutenberg.org/files/25344/25344-0.txt

**Table of Contents**

- Text cleanup and processing 
- Regular expression, stemming, removing numbers, stop words, punctuation, and white spaces 
- Create a Term Document Matrix 
- Report descriptive stats on words and generate a word cloud 
- Conduct a k-means cluster of the words, identify words that occur in the clusters and interpret what these clusters mean 
- Write a 1-page executive summary of the results of this analysis, processing steps and what you learned from the analysis


**Introduction**

In order to conduct this text mining analysis, I chose the book The Scarlet Letter by Nathaniel Hawthorne in text format provided on the Project Gutenberg website
(www.gutenberg.org). The ebook was released on May 5, 2008 on the Gutenberg website and is available for free download. The ebook contains 87,709 words and is written
in the English language. Initially, the file came in a txt-format and was converted into csv-format for better compatibility for this analysis. Due to the conversion, 
the file contains some errors as well as corrupted words. However, this is not seen as problematic for the purpose of this analysis because the vast majority of the content
is in good shape. 

**Text Cleaning**

After reading the file into R the first sentence of the book was automatically used as header. Because this is not desirable, I opened the file in MS Excel and manually added a
new row as the first row and entered the word “Text” into the first cell. As result, when reading the csv file into R, it now does not count the first sentence of the book as 
header anymore. Furthermore, I noticed that the book contained a preface and epilogue which were added by the uploader and are irrelevant in terms of context of the book and 
therefore for the analysis. Consequently, I manually removed them. 

**Text Processing and Analysis**

After converting the cleaned text into a term document matrix 9,550 unique expressions remained. To make the analysis computationally feasible, words that are over 99% sparse were removed from the matrix. As a result, only 51 words remained. 99% was chosen because 98% resulted in 14 terms which is less suitable to work with. Next, a word cloud was generated. Looking at the word cloud, one can observe that “hester” “pearl” and “little” are the top 3 most frequent words. Because a word cloud does not give the observer any precise frequencies, a bar chart with the 10 most frequent words was created. From this exhibit, one can infer that “hester” and “pearl” seem to represent relevant parts of the content of the book. “hester” may be the name of the protagonist of the story and the “pearl” might play an important role. Moreover, descriptive statistics were applied. First, a correlation analysis on the terms “hester”, “pearl” and “little” was conducted. The output reveals that “hester” has .52 correlation to “prynne”. This may imply that “Prynne” could be the person’s last name because it is often found in connection with “hester”. Also, the word “pearl” appears to be used in connection with “little” and “said” which may indicate that “pearl” is in fact a young person. The Within Sum of Squares curve does not unequivocally suggest an exact number of clusters for a k-means clustering analysis, however the number 5 was chosen to keep the analysis simple and easy to follow. The k-means clustering analysis reveals cluster #1 to contain the words "pearl" and "little" and cluster #2 to contain “hester” and “Prynne”. The third cluster contains the majority of words. This could further accentuate the importance of “hester”, “Prynne”, “little” and “pearl” for the story of the book. Cluster number three, containing most words, also contains the word “dimmesdale” which may indicate the last name of another main character in the story.

**Conclusion and Learnings** 

In conclusion, it can be said that the results of this text mining analysis are quite intriguing. They show how powerful text mining can be. With my brief analysis I was able to 
make inferences about the content of the book and potentially identify its protagonist. As next step in the analysis, one could argue that with an increase in clusters one may get additional useful information. Lastly, I learned how to conduct a basic text mining analysis and make inferences about a text file. In addition, I learned how to convert a txt-file into csv format and that the source of data is important. A prepared csv-file can save a lot of time in preprocessing. 
