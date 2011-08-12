#/bin/sh

 source ~/.bashrc

 export LC_ALL=
 export LC_ALL=en_US.UTF-8

 if ! [ -d $HOME_anu_tmp ] ; then
     echo $HOME_anu_tmp " directory does not exist "
     echo "Creating "$HOME_anu_tmp 
    mkdir $HOME_anu_tmp
 fi

 MYPATH1=`pwd`
 MYPATH=$HOME_anu_tmp
 cp $1 $MYPATH/. 

 if ! [ -d $MYPATH/tmp ] ; then
    echo "tmp  does not exist "
    echo " Creating tmp "
    mkdir $MYPATH/tmp
 fi

 if ! [ -d $MYPATH1/help ] ; then
    echo "help dir  does not exist "
    echo "Creating help dir"
    mkdir $MYPATH1/help
 fi

 if  [ -e $MYPATH/tmp/$1_tmp ] ; then
    rm -rf $MYPATH/tmp/$1_tmp
 fi

 mkdir $MYPATH/tmp/$1_tmp

 echo "Saving Format info ..."

 $HOME_anu_test/Anu/stdenglish.sh $1 $MYPATH
 $HOME_anu_test/Anu/pre_process.sh $1 $MYPATH
 $HOME_anu_test/Anu/save_format.sh $1 $MYPATH

 echo "Saving word information"
 cd $HOME_anu_test/Anu_src
 ./word.out < $MYPATH/tmp/tmp_save_format/$1.fmt_split $MYPATH/tmp $1
 ./rm_tags.out < $MYPATH/tmp/$1_tmp/new_text.txt > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt

  echo "Saving morph information"
  cd $HOME_anu_test/apertium/
  sed 's/\([^0-9]\)\.\([^0-9]*\)/\1 \.\2/g'  $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt | sed 's/?/ ?/g'| sed 's/\"/\" /g'  | sed 's/!/ !/g' > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tmp
  apertium-destxt $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt_tmp  | lt-proc -a en.morf.bin | apertium-retxt > $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.morph
  perl morph.pl $MYPATH $1 < $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.morph

  echo "Calling POS Tagger and Chunker (APERTIUM)" 
  cd $HOME_anu_test/apertium
  sh run_chunker_and_tagger.sh $1

  cd $HOME_anu_test/Anu_src
  ./aper_chunker.out $MYPATH/tmp/$1_tmp/chunk.txt < $MYPATH/tmp/$1_tmp/one_sentence_per_line.txt.chunker

  echo "Calling Link Parser"
  cd $HOME_anu_test/Parsers/LINK/link-grammar-4.5.7/link-grammar
  ./link-parser $HOME_anu_test/Parsers/LINK/link-grammar-4.5.7/data/en $MYPATH/tmp $1 $2 <$MYPATH/tmp/$1_tmp/one_sentence_per_line.txt 
 # cd $HOME_anu_test/Parsers/LINK/link-grammar-4.7.4/link-grammar
 #./link-parser $HOME_anu_test/Parsers/LINK/link-grammar-4.7.4/data/en $MYPATH/tmp $1 $2 <$MYPATH/tmp/$1_tmp/one_sentence_per_line.txt

  #running stanford NER (Named Entity Recogniser) on whole text.
  echo "Finding NER... "
  cd $HOME_anu_test/Parsers/stanford-parser/stanford-ner-2008-05-07/
  sh run-ner.sh $1
 
  cd $MYPATH/tmp/$1_tmp
  sed 's/&/\&amp;/g' one_sentence_per_line.txt|sed -e s/\'/\\\'/g |sed 's/\"/\&quot;/g' |sed  "s/^/(Eng_sen \"/" |sed -n '1h;2,$H;${g;s/\n/\")\n;~~~~~~~~~~\n/g;p}'|sed -n '1h;2,$H;${g;s/$/\")\n;~~~~~~~~~~\n/g;p}' > one_sentence_per_line_tmp.txt
  $HOME_anu_test/Anu_src/split_file.out one_sentence_per_line_tmp.txt dir_names.txt English_sentence.dat
  $HOME_anu_test/Anu_src/split_file.out link_relation_info.txt dir_names.txt link_relation_info_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out link_name_expand.txt dir_names.txt link_name_expand.dat
  $HOME_anu_test/Anu_src/split_file.out linkid_word.txt dir_names.txt linkid_word_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out link_numeric_word.txt dir_names.txt link_numeric_word_tmp.dat
  $HOME_anu_test/Anu_src/split_file.out linkage_count.txt dir_names.txt linkage_count
  $HOME_anu_test/Anu_src/split_file.out chunk.txt dir_names.txt chunk.dat 
  $HOME_anu_test/Anu_src/split_file.out one_sentence_per_line.txt.ner dir_names.txt ner.dat

  echo 'matching compounds......'
    grep -v '^$' $MYPATH/tmp/$1.snt  > $1.snt  
##NOTE: While 'matching compounds', using one_sentence_per_line.txt_tmp problem occured when we get punctuations in between the sentence. Ex: I am warning you for the last time, stop talking! 
## So '$1.snt' file which contains only sentences without punctuations is used. (Modified by Roja (11-08-11)) 
  perl $HOME_anu_test/Anu_src/Compound-dict.pl $HOME_anu_test/Anu_databases/compound.gdbm  $1.snt > compound_phrase.txt
  perl $HOME_anu_test/Anu_src/Match-sen.pl $HOME_anu_test/Anu_databases/Complete_sentence.gdbm  ../$1.snt one_sentence_per_line.txt > sen_phrase.txt

  $HOME_anu_test/Anu_src/split_file.out sen_phrase.txt dir_names.txt sen_phrase.dat
  $HOME_anu_test/Anu_src/split_file.out compound_phrase.txt dir_names.txt compound_phrase.dat
 
 cd $HOME_anu_test/bin
 while read line
 do
 echo "Hindi meaning using Link parser" $line 
   timeout 180 ./run_sentence_link.sh $1 $line 1 $MYPATH
    echo ""
 done < $MYPATH/tmp/$1_tmp/dir_names.txt
 
 cd $MYPATH/tmp/$1_tmp/
 echo "(defglobal ?*path* = $HOME_anu_test)" > path_for_html.clp
 echo "(defglobal ?*mypath* = $MYPATH)" >> path_for_html.clp
 echo "(defglobal ?*filename* = $1)" >> path_for_html.clp

 echo "Calling Interface related programs"
 sh $HOME_anu_test/shell_scripts/ClipsToAnu_browser_intfc.sh $1 $MYPATH
 echo "<html><body>" > $MYPATH/tmp/$1_tmp/$1.txt.html
 cat $MYPATH/$1 >>$MYPATH/tmp/$1_tmp/$1.txt.html
 echo "</body></html>" >> $MYPATH/tmp/$1_tmp/$1.txt.html

 cp $MYPATH/$1 $MYPATH/tmp/$1_tmp/
 sh $HOME_anu_test/shell_scripts/frame.sh $1 $MYPATH/tmp/$1_tmp/

  mkdir $MYPATH/tmp/$1_tmp/anu_html
  cp $HOME_anu_test/Browser/img.php $HOME_anu_test/Browser/val.js $MYPATH/tmp/$1_tmp/anu_html/
 
  cp *.html  $MYPATH1/. 
  cd $HOME_anu_test/Browser
  cp -r help/*htm $MYPATH1/help/
  cd src
  cp *.html *.js *.css $MYPATH1

	#To add slashes before(',",(,) etc.. )  inside initialise function(used for google api)

	cd $MYPATH1
	perl $HOME_anu_test/Anu_src/change-html.pl < $1.html > $1-new.html
	cp $1.html $1-old.html
	cp $1-new.html $1.html

