#get wet file which is text body from warc no headers

#ListOfWarcs=(`ls *.gz`)
#for i in $ListOfWarcs[@]"
#do
###
#done
#replace later for i in ListOfWarcs

##########rm *.gz
##########wget http://s3.amazonaws.com/aws-publicdatasets/common-crawl/crawl-data/CC-MAIN-2013-20/segments/1368711605892/wet/CC-MAIN-20130516134005-00099-ip-10-60-113-184.ec2.internal.warc.wet.gz

#prepare wet for text analysis]
rm result.txt

zcat CC-MAIN-20130516134005-00099-ip-10-60-113-184.ec2.internal.warc.wet.gz | warcfilter --url "http://www.google.com"  >> result.txt

rm result2.txt

cat result.txt |  warcextract  >> result2.txt


wget https://sites.google.com/site/miningtwitter/basics/getting-data/files/positive_words.txt?attredirects=0
wget https://sites.google.com/site/miningtwitter/basics/getting-data/files/negative_words.txt?attredirects=0

mv negative_words.txt?attredirects=0 negative_words.txt
mv positive_words.txt?attredirects=0 positive_words.txt



rm -r WorkOnWet
mkdir WorkOnWet
mv result2.txt WorkOnWet
cp WordCloudTheWet.R WorkOnWet
cp negative_words.txt WorkOnWet
cp positive_words.txt WorkOnWet

cd WorkOnWet


#Import text and get wordcloud
R CMD BATCH WordCloudTheWet.R

#get positive and negative dictionaries

#import text into R and determine sentiment score

#make wordcloud

#make chernoff face

#map sentiment to rworldmap by color

