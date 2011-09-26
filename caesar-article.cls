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