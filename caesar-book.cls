\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{caesar-book}[2011/08/16 v0.2 Caesar Book class]

% Caesar Book version 0.1 2011-08-18 OS/AT

% first load the article-class
\LoadClass{book}

%%
% Load the common style elements
\input{caesar.def}

%%
% Set up any book-specific stuff now (this code is borrowed from the tufte-book.cls file

\renewcommand\frontmatter{%
  \cleardoublepage%
%  \@mainmatterfalse%
  \fancyhf{}%
   \fancyfoot[LE]{\thepage}
   \fancyfoot[RO]{\thepage}
}


%%
% The main matter in Tufte's /Beautiful Evidence/ doesn't restart the page
% numbering---it continues where it left off in the front matter.
\renewcommand\mainmatter{%
  \cleardoublepage%
%  \@mainmattertrue%
  \fancyhf{}%
      \renewcommand{\chaptermark}[1]{\markboth{##1}{}}%
      \fancyfoot[LE]{\thepage\newlinetospace}
      \fancyfoot[RO]{\newlinetospace\thepage}
}


%%
% The back matter contains appendices, indices, glossaries, endnotes,
% biliographies, list of contributors, illustration credits, etc.
\renewcommand\backmatter{%
}

%%
% Only show the chapter titles in the table of contents
\setcounter{tocdepth}{0}