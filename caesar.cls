%%
%% This file is the new, unified caesar class file 2011-10-14 (OS-AT)
\NeedsTeXFormat{LaTeX2e}

\ProvidesFile{caesar.cls}[2011/10/16 v0.2 Grand Unified Caesar Class]

%%
% The `keyval' package simplifies the user interface for the document class options
\RequirePackage{keyval}

%%
% We use the `ifthen' package to handle our package option switches
\RequirePackage{ifthen}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------options section-------------------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% book option -- Tufte style book
\newboolean{@caesar@book}%
\setboolean{@caesar@book}{true}%
\DeclareOption{book}{\setboolean{@caesar@handout}{false}}%

%%
% handout option -- no comment
\newboolean{@caesar@handout}%
\setboolean{@caesar@handout}{false}%
\DeclareOption{handout}{\setboolean{@caesar@handout}{true}\setboolean{@caesar@book}{false}}%

%%
% kindle option -- optimized pdf output for kindle eReader
\newboolean{@caesar@kindle}%
\setboolean{@caesar@kindle}{false}%
\DeclareOption{epubli}{\setboolean{@caesar@kindle}{true}\setboolean{@caesar@scroll}{false}\setboolean{@caesar@epubli}{false}}%

%%
% `scroll' option
\newboolean{@caesar@scroll}%
\setboolean{@caesar@scroll}{false}%
\DeclareOption{scroll}{\setboolean{@caesar@scroll}{true}\setboolean{@caesar@kindle}{false}\setboolean{@caesar@epubli}{false}}%

%%
% alternative Chapter and Section headings
\newboolean{@caesar@arminius}%
\setboolean{@caesar@arminius}{false}%
\DeclareOption{arminius}{\setboolean{@caesar@arminius}{true}}

%%
% debug option
\newboolean{@caesar@debug}%
\DeclareOption{debug}{\setboolean{@caesar@debug}{true}}%

%%
% twoside option
\newboolean{@caesar@twoside}
\DeclareOption{twoside}{%
  \setboolean{@caesar@twoside}{true}
}

%%
% \ExecuteOptions{}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Load the underlying classes first
\ifthenelse{\boolean{@caesar@handout}}{\LoadClassWithOptions{article}}{\LoadClassWithOptions{book}}

% provide the ragged outer option
\ifthenelse{\boolean{@twoside}}{%
\newcommand{\raggedouter}{%
	\checkoddpage%
    	\ifoddpage%
		\RaggedRight%
    	\else%
		\RaggedLeft%
    	\fi%
}}{\newcommand{\raggedouter}{\RaggedRight}}

% figure across the whole page including the margin	 	
\renewenvironment{figure*}[1][] 	
{\begin{figure}[#1]	 	
\checkoddpage%	
\ifoddpage% 	
\hspace{0pt}%	
\else%
\hspace{-120pt}%
\fi%
}
{\end{figure}}

%%
% Changepage package for symmetric twoside handling
\RequirePackage[strict]{changepage}

%%
% nice headings and TOC
\RequirePackage{titlesec,titletoc}

\RequirePackage{ragged2e}
%\RequirePackage{marginnote}
\RequirePackage{caption}
\RequirePackage{sidenotes}
\RequirePackage{morefloats}
%\RequirePackage{microtype}

%%
% Set page layout geometry -- default is epubli science-book format
\RequirePackage[paperwidth=170mm, paperheight=240mm, left=40pt, top=40pt, textwidth=280pt, marginparsep=20pt, marginparwidth=100pt, textheight=560pt, footskip=40pt]{geometry}%

\ifthenelse{\boolean{@caesar@handout}}{\geometry{paperwidth=210mm, paperheight=297mm, left=50pt, top=50pt, textwidth=345pt, marginparsep=25pt, marginparwidth=124pt, textheight=692pt, footskip=50pt}}{}%

\ifthenelse{\boolean{@caesar@kindle}}{\geometry{paperwidth=255pt, paperheight=340pt, left=10pt, top=10pt, textwidth=235pt, marginparsep=0pt, marginparwidth=0pt, textheight=310pt, footskip=20pt}}{}%

\ifthenelse{\boolean{@caesar@scroll}}{\geometry{paperwidth=170mm, paperheight=16383pt, left=40pt, top=40pt, textwidth=280pt, marginparsep=20pt, marginparwidth=100pt, textheight=16263pt, footskip=40pt}\setcounter{totalnumber}{100}}{}%

%%
% set the fonts
\RequirePackage{fontspec}

% Use Neo Euler as math font
\RequirePackage[math-style=upright, vargreek-shape=TeX]{unicode-math}% 
\setmathfont{Neo Euler}%
% Use the Palatino-Clone Tex Gyre Pagella as main font
\setmainfont[Ligatures=TeX, Numbers=OldStyle]{Tex Gyre Pagella}%
% Use Tex Gyre Cursor as Monospace Font
\setmonofont{Tex Gyre Cursor}%
% Use Tex Gyre Heros Cn as Sans Serif Font
\setsansfont{Tex Gyre Heros Cn}%
% fontsize is 10pt, 13pt for book and 12pt, 15pt for handout
\ifthenelse{\boolean{@caesar@handout}}{\renewcommand{\normalsize}{\fontsize{12pt}{15pt}\selectfont}}{\renewcommand{\normalsize}{\fontsize{10pt}{13pt}\selectfont}}%
% fontsize is 10pt, 13pt for book and 9pt, 11pt for kindle
\ifthenelse{\boolean{@caesar@kindle}}{\renewcommand{\normalsize}{\fontsize{9pt}{11pt}\selectfont}}{}%

% adjust the footnote sizes
\ifthenelse{\boolean{@caesar@handout}}{\renewcommand{\footnotesize}{\fontsize{10pt}{12pt}\selectfont}}{\renewcommand{\footnotesize}{\fontsize{8pt}{10pt}\selectfont} }%

\setcounter{secnumdepth}{-1}

\ifthenelse{\boolean{@caesar@arminius}}{%
	\titleformat{\chapter}%
 	 [hang]% shape
 	 {\relax}% format applied to label+text
 	 {\thechapter}% label
 	 {0pt}% horizontal separation between label and title body
	 {\rmfamily\MakeUppercase}% before the title body
	 [\titlerule]% after the title body
}{%
	\titleformat{\chapter}%
	  [display]% shape
	  {\relax\itshape\huge}% format applied to label+text
	  {\thechapter}% label
	  {0pt}% horizontal separation between label and title body
	  {\huge\rmfamily\itshape}% before the title body
	  []% after the title body
}

\ifthenelse{\boolean{@caesar@arminius}}{%
\titleformat{\section}%
  [hang]% shape
  {\normalfont\scshape}% format applied to label+text
  {\thesection}% label
  {}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body
}{%
\titleformat{\section}%
  [hang]% shape
  {\normalfont\Large\itshape}% format applied to label+text
  {\thesection}% label
  {1em}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body
  }%

\titleformat{\subsection}%
  [hang]% shape
  {\normalfont\large\itshape}% format applied to label+text
  {\thesubsection}% label
  {1em}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body

\titleformat{\paragraph}%
  [runin]% shape
  {\normalfont\itshape}% format applied to label+text
  {\theparagraph}% label
  {1em}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body

%%
% spaces before and after the headings
\ifthenelse{\boolean{@caesar@arminius}}{%
\titlespacing*{\chapter}{0pt}{\baselineskip}{\baselineskip}
\titlespacing*{\section}{0pt}{\baselineskip}{\baselineskip}
}{}%

%%
% The Table of Contents
\ifthenelse{\boolean{@caesar@arminius}}{%
\titlecontents{chapter}%
	[0em] % distance from left margin
	{\vspace{1.5\baselineskip}\begin{fullwidth}\rmfamily} % above (global formatting of entry)
	{\hspace*{0em}\contentslabel{2em}} % before w/label (label = ``2'')
	{\hspace*{0em}} % before w/o label
	{\rmfamily\upshape\qquad\thecontentspage} % filler + page (leaders and page num)
	[\end{fullwidth}] % after
}{%
\titlecontents{chapter}%
	[0em] % distance from left margin
	{\vspace{1.5\baselineskip}\begin{fullwidth}\LARGE\rmfamily\itshape} % above (global formatting of entry)
	{\hspace*{0em}\contentslabel{2em}} % before w/label (label = ``2'')
	{\hspace*{0em}} % before w/o label
	{\rmfamily\upshape\qquad\thecontentspage} % filler + page (leaders and page num)
	[\end{fullwidth}] % after
}

%%
% display only the highest sections in the TOC
\ifthenelse{\boolean{@caesar@handout}}{\setcounter{tocdepth}{1}}{\setcounter{tocdepth}{0}}

%%
% Set up any book-specific stuff now (this code is borrowed from the tufte-book.cls file)
\ifthenelse{\boolean{@caesar@book}}{\renewcommand\frontmatter{%
  \cleardoublepage%
  \fancyhf{}%
   \fancyfoot[LE]{\thepage}%
   \fancyfoot[RO]{\thepage}}%
}{\newcommand\frontmatter{}}

%%
% The main matter in Tufte's /Beautiful Evidence/ doesn't restart the page
% numbering---it continues where it left off in the front matter.
\ifthenelse{\boolean{@caesar@book}}{\renewcommand\mainmatter{%
  \cleardoublepage%
%  \@mainmattertrue%
  \fancyhf{}%
      \renewcommand{\chaptermark}[1]{\markboth{##1}{}}%
      \fancyfoot[LE]{\thepage\newlinetospace}
      \fancyfoot[RO]{\newlinetospace\thepage}
}}{\newcommand\mainmatter{}}

%%
% The back matter contains appendices, indices, glossaries, endnotes,
% biliographies, list of contributors, illustration credits, etc.
\ifthenelse{\boolean{@caesar@book}}{\renewcommand\backmatter{}}{\newcommand\backmatter{}}

% swallow the abstract
\ifthenelse{\boolean{@caesar@book}}{\newsavebox{\abstractbox}
\newenvironment{abstract}
{\begin{lrbox}{\abstractbox}}
{\end{lrbox}}}{}

% swallow the questions
\ifthenelse{\boolean{@caesar@book}}{
\newsavebox{\questionsbox}
\newenvironment{questions}
{
\begin{lrbox}{\questionsbox}
\begin{minipage}{5cm}
\begin{enumerate}}
{\end{enumerate}
\end{minipage}
\end{lrbox}
}}{\newenvironment{questions}%
{\section{Fragen}%
\begin{enumerate}}%
{\end{enumerate}}}

% define a tutorial environment
\ifthenelse{\boolean{@caesar@book}}{%
\newenvironment{tutorials}
{\section{Aufgaben}
\begin{enumerate}}
{\end{enumerate}}}{\newenvironment{tutorials}
{\section{Aufgaben}
\begin{enumerate}}
{\end{enumerate}}
}

%%
% Turns newlines into spaces.  Based on code from the `titlesec' package.

