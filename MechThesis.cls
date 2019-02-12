%
% This file is Mechthesis.cls
%
% part of MechThesis template: https://github.com/jcanton/mechthesis.git
%
% Jacopo Canton, Nicolò Fabbiane (in alphabetical order)
% jcanton<at>mech.kth.se, nicolo<at>mech.kth.se
%
% Based on the template by the (not-so-)anonymous DS. Thank you, DS.
%
% November, 2017
%
%==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MechThesis}[2015/11/20]
\def\@tempa#1#2\@nil{\edef\@classname{#1}}
\expandafter\@tempa\@currnamestack{}{}{}\@nil
\ifx\@classname\@empty \edef\@classname{\@currname}\fi
\DeclareOption{a4paper}{\paperheight 297mm\paperwidth 210mm
   \textheight 54.5pc }
\DeclareOption{letterpaper}{\paperheight 11in\paperwidth 8.5in }
\DeclareOption{landscape}{\@tempdima\paperheight
   \paperheight\paperwidth \paperwidth\@tempdima}
\DeclareOption{thesissize}{\paperheight 240mm\paperwidth 170mm
\textheight=190mm \textwidth=120mm}
\DeclareOption{thesissizeA4}{\paperheight 297mm\paperwidth 210mm
\textheight=228mm \textwidth=148mm}
\DeclareOption{thesissizeG5}{\paperheight 242mm\paperwidth 164mm
\textheight=47pc \textwidth=120mm}
%
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\overfullrule5\p@}
\DeclareOption{final}{\overfullrule\z@ }
\newif\if@printafour % Print in A4 (required from the printer Universitetsservice US--AB in 2014)
\DeclareOption{printA4}{\@printafourtrue}
\newif\if@cropmarks % Add cropmarks and print in A4
\DeclareOption{cropmarks}{\@cropmarkstrue}
\newif\if@titlepage
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{nomath}{%
   \def\numberwithin##1##2{\@ifundefined{c@##1}{\@nocounterr{##1}}{%
     \@ifundefined{c@##2}{\@nocounterr{##2}}{%
     \@addtoreset{##1}{##2}%
     \toks@\@xp\@xp\@xp{\csname the##1\endcsname}%
     \@xp\xdef\csname the##1\endcsname
       {\@xp\@nx\csname the##2\endcsname
        .\the\toks@}}}}
}
\DeclareOption{psamsfonts}{%
   \PassOptionsToPackage{psamsfonts}{amsfonts}%
   \PassOptionsToPackage{cmex10}{amsmath}}
\newif\iftagsleft@
\DeclareOption{leqno}{%
   \tagsleft@true \PassOptionsToPackage{leqno}{amsmath}}
\DeclareOption{reqno}{%
   \tagsleft@false \PassOptionsToPackage{reqno}{amsmath}}
\newif\ifctagsplit@
\DeclareOption{centertags}{%
   \ctagsplit@true \PassOptionsToPackage{centertags}{amsmath}}
\DeclareOption{tbtags}{%
   \ctagsplit@false \PassOptionsToPackage{tbtags}{amsmath}}
