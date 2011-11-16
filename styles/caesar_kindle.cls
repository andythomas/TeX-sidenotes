%%
\NeedsTeXFormat{LaTeX2e}

\ProvidesFile{caesar_kindle.cls}[2011/11/16 v0.3 Caesar kindle]

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
\captionsetup{width=110pt, justification=RaggedRight, font=footnotesize, skip = 0pt}

%%
% Set page layout geometry -- default is epubli science-book format
\RequirePackage[paperwidth=255pt, paperheight=340pt, left=10pt, top=10pt, textwidth=235pt, marginparsep=0pt, marginparwidth=0pt, textheight=310pt, footskip=20pt]{geometry}%

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
% fontsize 
\renewcommand{\normalsize}{\fontsize{9pt}{11pt}\selectfont}%
% footnotesize
\renewcommand{\footnotesize}{\fontsize{8pt}{10pt}\selectfont}%
% chapter has numbers
\setcounter{secnumdepth}{0}
%

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
   {\vspace{1.5\baselineskip}\begin{fullwidth}\rmfamily} % above (global formatting of entry)
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

\pagestyle{empty}

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
\newcommand{\normalfigure}[2]{%
\begin{figure}[ht!]%
	\includegraphics[width=235pt]{#1}
	\captionsetup{width=\textwidth, justification=justified}
	\caption{#2\label{#1}}%
\end{figure}%
}

%graphics in the margin, #1 filename=label, #2 caption
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

\newcommand{\normaltable}[3]{%
\begin{table}[ht!]%
	#3
	\captionsetup{width=\textwidth, justification=justified}
	\caption{#2\label{#1}}%
\end{table}%
}

\newcommand{\tinyfigure}[1]{\includegraphics{#1}}

\newcommand{\reference}[3]{%
\footnote{\fullcite[#1][#2]{#3}}%
}

\newcommand{\annotation}[1]{%
\footnote{#1}%
}

% quoted text
\newcommand{\quotetext}{\textit}
%