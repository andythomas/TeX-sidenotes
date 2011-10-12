\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{caesar-article}[2011/08/16 v0.2 Caesar Article class]

% Caesar Article version 0.1 2011-08-11 OS/AT

% first load the article-class
\LoadClass{article}

%%
% chapter not defined up to now
\newcommand{\chapter}{}

%%
% Load the common style elements
\input{caesar.def}

% For now I left out the sans serif abstract, which was loaded when using sf sidenotes
\renewenvironment{quotation}
               {\list{}{\listparindent 1pc%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin%
                        \parsep	10pt}% Not sure about this one (Oliver)
                \small%
                \item\relax\noindent\ignorespaces}
               {\endlist}

\renewenvironment{abstract}
  {\begin{quotation}}
  {\end{quotation}}
  
\geometry{paperwidth=210mm, paperheight=297mm, left=50pt, top=50pt, textwidth=345pt, marginparsep=25pt, marginparwidth=124pt, textheight=692pt, footskip=50pt}

% fontsize is 12pt, 14pt
% footnotes are 10/12 
\renewcommand{\normalsize}{\fontsize{12pt}{14pt}\selectfont} 
\renewcommand{\footnotesize}{\fontsize{10pt}{12pt}\selectfont} 

\captionsetup{width=\marginparwidth, justification=RaggedRight, font=footnotesize, skip = 0pt}
\renewcommand{\sidestyle}{\footnotesize\RaggedRight}

% make an unused chapter counter to avoid an error
\newcounter{chapter}
\renewcommand\chapter[1]{}
% define a questions environment
\newenvironment{questions}
{\section{Fragen}
\begin{enumerate}}
{\end{enumerate}}
% define a tutorial environment
\newenvironment{tutorials}
{\section{Aufgaben}
\begin{enumerate}}
{\end{enumerate}}