\DeclareOption{fleqn}{%
   \def\[{\relax
     \ifmmode\@badmath
     \else
       \begin{trivlist}%
       \@beginparpenalty\predisplaypenalty
       \@endparpenalty\postdisplaypenalty
       \item[]\leavevmode
       \hbox to\linewidth\bgroup$\displaystyle
       \hskip\mathindent\bgroup
     \fi}%
   \def\]{\relax
     \ifmmode
       \egroup \m@th$\hfil \egroup
       \end{trivlist}%
     \else \@badmath
     \fi}%
   \renewenvironment{equation}{%
     \@beginparpenalty\predisplaypenalty
     \@endparpenalty\postdisplaypenalty
     \refstepcounter{equation}%
     \@topsep\abovedisplayskip \trivlist
     \item[]\leavevmode
     \hbox to\linewidth\bgroup\hskip\mathindent$\displaystyle
   }{%
     \m@th$\hfil \displaywidth\linewidth \hbox{\@eqnnum}\egroup
     \endtrivlist
   }%
   \renewenvironment{eqnarray}{%
     \stepcounter{equation}\let\@currentlabel\theequation
     \global\@eqnswtrue \global\@eqcnt\z@ \tabskip\mathindent
     \let\\=\@eqncr \abovedisplayskip\topsep
     \ifvmode \advance\abovedisplayskip\partopsep \fi
     \belowdisplayskip\abovedisplayskip
     \belowdisplayshortskip\abovedisplayskip
     \abovedisplayshortskip\abovedisplayskip
     $$\everycr{}\halign to\linewidth\bgroup
       \hskip\@centering
       $\displaystyle\tabskip\z@skip####\m@th$&%
       \@eqnsel \global\@eqcnt\@ne
       \hfil${}####{}\m@th$\hfil&%
       \global\@eqcnt\tw@
       $\displaystyle ####\m@th$\hfil\tabskip\@centering&%
       \global\@eqcnt\thr@@
       \hbox to \z@\bgroup\hss####\egroup\tabskip\z@skip\cr
     }{%
       \@@eqncr \egroup \global\advance\c@equation\m@ne$$%
       \global\@ignoretrue
     }%
   \newdimen\mathindent \mathindent\leftmargini
}
\newif\if@paperpagenum
\DeclareOption{paperpagenum}{\@paperpagenumtrue}
\DeclareOption{globalpagenum}{\@paperpagenumfalse}
\newif\if@happyadvisor
\DeclareOption{happyadvisor}{\@happyadvisortrue}
\AtBeginDocument{%
   \if@printafour\usepackage[a4]{crop}\fi
   \if@cropmarks\usepackage[cam,a4,center]{crop}\fi
   \@ifpackageloaded{natbib}
     {\bibpunct{(}{)}{;}{a}{}{,}%
      \global\let\thebibliography\JFMthebib
      \global\let\endthebibliography\JFMendthebib}
     {\relax}%
}%
%
\newcommand{\ignorenewline}{\let\\=~}
\newcommand{\@mainsize}{10}
\newcommand{\@ptsize}{0}
\newcommand{\larger}[1][1]{%
   \count@\@currsizeindex \advance\count@#1\relax
   \ifnum\count@<\z@ \count@\z@ \else\ifnum\count@>12 \count@12 \fi\fi
   \ifcase\count@
     \Tiny\or\Tiny\or\tiny\or\SMALL\or\Small\or\small
     \or\normalsize
     \or\large\or\Large\or\LARGE\or\huge\or\Huge\else\Huge
   \fi
}
\newcommand{\smaller}[1][1]{\larger[-#1]}
\def\@adjustvertspacing{%
   \bigskipamount.7\baselineskip plus.7\baselineskip
   \medskipamount\bigskipamount \divide\medskipamount\tw@
   \smallskipamount\medskipamount \divide\smallskipamount\tw@
   \abovedisplayskip\medskipamount
   \belowdisplayskip \abovedisplayskip
   \abovedisplayshortskip\abovedisplayskip
   \advance\abovedisplayshortskip-1\abovedisplayskip
   \belowdisplayshortskip\abovedisplayshortskip
   \advance\belowdisplayshortskip 1\smallskipamount
   \jot\baselineskip \divide\jot 4 \relax
}

\renewcommand\normalsize{\@xsetfontsize\normalsize 6%
   \@adjustvertspacing \let\@listi\@listI}
\newcommand\Tiny{\@xsetfontsize\Tiny 1}
\newcommand\tiny{\@xsetfontsize\tiny 2}
\newcommand\SMALL{\@xsetfontsize\SMALL 3}
\newcommand\Small{\@xsetfontsize\Small 4%
   \@adjustvertspacing
   \def\@listi{\topsep\smallskipamount \parsep\z@skip \itemsep\z@skip}}
\newcommand\small{\@xsetfontsize\small 5\@adjustvertspacing}
\def\footnotesize{\Small}
\def\scriptsize{\SMALL}
\newcommand\large{\@xsetfontsize\large 7\@adjustvertspacing}
\newcommand\Large{\@xsetfontsize\Large 8\@adjustvertspacing}
\newcommand\LARGE{\@xsetfontsize\LARGE 9}
\newcommand\huge{\@xsetfontsize\huge{10}}
\newcommand\Huge{\@xsetfontsize\Huge{11}}
\newcommand{\change}[1]{{\color{Rhodamine}#1}}
\def\@xsetfontsize#1#2{%
   \chardef\@currsizeindex#2\relax
   \edef\@tempa{\@nx\@setfontsize\@nx#1%
     \@xp\ifcase\@xp\@currsizeindex\@typesizes
       \else{99}{99}\fi}%
   \@tempa
}
\chardef\@currsizeindex=6
\widowpenalty=10000
\clubpenalty=10000
\brokenpenalty=10000
\newdimen\linespacing
\lineskip=1pt \lineskiplimit=1pt
\normallineskip=1pt \normallineskiplimit=1pt
\let\baselinestretch=\@empty
\headheight=5pt \headsep=18pt
\footskip=18pt
\textheight=50.5pc \topskip=10pt
\textwidth=30pc
\columnsep=10pt \columnseprule=0pt
\marginparwidth=50pt
\marginparsep=6pt
\marginparpush=5pt
\AtBeginDocument{\settoheight{\footnotesep}{\footnotesize M$^1$}}
\skip\footins=7pt plus11pt
\skip\@mpfootins=\skip\footins
\fboxsep=3pt \fboxrule=.4pt
\arrayrulewidth=.4pt    \doublerulesep=2pt
\labelsep=5pt           \arraycolsep=\labelsep
\tabcolsep=\labelsep    \tabbingsep=\labelsep
\floatsep=15pt plus 12pt    \dblfloatsep=15pt plus 12pt
\textfloatsep=\floatsep  \dbltextfloatsep=15pt plus 12pt
\intextsep=\floatsep
\@fptop=0pt plus1fil     \@dblfptop=0pt plus1fil
\@fpbot=0pt plus1fil     \@dblfpbot=0pt plus1fil
\@fpsep=8pt plus2fil     \@dblfpsep=8pt plus2fil\relax
\parskip=2pt \relax
\newdimen\normalparindent
\normalparindent=18pt
\parindent=\normalparindent
\partopsep=0pt \relax \parsep=0pt \relax \itemsep=0pt \relax
\@lowpenalty=51         \@medpenalty=151        \@highpenalty=301
\@beginparpenalty=-\@lowpenalty
\@endparpenalty=-\@lowpenalty
\@itempenalty=-\@lowpenalty
\DeclareOption{8pt}{\def\@mainsize{8}\def\@ptsize{8}%
   \def\@typesizes{%
     \or{5}{6}\or{5}{6}\or{5}{6}\or{6}{7}\or{7}{8}%
     \or{8}{10}% normalsize
     \or{9}{11}\or{10}{12}\or{\@xipt}{13}%
     \or{\@xiipt}{14}\or{\@xivpt}{17}}%
   \normalsize \linespacing=\baselineskip
}
\DeclareOption{9pt}{\def\@mainsize{9}\def\@ptsize{9}%
   \def\@typesizes{%
     \or{5}{6}\or{5}{6}\or{6}{7}\or{7}{8}\or{8}{10}%
     \or{9}{11}% normalsize
     \or{10}{12}\or{\@xipt}{13}\or{\@xiipt}{14}%
     \or{\@xivpt}{17}\or{\@xviipt}{20}}%
   \normalsize \linespacing=\baselineskip
}
\DeclareOption{10pt}{\def\@mainsize{10}\def\@ptsize{0}%
   \def\@typesizes{%
     \or{5}{6}\or{6}{7}\or{7}{8}\or{8}{10}\or{9}{11}%
     \or{10}{12}% normalsize
     \or{\@xipt}{13}\or{\@xiipt}{14}\or{\@xivpt}{17}%
     \or{\@xviipt}{20}\or{\@xxpt}{24}}%
   \normalsize \linespacing=\baselineskip
}
\DeclareOption{11pt}{\def\@mainsize{11}\def\@ptsize{1}%
   \def\@typesizes{%
     \or{6}{7}\or{7}{8}\or{8}{10}\or{9}{11}\or{10}{12}%
     \or{\@xipt}{13}% normalsize
     \or{\@xiipt}{14}\or{\@xivpt}{17}\or{\@xviipt}{20}%
     \or{\@xxpt}{24}\or{\@xxvpt}{30}}%
   \normalsize \linespacing=\baselineskip
}
\DeclareOption{12pt}{\def\@mainsize{12}\def\@ptsize{2}%
   \def\@typesizes{%
     \or{7}{8}\or{8}{10}\or{9}{11}\or{10}{12}\or{\@xipt}{13}%
     \or{\@xiipt}{14}% normalsize
     \or{\@xivpt}{17}\or{\@xviipt}{20}\or{\@xxpt}{24}%
     \or{\@xxvpt}{30}\or{\@xxvpt}{30}}%
   \normalsize \linespacing=\baselineskip
}

\DeclareOption{makeidx}{}
\input{amsgen.sty}
%
%------------------------------------------------------------------------------
% Default options for MechThesis class
%
\ExecuteOptions{thesissizeG5,twoside,onecolumn,10pt,reqno,tbtags,globalpagenum,final}
\ProcessOptions\relax
%------------------------------------------------------------------------------
%
\let\paragraphname\@empty
\let\subparagraphname\@empty
\let\sectionname\@empty
\let\subsectionname\@empty
\let\subsubsectionname\@empty
\def\leftmark{\expandafter\@firstoftwo\topmark{}{}}
\def\rightmark{\expandafter\@secondoftwo\botmark{}{}}
\long\def\@nilgobble#1\@nil{}
\def\@secmark#1#2#3#4{%
   \begingroup \let\protect\@unexpandable@protect
   \edef\@tempa{\endgroup \toks@{\@nx#2{#3}{\@secnumber}}}%
   \@tempa
   \toks@\@xp{\the\toks@{#4}}%
   \afterassignment\@nilgobble\@temptokena\@themark{}\@nil
   \edef\@tempa{\@nx\@mkboth{%
     \ifx\markright#1\the\@temptokena\else\the\toks@\fi}{\the\toks@}}%
   \@tempa}
\let\@secnumber\@empty
\def\markboth#1#2{%
   \begingroup
     \@temptokena{{#1}{#2}}\xdef\@themark{\the\@temptokena}%
     \mark{\the\@temptokena}%
   \endgroup
   \if@nobreak\ifvmode\nobreak\fi\fi}
\def\ps@myheadings{\ps@headings \let\@mkboth\@gobbletwo}
\newskip\normaltopskip
\normaltopskip=10pt \relax
\let\sectionmark\@gobble
\let\subsectionmark\@gobble
\let\subsubsectionmark\@gobble
\let\paragraphmark\@gobble
%
\def\ps@empty{\let\@mkboth\@gobbletwo
   \let\@oddhead\@empty \let\@evenhead\@empty
   \let\@oddfoot\@empty \let\@evenfoot\@empty
   \global\topskip\normaltopskip}
\def\ps@plain{\ps@empty
	\def\@oddfoot{\normalfont\scriptsize \hfil\thepage\hfil}%
	\let\@evenfoot\@oddfoot}
\def\ps@headings{\ps@empty
   \def\@evenhead{%
		\small \rlap{\thepage}\hspace{8mm}% headings are not centered (left)
		{\leftmark}\hfil%
	}%
   \def\@oddhead{%
		\small \hfil {\rightmark}% headings are not centered (right)
		\hspace{8mm}\llap{\thepage}%
	}%
   \let\@mkboth\markboth
   \def\partmark{\@secmark\markboth\partrunhead\partname}%
   \def\chaptermark{%
   	\@secmark\markboth\chapterrunhead{}%
	}%
   \def\sectionmark{%
   	\@secmark\markright\sectionrunhead\sectionname%
	}%
}
%------------------------------------------------------------------------------
\def\cleardoublepage{
	\clearpage \if@twoside
	\ifodd\c@page
	\else\hbox{}\thispagestyle{empty}\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi
}
%------------------------------------------------------------------------------
% Header, footer, and page style in paper environment
% from JFM.cls 9907
\def\ps@paper{\let\@mkboth\markboth
   \def\@oddhead{%
		\hfil{\itshape\ignorenewline\@shortpapertitle}%
		\hfil%
		\stepcounter{paperpage}\llap{\small\if@paperpagenum\thepaperpage\else\thepage\fi}%
	}%
   \def\@evenhead{%
		\stepcounter{paperpage}\rlap{\small\if@paperpagenum\thepaperpage\else\thepage\fi}%
		\hfil%
		\itshape\@shortpaperauthor\hfil%
	}%
%	\def\@oddfoot{\normalfont\scriptsize \hfill\stepcounter{paperpage}\thepaperpage\hfill}%
	\def\@oddfoot{}%
	\let\@evenfoot\@oddfoot
   \def\sectionmark##1{\markboth{##1}{}}%
   \def\subsectionmark##1{\markright{##1}}%
}
\def\ps@paperplain{
	\ps@empty
	\def\@oddfoot{\normalfont\scriptsize \hfill\stepcounter{paperpage}\if@paperpagenum\thepaperpage\else\thepage\fi\hfill}%
	\let\@evenfoot\@oddfoot
}
%------------------------------------------------------------------------------
%
\expandafter\@iden
%
\usepackage[dvipsnames]{xcolor}\relax
\RequirePackage{amsmath}\relax
\RequirePackage{amsfonts}\relax
\RequirePackage{amssymb}\relax
%
\newcommand{\uppercasenonmath}[1]{\toks@\@emptytoks
   \@xp\@skipmath\@xp\@empty#1$$%
   \edef#1{\@nx\@upprep\the\toks@}%
}
\newcommand{\@upprep}{%
   \spaceskip1.3\fontdimen2\font plus1.3\fontdimen3\font
   \upchars@}
\newcommand{\upchars@}{%
   \def\ss{SS}\def\i{I}\def\j{J}\def\ae{\AE}\def\oe{\OE}%
   \def\o{\O}\def\aa{\AA}\def\l{\L}\def\Mc{M{\scshape c}}}
\newcommand{\@skipmath}{}
\long\def\@skipmath#1$#2${%
   \@xskipmath#1\(\)%
   \@ifnotempty{#2}{\toks@\@xp{\the\toks@$#2$}\@skipmath\@empty}}%
\newcommand{\@xskipmath}{}
\long\def\@xskipmath#1\(#2\){%
   \uppercase{\toks@\@xp\@xp\@xp{\@xp\the\@xp\toks@#1}}%
   \@ifnotempty{#2}{\toks@\@xp{\the\toks@\(#2\)}\@xskipmath\@empty}}%
\newcommand{\today}{%
   \relax\ifcase\month\or
   January\or February\or March\or April\or May\or June\or
   July\or August\or September\or October\or November\or December\fi
   \space\number\day, \number\year}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
%------------------------------------------------------------------------------
% Title, authors, affiliations in paper environment
% from JFM.cls 9907
%
\let\fontswitch=\relax
%
\newcommand\papertitle{\@ifnextchar [{\@papertitletwo}{\@papertitleone}}
\def\@papertitletwo[#1]#2{\gdef\@papertitle{#2}\gdef\@shortpapertitle{#1}}
\def\@papertitleone#1{%
	\gdef\@papertitle{#1}\gdef\@shortpapertitle{#1}%
}
\newcommand\shortpapertitle[1]{\gdef\@shortpapertitle{#1}}
\def\papertoctitle#1{\gdef\@papertoctitle{#1}}
%
\newcommand\paperaffiliation[1]{\gdef\@paperaffiliation{#1}}
%
\newcommand\paperauthor{\@ifnextchar [{\@paperauthortwo}{\@paperauthorone}}
\def\@paperauthortwo[#1]#2{\gdef\@paperauthor{#2}\gdef\@shortpaperauthor{#1}}
\def\@paperauthorone#1{%
	\gdef\@paperauthor{#1}%
	\begingroup%
		\def\paperand{and}\gdef\@shortpaperauthor{#1}%
	\endgroup%
}
\newcommand\shortpaperauthor[1]{\gdef\@shortpaperauthor{#1}}
%
\newcommand\listpaperauthor[1]{\gdef\@listpaperauthor{#1}}
%
\newcommand\paperjournal{\@ifnextchar [{\@paperjournaltwo}{\@paperjournalone}}
\def\@paperjournaltwo[#1]#2{\gdef\@paperjournal{#2}\gdef\@shortpaperjournal{#1}}
\def\@paperjournalone#1{%
	\gdef\@paperjournal{#1}\gdef\@shortpaperjournal{#1}%
}
%
\def\papervolume#1{\gdef\@papervolume{#1}}
%
\def\papernumber#1{\gdef\@papernumber{#1}}
%
\def\paperpages#1{\gdef\@paperpages{#1}}
%
\def\paperyear#1{\gdef\@paperyear{#1}}
%
\newcommand\papersummary[1]{\gdef\@papersummary{#1}}
%
\newcommand\paperinit%
{%
	\papertitle{}
	\papertoctitle{}
	\paperauthor{}
	\listpaperauthor{}
	\paperaffiliation{}
	\paperjournal{}
	\papervolume{}
	\papernumber{}
	\paperpages{}
	\paperyear{}
	\papersummary{}
}%
\paperinit
%-----------------------------------------------------------------------------
\def\title{\@ifnextchar [{\@titletwo}{\@titleone}}
\def\@titletwo[#1]#2{\gdef\@title{#2}\gdef\@abstracttitle{#1}}
\def\@titleone#1{%
	\gdef\@title{#1}\gdef\@abstracttitle{\ignorenewline #1}%
}
\def\titel#1{\gdef\@titel{#1}}
\gdef\@titel{\@empty}
%
\def\author{\@ifnextchar [{\@authortwo}{\@authorone}}
\def\@authortwo[#1]#2{\gdef\@author{#2}\gdef\@shortauthor{#1}}
\def\@authorone#1{%
	\gdef\@author{#1}\gdef\@shortauthor{#1}%
}
%
\def\affiliation#1{\gdef\@affiliation{#1}}
\def\anslutning#1{\gdef\@anslutning{#1}}
\gdef\@anslutning{\@empty}
%
\def\date#1#2#3{\gdef\@city{#1}\gdef\@month{#2}\gdef\@year{#3}}
%
\def\info#1{\gdef\@info{#1}}
%
\def\printer#1{\gdef\@printer{#1}}
%
%------------------------------------------------------------------------------
%	Front matter macros
%
\def\mechdocument{Technical Reports}%
\def\mechaddress{%
	Royal Institute of Technology\par%
	Department of Mechanics\par%
	SE-100 44 Stockholm, Sweden\par%
}%	
\def\makecoverpage{%
	\thispagestyle{empty}%
	\setcounter{page}{1}%
	\pdfbookmark[0]{Cover page}{coverpage}
   \topskip 5cm%
   \begingroup%
   %
   \begingroup%
	\LARGE\bfseries\centering%
	\@title%
	\bigskip\bigskip\par%
	\endgroup%
	\centering by%
	\bigskip\bigskip\par%
	\begingroup%
	\LARGE\mdseries\centering%
	\@author%
	\bigskip\bigskip\par%
	\endgroup%
	%
	\vspace*{\fill}%
	%
	\@month~\@year\par%
	\mechdocument\par%
	\mechaddress\par%
	\endgroup%
	\clearpage%
	\thispagestyle{empty}%
	\refstepcounter{frontsection}%
	\vspace*{\fill}%
	\begingroup%
	\otherlanguage{swedish}
	\noindent\ignorespaces\@info\bigskip\par%
	\otherlanguage{english}
	%
	\noindent\copyright\@author~\@year%
	\smallskip\par%
	%
	\noindent\@printer~\@year%
	\endgroup%
	\clearpage%
}%
%
\def\dedication#1{%
	\cleardoublepage%
	\thispagestyle{empty}%
	\refstepcounter{frontsection}%
	\null\vspace{\stretch{0.2}}%
	\begingroup%
	\flushright#1\par%
	\endgroup%
	\vspace*{\fill}%
	\cleardoublepage%
}%
%
\newenvironment{abstract}{%
	\newcommand\keywords[1]{%
		\bigskip\bigskip\par%
		\noindent{\bf Key words:~}##1
	}%
	\clearpage%
	\refstepcounter{frontsection}%
   \typeout{Abstract\space\@secnumber}%
   \def\@toclevel{0}%
	\@tocwriteb\tocchapter{chapter}{Abstract}%
	%
	\noindent{\Large\bf\@abstracttitle}%
	\bigskip\par%
	\noindent{\bf\@author}%
	\par%
	\noindent\@affiliation%
	\bigskip\bigskip\par%
	\noindent{\Large\bf Abstract}%
	\par%
	\noindent\ignorespaces%
}{%
	\clearpage%
}%
\newenvironment{abstrakt}{%
	\newcommand\nyckelord[1]{%
		\bigskip\bigskip\par%
		\noindent{\bf Nyckelord:~}##1
	}%
	\clearpage%
	\refstepcounter{frontsection}%
	\begin{otherlanguage}{swedish}
   \let\@secnumber\@empty%
   \typeout{Sammanfattning\space\@secnumber}%
   \def\@toclevel{0}%
	\@tocwriteb\tocchapter{chapter}{Sammanfattning}
	%
	\noindent{\Large\bf\@titel}%
	\bigskip\par%
	\noindent{\bf\@author}%
	\par%
	\noindent\@anslutning%
	\bigskip\bigskip\par%
	\noindent{\Large\bf Sammanfattning}%
	\par%
	\noindent\ignorespaces%
}{%
	\end{otherlanguage}
	\clearpage%
}%
\newenvironment{preface}{%
	\clearpage%
	\refstepcounter{frontsection}%
   \let\@secnumber\@empty%
   \typeout{Preface\space\@secnumber}%
   \def\@toclevel{0}%
	\@tocwriteb\tocchapter{chapter}{Preface}%
	\begingroup%
		\centering\large\bf Preface%
		\bigskip\par%
	\endgroup%
	\noindent\ignorespaces%
}{%
	\bigskip\par%
	\IfFileExists{\jobname.pls}{\input{\jobname.pls}}{}
	\bigskip\par%
	\flushright%
	\@month~\@year,~\@city%
	\par%
	{\it \@author}%
	\par%
	\clearpage%
}%
\newenvironment{divisionofwork}{%
	\bigskip\par%
	\refstepcounter{frontsection}%
	\noindent {\bf{Division of work between authors}}%
	\par%
	\newcounter{listcount}\setcounter{listcount}{0}%
	\newcommand\paperitem{%
		\stepcounter{listcount}
		\smallskip\par%
		\noindent{\bf\papername~\thelistcount.}~%
	}%
	\noindent\ignorespaces%
}{%
	\medskip\par%
}%
\newenvironment{otherpublications}{%
	\bigskip\par%
	\refstepcounter{frontsection}%
	\noindent {\bf{Other publications}}%
	\par%
	\newcommand\paperitem[7]{%
		% 1:authors, 2:year, 3:title, 4:journal, 5:volume, 6:number, 7:pages
		\smallskip\par%
		\noindent%
		{\sc ##1}%
		\@ifempty{##2}{.}{, ##2.}%
		\@ifempty{##3}{}{ {\it ##3}.}%
		\@ifempty{##4}{}{ ##4}%
		\@ifempty{##5}{}{ {\bf##5}}%
		\@ifempty{##6}{}{ (##6)}%
		\@ifempty{##7}{}{, ##7}.%
	}%
	\noindent\ignorespaces%
}{%
	\medskip\par%
}%
\newenvironment{conferences}{%
	\bigskip\par
	\refstepcounter{frontsection}%
	\noindent {\bf{Conferences}}%
	\par%
	\newcommand\conferenceitem[5]{%
		% 1:authors, 2:year, 3:title, 4:conference, 5:location
		\smallskip\par%
		\noindent%
		{\sc ##1.}%
		\@ifempty{##3}{}{ {\it ##3}.}%
		\@ifempty{##4}{}{ ##4}%
		\@ifempty{##5}{.}{. ##5}%
		\@ifempty{##2}{.}{, ##2.}%
	}%
	\noindent\ignorespaces%
}{%
	\medskip\par%
}%
\newcommand{\thesisstructure}{%
	\bigskip\par{\noindent{\bf Thesis structure.}~\ignorespaces}%
}%
%------------------------------------------------------------------------------
% from JFM.cls
\newenvironment{paperabstract}
   {\newcommand\keywords[1]{%
			\par\vskip 9\p@ \@plus 1\p@ \@minus 1\p@
    	\noindent\small{\bf Key words:} ##1\par
		 }%
		\par\normalfont\normalsize\noindent\ignorespaces
	 }%
   {\par\vskip 5\p@ \@plus 1\p@ \@minus 1\p@
    \vbox{\centerline{\rule[4\p@]{\textwidth}{.4\p@}}}}
%------------------------------------------------------------------------------
\def\labelenumi{\theenumi.}
\def\theenumi{\@arabic\c@enumi} \def\labelenumii{(\theenumii)}
\def\theenumii{\@alph\c@enumii} \def\p@enumii{\theenumi}
\def\labelenumiii{(\theenumiii)} \def\theenumiii{\@roman\c@enumiii}
\def\p@enumiii{\theenumi(\theenumii)} \def\labelenumiv{(\theenumiv)}
\def\theenumiv{\@Alph\c@enumiv} \def\p@enumiv{\p@enumiii\theenumiii}
\def\labelitemi{$\m@th\bullet$}
\def\labelitemii{\bfseries --}% \upshape already done by \itemize
\def\labelitemiii{$\m@th\ast$}
\def\labelitemiv{$\m@th\cdot$}
\def\verse{\let\\\@centercr
   \list{}{\itemsep\z@ \itemindent -1.5em\listparindent\itemindent
   \rightmargin\leftmargin \advance\leftmargin 1.5em}\item[]}
\let\endverse=\endlist
\def\quotation{\list{}{%
     \leftmargin3pc \listparindent\normalparindent
     \itemindent\z@
     \rightmargin\leftmargin \parsep\z@ \@plus\p@}%
   \item[]}
\let\endquotation=\endlist
\def\quote{\list{}{\rightmargin\leftmargin}\item[]}
\let\endquote=\endlist
\def\trivlist{\parsep\parskip\@nmbrlistfalse
   \@trivlist \labelwidth\z@ \leftmargin\z@
   \itemindent\z@
   \let\@itemlabel\@empty
   \def\makelabel##1{\upshape##1}}

\def\enumerate{\ifnum \@enumdepth >3 \@toodeep\else
       \advance\@enumdepth \@ne
       \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
       {\csname label\@enumctr\endcsname}{\usecounter
         {\@enumctr}\def\makelabel##1{\hss\llap{\upshape##1}}}\fi}

\def\itemize{%
   \ifnum\@itemdepth>3 \@toodeep
   \else \advance\@itemdepth\@ne
     \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
     \list{\csname\@itemitem\endcsname}%
       {\def\makelabel##1{\hss\llap{\upshape##1}}}%
   \fi}
\newcommand{\descriptionlabel}[1]{\hspace\labelsep \normalshape\rm (#1)}
\newcommand{\description}{\list{}{%
   \advance\leftmargini6\p@ \itemindent-6\p@
   \labelwidth\z@ \let\makelabel\descriptionlabel}}
\let\enddescription=\endlist
\let\upn=\textup
\AtBeginDocument{%
   \settowidth\leftmargini{\labelenumi\hskip\labelsep}%
   \advance\leftmargini by \normalparindent
   \settowidth\leftmarginii{\labelenumii\hskip\labelsep}%
   \advance\leftmarginii by 15pt
   \settowidth\leftmarginiii{\labelenumiii\hskip\labelsep}%
   \advance\leftmarginiii by 12pt
   \settowidth\leftmarginiv{\labelenumiv\hskip\labelsep}%
   \advance\leftmarginiv by 10pt
   \leftmarginv=10pt
   \leftmarginvi=10pt
   \leftmargin=\leftmargini
   \labelsep=5pt
   \labelwidth=\leftmargini \advance\labelwidth-\labelsep
   \@listi}
\newskip\listisep
\listisep\smallskipamount
\def\@listI{\leftmargin\leftmargini \parsep\z@skip
   \topsep\listisep \itemsep\z@skip
   \listparindent\normalparindent}
\let\@listi\@listI
\def\@listii{\leftmargin\leftmarginii
   \labelwidth\leftmarginii \advance\labelwidth-\labelsep
   \topsep\z@skip \parsep\z@skip \partopsep\z@skip \itemsep\z@skip}
\def\@listiii{\leftmargin\leftmarginiii
   \labelwidth\leftmarginiii \advance\labelwidth-\labelsep}
\def\@listiv{\leftmargin\leftmarginiv
   \labelwidth\leftmarginiv \advance\labelwidth-\labelsep}
\def\@listv{\leftmargin\leftmarginv
   \labelwidth\leftmarginv \advance\labelwidth-\labelsep}
\def\@listvi{\leftmargin\leftmarginvi
   \labelwidth\leftmarginvi \advance\labelwidth-\labelsep}
%
\def\@startsection#1#2#3#4#5#6{%
\if@noskipsec \leavevmode \fi
  \par \@tempskipa #4\relax
  \@afterindentfalse
  \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi
  \if@nobreak \everypar{}\else
      \addpenalty\@secpenalty\addvspace\@tempskipa\fi
  \@ifstar{\@dblarg{\@sect{#1}{\@m}{#3}{#4}{#5}{#6}}}%
          {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}%
}
%
\def\@sect#1#2#3#4#5#6[#7]#8{%
   \edef\@toclevel{\ifnum#2=\@m 0\else\number#2\fi}%
   \ifnum #2>\c@secnumdepth \let\@secnumber\@empty
   \else \@xp\let\@xp\@secnumber\csname the#1\endcsname\fi
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
     \refstepcounter{#1}%
     \edef\@svsec{\ifnum#2<\@m
        \@ifundefined{#1name}{}{%
          \ignorespaces\csname #1name\endcsname\space}\fi
        \@nx\textup{%
          \csname the#1\endcsname.}\enspace
     }%
   \fi
   \@tempskipa #5\relax
   \ifdim \@tempskipa>\z@ % then this is not a run-in section heading
     \begingroup #6\relax
     \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty\@M #8\par}%
     \endgroup
   \csname #1mark\endcsname{#7}%
     \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
   \else
   \def\@svsechd{#6\hskip #3\@svsec
     \@ifnotempty{#8}{\ignorespaces#8\unskip
        \@addpunct.}%
     \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
   }%
   \fi
   \global\@nobreaktrue
   \@xsect{#5}}
\let\@ssect\relax
\def\partname{Part}
\def\chaptername{Chapter}
\def\papername{Paper}
\def\appendixname{Appendix}
\newcounter{part}
\newcounter{chapter}
\newcounter{section}[chapter]
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
\newcounter{frontsection}
\newcounter{paper}
\newcounter{paperpage}
\newcommand\thepage            {\arabic{page}}
\renewcommand\thepart          {\Roman{part}}
\renewcommand\thechapter       {\arabic{chapter}}
\renewcommand\thepaper         {\arabic{paper}}
\renewcommand\thesection       {\thechapter.\arabic{section}}
\renewcommand\thesubsection    {\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection.\arabic{subsubsection}}
\renewcommand\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\renewcommand\thepaperpage     {P\thepaper-\arabic{paperpage}}
\setcounter{secnumdepth}{3}
\def\specialsection{\@startsection{section}{1}%
   \z@{2\linespacing\@plus\linespacing}{.5\linespacing}%
   {\large\scshape\centering}}
\def\part{%
	\cleardoublepage%
	\thispagestyle{empty}%
	\null\vfil%
	\markboth{}{}%
	\secdef\@part\@spart
}%
\def\@part[#1]#2{%
	\refstepcounter{part}%
   \let\@secnumber\thepart
   \typeout{\partname\space\@secnumber\space #2}%
   \def\@toclevel{-1}%
   \let\temp\thepage
   \def\thepage{~}
	\@tocwriteb\tocpart{part}{#2}
   %
   \begingroup
	\centering
   \ifnum \c@secnumdepth >-2\relax
        {\fontsize{\@xxpt}{25}\bfseries
          \partname\ \thepart}
          \vskip 20\p@ \fi
   \fontsize{\@xxpt}{25}\bfseries
       #1\vfil\vfil\endgroup \newpage\thispagestyle{empty}\cleardoublepage
   \let\thepage\temp
}

\def\@spart#1{\addcontentsline{toc}{part}{\protect\noindent#1}%
   \begingroup\centering
   \fontsize{\@xxpt}{25}\bfseries
      #1\vfil\vfil\endgroup \newpage\thispagestyle{empty}}
\def\partrunhead#1#2#3{%
   \@ifnotempty{#2}{\scshape{#1 #2}\@ifnotempty{#3}{. }}%
   \def\@tempa{#3}%
   \ifx\@empty\@tempa\else\scshape\@tempa\fi}
\let\chapterrunhead\partrunhead
\let\sectionrunhead\partrunhead
%------------------------------------------------------------------------------
% equations in paper environment, from JFM 9906
\numberwithin{equation}{chapter}
\newcommand\@raggedright{\rightskip=\@flushglue \let\\=\@centercr
   \parindent\z@}
\newcommand\@raggedcenter{\centering\rightskip=\@flushglue
   \let\\=\@centercr}
%------------------------------------------------------------------------------
%
\def\section{\@startsection{section}{1}%
   {\z@}
     {10\p@ \@plus 5\p@ \@minus 5\p@}
     {3\p@}
     {\normalfont\large\bfseries\@raggedright}}
\def\subsection{\@startsection{subsection}{2}%
   {\z@}
     {-9\p@ \@plus -2\p@ \@minus -2\p@}
     {3\p@}
     {\normalfont\normalsize\itshape\@raggedcenter}}
\def\subsubsection{\@startsection{subsubsection}{3}% OSO FIX 20000504
  {\z@}
     {-9\p@ \@plus -2\p@ \@minus -2\p@}
     {3\p@}
     {\normalfont\normalsize\itshape\@raggedright}}
\def\paragraph{\@startsection{paragraph}{4}%
   \normalparindent\z@{-\fontdimen2\font}%
   \normalfont}
\def\subparagraph{\@startsection{subparagraph}{5}%
   \z@\z@{-\fontdimen2\font}%
   \normalfont}
\def\appendixname{Appendix}
\def\@Roman#1{\@xp\@slowromancap
   \romannumeral#1@}%
\def\@slowromancap#1{\ifx @#1% then terminate
   \else
     \if i#1I\else\if v#1V\else\if x#1X\else\if l#1L\else\if
     c#1C\else\if m#1M\else#1\fi\fi\fi\fi\fi\fi
     \@xp\@slowromancap
   \fi
}
\def\frontmatter{%
	\cleardoublepage%
	\pagenumbering{roman}%
	\pagestyle{plain}%
}
\def\mainmatter{%
	\cleardoublepage%
	\pagenumbering{arabic}%
	\pagestyle{headings}%
        \setcounter{page}{-1}%
}
\def\backmatter{%
	\cleardoublepage%
}
%
\def\aufm #1\endaufm{\vspace*{12pt}{\flushright #1\par}}
\def\xcb{%
   \settowidth{\leftmargini}{0.\hskip\labelsep}%
   \settowidth{\leftmarginii}{(d.)\hskip\labelsep}%
\@startsection{section}% counter name; ignored because of the
                                 % * below
{1}% sectioning level
{\z@}% indent to the left of the section title
{18\p@\@plus2\p@}% vertical space above
{1sp}% Space below of 13pt base-to-base, so none needs to be added
     % here; but \z@ would cause the following text to be run-in, so we
     % use 1sp instead.
{\bfseries}% The font of the subsection title
*% always unnumbered
}%
\def\endxcb{\par}
%
\def\chapter{\clearpage \thispagestyle{plain}\global\@topnum\z@
   \@afterindentfalse \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
   \refstepcounter{chapter}%
   \ifnum\c@secnumdepth<\z@ \let\@secnumber\@empty
   \else \let\@secnumber\thechapter \fi
   \typeout{\chaptername\space\@secnumber\space #2}%
   \def\@toclevel{0}%
   \ifx\chaptername\appendixname \@tocwriteb\tocappendix{chapter}{#2}%
   \else \@tocwriteb\tocchapter{chapter}{#2}\fi
   \ifx\chaptername\appendixname
   \setcounter{equation}{0}
   \fi
   \chaptermark{#1}%
   \addtocontents{lof}{\protect\addvspace{10\p@}}%
   \addtocontents{lot}{\protect\addvspace{10\p@}}%
   \@makechapterhead{#2}\@afterheading
}
\def\@schapter#1{%
	\typeout{#1}%
   \let\@secnumber\@empty
   \def\@toclevel{0}%
   \ifx\chaptername\appendixname \@tocwriteb\tocappendix{chapter}{#1}%
   \else \@tocwriteb\tocchapter{chapter}{#1}\fi
   \chaptermark{#1}%
   \addtocontents{lof}{\protect\addvspace{10\p@}}%
   \addtocontents{lot}{\protect\addvspace{10\p@}}%
   \@makeschapterhead{#1}\@afterheading
}
%------------------------------------------------------------------------------
\newcounter{table}[chapter]
\newenvironment{acknowledgements}{%
   \chapter*{Acknowledgements}%
%   \par\vskip 10\p@ \@plus 1\p@ \@minus 1\p@%
}{%
	\par%
}%
\let\acknowledgments\acknowledgements
\let\endacknowledgements\endacknowledgments
%------------------------------------------------------------------------------
\newwrite\paperlistfile
\newif\if@paperlistopen
\newwrite\papersummfile
\newif\if@papersummopen
%
\newenvironment{paper}{
	\refstepcounter{paper}%
	\renewcommand{\HyperDestNameFilter}[1]{paper\thepaper##1}
	%
	\let\tlabel\label \renewcommand{\label}[1]{\tlabel{P\thepaper:##1}}
	\let\tlabeleq\label@in@display \renewcommand{\label@in@display}[1]{\tlabeleq{P\thepaper:##1}}
	\let\tref\ref \renewcommand{\ref}[1]{\tref{P\thepaper:##1}}
	%
	\let\@secnumber\thepaper%
   \def\@toclevel{0}%
   \let\temp\thepage
   \if@paperpagenum\def\thepage{P\thepaper}\fi
	\@tocwriteb\tocpaper{paper}{\@papertoctitle}
	\makepaperhead
   \let\thepage\temp
   \setcounter{figure}{0}%
   \setcounter{equation}{0}%
   \setcounter{table}{0}%
   \setcounter{chapter}{0}%
   \setcounter{section}{0}%
   \setcounter{paperpage}{0}%
	\renewcommand\thefigure{\@arabic\c@figure}
	\renewcommand\theequation{\@arabic\c@equation}
	\renewcommand\thetable{\@arabic\c@table}
	\renewcommand\thesection{\arabic{section}}
   \addtocontents{toc}{\setcounter {tocdepth}{0}}%
   \addtocontents{lof}{\protect\addvspace{10\p@}}%
   \addtocontents{lot}{\protect\addvspace{10\p@}}%
   %
	\def\@paperpublishlst{%
		\ifx\@shortpaperjournal\@empty\else\@empty{{\@shortpaperjournal}}\fi%
		\ifx\@papervolume\@empty\else{ {\bf\@papervolume}}\fi%
		\ifx\@papernumber\@empty\else{ (\@papernumber)}\fi%
		\ifx\@paperpages\@empty\else{, \@paperpages}\fi.%
	}%
	\if@paperlistopen\else
		\global\@paperlistopentrue
		\immediate\openout\paperlistfile=\jobname.pls\relax
	\fi
   \write\paperlistfile{%
   	\noindent%
   	{\bf\papername~\thepaper.} %
   	{\sc\ifx\@listpaperauthor\@empty\@shortpaperauthor\else\@listpaperauthor\fi}%
   	\ifx\@paperyear\@empty{. }\else{, \@paperyear. }\fi%
		{\it\detokenize\expandafter{\ignorenewline}%
		    \detokenize\expandafter{\@papertitle. }}%
		\@paperpublishlst%
   }%
   \write\paperlistfile{\bigskip\par}
   %
	\if@papersummopen\else
		\global\@papersummopentrue
		\immediate\openout\papersummfile=\jobname.psm\relax
	\fi
   \write\papersummfile{%
   	\unexpanded{\noindent}%
   	{\unexpanded{\large}\bf\papername~\thepaper}%
   	\unexpanded{\\*[\medskipamount]}%
		{\it\detokenize\expandafter{\ignorenewline}%
		    \detokenize\expandafter{\@papertitle}}%
   	\unexpanded{\\*[\medskipamount]}%
   }%
   \write\papersummfile{\@papersummary}%
   \write\papersummfile{\bigskip\par}
   %
	\pagestyle{paper}
	\def\bibname{References}
	\renewenvironment{thebibliography}[1]{%
		\bigskip
		\centerline{\normalsize\scshape\@xp{\bibname}}
		\list{}{\labelwidth\z@ \leftmargin 2em \itemindent -2em \itemsep 1\p@}%
		\normalfont\small \parindent\z@
		\parskip\z@ \@plus .1\p@\relax
		\sloppy\clubpenalty\z@ \widowpenalty\@M
		\sfcode`\.\@m\relax
	}{%
		\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
		\endlist
	}
	\def\appendix{%
		\par
		\c@section\z@
		\def\thesection{\appendixname\ \@Alph\c@section}
		\def\thesubsection{\@Alph\c@section .\arabic{subsection}}
	}
}{%
	\cleardoublepage%
	\paperinit
}%
% end of definition of paper environment
%
\if@happyadvisor
	\newcounter{papertot}
	\IfFileExists{\jobname.pls}{%
		\newread\dummyfile
		\openin\dummyfile=\jobname.pls
		\read\dummyfile to\dummyline
		\loop
			\unless\ifeof\dummyfile
			\read\dummyfile to\dummyline
			\read\dummyfile to\dummyline
			\stepcounter{papertot}
		\repeat
		\closein\dummyfile
	}{%
	}%
	\typeout{Number of papers: \thepapertot}
	%
	\RequirePackage{fp}
	\newlength{\paperboxskip}
	\setlength{\paperboxskip}{20mm}
	\ifnum \thepapertot > 8
		\FPdiv\newpaperboxskip{160}\thepapertot
		\setlength{\paperboxskip}{\newpaperboxskip mm}
		\typeout{New paperboxskip: \newpaperboxskip mm}
	\fi
\else
	\newlength{\paperboxskip}
	\setlength{\paperboxskip}{20mm}
\fi
\newlength{\paperblackbox}
\setlength{\paperblackbox}{20mm}
\def\makepaperhead{
	% paper cover page for A4G5
	{
		\cleardoublepage
		\thispagestyle{empty}
		\topskip 50mm
		\begin{center}
			{\Huge\bf\papername~\thepaper}
		\end{center}
		{\vskip -40mm}
		{\vskip -\paperblackbox}
		{\vskip \c@paper\paperboxskip}
		\mbox{\hspace{1.15\textwidth}}\makebox[\paperblackbox][r]%
   	{%
			\colorbox{black}{%
				\scalebox{3}{%
					\rule[-5pt]{0pt}{16pt}
					{\color{white} \large \bf \thepaper}
					\hspace{2.0em}
				}
			}
		}
	}
	\cleardoublepage
	%
}
\def\makepapertitle{%
	\def\@paperpublish{%
		\ifx\@paperjournal\@empty\else{\it\@paperjournal}\fi%
		\ifx\@paperyear\@empty\else{ (\@paperyear)}\fi%
		\ifx\@papervolume\@empty\else{, vol. {\bf\@papervolume}}\fi%
		\ifx\@papernumber\@empty\else{ (\@papernumber)}\fi%
		\ifx\@paperpages\@empty\else{, \@paperpages}\fi%
	}%
	\thispagestyle{paperplain}
	\vspace*{10\p@}%
	{\centering \sloppy
		{\normalfont\LARGE\fontswitch\bfseries \@papertitle\par}%
		\vskip 14\p@ \@plus 2\p@ \@minus 1\p@
		{\normalfont\large\fontswitch\bfseries \baselineskip=12\p@
		   \uppercase{\@paperauthor}\par}
		\vskip 4\p@ \@plus 1\p@
		{\normalfont\small \@paperaffiliation \par}%
		\vskip 8\p@ \@plus 2\p@ \@minus 1\p@
		{\normalfont\small \@paperpublish}% Publish status
		\par%
	}%
	\vskip 8\p@ \@plus 2\p@ \@minus 1\p@
}%
\def\makepapersummary{%
  \chapter*{Summary of the papers}
  \IfFileExists{\jobname.pls}{{\raggedbottom\input{\jobname.psm}}\flushbottom}{}
}%
%------------------------------------------------------------------------------
\def\@makechapterhead#1{\global\topskip 7.5pc\relax
   \begingroup
   \fontsize{\@xivpt}{18}\centering
     \ifnum\c@secnumdepth>\m@ne
       \leavevmode \hskip-\leftskip
       \rlap{\vbox to\z@{\vss
           \centerline{\normalsize\mdseries
               \scshape\@xp{\chaptername}\enspace\thechapter}
           \vskip 3pc}}\hskip\leftskip\fi
      \bfseries #1\par \endgroup
%   \skip@34\p@ \advance\skip@-\normalbaselineskip
   \skip@52\p@ \advance\skip@-\normalbaselineskip
   \vskip\skip@ }
\def\@makeschapterhead#1{\global\topskip 7.5pc\relax
   \begingroup
   \fontsize{\@xivpt}{18}\centering
   \bfseries #1\par \endgroup
%   \skip@34\p@ \advance\skip@-\normalbaselineskip
   \skip@52\p@ \advance\skip@-\normalbaselineskip
   \vskip\skip@ }
\def\appendix{\par
   \c@chapter\z@ \c@section\z@
   \let\chaptername\appendixname
   \def\thechapter{\@Alph\c@chapter}}
\newcommand{\@pnumwidth}{1.6em}
\newcommand{\@tocrmarg}{2.6em}
\setcounter{tocdepth}{1}
\def\@starttoc#1#2{%
   \begingroup
   \let\secdef\@gobbletwo \chapter
   \let\@secnumber\@empty % for \@tocwrite and \chaptermark
   \ifx\contentsname#2%
   \else \@tocwrite{chapter}{#2}\fi
   \typeout{#2}\@xp\chaptermark\@xp{#2}%
   \@makeschapterhead{#2}\@afterheading
   \makeatletter
   \@input{\jobname.#1}%
   \if@filesw
     \@xp\newwrite\csname tf@#1\endcsname
     \immediate\@xp\openout\csname tf@#1\endcsname \jobname.#1\relax
   \fi
   \global\@nobreakfalse \endgroup
   \newpage
}
\def\contentsname{Contents}
\def\listfigurename{List of Figures}
\def\listtablename{List of Tables}
\def\tocpagebreak{\addtocontents{toc}{\protect\clearpage}}
\def\tableofcontents{%
	\cleardoublepage%
	\refstepcounter{frontsection}%
	\pdfbookmark[0]{Contents}{contents}
	\@starttoc{toc}%
	\contentsname%
}%
\def\listoffigures{\@starttoc{lof}\listfigurename}
\def\listoftables{\@starttoc{lot}\listtablename}
\AtBeginDocument{%
   \@for\@tempa:=-1,0,1,2,3\do{%
     \@ifundefined{r@tocindent\@tempa}{%
       \@xp\gdef\csname r@tocindent\@tempa\endcsname{0pt}}{}%
   }%
}
\def\@writetocindents{%
   \begingroup
   \@for\@tempa:=-1,0,1,2,3\do{%
     \immediate\write\@auxout{%
       \string\newlabel{tocindent\@tempa}{%
         \csname r@tocindent\@tempa\endcsname}}%
   }%
   \endgroup}
\AtEndDocument{\@writetocindents}

\let\indentlabel\@empty
\def\@tochangmeasure#1{\sbox\z@{#1}%
   \ifdim\wd\z@>\csname r@tocindent\@toclevel\endcsname\relax
     \@xp\xdef\csname r@tocindent\@toclevel\endcsname{\the\wd\z@}%
   \fi
}
\def\@tocline#1#2#3#4#5#6#7{\relax
	\ifnum #1>\c@tocdepth % then omit
	\else
		\par \addpenalty\@secpenalty\addvspace{#2}%
		\begingroup \hyphenpenalty\@M
		\@ifempty{#4}{%
			\@tempdima\csname r@tocindent\number#1\endcsname\relax
		}{%
			\@tempdima#4\relax
		}%
		\parindent\z@ \leftskip#3\relax \advance\leftskip\@tempdima\relax
		\rightskip\@pnumwidth plus1em \parfillskip-\@pnumwidth
		#5\leavevmode\hskip-\@tempdima #6\relax
		\hfil\hbox to\@pnumwidth{\@tocpagenum{#7}}\par
		\nobreak
		\endgroup
	\fi}
\def\@tocpagenum#1{\hss{\mdseries #1}}
\def\@tocwrite#1{\@xp\@tocwriteb\csname toc#1\endcsname{#1}}
\def\@tocwriteb#1#2#3{%
	\begingroup
		\def\@tocline##1##2##3##4##5##6{%
	    \ifnum##1>\c@tocdepth
	    \else \sbox\z@{##5\let\indentlabel\@tochangmeasure##6}\fi}%
	  \csname l@#2\endcsname{#1{\csname#2name\endcsname}{\@secnumber}{}}%
	\endgroup
	\addcontentsline{toc}{#2}%
	  {\protect#1{\csname#2name\endcsname}{\@secnumber}{#3}}
}
\def\l@paragraph{\@tocline{2}{0pt}{1pc}{}{}}
\newcommand{\tocparagraph}[3]{%
	\indentlabel{\@ifnotempty{#2}{\ignorespaces#1 #2.\quad}}#3%
}
\def\l@subparagraph{\@tocline{3}{0pt}{2pc}{5pc}{}}
\let\tocsubparagraph\tocparagraph
\def\l@section{\@tocline{1}{0pt}{1pc}{}{}}
\newcommand{\tocsection}[3]{%
	\indentlabel{\@ifnotempty{#2}{\ignorespaces#1 #2.\quad}}#3%
}
\def\l@subsection{\@tocline{2}{0pt}{2pc}{5pc}{}}
\let\tocsubsection\tocsection
\def\l@subsubsection{\@tocline{3}{0pt}{3pc}{7pc}{}}
\let\tocsubsubsection\tocsection
%\def\l@chapter{ \@tocline{0}{8pt plus1pt}{0pt}{}{\bfseries}}
%\let\tocchapter\tocsection
\def\l@chapter{ \@tocline{0}{8pt plus1pt}{0pt}{66pt}{\bfseries}}
\newcommand{\tocchapter}[3]{%
	\indentlabel{\@ifnotempty{#2}{\rlap{\ignorespaces#1~#2.}\hspace{66pt}}}#3%
}
\let\tocappendix\tocchapter
\def\l@paper{ \@tocline{0}{8pt plus1pt}{0pt}{55pt}{\bfseries}}
\newcommand{\tocpaper}[3]{%
	\indentlabel{\@ifnotempty{#2}{\rlap{\ignorespaces#1~#2.}\hspace{55pt}}}#3%
}
\def\l@part{ \@tocline{-1}{20pt plus2pt}{0pt}{}{\bfseries}}
\newcommand{\tocpart}[3]{%
	\@ifnotempty{#2}{\ignorespaces#1 #2 -\ }#3%
}
\def\l@figure{\@tocline{0}{3pt plus2pt}{0pt}{}{}}
\let\l@table=\l@figure
%jk \def\refname{References}
\renewcommand\@biblabel[1]{}% FROM LATEX.LTX
\def\bibname{Bibliography}
\def\bibliographystyle#1{%
    \if@filesw\immediate\write\@auxout
     {\string\bibstyle{#1}}\fi
         \def\@tempa{#1}%
         \def\@tempb{amsplain}%
         \def\@tempc{}%
         \ifx\@tempa\@tempb
                 \def\@biblabel##1{##1.}%
                 \def\bibsetup{}%
         \else
                 \def\bibsetup{\labelsep6\p@}%
         \ifx\@tempa\@tempc
                 \def\@biblabel##1{}%
                 \def\bibsetup{\labelwidth\z@ \leftmargin24\p@
                 \itemindent-24\p@
                           \labelsep\z@ }%
         \fi
\fi}
\newcommand\newblock{\hskip .11em \@plus .33em \@minus .07em\relax}
\newcommand\bibls{\kern.065em\relax}
\newenvironment{thebibliography}[1]{%
  \@xp\chapter\@xp*\@xp{\bibname}
%  \par\vskip 20\p@ \@plus 1\p@ \@minus 1\p@
%  \nobreak
%  \vskip 4\p@ \@plus .5\p@ \@minus .5\p@
%  \nobreak
  \list{}{\labelwidth\z@ \leftmargin 2em \itemindent -2em \itemsep 1\p@}%
  \normalfont\small \parindent\z@
  \parskip\z@ \@plus .1\p@\relax
  \sloppy\clubpenalty\z@ \widowpenalty\@M
  \sfcode`\.\@m\relax
}{%
  \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}
\let\JFMthebib\thebibliography
\let\JFMendthebib\endthebibliography
\DeclareRobustCommand\cite{% FROM LATEX.LTX
   \@ifnextchar [{\@tempswatrue\global\@altcitetrue\@citex}
     {\@tempswafalse\global\@altcitefalse\@citex[]}}
\def\@citex[#1]#2{% FROM LATEX.LTX
   \let\@citea\@empty
   \@cite{\@for\@citeb:=#2\do
     {\@citea\def\@citea{,\penalty\@m\ }%
      \edef\@citeb{\expandafter\@firstofone\@citeb}%
      \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
      \@ifundefined{b@\@citeb}{\mbox{\reset@font\bfseries ?}%
        \G@refundefinedtrue
        \@latex@warning
          {Citation `\@citeb' on page \thepage \space undefined}}%
        {{\csname b@\@citeb\endcsname}}}}{#1}}
\renewcommand\@cite[2]{% FROM LATEX.LTX
   {\if@altcite #2\else #1\fi}\global\@altcitefalse}
%
\def\bysame{\leavevmode\hbox to3em{\hrulefill}\thinspace}
\def\newblock{}
\newif\if@restonecol
\def\indexchap{\@startsection{chapter}{1}{\z@}{92pt}{10pc}%
   {\centering\fontsize{\@xivpt}{18}\bfseries}}%
\def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
   \columnseprule\z@ \columnsep 35\p@
   \twocolumn[\@xp\indexchap\@xp*\@xp{\indexname}]%
   \@xp\chaptermark\@xp{\indexname}%
   \thispagestyle{plain}%
   \let\item\@idxitem
   \parindent\z@  \parskip\z@\@plus.3\p@\relax
   \footnotesize}
\def\indexname{Index}
\def\@idxitem{\par\hangindent 2em}
\def\subitem{\par\hangindent 2em\hspace*{1em}}
\def\subsubitem{\par\hangindent 3em\hspace*{2em}}
\def\endtheindex{\if@restonecol\onecolumn\else\clearpage\fi}
\def\indexspace{\par\bigskip}
\@addtoreset{footnote}{chapter}
\def\footnoterule{\kern-.4\p@
         \hrule\@width 5pc\kern11\p@\kern-\footnotesep}
\def\@makefnmark{\hbox{$\m@th^{\@thefnmark}$}}
\def\@makefntext{\noindent\@makefnmark}
\long\def\@footnotetext#1{\insert\footins{%
   \normalfont\footnotesize
   \interlinepenalty\interfootnotelinepenalty
   \splittopskip\footnotesep \splitmaxdepth \dp\strutbox
   \floatingpenalty\@MM \hsize\columnwidth
   \@parboxrestore \parindent\normalparindent \sloppy
   \edef\@currentlabel{\p@footnote\@thefnmark}%
   \@makefntext{\rule\z@\footnotesep\ignorespaces#1\unskip\strut\par}}}
\hfuzz=1pt \vfuzz=\hfuzz
\def\sloppy{\tolerance9999 \emergencystretch 3em\relax}
%------------------------------------------------------------------------------
% from JFM
\setcounter{topnumber}{3}
\setcounter{bottomnumber}{0}
\setcounter{totalnumber}{3}
\setcounter{dbltopnumber}{3}
\renewcommand\topfraction{.9}
\renewcommand\bottomfraction{.9}
\renewcommand\textfraction{.05}
\renewcommand\floatpagefraction{.95}
\renewcommand\dbltopfraction{.9}
\renewcommand\dblfloatpagefraction{.5}
\setlength\floatsep{10\p@ \@plus 2\p@ \@minus 1\p@}
\setlength\textfloatsep{12\p@ \@plus 6\p@}
\setlength\intextsep{\floatsep}
\setlength\dblfloatsep{\floatsep}
\setlength\dbltextfloatsep{\floatsep}
\setlength\@fptop{\z@ \@plus 0fil}
\setlength\@fpsep{10\p@ \@plus 0fil}
\setlength\@fpbot{\z@ \@plus 3fil}
\setlength\@dblfptop{\z@ \@plus 0fil}
\setlength\@dblfpsep{10\p@ \@plus 0fil}
\setlength\@dblfpbot{\z@ \@plus 3fil}
%------------------------------------------------------------------------------
%
\newcommand{\fps@figure}{tbp}
\newcommand{\fps@table}{tbp}
\newcounter{figure}[chapter]
\def\captionheadfont@{\scshape}
\def\captionfont@{\normalfont}
\def\ftype@figure{1}
\def\ext@figure{lof}
%
\renewcommand\thefigure{\thechapter.\@arabic\c@figure}
\def\fnum@figure{\figurename\ \thefigure}
\def\figurename{Figure}
\def\figure{\@float{figure}}
\def\endfigure{\end@float}
\def\ftype@table{2}
\def\ext@table{lot}
\renewcommand\thetable{\thechapter.\@arabic\c@table}
\def\fnum@table{\tablename\ \thetable}
\def\tablename{Table}
\def\table{\@float{table}}
\def\endtable{\end@float}
\long\def\@makecaption#1#2{%
   \setbox\@tempboxa\vbox{\color@setgroup
     \advance\hsize-6pc\noindent
     \captionfont@\captionheadfont@#1\@xp\@ifnotempty\@xp
         {\@cdr#2\@nil}{.\captionfont@\upshape\enspace#2}%
     \unskip\kern-6pc\par
     \global\setbox\@ne\lastbox\color@endgroup}%
   \ifhbox\@ne % the normal case
     \setbox\@ne\hbox{\unhbox\@ne\unskip\unskip\unpenalty\unkern}%
   \fi
   \ifdim\wd\@tempboxa=\z@ % this means caption will fit on one line
     \setbox\@ne\hbox to\columnwidth{\hss\kern-6pc\box\@ne\hss}%
   \else % tempboxa contained more than one line
     \setbox\@ne\vbox{\unvbox\@tempboxa\parskip\z@skip
         \noindent\unhbox\@ne\advance\hsize-6pc\par}%
\fi
   \ifnum\@tempcnta<64 % if the float IS a figure...
     \addvspace\abovecaptionskip
     \moveright 3pc\box\@ne
   \else % if the float IS NOT a figure...
     \moveright 3pc\box\@ne
     \nobreak
     \vskip\belowcaptionskip
   \fi
\relax
}
\newskip\abovecaptionskip \abovecaptionskip=12pt \relax
\newskip\belowcaptionskip \belowcaptionskip=12pt \relax
\RequirePackage{amsthm}
\def\@swapped#1#2{#2%
   \@ifnotempty{#1}{\@addpunct{.}\quad#1\unskip}}
\def\th@plain{%
   \let\theoremindent\indent
   \theoremheadfont{\scshape}% heading font small caps
   \theoremnotefont{\mdseries\upshape}%
   \theorempreskipamount.5\baselineskip\@plus.2\baselineskip
                                     \@minus.2\baselineskip
   \theorempostskipamount\theorempreskipamount
   \itshape
}
\def\th@definition{%
   \let\theoremindent\indent
   \theoremheadfont{\scshape}% heading font small caps
   \theoremnotefont{\mdseries\upshape}%
   \theorempreskipamount.5\baselineskip\@plus.2\baselineskip
                                     \@minus.2\baselineskip
   \theorempostskipamount\theorempreskipamount
   \upshape
}
\def\th@remark{%
   \let\theoremindent\indent
   \theoremheadfont{\scshape}% heading font small caps
   \theoremnotefont{\mdseries\upshape}%
   \theorempreskipamount.5\baselineskip\@plus.2\baselineskip
                                     \@minus.2\baselineskip
   \theorempostskipamount\theorempreskipamount
   \upshape
}
\renewenvironment{proof}[1][\proofname]{\par \normalfont
   \topsep6\p@\@plus6\p@ \trivlist \itemindent\normalparindent
   \item[\hskip\labelsep\scshape
     #1\@addpunct{.}]\ignorespaces
}{%
   \qed\endtrivlist
}
\def\nonbreakingspace{\unskip\nobreak\ \ignorespaces}
\def~{\protect\nonbreakingspace}
\def\fullwidthdisplay{\displayindent\z@ \displaywidth\columnwidth}
\edef\@tempa{\noexpand\fullwidthdisplay\the\everydisplay}
\everydisplay\expandafter{\@tempa}
\newcommand\seename{see also}%
\newcommand\see[2]{{\em \seename\/} #1}%
\newcommand\smallls{\kern.12em\relax}% from JFM.cls
\newcommand\ls{\kern.15em\relax}% from JFM.cls
\newcommand\ns{\kern.5em\relax}% from JFM.cls
\newcommand\printindex{\@input{\jobname.ind}}%
\def\@settranslators{\par
   \begingroup
   Translated by: \andify\@translators \uppercasenonmath\@translators
   \@translators \@@par
   \endgroup}
\def\calclayout{\advance\textheight -\headheight
   \advance\textheight -\headsep
   \oddsidemargin\paperwidth
   \advance\oddsidemargin -\textwidth
   \divide\oddsidemargin\tw@
   \ifdim\oddsidemargin<.5truein \oddsidemargin.5truein \fi
   \advance\oddsidemargin -1truein
   \evensidemargin\oddsidemargin
   \topmargin\paperheight \advance\topmargin -\textheight
   \advance\topmargin -\headheight \advance\topmargin -\headsep
   \divide\topmargin\tw@
   \ifdim\topmargin<.5truein \topmargin.5truein \fi
   \advance\topmargin -1.1truein\relax
}
\calclayout % initialize
\pagestyle{headings}
\endinput
%%
%% End of file `Mechthesis.cls'.
