# Tasso in Music Project Digital Scores #

This repository contains digital music scores in the Humdrum data
format from the [Tasso in Music Project](http://www.tassomusic.org) (TMP).
The primary web interface for these scores is http://www.tassomusic.org
which allows online searching and browsing, conversions into other
data formats, such as MIDI and graphical notation, as well as
interfaces to some online analysis tools.  These scores are a
collection madrigals by various composers who set the poems of
Torquato Tasso to music, mostly from the 1570's to the 1640's ([see
these histograms of publication dates](https://www.tassomusic.org/analysis/publication-date)).

The `Trm/kern` directory contains the primary format for the digital
scores in the Humdrum data format.  The makefile can create or
download other formats of the digital scores, including MIDI and
PDF files.

# Filenames #

Each file in the database starts with a unique TMP catalog number.
This consists of a three-letter genre ID (currently only `Trm` which
means "Tasso RiMe"., followed by a four- to six-digit number to
represent a specific poetic work/excerpt by Torquato Tasso, followed
by a letter indicating the setting number by a particular composer.
For the `Trm` set, the four-digit number indicates the Tasso rime
(poem) according to the
[Solerti](https://it.wikipedia.org/wiki/Angelo_Solerti) enumeration
as found in [Le rime de Torquato
Tasso](https://archive.org/details/lerimeditorquat00solegoog).

The ending letter of the catalog number indicates a particular
musical setting.  This letter is arbitrary, but usually enumerates
the list of composers in alphabetical order (unless a new one is
added at the end of the list out of order).

Title information follows the first dash in the filenames and are
a courtesy for human beings.  As such they can be removed from
filenames, leaving only the unique catalog numbers.  The title
in the filename ends at two dashes.  After the double dash, the
composer's last name and first publication year are given in the
filename.


# Download #

To download this Github repository using
[git](http://en.wikipedia.org/wiki/Git_%29software%29) in a terminal, type:

```bash
git clone https://github.com/TassoInMusicProject/tasso-scores
```

In a unix terminal, you can check to see if git is installed by
typing ```which git```.  If the terminal replies with a path to
git, then you can proceed with the above cloning to download the
repository.  If not, then typically you can use a package manager
to install git, such as ```apt-get install git``` or ```yum install
git``` in linux.  On Apple OS X computers, git can be installed
directly from [here](http://git-scm.com/download/mac) or by more
experienced users from a mac package manager such as
[Homebrew](http://brew.sh).  If you have a comicbook-like view of the
computer world, you can download GUI interfaces for git
[here](http://git-scm.com/downloads/guis).  A [Github/git
plugin](http://eclipse.github.com) is also available for the Eclipse
IDE ([watch video](http://www.youtube.com/watch?v=ptK9-CNms98)).

There is also a ZIP file download on the github page where this
readme is displayed.


# Update #

After you have downloaded this repository with `git`, you can check 
periodically for updates for all composers' works using this command:

```bash
git pull
```

Alternatively, the makefile in the base directory can be used to
run this command:

```bash
make update
```

# Processing scores #

The digital scores in this repository are designed to work with the
[Humdrum Toolkit](http://www.humdrum.org)
([github](https://github.com/humdrum-tools/humdrum-tools)).
A makefile in the base directory of the repository contains some
basic processing commands which either require 
[Humdrum Extras](http://extras.humdrum.org) 
([github](https://github.com/craigsapp/humextra))
to manipulate the
data files, or commands (starting with "web") which download data
generated online by the [TMP website](http://tmp.tassomusic.org).

Here are some of the make commands which you can run in the base directory
of the downloaded repository:

<table>
<tr><td width=200 colspan=2> No additional software needed: </td></tr>
<tr><td><tt>make</tt></td>
    <td>  List all of the possible make commands (i.e., this list).
    </tr>
<tr><td><tt>make&nbsp;update</tt></td>
    <td>  Download any updates to the online repository.
    </tr>
<tr><td><tt>make&nbsp;clean</tt></td>
    <td>  Delete directories of data created by this makefile, such as
	  <tt>kern-reduced</tt>, <tt>midi</tt>, <tt>pdf</tt>, 
	  <tt>pdf-notext</tt>.
    </tr>
<tr><td><tt>make&nbsp;notitle</tt></td>
    <td>  Remove titles from files names and store in directory
         called kern-notitle in each composer's directory.
    </tr>
<tr><td><tt>make&nbsp;web-pdf</tt></td>
    <td>  Download PDF files for graphical music scores for each piece from the
	  <a href=http://www.tassomusic.org>TMP website</a>.
    </tr>
<tr><td><tt>make&nbsp;web-pdf-notext</tt></td>
    <td>  Download PDF files for graphical music scores for each piece from the
	  <a href=http://www.tassomusic.org>TMP website</a> with lyrics removed
	  from all parts.
    </tr>
<tr><td><tt>make&nbsp;web-reduced</tt></td>
    <td>  Download version of the data file which divides all note durations
          by a factor of four.  This data is useful for doing rhythmic
	  analysis with the standard Humdrum Toolkit.  
    </tr>
<tr><td colspan=2> <a href=http://github.com/craigsapp/humextra>Humdrum Extras</a>
      installation required: </td></tr>
<tr><td><tt>make&nbsp;reduced</tt></td>
    <td>  Decrease all note durations by a factor of four.  Output data 
          will be stored in a directory called <tt>kern-reduced</tt> within
          each composer's directory.  Similar to <tt>make web-reduced</tt>, but
	  much faster.
    </tr>
<tr><td><tt>make&nbsp;notext</tt></td>
    <td>  Remove lyrics from all parts. Resulting data
          will be stored in a directory called <tt>kern-notext</tt> within
          each composer's directory.  
    </tr>
<tr><td><tt>make&nbsp;genres</tt></td>
    <td>  Download works organized by genre from kernScores.
    </tr>
<tr><td colspan=2> <a href=http://github.com/humdrum-tools/humdrum-tools>Humdrum Toolkit</a>
      installation required: </td></tr>
<tr><td><tt>make&nbsp;census</tt></td>
    <td>  Run <tt>census&nbsp;-k</tt> on all works.
    </tr>
</table>



# Alternate data access #

### TMP website ###

The website http://www.tassomusic.org is a high-level interface
to these scores, but also includes lower-level access to the data,
data conversions, and analytic tools using URL parameters in the
web address.  On the TMP website, each score has a "work info" page
generated with this format:

```
http://www.tassomusic.org/work?id=Trm0047m
```

Where ```Trm0047m``` is the TMP catalog for the 13th musical setting
of rime 47.  


### kernScores website ###

The [kernScores](http://kern.humdrum.org) library of musical scores
for analysis in the Humdrum Toolkit has a page dedicated to the TMP
scores:

```
http://kern.humdrum.org/browse?l=tmp
```

### VHV website ###

The TMP scores can also be viewed with the Verovio Humdrum Viewer by
going to this URL:

```
http://verovio.humdrum.org/?file=tmp
```

