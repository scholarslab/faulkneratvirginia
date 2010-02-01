for i in `ls ../cocoon/data/tei/*.xml` ; do java -jar saxon/saxon9.jar -xi:on -s $i -xsl:transcription_to_solr.xsl > index/add_`basename $i`; done;
java -jar saxon/saxon9.jar -xi:on -s ../cocoon/data/site_info.xml -xsl:prose_to_solr.xsl > index/add_site_info.xml
echo "Processing `basename $i`"

FILES="index/add_*.xml"
URL=http://localhost:8080/solr/faulkner/update

for f in $FILES; do
  echo Posting file $f to $URL
  curl $URL --data-binary @$f -H 'Content-type:text/xml; charset=utf-8' 
  echo
done

#send the commit command to make sure all the changes are flushed and visible
curl $URL --data-binary '<commit/>' -H 'Content-type:text/xml; charset=utf-8'
echo

#optimize the index
curl $URL --data-binary '<optimize/>' -H 'Content-type:text/xml; charset=utf-8'
echo

#reload the core
curl http://localhost:8080/solr/admin/cores -F command=RELOAD -F core=faulkner
echo