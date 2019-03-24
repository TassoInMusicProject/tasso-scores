## tasso-scores Makefile
##
## Programmer:    Craig Stuart Sapp <craig@ccrma.stanford.edu>
## Creation Date: Sun Apr  2 18:12:30 PDT 2017
## Last Modified: Sun Apr  2 18:12:33 PDT 2017
## Filename:      Makefile
## Syntax:        GNU makefile
##
## Description: 
##
## Makefile for basic processing of Tasso digital score repository.
## To run this makefile, type (without quotes) one of the following
## commands in a bash terminal (usually the default terminal shell
## in linux, and also /Applications/Utilities/Terminal.app in OS X 
## computers).
##
## "make"        -- Download any updates to online TMP files.
##
## "make update" -- Download any updates to online TMP files.
##
## "make clean" -- Delete directories of data created by this makefile,
##     such as kern-reduced, pdf, and midi which may be found
##     in each composer's directory.
##
## "make notitle" -- Make a version of the files where the title is
##     removed from the filename.
##
## ===============================================================
##
## Make commands which require Humdrum Extras to be installed:
##
## "make reduced" -- Create reduced-rhythm versions of the data files
##     by dividing note durations by 4 so that whole notes become
##     quarter notes.  This is necessary to use the data with rhythm
##     analysis tools in the standard Humdrum Toolkit.
##
## "make notext" -- Remove **text spines from data and store
##     output in kern-notext directories for each composer directory.
##
## "make genres" -- Groups work by genre by downloading from kernScores.
##
## "make notearray" -- Create note array files.
##
## ===============================================================
##
## If Humdrum Extras is not installed, you can use web downloaded versions
## of the above make commands:
##
## "make web-pdf" -- Download PDF graphical music scores from the TMP website.
##
## "make web-pdf-notext" -- Download PDFs of graphical music scores from TMP 
##    website which do not include lyrics.
##
## "make web-reduced" -- Same as "make reduced", but download from the
##    TMP website without the need to have Humdrum Extras installed.
##
## "make web-musedata" -- Download MuseData files used to create PDF files.
##
## ===============================================================
## 
## Humdrum Toolkit dependent make commands:
##
## "make census" -- Run census -k on all files.
##
##


# targets which don't actually refer to files/directories:
.PHONY : 

all:
	@echo ''
	@echo 'Run this makefile with one of the following labels:'
	@echo '   "make update"      : download any new changes in online data repository.'
	@echo '   "make notitle"     : remove titles from filenames.'
	@echo '   "make clean"       : delete data directories created by this makefile.'
	@echo ''
	@echo 'Comands requiring Humdrum Extras to be installed.'
	@echo '   "make reduced"     : create rhythmically reduced kern files.'
	@echo '   "make notext"      : remove lyrics from scores.'
	@echo '   "make genres"      : group works by genre.'
	@echo '   "make notearray"   : create notearray files.'
	@echo ''
	@echo 'TMP website downloads:'
	@echo '   "make web-pdf"      : download score PDFs from TMP website.'
	@echo '   "make web-pdf-notext" : download score PDFs without lyrics.'
	@echo '   "make web-reduced"  : download rhythmically reduced kern files.'
	@echo '   "make web-musedata" : download MuseData files from TMP website.'
	@echo ''

BASEURL   = http://josquin.stanford.edu
DATAURL   = $(BASEURL)/cgi-bin/tasso?
PDFTYPE   = notationwitheditorialwithtext
PDFNOTEXT = notationwitheditorialnotext
REDUCED   = humdrumreduced

# If wget is not present on the computer, try using curl since the
# computer is most likely an OS X one:

WGET = `which wget`
ifeq ($(WGET),) 
   WGET = curl
else 
   WGET = wget -O-
endif

############################################################################
##
## General make commands:
##


index:
	bin/makehmdindex > index.hmd



##############################
#
# make update -- Download any changes in the Github repositories for
#      each composer.
#

update:       github-pull
githubupdate: github-pull
githubpull:   github-pull
github-pull:
	git pull



