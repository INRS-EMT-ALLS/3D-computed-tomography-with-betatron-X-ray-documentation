% --------------------------------------------------------------------------- %
% Author:          J. Dumont and D. Gagnon							          %
% Date created:    2016-03-10           
% --------------------------------------------------------------------------- %

% ----------------------------------------------------------------- %
% --                    Class Identification                     -- %
% ----------------------------------------------------------------- %
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{inrs-report}[2015/02/04 v0.1 INRS Report class]
\RequirePackage{ifthen}

% ----------------------------------------------------------------- %
% --                   Primary Specifications                    -- %
% ----------------------------------------------------------------- %
% -- Default language is English, but this can be
% -- changed with the francais class option.

\LoadClassWithOptions{memoir}
\newboolean{INRS@francais}
\setboolean{INRS@francais}{false}
\DeclareOption{francais}
{%
    \setboolean{INRS@francais}{true}
}

\DeclareOption{article}{
      %%% Article options
      \counterwithout{section}{chapter}
      \setsecnumdepth{subsection}
      \settocdepth{subsection}
      \PassOptionsToClass{\CurrentOption}{memoir}
      
}

% -- Pass other options direclty to memoir class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax


% Create titlepage command
\newcommand*{\INRS@titlepage}{}

% ----------------------------------------------------------------- %
% --                          Packages                           -- %
% ----------------------------------------------------------------- %
% -- Choice of language
\ifthenelse{\boolean{INRS@francais}}
{%
    \RequirePackage[english,francais]{babel}
}%
{%
    \RequirePackage[english]{babel}
}%

%\RequirePackage[in]{fullpage}
\RequirePackage[letterpaper, total={6in, 8in}]{geometry}
\RequirePackage{amsthm,amsmath,amssymb}   % Defines mathematics-related environements, symbols and others.
\RequirePackage{graphicx}                 % Allows the use of graphics.
\RequirePackage[                          % PDF format config.
      unicode=true,                       % Unicode encoding.
      bookmarks=true,                     % Bookmarks in PDF.
      bookmarksnumbered=true,             % Numberred bookmarks.
      bookmarksopenlevel=3,               % Shows up to subsections when opening PDF.
      pdfborder= {0 0 0},                 % Removes the border around links.
      backref=false,                      % Removes the links from bibliography to main text.
      colorlinks=true,                    % Colouring the links.
      linktoc=page,                       % In ToC, only page numbers are links, not section titles.
      linkcolor=red,                      % Colour of links (section numbers, pages, ...).
      citecolor=blue,                     % Colour of links to bibliography (citations).
      urlcolor=blue]                      % Colour of URLs.
      {hyperref}

% ----------------------------------------------------------------- %
% --                       Class Variables                       -- %
% ----------------------------------------------------------------- %
% -- We define multiple variables that are used to generate
% -- title page and such.
\newcommand{\INRS@title}{[Title]}
\newboolean{INRS@hastitle}
\renewcommand*{\title}[1]
{%
      \setboolean{INRS@hastitle}{true}
      \renewcommand*{\INRS@title}{#1}
}%

\newcommand{\INRS@reportnumber}{0}
\newboolean{INRS@hasreportnumber}
\newcommand*{\reportnumber}[1]
{%
      \setboolean{INRS@hasreportnumber}{true}
      \renewcommand*{\INRS@reportnumber}{#1}
}%

\newcommand{\INRS@author}{[Author]}
\newboolean{INRS@hasauthor}
\renewcommand*{\author}[1]
{%
      \setboolean{INRS@hasauthor}{true}
      \renewcommand*{\INRS@author}{#1}
}%

\newcommand{\INRS@affiliation}{[Affiliation]}
\newboolean{INRS@hasaffiliation}
\newcommand*{\affiliation}[1]
{%
      \setboolean{INRS@hasaffiliation}{true}
      \renewcommand*{\INRS@affiliation}{#1}
}%

\newcommand{\INRS@supervisor}{[Supervisor]}
\newboolean{INRS@hassupervisor}
\newcommand*{\supervisor}[1]
{%
      \setboolean{INRS@hassupervisor}{true}
      \renewcommand*{\INRS@supervisor}{#1}
}%

\newcommand{\INRS@date}{\today}
\renewcommand{\date}[1]
{%
      \renewcommand*{\INRS@date}{#1}
}%

\newcommand{\INRS@revision}{\today}
\newboolean{INRS@hasrevision}
\newcommand*{\revision}[1]
{%
      \setboolean{INRS@hasrevision}{true}
      \renewcommand*{\INRS@revision}{#1}
}%

\newcommand{\INRS@logo}{}
\newboolean{INRS@haslogo}
\newcommand*{\logo}[1]
{
      \setboolean{INRS@haslogo}{true}
      \renewcommand*{\INRS@logo}{#1}
}

\newcommand{\INRS@reportversion}{}
\newboolean{INRS@hasreportversion}
\newcommand*{\reportversion}[1]
{
  \setboolean{INRS@hasreportversion}{true}
  \renewcommand*{\INRS@reportversion}{#1}
}


% -- Default title page.
\newcommand*{\printtitle}
{%

      \ifx\INRS@titlepage\empty
      \begin{titlingpage}
      \begin{OnehalfSpace}

          \begin{center}
          {\huge \INRS@title}\\[0.5\baselineskip]
          
          \vfill

          \ifthenelse{\boolean{INRS@hasreportversion}}
          {\large Revision \INRS@reportversion}

          \vfill
          
          \INRS@author\\

          \vfill
                  
              \INRS@affiliation

          \vfill

          \ifthenelse{\boolean{INRS@haslogo}}
          {\INRS@logo}
          {}
      
            \vfill
      
                  \ifthenelse{\boolean{INRS@francais}}
                  {	
                  \ifthenelse{\boolean{INRS@hassupervisor}}{\emph{Superviseur:}\\\INRS@supervisor}{}
                  }
                  {
                  \ifthenelse{\boolean{INRS@hassupervisor}}{\emph{Supervisor:}\\\INRS@supervisor}{}	
                  }
                  \vfill
                  
                  %% Date et revision
                  \INRS@date
                  \ifthenelse{\boolean{INRS@hasrevision}}{
                    \\ 
                    \ifthenelse{\boolean{INRS@francais}}{Derni\`{e}re r\'evision: \INRS@revision}{Last revised: \INRS@revision}
                  }

         \end{center}
      \end{OnehalfSpace}
      \end{titlingpage}
}