%%
\NeedsTeXFormat{LaTeX2e}

\ProvidesFile{caesar_kindle.cls}[2012/05/16 v0.5 Caesar kindle]

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

% we need a couple of packages for the formatting in kindle size
%
% allow to customize captions and initialize with decent values
\RequirePackage{caption}
\captionsetup{width=110pt, justification=RaggedRight, font=footnotesize, skip = 0pt}

% microtypography
\RequirePackage[babel]{microtype}

% Set page layout geometry -- default is small kindle
\RequirePackage[paperwidth=255pt, paperheight=340pt, left=10pt, top=10pt, textwidth=235pt, marginparsep=0pt, marginparwidth=0pt, textheight=310pt, footskip=20pt]{geometry}%
% fullwidth makes no sense here
\newenvironment{fullwidth}{}{}

% set the fonts
%
\RequirePackage{fontspec}
%
% Use Neo Euler as math font
\RequirePackage[math-style=upright, vargreek-shape=TeX]{unicode-math}% 
\setmathfont{Asana Math}%
% Use the Palatino-Clone Tex Gyre Pagella as main font
\setmainfont[Ligatures=TeX, Numbers=OldStyle]{Tex Gyre Pagella}%
% Use Tex Gyre Cursor as Monospace Font
\setmonofont{Tex Gyre Cursor}%
% Use Tex Gyre Heros Cn as Sans Serif Font
\setsansfont{Tex Gyre Heros}%
%fontsize is 10pt, 13pt for book and 9pt, 11pt for kindle
\renewcommand{\normalsize}{\fontsize{9pt}{11pt}\selectfont}%
% footnotesize
\renewcommand{\footnotesize}{\fontsize{8pt}{10pt}\selectfont}%

% nice headings and TOC
%
\RequirePackage{titlesec,titletoc}
% chapter has numbers
\setcounter{secnumdepth}{0}
% chapter format
   \titleformat{\chapter}%
   [hang]% shape
   {\relax}% format applied to label+text
   {}% label
   {0pt}% horizontal separation between label and title body
   {\rmfamily\MakeUppercase}% before the title body
   [\titlerule]% after the title body
% section format
\titleformat{\section}%
  [hang]% shape
  {\normalfont\scshape}% format applied to label+text
  {}% label
  {}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body
  \titleformat{\subsection}%
  [hang]% shape
  {\normalfont}% format applied to label+text
  {}% label
  {}% horizontal separation between label and title body
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
% spaces before and after the headings
\titlespacing*{\chapter}{0pt}{\baselineskip}{\baselineskip}
\titlespacing*{\section}{0pt}{\baselineskip}{\baselineskip}
% the table of contents, only chapters
\setcounter{tocdepth}{0}
\titlecontents{chapter}%
   [0em] % distance from left margin
   {\vspace{1.5\baselineskip}\rmfamily} % above (global formatting of entry)
   {\hspace*{0em}\contentslabel{2em}} % before w/label (label = ``2'')
   {\hspace*{0em}} % before w/o label
   {\rmfamily\upshape\qquad\thecontentspage} % filler + page (leaders and page num)
   [] % after

%set up header, footer and page numbering
%
% helper package
\RequirePackage{fancyhdr}
% The running heads and feet do not have rules XXX
% XXX in kindle never page numbers?!
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyhf{}%
{\fancyfoot[LE,RO]{\thepage}}
\fancypagestyle{plain}{%
	\fancyhf{}
}
% the frontmatter is empty, mainmatter with page numbering
\renewcommand{\frontmatter}{\pagestyle{empty}}
\renewcommand{\mainmatter}{\cleardoublepage\pagestyle{empty}}

% ------------------------------------------------------------------------------------
% the custom high-level macros start here
% -------------------------------------------------------------------------------------

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
  \noindent\large\lsstyle\MakeTextUppercase{\@author}\par%
  \vspace{6em}%
  \noindent\fontsize{20}{24}\selectfont\textcolor{darkgray}{\textls[125]{\MakeTextUppercase{\@title}}}\par
  \vfill%
  \large\selectfont\par\noindent\lsstyle\MakeTextUppercase{\publisher}\par
  }%
  \endgroup%
  \thispagestyle{empty}%
  \clearpage%
}

% the figure sizes
%
% helper package
\RequirePackage{graphicx} 

% no difference for large and normalfigure in kindle style
\newcommand{\largefigure}[3][ht!]{%
\begin{figure}[#1]%
	\includegraphics[width=235pt]{#2}
	\captionsetup{width=\textwidth, justification=justified}
	\caption{#3\label{#2}}%
\end{figure}%
}

\newcommand{\normalfigure}[3][ht!]{%
\begin{figure}[#1]%
	\includegraphics[width=235pt]{#2}
	\captionsetup{width=\textwidth, justification=justified}
	\caption{#3\label{#2}}%
\end{figure}%
}

% smallfigure is smaller with adjacent caption
\newcommand{\smallfigure}[2]{%
\begin{figure}[ht!]
\begin{minipage}[b]{110pt}
\centering
\includegraphics[width=110pt]{#1}
\end{minipage}
\hfill
\begin{minipage}[b]{110pt}
\centering
	\captionsetup{width=110pt, justification=RaggedRight}
	\caption{#2\label{#1}}%
\end{minipage}
\end{figure}
}

% the table sizes
%
% no difference for large and normaltable in kindle style

\newcommand{\largetable}[4][ht!]{%
\begin{table}[#1]%
	\fontsize{5}{7}\selectfont
	#4
	\captionsetup{width=\textwidth, justification=justified}
	\caption{#3\label{#2}}%
\end{table}%
}

\newcommand{\normaltable}[4][ht!]{%
\begin{table}[#1]%
	\fontsize{8}{10}\selectfont
	#4
	\captionsetup{width=\textwidth, justification=justified}
	\caption{#3\label{#2}}%
\end{table}%
}

% table in the margin, #1 label, #2 caption, #3 code
\newcommand{\smalltable}[3]{%
\begin{table}[ht!]
\begin{minipage}[b]{110pt}
\centering
#3
\end{minipage}
\hfill
\begin{minipage}[b]{110pt}
\centering
	\captionsetup{width=110pt, justification=RaggedRight}
	\caption{#2\label{#1}}%
\end{minipage}
\end{table}
}

%
% sidenote without a mark in the text
\newcommand{\comment}[1]{\footnote{#1}}
% sidenote with textmark 
\newcommand{\annotation}[1]{\footnote{#1}}%
% citation with textmark
\newcommand{\reference}[3]{\footfullcite[#1][#2]{#3}}%