##############################
#
# make clean -- Remove all automatically generated or downloaded data files.  
#     Make sure that you have not added your own content into the directories 
#     in which these derivative files are located; otherwise, these will be 
#     deleted as well.
#

clean:
	-rm -rf T??/kern-reduced
	-rm -rf T??/kern-notext
	-rm -rf T??/kern-notitle
	-rm -rf T??/midi
	-rm -rf T??/pdf
	-rm -rf T??/pdf-notext
	-rm -rf T??/notearray
	-rm -rf T??/musedata


##############################
#
# make kern-notext -- Remove titles from filenames and store in a
#     directory called kern-notext within each composer directory.
#

notitle:       kern-notitle
no-title:      kern-notitle
kern-no-title: kern-notitle
kernnotitle:   kern-notitle
kern-notitle:
	for dir in [A-Z]??/kern; 						\
	do									\
	   echo Processing composer $$dir;					\
	   (cd $$dir; mkdir -p ../kern-notitle;					\
	   for file in *.krn;							\
	   do									\
	      cp $$file ../kern-notitle/`echo $$file | sed 's/-.*krn//'`.krn;	\
	   done									\
	   )									\
	done



############################################################################
##
## Web downloading related make commands:
##


########################################
#
# make web-midi -- Download PDF files of graphical music notation
#     which are generated from the source **kern Humdrum data.
#

midi:    web-midi
webmidi: web-midi
web-midi:
	for dir in [A-Z]??/kern;				\
	do							\
	   echo Processing composer $$dir;			\
	   (cd $$dir; mkdir -p ../midi;				\
	      for file in *.krn;				\
	      do						\
	         echo "   Downloading MIDI for $$file ...";	\
	         $(WGET) "$(DATAURL)a=midi&f=$$file" 		\
	            > ../midi/`basename $$file .krn`.mid;	\
	      done						\
	   )							\
	done



########################################
#
# make web-pdf -- Download PDF files of graphical music notation
#     which are generated from the source **kern Humdrum data.
#

pdf:    web-pdf
webpdf: web-pdf
web-pdf:
	for dir in [A-Z]??/kern;				\
	do							\
	   echo Processing composer $$dir;			\
	   (cd $$dir; mkdir -p ../pdf;				\
	      for file in *.krn;				\
	      do						\
	         echo "   Downloading PDF for $$file ...";	\
	         $(WGET) "$(DATAURL)a=$(PDFTYPE)&f=$$file" 	\
	            > ../pdf/`basename $$file .krn`.pdf;	\
	      done						\
	   )							\
	done



########################################
#
# make web-pdf-notext -- Download PDF files of graphical music notation,
#     removing any lyrics from the music.
#

pdfnotext:     web-pdf-notext
pdf-notext:    web-pdf-notext
webpdfnotext:  webpdf-notext
webpdf-notext: web-pdf-notext
web-pdfnotext: web-pdf-notext
web-pdf-notext:
	for dir in [A-Z]??/kern;				\
	do							\
	   echo Processing composer $$dir;			\
	   (cd $$dir; mkdir -p ../pdf-notext;			\
	      for file in *.krn;				\
	      do						\
	         echo "   Downloading PDF for $$file ...";	\
	         $(WGET) "$(DATAURL)a=$(PDFNOTEXT)&f=$$file" 	\
	            > ../pdf-notext/`basename $$file .krn`.pdf;	\
	      done						\
	   )							\
	done





############################################################################
##
## Humdrum Extras related make commands:
##


##############################
#
# make kern-reduced -- Create Humdrum **kern data which does not contain any
#     rational reciprocal rhythms.  Standard **recip data cannot represent 
#     non-integer subdivisions of the whole note (excluding augmentation
#     dots).  The extended reciprocal value for a triplet whole note is
#     3%2 which means that the duration is 2/3rds of a whole note. 
#
#     After running "make reduced", a subdirectory called "kern-reduced"
#     will be generated in each composer directory (parallel to the 
#     "kern" subdirectories that contain the original Humdrum **kern data
#     for the scores.
#
#     This label requires that the "rscale" tool from the Humdrum Extras
#     package is installed (see https://github.com/craigsapp/humextra).
#     If you do not have it installed, instead run "make webreduced").
#

