This package is based on Robin Fairbairns footmisc package.

Copyright 2016 Bastien Roucari\`es
Copyright 1995, 1996, 1998, 1999, 2001--2003, 2008, 2009 Robin Fairbairns

It allow to personnalize footnote on LaTeX.

Last version is found here https://github.com/bastien-roucaries/footmisx
\newif\if@tempswb
\newcommand{\DefineFNsymbols}{%
        \@ifstar{\@tempswbtrue\@DefineFNsymbols}%
                {\@tempswbfalse\@DefineFNsymbols}%
}
\newcommand{\@DefineFNsymbols}[1]{%
  \@ifnextchar[% ]
    {\@DefineFNsymbols@{#1}}{\@DefineFNsymbols@{#1}[text]}%
}
\def\@DefineFNsymbols@#1[#2]#3{%
  \expandafter\ifx\csname FN@fnsymbol@#1\endcsname\relax
    \PackageInfo{footmisx}{Declaring symbol style #1}%
  \else
    \PackageWarning{footmisx}{Redeclaring symbol style #1}%
  \fi
  \toks@{}%
  \def\@tempb{\end}%
  \FN@build@symboldef#3\end
  \def\@tempc{math}%
  \def\@tempd{#2}%
  \expandafter\xdef\csname FN@fnsymbol@#1\endcsname##1{%
    \ifx\@tempc\@tempd
      \noexpand\ensuremath
    \else
      \noexpand\nfss@text
    \fi
    {%
      \noexpand\ifcase##1%
      \the\toks@
      \noexpand\else
      \if@tempswb
        \noexpand\@ctrerr
      \else
        \noexpand\@arabic##1\noexpand\FN@orange##1%
      \fi
      \noexpand\fi
    }%
  }%
}
\def\FN@build@symboldef#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@tempb
  \else
    \toks@\expandafter{\the\toks@\or#1}%
    \expandafter\FN@build@symboldef
  \fi
}
\newcommand{\DefineFNsymbolsTM}{%
        \@ifstar{\@tempswbtrue\@DefineFNsymbolsTM}%
                {\@tempswbfalse\@DefineFNsymbolsTM}}%
\newcommand{\@DefineFNsymbolsTM}[2]{%
  \expandafter\ifx\csname FN@fnsymbol@#1\endcsname\relax
    \PackageInfo{footmisx}{Declaring symbol style #1}%
  \else
    \PackageWarning{footmisx}{Redeclaring symbol style #1}%
  \fi
  \toks@{}%
  \def\@tempb{\end}%
  \FN@build@symboldefTM#2\end\@null
  \expandafter\xdef\csname FN@fnsymbol@#1\endcsname##1{%
    \noexpand\ifcase##1%
      \the\toks@
    \noexpand\else
      \if@tempswb
        \noexpand\@ctrerr
      \else
        \noexpand\@arabic##1\noexpand\FN@orange##1%
      \fi
    \noexpand\fi
  }%
}%
\def\FN@build@symboldefTM#1#2{%
  \def\@tempa{#1}%
  \ifx\@tempa\@tempb
  \else
    \toks@\expandafter{\the\toks@\or\TextOrMath{#1}{#2}}%
    \expandafter\FN@build@symboldefTM
  \fi
}
\@ifundefined{TextOrMath}{%
  \@ifundefined{eTeXversion}{%
    \PackageError{footmisx}{Can't define commands for footnote symbol}%
                           {Use e-LaTeX, or load package fixltx2e before
                             footmisx}%
  }{%
    \protected\expandafter\def\csname TextOrMath\space\endcsname{%
      \ifmmode \expandafter\@secondoftwo
      \else    \expandafter\@firstoftwo   \fi
    }
    \edef\TextOrMath#1#2{%
      \expandafter\noexpand\csname TextOrMath\space\endcsname
        {#1}{#2}%
    }%
  }%
}{}
\def\FN@orange#1{%
  \@bsphack
  \PackageInfo{footmisx}{Footnote number \number#1 out of range}%
  \protect\@fnsymbol@orange
  \@esphack
}
\global\let\@diagnose@fnsymbol@orange\relax
\AtEndDocument{\@diagnose@fnsymbol@orange}
\def\@fnsymbol@orange{%
  \gdef\@diagnose@fnsymbol@orange{%
    \PackageWarningNoLine{footmisx}{Some footnote number(s)
      were out of range
      \MessageBreak
      see log for details%
    }%
  }%
}
\@ifundefined{textbardbl}{%
  \DeclareTextSymbol{\textbardbl}{OMS}{107}%
  \DeclareTextSymbolDefault{\textbardbl}{TS1}}{}%
\DefineFNsymbolsTM*{bringhurst}{%
  \textasteriskcentered *
  \textdagger    \dagger
  \textdaggerdbl \ddagger
  \textsection   \mathsection
  \textbardbl    \|%
  \textparagraph \mathparagraph
}%
\DefineFNsymbolsTM*{chicago}{%
  \textasteriskcentered *
  \textdagger    \dagger
  \textdaggerdbl \ddagger
  \textsection   \mathsection
  \textbardbl    \|%
  \#\#%
}%
\DefineFNsymbolsTM*{wiley}{
  \textasteriskcentered *
  {\textasteriskcentered\textasteriskcentered}{**}%
  \textdagger    \dagger
  \textdaggerdbl \ddagger
  \textsection   \mathsection
  \textparagraph \mathparagraph
  \textbardbl    \|%
}%
\DefineFNsymbolsTM{lamport-robust}{
  \textasteriskcentered *
  \textdagger    \dagger
  \textdaggerdbl \ddagger
  \textsection   \mathsection
  \textparagraph \mathparagraph
  \textbardbl    \|%
  {\textasteriskcentered\textasteriskcentered}{**}%
  {\textdagger\textdagger}{\dagger\dagger}%
  {\textdaggerdbl\textdaggerdbl}{\ddagger\ddagger}%
}
\DefineFNsymbolsTM*{lamport*}{%
  \textasteriskcentered *
  \textdagger    \dagger
  \textdaggerdbl \ddagger
  \textsection   \mathsection
  \textparagraph \mathparagraph
  \textbardbl    \|%
  {\textasteriskcentered\textasteriskcentered}{**}%
  {\textdagger\textdagger}{\dagger\dagger}%
  {\textdaggerdbl\textdaggerdbl}{\ddagger\ddagger}%
  {\textsection\textsection}{\mathsection\mathsection}%
  {\textparagraph\textparagraph}{\mathparagraph\mathparagraph}%
  {\textasteriskcentered\textasteriskcentered\textasteriskcentered}{***}%
  {\textdagger\textdagger\textdagger}{\dagger\dagger\dagger}%
  {\textdaggerdbl\textdaggerdbl\textdaggerdbl}{\ddagger\ddagger\ddagger}%
  {\textsection\textsection\textsection}%%
    {\mathsection\mathsection\mathsection}%
  {\textparagraph\textparagraph\textparagraph}%%
    {\mathparagraph\mathparagraph\mathparagraph}%
}
\setfnsymbol{lamport*}
\DefineFNsymbolsTM{lamport*-robust}{%
  \textasteriskcentered *
  \textdagger    \dagger
  \textdaggerdbl \ddagger
  \textsection   \mathsection
  \textparagraph \mathparagraph
  \textbardbl    \|%
  {\textasteriskcentered\textasteriskcentered}{**}%
  {\textdagger\textdagger}{\dagger\dagger}%
  {\textdaggerdbl\textdaggerdbl}{\ddagger\ddagger}%
  {\textsection\textsection}{\mathsection\mathsection}%
  {\textparagraph\textparagraph}{\mathparagraph\mathparagraph}%
  {\textasteriskcentered\textasteriskcentered\textasteriskcentered}{***}%
  {\textdagger\textdagger\textdagger}{\dagger\dagger\dagger}%
  {\textdaggerdbl\textdaggerdbl\textdaggerdbl}{\ddagger\ddagger\ddagger}%
  {\textsection\textsection\textsection}%%
    {\mathsection\mathsection\mathsection}%
  {\textparagraph\textparagraph\textparagraph}%%
    {\mathparagraph\mathparagraph\mathparagraph}%
}
\ExplSyntaxOn
\cs_new_nopar:Nn \__footmisx_noHref:n {\ref{#1}}
\tl_const:Nn \__footmisx_define__footmisx_noHref: {
  \@ifpackageloaded{hyperref}{
    \cs_gset:Nn \__footmisx_noHref:n {\ref*{#1}}
  }
  {
    \cs_gset:Nn \__footmisx_noHref:n {\ref{#1}}
  }
}
\__footmisx_AtEndOfPackageFile_and_now:NN {hyperref}{
  \__footmisx_define__footmisx_noHref: {}
}
\cs_new_nopar:Nn \__footmisx_@makefnmarklink:n {\textfootmark{#1}}
\cs_new_eq:NN \__footmisx_noref_@makefnmarklink:n \__footmisx_@makefnmarklink:n
\cs_new_nopar:Nn \__footmisx_hyperref_@makefnmarklink:n {
    \__footmisx_noref_@makefnmarklink:n {
    \stepcounter{Hfootnote}%
    \global\let\Hy@saved@currentHref\@currentHref
    \hyper@makecurrent{Hfootnote}%
    \global\let\Hy@footnote@currentHref\@currentHref
    \global\let\@currentHref\Hy@saved@currentHref
    \hyper@linkstart{link}{\Hy@footnote@currentHref}%
    #1
    \hyper@linkend
    }
}
\tl_const:Nn \__footmisx_define__footmisx_@makefnmarklink: {
  \@ifpackageloaded{hyperref}{
    \ifHy@hyperfootnotes
       \cs_gset_eq:NN \__footmisx_@makefnmarklink:n \__footmisx_hyperref_@makefnmarklink:n
    \else
       \cs_gset_eq:NN \__footmisx_@makefnmarklink:n \__footmisx_noref_@makefnmarklink:n
    \fi
  }
  {
    \cs_gset_eq:NN \__footmisx_@makefnmarklink:n \__footmisx_noref_@makefnmarklink:n
  }
}
\__footmisx_AtEndOfPackageFile_and_now:NN {hyperref} {
  \__footmisx_define__footmisx_@makefnmarklink: {}
}
\cs_new_nopar:Nn \__footmisx_@makefnmarklink_stared:Nn {
  \IfBooleanTF{#1}
    {\__footmisx_noref_@makefnmarklink:n{#2}}
    {\__footmisx_@makefnmarklink:n{#2}}
}
\DeclareDocumentCommand{\__footmisx_makefnmarklink}
  {sO{\@thefnmark}}
  {\__footmisx_@makefnmarklink_stared:Nn{#1}{#2}
}

\cs_set_eq:NN \__footmisx_orig_@makefnmark \@makefnmark
\cs_set_eq:NN \@makefnmark \__footmisx_makefnmarklink
\cs_new_nopar:Nn \__footmisx_@footnotemark_stared:Nn {
  \leavevmode
  \mode_if_horizontal:TF
  {
    \edef\@x@sf{\the\spacefactor}
    \FN@mf@check
    \nobreak
  }
  {}
  \__footmisx_@makefnmarklink_stared:Nn{#1}{#2}
  \FN@mf@prepare
  \mode_if_horizontal:TF
  {\spacefactor\@x@sf}
  {}
  \relax
}
\DeclareDocumentCommand{\__footmisx_@footnotemark}{sO{\@thefnmark}}{
   \__footmisx_@footnotemark_stared:Nn{#1}{#2}
}
\tl_const:Nn \__footmisx_define_@footnotemark_tl: {
   \cs_gset_eq:NN \@footnotemark \__footmisx_@footnotemark
}
\__footmisx_define_@footnotemark_tl:
\__footmisx_disablepatchinginpackage:cN{@footnotemark}{hyperref}
\tl_new:N \g__footmisx_footnotetextbeginhook_tl
\tl_new:N \g__footmisx_footnotetextbeginhook_setspace_tl
\tl_put_right:Nn {\g__footmisx_footnotetextbeginhook_tl}
   {\g__footmisx_footnotetextbeginhook_setspace_tl}
\tl_const:Nn \g__footmisx_definesetspacehook_tl: {
  \@ifpackageloaded{setspace}{%
    \@ifclassloaded{memoir}{%
      \tl_gset:Nn {\g__footmisx_footnotetextbeginhook_setspace_tl}
      {\cs_set_eq:NN \baselinestretch \m@m@singlespace}
    }{%
      \tl_gset:Nn {\g__footmisx_footnotetextbeginhook_setspace_tl}
      {\cs_set_eq:NN \baselinestretch \setspace@singlespace}
    }%
  }{
    \tl_gset:Nn {\g__footmisx_footnotetextbeginhook_setspace_tl} {}
  }
}
\__footmisx_AtEndOfPackageFile_and_now:NN {setspace} {
  \g__footmisx_definesetspacehook_tl:
}
\__footmisx_disablepatchinginpackage:cN{@footnotetext}{setspace}
\__footmisx_disablepatchinginpackage:cN{@mpfootnotetext}{setspace}
\ExplSyntaxOn
\cs_new:Nn \__footmisx_marginpar@footnotetext:N {
  \marginpar{
    % hook at beginning
    \g__footmisx_footnotetextbeginhook_tl
    \reset@font\footnotesize
    \protected@edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}%
    \color_group_begin:
     \@makefntext{%
       \ignorespaces#1%
     }%
     \color_group_end:
   }%
   \FN@mf@prepare
}
\cs_new:Nn \__footmisx_par@footnotetext:N {
  \insert\footins{%
    % hook at beginning
    \g__footmisx_footnotetextbeginhook_tl
    \reset@font\footnotesize
    \protected@edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}%
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox
    \floatingpenalty\@MM
    \hsize\columnwidth
    \@parboxrestore
    \color_group_begin:
        \setbox\FN@tempboxa=\hbox{%
          \@makefntext{\ignorespaces#1\strut
            \penalty-10\relax
            \hskip\footglue
          }% end of \@makefntext parameter
        }% end of \hbox
        \dp\FN@tempboxa=0pt
        \ht\FN@tempboxa=\dimexpr\wd\FN@tempboxa *
                          \footnotebaselineskip / \columnwidth\relax
        \box\FN@tempboxa
      \color_group_end:
    }%
    \FN@mf@prepare
}
\cs_new:Nn \__footmisx_normal@footnotetext:N {
  \insert\footins{%
    \g__footmisx_footnotetextbeginhook_tl
    \reset@font\footnotesize
    \protected@edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}%
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox
    \floatingpenalty\@MM
    \hsize\columnwidth
    \@parboxrestore
    \color_group_begin:
    \@makefntext{%
      \rule\z@\footnotesep
      \ignorespaces#1\@finalstrut\strutbox
    }%
    \color_group_end:
  }%
  \FN@mf@prepare
}%
\ifFN@para
\cs_gset_eq:NN \@footmisxnotetext \__footmisx_par@footnotetext:N
\else
\ifFN@sidefn
\cs_gset_eq:NN \@footmisxnotetext \__footmisx_marginpar@footnotetext:N
\else
\cs_gset_eq:NN \@footmisxnotetext \__footmisx_normal@footnotetext:N
\fi
\fi
\ExplSyntaxOff
\ExplSyntaxOn
\__footmisx_AtEndOfPackageFile_and_now:NN {hyperref} {
  \@ifpackageloaded{hyperref}
  {
    \cs_gset_eq:cc {H @ @ footnotetext} {@footmisxnotetext}
  }{
    \cs_gset_eq:cc {@footnotetext} {@footmisxnotetext}
  }
}
\ExplSyntaxOff
\ExplSyntaxOn
\NewDocumentCommand{\textfootmark}{m}
    {\hbox{\@textsuperscript{\normalfont#1}}}
\ExplSyntaxOff
\ExplSyntaxOn
\cs_new_nopar:Nn \__footmisx_footref_stared:Nn {
  \textfootmark{
    \IfBooleanTF{#1}
      {\__footmisx_noHref:n{#2}}
      {\ref{#2}}
  }
}
\DeclareDocumentCommand {\__footmisx_footref} {s m}
{
    \__footmisx_footref_stared:Nn{#1}{#2}
}
\ExplSyntaxOff
\ExplSyntaxOn
\__footmisx_AtEndOfPackageFile_and_now:NN {hyperref} {\cs_gset_eq:NN \footref \__footmisx_footref}
\ExplSyntaxOff
\ExplSyntaxOn
\DeclareDocumentCommand\mpfootnotemark{o}
{
  \IfValueTF {#1}
  {
    \group_begin:
    \cs_set:cpn {c@\@mpfn} {#1}
    \unrestored@protected@xdef\@thefnmark{\thempfn}
    \group_end:
  }
  {
    \stepcounter\@mpfn
    \protected@xdef\@thefnmark{\thempfn}
  }
  \@footnotemark
}
\ExplSyntaxOff