\DeclareRobustCommand{\@caesar@newlinetospace}{%
  \@ifstar{\@caesar@newlinetospace@i}{\@caesar@newlinetospace@i}%
}

\def\@caesar@newlinetospace@i{%
  \ifdim\lastskip>\z@\else\space\fi
  \ignorespaces%
}

\DeclareRobustCommand{\newlinetospace}[1]{%
  \let\@caesar@orig@cr\\% save the original meaning of \\
  \def\\{\@caesar@newlinetospace}% turn \\ and \\* into \space
  \let\newline\\% turn \newline into \space
  #1%
  \let\\\@caesar@orig@cr% revert to original meaning of \\
}%

%%
% From here on: Header and Footer

\RequirePackage{fancyhdr}

% The running heads/feet don't have rules
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\pagestyle{fancy}

\fancyhf{}%
{\fancyfoot[LE,RO]{\thepage}}

\fancypagestyle{plain}{%
	\fancyhf{}
}

%%
% custom environments

% Newthought environment
\newcommand\newthought[1]{%
   \addvspace{1.0\baselineskip plus 0.5ex minus 0.2ex}%
   \noindent\textsc{#1}%
}%

% Quotation environment
\renewenvironment{quotation}
               {\list{}{\listparindent 1pc%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin%
                        \parsep	10pt}% Not sure about this one (Oliver)
                \small%
                \item\relax\noindent\ignorespaces}
               {\endlist}

% Abstract environment
\ifthenelse{\boolean{@caesar@handout}}{\renewenvironment{abstract}{\begin{quotation}}{\end{quotation}}}{}

% fullwidth environment
\newlength{\overhang}
\setlength{\overhang}{\marginparwidth}
\addtolength{\overhang}{\marginparsep}

\newenvironment{fullwidth}
  {\ifthenelse{\boolean{@twoside}}%
     {\begin{adjustwidth*}{}{-\overhang}}%
     {\begin{adjustwidth}{}{-\overhang}}%
  }%
  {\ifthenelse{\boolean{@twoside}}%
    {\end{adjustwidth*}}%
    {\end{adjustwidth}}%
  }

\DeclareCaptionJustification{raggedouter}{\raggedouter}
%\renewcommand{\marginnotevadjust}{2pt}
\captionsetup{width=\marginparwidth, justification=raggedouter, font=footnotesize, skip = 0pt}
\renewcommand{\sidestyle}{\footnotesize\raggedouter}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author, titel and publisher
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xifthen}
\RequirePackage{color}
\definecolor{darkgray}{rgb}{0.25,0.25,0.25}
\newcommand{\publisher}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% designing the titlepage \maketitlepage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\DeclareTextFontCommand{\textsmallcaps}{\scshape}  % Wozu ist das nötig?
 