reduced:     kern-reduced
kernreduced: kern-reduced
kern-reduced:
	for dir in [A-Z]??/kern; 				\
	do							\
	   echo Processing composer $$dir;			\
	   (cd $$dir; mkdir -p ../kern-reduced;			\
	   for file in *.krn;					\
	   do							\
	      rscale -f 1/4 $$file > ../kern-reduced/$$file;	\
	   done							\
	   )							\
	done

#
# make webreduced -- same result as "make reduced" but download data from
# TMP website (much slower, but no extra software installation is required).
#

webkernreduced:  web-kern-reduced
webreduced:      web-kern-reduced
web-kernreduced: web-kern-reduced
webkern-reduced: web-kern-reduced
web-kern-reduced:
	for dir in [A-Z]??/kern;				\
	do							\
	   echo Processing composer $$dir;			\
	   (cd $$dir; mkdir -p ../kern-reduced;			\
	      for file in *.krn;				\
	      do						\
	         echo "   Downloading file $$file ...";		\
	         $(WGET) "$(DATAURL)a=$(REDUCED)&f=$$file" 	\
	            > ../kern-reduced/$$file;			\
	      done						\
	   )							\
	done

musedata:     web-musedata
webmusedata:  web-musedata
web-musedata: web-musedata
web-musedata:
	for dir in [A-Z]??/kern;				\
	do							\
	   echo Processing composer $$dir;			\
	   (cd $$dir; mkdir -p ../musedata;			\
	      for file in *.krn;				\
	      do						\
	         echo "   Downloading file $$file ...";		\
	         $(WGET) "$(DATAURL)a=musedata&f=$$file" 	\
	            > ../musedata/`basename $$file .krn`.msd;	\
	      done						\
	   )							\
	done



##############################
#
# make kern-notext -- Remove **text spines from data and store in
#     directory called "kern-notext".
#

kernnotext: kern-notext
kern-notext:
	for dir in [A-Z]??/kern; 					\
	do								\
	   echo Processing composer $$dir;				\
	   (cd $$dir; mkdir -p ../kern-notext;				\
	   for file in *.krn;						\
	   do								\
	      extractx -i '**kern' $$file > ../kern-notext/$$file;	\
	   done								\
	   )								\
	done



##############################
#
# make notearray -- Create note array files.  Output is stored in a directory
#     called "notearray" in each composer directory.
#

notearray:
	for dir in [A-Z]??/kern; 					\
	do								\
	   echo Processing composer $$dir;				\
	   (cd $$dir; mkdir -p ../notearray;				\
	   for file in *.krn;						\
	   do								\
	      notearray -jicale --mel $$file 				\
		| egrep -v 'LO:LB|break.*default'			\
		> ../notearray/`basename $$file .krn`.dat;		\
	   done								\
	   )								\
	done



############################################################################
##
## standard Humdrum Toolkit related make commands:
##


##############################
#
# make census -- Count notes in all score for all composers.
#

census:
	(for i in [A-Z]??/kern; do cat $$i/*.krn; done) | census -k



############################################################################
##
## Maintenance commands (not useable in general).  Used when new works
## are added to the database.
##

process: refs abbr system original index

ref: refs
refs:
	bin/fillinrefinfo -w Trm/kern/*.krn
	bin/fillinrefinfo -a -w Tam/kern/*.krn
	bin/fillinrefinfo -g -w Tsg/kern/*.krn
	# need also to do other genres here

abbr:
	bin/addAbbreviations */kern/*.krn

system:
	bin/fixsystemdecoration Trm/kern/*.krn
	bin/fixsystemdecoration Tam/kern/*.krn
	bin/fixsystemdecoration Tri/kern/*.krn
	bin/fixsystemdecoration Tsg/kern/*.krn

original:
	bin/addoriginal -w Trm/kern/*.krn
	bin/addoriginal -w Tam/kern/*.krn
	bin/addoriginal -w Tsg/kern/*.krn
	# need also to do other genres here


