%{
#include <stdio.h>
#define YYSTYPE char*
#include "y.tab.h"
extern YYSTYPE yylval; 
%}
%%
[(][,.;'"`?:!\-\%LR][,.;'"`?:!\-/\[\]\%CRBL ]*[)]                  /*  */

\[                      return LEFT_BRACKET;
\]                      return RIGHT_BRACKET;
\/                      return SLASH;
\(                      return LEFT_PAREN;
\)                      return RIGHT_PAREN;
TOP                     yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
ROOT                    yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
S                       yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
SBAR                    yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
SBARQ                   yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
SINV                    yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
SQ                      yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
ADJP                    yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
ADVP                    yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
CC                      yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
CD 		        yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
CONJP 		        yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
DT              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
EX              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
FW              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
FRAG              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
IN              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
INTJ              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
JJ              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
JJR             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
JJS             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
LS              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
LST              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
MD              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
NP              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
NP[@]              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;/*added NP@ tag using tsurgeon to handle POS ]*/ 
NAC              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
NN              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
NX              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
NNS             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
NNP             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
NNPS            	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
PP	            	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
PRN	            	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
PNP	            	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
PDT             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
POS             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
PRT             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
PRP             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
PRP[$]            	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
QP              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
RB              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
RBR             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
RBS             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
RP              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
RRC              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
SYM             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
TO              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
UH              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
VP              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
VB              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
VBD             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
VBG             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
VBN             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
VBP             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
VBZ             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
WDT             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
WP              	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
WP[$]             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
WHNP                    yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
WHADJP                  yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
WRB             	yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
WHPP                    yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
X                       yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
WHADVP                  yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
UCP                     yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return TOK_CATEGORY;
[A-Za-z0-9%='][A-Za-z0-9.,%'-]*    yylval=malloc(yyleng+1);strncpy(yylval,yytext,yyleng);*(yylval+yyleng)='\0'; return STRING;
\n                      /* ignore end of line */;
[ \t]+                  /* ignore whitespace */;
[, .]*                   /*                   */
%%