\RequirePackage{textcase} % provides \MakeTextUppercase and \MakeTextLowercase
\newcommand{\allcaps}{\MakeTextUppercase}
\newcommand{\smallcaps}{\MakeTextLowercase}

\newcommand{\maketitlepage}[0]{%
  \let\@@title\@empty%
   \let\@@author\@empty%
   \let\@@publisher\@empty%
   \let\@@date\@empty%
      \gdef\@@title{\Huge\lsstyle\textcolor{darkgray}{\allcaps{\@title}}\par}%
      \gdef\@@author{\LARGE\textcolor{darkgray}{\lsstyle\allcaps{\@author}}\par}%
      \gdef\@@publisher{\Large\selectfont\par\noindent\lsstyle\allcaps{\publisher}\par}%
      \gdef\@@date{\large\@date\par}%
  \cleardoublepage%
  \begingroup%
  {%
  \sffamily%
  \begin{fullwidth}%
%  \LARGE\par\noindent\textcolor{darkgray}{\lsstyle\allcaps{\author}}%
  \@@author
  \vspace{6em}%
%  \Huge\par\noindent\textcolor{darkgray}{\lsstyle\allcaps{\title}}%
  \noindent\@@title
  \vfill%
%  \Large\selectfont\par\noindent\lsstyle\allcaps{\publisher}%
  \@@publisher
  \end{fullwidth}%
  }%
  \endgroup%
  \thispagestyle{empty}%
  \clearpage%
}

