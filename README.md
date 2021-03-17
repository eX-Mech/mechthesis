# MechThesis

part of MechThesis template: https://github.com/eX-Mech/mechthesis.git

Jacopo Canton, Nicolò Fabbiane (in alphabetical order)<br /> 
jcanton-at-mech.kth.se, nicolo-at-mech.kth.se

September, 2016


This template is meant for PhD and Licentiate theses at KTH Mechanics.<br /> 
It is based on the previous template by the (not-so-)anonymous DS.
Thank you, DS.<br /> 

This is just a STARTING POINT: you can use it or not, like it or not, edit it
or not, thank us or not.


## COMPILE
A Makefile has been developed for this template and tested for `pdflatex` and
`lualatex`. The options implemented are:

 - `all`(default): compile the whole package (BibTeX included)
 - `clean`:        clean all auxiliary files (except the pdf)
 - `clean_thesis`: clean auxiliary files for the introduction only
 - `clean_papers`: clean auxiliary files for the papers only

### Partial compilation via `\includeonly`
It is possible to compile only some parts of the document via `\includeonly`.
This command permits to specify which `\include` arguments are compiled.
For example, specifying in the premable:

   `\includeonly{introduction,paper1/paper}`

will compile only the introduction and the first paper. More information about
this feature can be found at https://en.wikibooks.org/wiki/TeX/includeonly.


## USE OF THE TEMPLATE

### Papers
Each paper has its own folder numbered consecutively, as it appears in the
thesis. Each folder must contain the source files and the figures necessary for
the paper, while all bibliography entries have to be collected in the unique
bibliography file `thesis.bib`.
Each paper has to be prepared before compilation as follows:

 - comment preamble, bibliography and begin/end{document} in the original
   source file and rename it `article.tex`;
 - copy any custom commands/packages in `commands.tex`/`packages.tex` in
   the main folder;
 - edit the paper information in `paper.tex` file.

The paper list in the preface, the table of contents and the chapter 'Summary
of the Papers' are automatically written using the paper information found in
`paper.tex`.

### Packages and commands
Two files are provided for custom commands and packages: `commands.tex` and
`packages.tex`. These files are located in the main folder.
We reccomend to add commands and packages in these files only.

### List of options for the class, defaults are in [ ]:

 - paper size:
    - `a4paper`:        A4 format
    - `letterpaper`:    US letter format
    - `thesissisze`:    old paper format for the thesis
    - `thesissizeA4`:   A4 format, different margins
    - [`thesissizeG5`]: G5 format (current format for the thesis)

 - printing:
    - [`twoside`]: two sided pages
    - `oneside`:   one sided pages

 - columns:
    - [`onecolumn`]: one column text
    - `twocolumns`:  two column text

 - font size: `8pt`, `9pt`, [`10pt`], `11pt`, `12pt`

 - position of equation numbers:
    - `leqno`:   equation numbers flushed to the left of the page
    - [`reqno`]: equation numbers flushed to the right of the page

 - split-equation numbers:
    - [`tbtags`]:    equation numbers vertically aligned with last eq. line
    - `centertags`:  equation numbers vertically centered to the equation

 - page numbers in papers:
    - [`globalpagenum`]: papers' pages continue the introduction page numbering
    - `paperpagenum`:    each paper has its own page numbering as P#-page

 - editing:
    - [`final`]:    generate a complete pdf
    - `draft`:      generate a pdf where figures are replaced by boxes
    - `printA4`:    generate a pdf in A4, top-left aligned, with original margins
                    (preferred by the printer US-AB in 2015)
    - `cropmarks`:  generate a pdf in A4, center aligned, with original margins
                    and cropmarks

 - paper covers:
    - `happyadvisor`: recomputes the paper tags spacing on the cover of each
                      paper if you have more than 8 papers


We decline any responsibility for the usage of this template including bugs,
bed-bugs, formatting errors, unhappy advisors, Justin Bieber and death; not 
necessarily in this order.
