%%
\NeedsTeXFormat{LaTeX2e}

\ProvidesFile{caesar_book.cls}[2011/11/16 v0.3 Caesar book]

%%
% Load the amsmath and the mhchem package before loading microtype
\RequirePackage{amsmath}
\RequirePackage[version=3]{mhchem}

%%
% We use the `ifthen' package to handle our package option switches
\RequirePackage{ifthen}

%% this is derived from the book class
\LoadClassWithOptions{book}

% provide the ragged outer option
\newcommand{\raggedouter}{%
	\checkoddpage%
    	\ifoddpage%
		\RaggedRight%
    	\else%
		\RaggedLeft%
    	\fi%
}

%%
% Changepage package for symmetric twoside handling
\RequirePackage[strict]{changepage}

%%
% nice headings and TOC
\RequirePackage{titlesec,titletoc}

% we need a couple of packages for the formatting of the marginals
\RequirePackage{ragged2e}
\RequirePackage{caption}
\RequirePackage{sidenotes}

% -- microtypography
\RequirePackage[babel]{microtype}

% set up the captions
\DeclareCaptionJustification{raggedouter}{\raggedouter}
\captionsetup{font=footnotesize,justification=raggedouter, skip=4pt}

%%
% Set page layout geometry -- default is epubli science-book format
\RequirePackage[paperwidth=170mm, paperheight=240mm, left=40pt, top=40pt, textwidth=280pt, marginparsep=20pt, marginparwidth=100pt, textheight=560pt, footskip=40pt]{geometry}%

%%
% set the fonts
\RequirePackage{fontspec}

% Use Neo Euler as math font
\RequirePackage[math-style=upright, vargreek-shape=TeX]{unicode-math}% 
\setmathfont{Asana Math}%
% Use the Palatino-Clone Tex Gyre Pagella as main font
\setmainfont[Ligatures=TeX, Numbers=OldStyle]{Tex Gyre Pagella}%
% Use Tex Gyre Cursor as Monospace Font
\setmonofont{Tex Gyre Cursor}%
% Use Tex Gyre Heros Cn as Sans Serif Font
\setsansfont{Tex Gyre Heros}%
% fontsize is 10pt, 13pt for book and 12pt, 15pt for handout
\renewcommand{\normalsize}{\fontsize{10pt}{13pt}\selectfont}%
% fontsize is 10pt, 13pt for book and 9pt, 11pt for kindle
\renewcommand{\footnotesize}{\fontsize{8pt}{10pt}\selectfont}%

\setcounter{tocdepth}{0}
\setcounter{secnumdepth}{-1}
%

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

% paragraph format
\titleformat{\paragraph}%
  [runin]% shape
  {\normalfont\itshape}% format applied to label+text
  {}% label
  {1em}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body

%%
% spaces before and after the headings
\titlespacing*{\chapter}{0pt}{\baselineskip}{\baselineskip}
\titlespacing*{\section}{0pt}{\baselineskip}{\baselineskip}

%%
% The Table of Contents
\titlecontents{chapter}%
   [0em] % distance from left margin
   {\vspace{1.5\baselineskip}\begin{fullwidth}\LARGE\rmfamily\itshape} % above (global formatting of entry)
   {\hspace*{0em}\contentslabel{2em}} % before w/label (label = ``2'')
   {\hspace*{0em}} % before w/o label
   {\rmfamily\upshape\qquad\thecontentspage} % filler + page (leaders and page num)
   [\end{fullwidth}] % after

%%
% display only the highest sections in the TOC
\setcounter{tocdepth}{0}

%%
% redefine the equation, table and figure counter when giving an explicit chapter number
% if other counters are encountered at farpoint, the can be changed the same way
\renewcommand{\thefigure}{\arabic{figure}}
\renewcommand{\thetable}{\arabic{table}}
\renewcommand{\theequation}{\arabic{equation}}


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
\renewcommand{\sidestyle}{\footnotesize\raggedouter}

%%
% High level macro set for kindle and the rest of the options

% graphics in text, #1 filename=label, #2 caption
\newcommand{\largefigure}[2]{%
\begin{figure}[htbp]%
 \checkoddpage%
    	\ifoddpage%
		%
    	\else%
		\hspace{-120pt}%
    	\fi%
 \includegraphics[width=400pt]{#1}%
 \captionsetup{margin={0pt,-120pt}, justification=justified}%
 \caption{#2}%
 \label{#1}%
\end{figure}%
}

\newcommand{\normalfigure}[2]{%
\begin{figure}[htbp]%
	\includegraphics[width=\textwidth]{#1}%
	\captionsetup{width=\textwidth, justification=justified}%
	\caption{#2\label{#1}}%
\end{figure}%
}

%graphics in the margin, #1 filename=label, #2 caption
\newcommand{\smallfigure}[2]{%
\begin{sidefigure}%
\includegraphics[width=\marginparwidth]{#1}%
\caption{#2\label{#1}}%
\end{sidefigure}%
}

% table in the margin, #1 label, #2 caption, #3 code
\newcommand{\smalltable}[3]{%
\begin{sidetable}%
	#3
	 \vspace{2pt}
	\caption{#2\label{#1}}%
\end{sidetable}%
}

\newcommand{\normaltable}[3]{%
\begin{table}[htbp]%
	#3
	\vspace{2pt}
	\captionsetup{width=\textwidth, justification=justified}
	\caption{#2\label{#1}}%
\end{table}%
}

% quoted text
\newcommand{\quotetext}{\textit}

\newcommand{\tinyfigure}[1]{\includegraphics{#1}}

\newcommand{\reference}[3]{%
\sidecite[#1][#2]{#3}}%

\newcommand{\annotation}[1]{\sidenote{#1}}%
%

%% compatibility options

\newcommand\newthought[1]{%
   \addvspace{1.0\baselineskip plus 0.5ex minus 0.2ex}%
   \noindent\textsc{#1}%
}%

\RequirePackage{color}
\definecolor{darkgray}{rgb}{0.25,0.25,0.25}

\RequirePackage{textcase} % provides \MakeTextUppercase and \MakeTextLowercase
\newcommand{\allcaps}{\MakeTextUppercase}
\newcommand{\smallcaps}{\MakeTextLowercase}

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

\newcommand{\maketitlepage}[0]{%
  \cleardoublepage%
  \begingroup%
  {%
  \sffamily%
  \begin{fullwidth}%
  \LARGE\lsstyle\allcaps{\@author}\par
  \vspace{6em}%
  \noindent\fontsize{38}{50}\selectfont\textcolor{darkgray}{\textls[125]{\allcaps{\@title}}}\par
  \vfill%
  \Large\selectfont\par\noindent\lsstyle\allcaps{\publisher}\par
  \end{fullwidth}%
  }%
  \endgroup%
  \thispagestyle{empty}%
  \clearpage%
}

\renewcommand{\frontmatter}{\pagestyle{empty}}
\renewcommand{\mainmatter}{\thispagestyle{empty}\pagestyle{fancy}}