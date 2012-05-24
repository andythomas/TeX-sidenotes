%%
\NeedsTeXFormat{LaTeX2e}
%
\ProvidesFile{caesar_book.cls}[2012/05/23 v0.55 Caesar book]

% Load the amsmath and the mhchem package before loading microtype
%
% better math handling
\RequirePackage{amsmath}
% chemical formulas
\RequirePackage[version=3]{mhchem}
% use lining numbers for chemical formulas
\mhchemoptions{textfontcommand=\addfontfeature{Numbers=Lining}} 

% We use the `ifthen' package to handle our package option switches
\RequirePackage{ifthen}

% this is derived from the book class
\LoadClassWithOptions{book}

% provide the ragged outer option
%
% ragged2e helps
\RequirePackage{ragged2e}
% Changepage package for symmetric twoside handling
\RequirePackage[strict]{changepage}
%
\newcommand{\raggedouter}{%
	\checkoddpage%
    	\ifoddpage%
		\RaggedRight%
    	\else%
		\RaggedLeft%
    	\fi%
}

% we need a couple of packages for the formatting of the marginals
%
% allow to customize captions and initialize with decent values
\RequirePackage{caption}
\DeclareCaptionJustification{raggedouter}{\raggedouter}
\captionsetup{font=footnotesize,justification=raggedouter, skip=4pt}
% put annotations, tables and figures in the margin and also initialize with decent values
\RequirePackage{sidenotes}
\renewcommand{\sidestyle}{\footnotesize\raggedouter}
% a lot of marginals need more float 'memory'
\RequirePackage[maxfloats=45]{morefloats}
% automatically adjust the side-floats nicely 
\RequirePackage{marginfix}

% microtypography
\newcommand{\caesar@letterspace}[1]{#1}
\RequirePackage{microtype}
\@ifpackagelater{microtype}{2011/08/18}{%
    \renewcommand{\caesar@letterspace}[1]{\textls{#1}}%
}{%
   \AtEndDocument{\ClassWarningNoLine{caesar_book}{Need newest microtype (beta) for letterspacing.}}
}

% Set page layout geometry -- default is epubli science-book format
\RequirePackage[paperwidth=170mm, paperheight=240mm, left=42pt, top=40pt, textwidth=280pt, marginparsep=20pt, marginparwidth=100pt, textheight=560pt, footskip=40pt]{geometry}
% fullwidth environment, text across textwidth+marginparsep+marginparwidth
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

% set the fonts
%
% we need fontspec with LuaLaTeX
\RequirePackage{fontspec}
%
% Use Asana math as math font, it matches Palatino
\RequirePackage[vargreek-shape=TeX]{unicode-math}% 
\setmathfont{Asana Math}%
% Use the Palatino-Clone Tex Gyre Pagella as main font
\setmainfont[Ligatures=TeX, Numbers=OldStyle]{Tex Gyre Pagella}%
% Use Tex Gyre Cursor as Monospace Font
\setmonofont{Tex Gyre Cursor}%
% Use Tex Gyre Heros as Sans Serif Font
\setsansfont{Tex Gyre Heros}%
% fontsize is 10pt, 13pt for book and 9pt, 11pt for kindle
\renewcommand{\normalsize}{\fontsize{10pt}{13pt}\selectfont}%
\renewcommand{\footnotesize}{\fontsize{8pt}{10pt}\selectfont}%

% nice headings and TOC
%
% load the helper package
\RequirePackage{titlesec,titletoc}
% no numbering at all
\setcounter{secnumdepth}{-1}
% chapter format
\titleformat{\chapter}%
   [display]% shape
   {\relax\itshape\huge}% format applied to label+text
   {}% label
   {0pt}% horizontal separation between label and title body
   {\huge\rmfamily\itshape}% before the title body
   []% after the title body
% section format
\titleformat{\section}%
  [hang]% shape
  {\normalfont\Large\itshape}% format applied to label+text
  {}% label
  {1em}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body
% subsection format
\titleformat{\subsection}%
  [hang]% shape
  {\normalfont\large\itshape}% format applied to label+text
  {}% label
  {1em}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body
% paragraph format
\titleformat{\paragraph}%
  [runin]% shape
  {\normalfont\itshape}% format applied to label+text
  {}% label
  {1em}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body
% italic description instead of bold)
\renewcommand*\descriptionlabel[1]{\hspace\labelsep\normalfont\em #1}
% The Table of Contents, only chapters 
\setcounter{tocdepth}{0}
\titlecontents{chapter}%
   [0em] % distance from left margin
   {\vspace{1.5\baselineskip}\begin{fullwidth}\LARGE\rmfamily\itshape} % above (global formatting of entry)
   {\hspace*{0em}\contentslabel{2em}} % before w/label (label = ``2'')
   {\hspace*{0em}} % before w/o label
   {\rmfamily\upshape\qquad\thecontentspage} % filler + page (leaders and page num)
   [\end{fullwidth}] % after

%set up header, footer and page numbering
%
% helper package
\RequirePackage{fancyhdr}
% The running heads and feet do not have rules
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
% set up the page numbering 
\fancyhf{}%
{\fancyfoot[LE,RO]{\thepage}}
\fancypagestyle{plain}{%
	\fancyhf{}
}
% the frontmatter is empty, mainmatter with page numbering
\renewcommand{\frontmatter}{\pagestyle{empty}}
\renewcommand{\mainmatter}{\cleardoublepage\pagestyle{fancy}}

% ------------------------------------------------------------------------------------
% the custom high-level macros start here
% -------------------------------------------------------------------------------------

% the title page is generated here
%
% provides \MakeTextUppercase and \MakeTextLowercase
\RequirePackage{textcase} 
% the title is too black, define gray
\RequirePackage{color}
\definecolor{darkgray}{rgb}{0.25,0.25,0.25}
% generate the page with \maketitlepage
\newcommand{\maketitlepage}[0]{%
  \cleardoublepage%
  \begingroup%
  {%
  \sffamily%
  \begin{fullwidth}%
  \LARGE\caesar@letterspace{\MakeTextUppercase{\@author}}\par
  \vspace{6em}%
  \noindent\fontsize{38}{50}\selectfont\textcolor{darkgray}{\caesar@letterspace{\MakeTextUppercase{\@title}}}\par
  \vfill%
  \Large\noindent\caesar@letterspace{\MakeTextUppercase{\publisher}}\par
  \end{fullwidth}%
  }%
  \endgroup%
  \thispagestyle{empty}%
  \clearpage%
}

% the figure sizes
%
% helper package
\RequirePackage{graphicx} 
% largefigure across the page, #1 optional placement, #2 filename=label, #3 caption
\newcommand{\largefigure}[3][htpd]{%
\begin{figure}[#1]%
 \checkoddpage%
    	\ifoddpage%
		%
    	\else%
		\hspace{-120pt}%
    	\fi%
 \includegraphics[width=400pt]{#2}%
 \ifthenelse{\isempty{#3}}%
{}%
% if the figure is on the verso page, shift left edge to the left
{\captionsetup{margin={0pt,-120pt}, justification=justified}%
 \caption{#3}}%
 \label{#2}%
\end{figure}%
}
%
% normalfigure in the text frame, #1 optional placement, #2 filename=label, #3 caption
\newcommand{\normalfigure}[3][htbp]{%
\begin{figure}[#1]%
	\includegraphics[width=\textwidth]{#2}%
	\captionsetup{width=\textwidth, justification=justified}%
	\caption{#3\label{#2}}%
\end{figure}%
}
%
% smallfigure in the margin, #1 filename=label, #2 caption
\newcommand{\smallfigure}[2]{%
\begin{sidefigure}%
\includegraphics[width=\marginparwidth]{#1}%
\caption{#2\label{#1}}%
\end{sidefigure}%
}

% the table sizes
%
% largetable across the page, #1 optional placement, #2 label, #3 caption, #4 code
\newcommand{\largetable}[4][htbp]{%
\begin{table}[#1]%
% if the table is on the verso page, shift left edge to the left
 \checkoddpage%
    	\ifoddpage%
		%
    	\else%
		\hspace{-120pt}%
    	\fi%
	#4
	\vspace{2pt}
 	\captionsetup{margin={0pt,-120pt}, justification=justified}%
	\caption{#3 \label{#2}}%
\end{table}%
}
%
% normaltable (text width), #1 optional placement, #2 label, #3 caption, #4 code
\newcommand{\normaltable}[4][htbp]{%
\begin{table}[#1]%
	#4
	\vspace{2pt}%
	\captionsetup{width=\textwidth, justification=justified}%
	\caption{#3\label{#2}}%
\end{table}%
}
%
% smalltable in the margin, #1 label, #2 caption, #3 code
\newcommand{\smalltable}[3]{%
\begin{sidetable}%
	#3
	 \vspace{2pt}
	\caption{#2\label{#1}}%
\end{sidetable}%
}

%
% sidenote without a mark in the text
\newcommand{\margintext}[1]{\marginpar{\sidestyle#1}}