%% Copyright Ian Jauslin 2021
%% 
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.


%% TeX format
\NeedsTeXFormat{LaTeX2e}[1995/12/01]

%% class name
\ProvidesClass{ian-presentation}[2021/05/19]

\def\ian@defaultoptions{
  \pagestyle{plain}
  \RequirePackage{amssymb}
}

%% paper dimensions
\setlength\paperheight{240pt}
\setlength\paperwidth{427pt}

%% fonts
\input{size11.clo}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}

%% text dimensions
\textheight=208pt
\textwidth=370pt
\hoffset=-1in
\voffset=-1in
\oddsidemargin=24pt
\evensidemargin=24pt
\topmargin=8pt
\headheight=0pt
\headsep=0pt
\marginparsep=0pt
\marginparwidth=0pt
\footskip=16pt


%% remove default skips
\parindent=0pt
\parskip=0pt
\baselineskip=0pt

%% something is wrong with \thepage, redefine it
\gdef\thepage{\the\c@page}

%% correct vertical alignment at the end of a document
\AtEndDocument{
  % save total slide count
  \immediate\write\@auxout{\noexpand\gdef\noexpand\slidecount{\thepage}}
  \vfill
  \eject
}


%% footer
% plain style
\def\ps@plain{
  \def\@oddhead{}
  \def\@evenhead{\@oddhead}
  \def\@oddfoot{\tiny\hfill\thepage/\safe\slidecount\hfill}
  \def\@evenfoot{\@oddfoot}
}
% empty style
\def\ps@empty{
  \def\@oddhead{}
  \def\@evenhead{\@oddhead}
  \def\@oddfoot{}
  \def\@evenfoot{\@oddfoot}
}


%% title of slide
\def\title#1{
  \hfil{\bf\large #1}\par
  \hfil\vrule width0.75\textwidth height0.3pt\par
  \vskip5pt
}


%% define a command and write it to aux file
\def\outdef#1#2{%
  % define command%
  \expandafter\xdef\csname #1\endcsname{#2}%
  % hyperlink number%
  \expandafter\xdef\csname #1@hl\endcsname{\thelncount}%
  % write command to aux%
  \immediate\write\@auxout{\noexpand\expandafter\noexpand\gdef\noexpand\csname #1\endcsname{\csname #1\endcsname}}%
  \immediate\write\@auxout{\noexpand\expandafter\noexpand\gdef\noexpand\csname #1@hl\endcsname{\thelncount}}%
}

%% use to call commands even when they are not defined
\def\safe#1{%
  \ifdefined#1%
    #1%
  \else%
    {\bf?}%
  \fi%
}


%% itemize
% left margin for items
\newlength\itemizeskip
\setlength\itemizeskip{20pt}
% space between the item symbol and the text
\newlength\itemizeseparator
\setlength\itemizeseparator{5pt}
% penalty preceding an itemize
\def\itemizepenalty{0}
% counter counting how many itemizes have been nested
\newcounter{itemizecount}

% item symbol (bullet for first level, triangle for further levels (should not need more than 2 levels in most cases))
\def\itemizept#1{
  \ifnum#1=1
    \textbullet
  \else
    $\scriptstyle\blacktriangleright$
  \fi
}

% implement itemizes
\newlength\current@itemizeskip
\setlength\current@itemizeskip{0pt}
\def\itemize{
  \par\penalty\itemizepenalty\medskip\penalty\itemizepenalty
  % increment level
  \addtocounter{itemizecount}{1}
  % increase indent
  \addtolength\current@itemizeskip{\itemizeskip}
  \leftskip\current@itemizeskip
}
\def\enditemize{
  % decrement level
  \addtocounter{itemizecount}{-1}
  % decrease indent
  \addtolength\current@itemizeskip{-\itemizeskip}
  \par\leftskip\current@itemizeskip
  \medskip
}
% implement item
\newlength\itempt@total
\def\item{
  % place symbol on left of margin
  \settowidth\itempt@total{\itemizept\theitemizecount}
  \addtolength\itempt@total{\itemizeseparator}
  \par
  \medskip
  \hskip-\itempt@total\itemizept\theitemizecount\hskip\itemizeseparator
}

%% enumerate (do not nest these!)
\newcounter{enumerate@count}
\def\enumerate{
  \setcounter{enumerate@count}0
  % redefine \item and \itemizept
  \let\olditem\item
  \let\olditemizept\itemizept
  \def\item{
    % counter
    \stepcounter{enumerate@count}
    % set symbol to enumerate number
    \def\itemizept####1{{\bf \theenumerate@count.}}
    \olditem
  }
  \itemize
}
\def\endenumerate{
  \enditemize
  \let\item\olditem
  \let\itemizept\olditemizept
}


%% end
\ian@defaultoptions

\endinput