% from here: redefenition of \maketitle
% again: the sf-option is left out
\renewcommand{\maketitle}{%
  \newpage%
  \global\@topnum\z@% prevent floats from being placed at the top of the page
  \begingroup%
    \setlength{\parindent}{0pt}%
    \setlength{\parskip}{4pt}%
    \let\@@title\@empty%
    \let\@@author\@empty%
    \let\@@date\@empty%
      \gdef\@@title{\Large\itshape\@title\par}%
      \gdef\@@author{\large\itshape\@author\par}%
      \gdef\@@date{\large\itshape\@date\par}%
    \@@title%
    \@@author%
    \@@date%
  \endgroup%
  \thispagestyle{plain}% suppress the running head
}

% if the book option is used, make a titlepage instead of the title alone
\ifthenelse{\boolean{@caesar@book}}{
\renewcommand{\maketitle}{\maketitlepage}}{}

%%
% When \cleardoublepage is called, produce a blank (empty) page -- i.e.,
% without headers and footers
\def\cleardoublepage{\clearpage\if@twoside\ifodd\c@page\else
  \hbox{}
  %\vspace*{\fill}
  %\begin{center}
  %  This page intentionally contains only this sentence.
  %\end{center}
  %\vspace{\fill}
  \thispagestyle{empty}
  \newpage
  \if@twocolumn\hbox{}\newpage\fi\fi\fi}

\newcommand{\CaesarInfoNL}[1]{\ClassInfo{\@caesar@pkgname}{#1\@gobble}}
\newcommand{\CaesarDebugInfoNL}[1]{\ifthenelse{\boolean{@caesar@debug}}{\CaesarInfoNL{#1}}{}}
\newcommand{\CaesarError}[2]{\ClassError{\@caesar@pkgname}{#1}{#2}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Things to do
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{@caesar@handout}}{\newcommand{\chapter}{}}{}
\ifthenelse{\boolean{@caesar@handout}}{\newcounter{chapter}\renewcommand\chapter[1]{}}{}