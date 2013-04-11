/* Ex: The average annual rainfall ranges from 2,000 mm to 3,000 mm , with temperatures ranging from 25 to 30° Celsius.
   In above example '°' symbol applies to both 25 and 30. So instead of combining '°' to 30 in Stanford penn o/p,  Chaitanya Sir suggested to consider all the Symbols as 'SYMBOL-NAME' and restore 'SYMBOL-NAME' back again with original Symbol.
   Ex: '°' is mapped to SYMBOL-DEGREE-SIGN and at the end SYMBOL-DEGREE-SIGN is replaced with °	
   Added by Roja (17-08-12) */
%{
#include <string.h>
char str[1000], *s1 , str2[1000];
int len, len1;
FILE *fp;
%}

%%

¡	{	printf(" SYMBOL-INVERTED-EXCLAMATION-MARK ");
 		 	fprintf(fp, " SYMBOL-INVERTED-EXCLAMATION-MARK 	%s\n", yytext);
		}
¢	{	printf(" SYMBOL-CENT-SIGN ");
			fprintf(fp, " SYMBOL-CENT-SIGN 	%s\n", yytext);
		}
£	{	printf(" SYMBOL-POUND-SIGN ");
			fprintf(fp, " SYMBOL-POUND-SIGN 	%s\n", yytext);
		}
¤	{	printf(" SYMBOL-CURRENCY-SIGN ");
			fprintf(fp, " SYMBOL-CURRENCY-SIGN 	%s\n", yytext);
		}
¥	{	printf(" SYMBOL-YEN-SIGN ");
			fprintf(fp, " SYMBOL-YEN-SIGN 	%s\n", yytext);
		}
¦	{	printf(" SYMBOL-BROKEN-BAR ");
			fprintf(fp, " SYMBOL-BROKEN-BAR 	%s\n", yytext);
		}
§	{	printf(" SYMBOL-SECTION-SIGN ");
			fprintf(fp, " SYMBOL-SECTION-SIGN 	%s\n", yytext);
		}
¨	{	printf(" SYMBOL-DIAERESIS ");
			fprintf(fp, " SYMBOL-DIAERESIS 	%s\n", yytext);
		}
©	{	printf(" SYMBOL-COPYRIGHT-SIGN ");
			fprintf(fp, " SYMBOL-COPYRIGHT-SIGN 	%s\n", yytext);
		}
ª	{	printf(" SYMBOL-FEMININE-ORDINAL-INDICATOR ");
			fprintf(fp, " SYMBOL-FEMININE-ORDINAL-INDICATOR 	%s\n", yytext);
		}
«	{	printf(" SYMBOL-LEFT-POINTING-DOUBLE-ANGLE-QUOTATION-MARK ");
			fprintf(fp, " SYMBOL-LEFT-POINTING-DOUBLE-ANGLE-QUOTATION-MARK 	%s\n", yytext);
		}
¬	{	printf(" SYMBOL-NOT-SIGN ");
			fprintf(fp, " SYMBOL-NOT-SIGN 	%s\n", yytext);
	/*	}
	{	printf(" SYMBOL-SOFT-HYPHEN ");
		fprintf(fp, " SYMBOL-SOFT-HYPHEN	%s\n", yytext);
	*/	}
®	{	printf(" SYMBOL-REGISTERED-SIGN ");
			fprintf(fp, " SYMBOL-REGISTERED-SIGN 	%s\n", yytext);
		}
¯	{	printf(" SYMBOL-MACRON ");
			fprintf(fp, " SYMBOL-MACRON 	%s\n", yytext);
		}
°	{	printf(" SYMBOL-DEGREE-SIGN ");
			fprintf(fp, " SYMBOL-DEGREE-SIGN 	%s\n", yytext);
		}
±	{	printf(" SYMBOL-PLUS-MINUS-SIGN ");
			fprintf(fp, " SYMBOL-PLUS-MINUS-SIGN 	%s\n", yytext);
		}
²	{	printf(" SYMBOL-SUPERSCRIPT-TWO ");
			fprintf(fp, " SYMBOL-SUPERSCRIPT-TWO 	%s\n", yytext);
		}
³	{	printf(" SYMBOL-SUPERSCRIPT-THREE ");
			fprintf(fp, " SYMBOL-SUPERSCRIPT-THREE 	%s\n", yytext);
		}
´	{	printf(" SYMBOL-ACUTE-ACCENT ");
			fprintf(fp, " SYMBOL-ACUTE-ACCENT 	%s\n", yytext);
		}
µ	{	printf(" SYMBOL-MICRO-SIGN ");
			fprintf(fp, " SYMBOL-MICRO-SIGN 	%s\n", yytext);
		}
¶	{	printf(" SYMBOL-PILCROW-SIGN ");
			fprintf(fp, " SYMBOL-PILCROW-SIGN 	%s\n", yytext);
		}
·	{	printf(" SYMBOL-MIDDLE-DOT ");
			fprintf(fp, " SYMBOL-MIDDLE-DOT 	%s\n", yytext);
		}
¸	{	printf(" SYMBOL-CEDILLA ");
			fprintf(fp, " SYMBOL-CEDILLA 	%s\n", yytext);
		}
¹	{	printf(" SYMBOL-SUPERSCRIPT-ONE ");
			fprintf(fp, " SYMBOL-SUPERSCRIPT-ONE 	%s\n", yytext);
		}
º	{	printf(" SYMBOL-MASCULINE-ORDINAL-INDICATOR ");
			fprintf(fp, " SYMBOL-MASCULINE-ORDINAL-INDICATOR 	%s\n", yytext);
		}
»	{	printf(" SYMBOL-RIGHT-POINTING-DOUBLE-ANGLE-QUOTATION-MARK ");
			fprintf(fp, " SYMBOL-RIGHT-POINTING-DOUBLE-ANGLE-QUOTATION-MARK 	%s\n", yytext);
		}
¼	{	printf(" SYMBOL-VULGAR-FRACTION-ONE-QUARTER ");
			fprintf(fp, " SYMBOL-VULGAR-FRACTION-ONE-QUARTER 	%s\n", yytext);
		}
½	{	printf(" SYMBOL-VULGAR-FRACTION-ONE-HALF ");
			fprintf(fp, " SYMBOL-VULGAR-FRACTION-ONE-HALF 	%s\n", yytext);
		}
¾	{	printf(" SYMBOL-VULGAR-FRACTION-THREE-QUARTERS ");
			fprintf(fp, " SYMBOL-VULGAR-FRACTION-THREE-QUARTERS	 %s\n", yytext);
		}
¿	{	printf(" SYMBOL-INVERTED-QUESTION-MARK ");
			fprintf(fp, " SYMBOL-INVERTED-QUESTION-MARK 	%s\n", yytext);
		}
÷	{	printf(" SYMBOL-DIVISION-SIGN ");
			fprintf(fp, " SYMBOL-DIVISION-SIGN 	%s\n", yytext);
		}
×	{	printf(" SYMBOL-MULTIPLICATION-SIGN ");
			fprintf(fp, " SYMBOL-MULTIPLICATION-SIGN 	%s\n", yytext);
		}
―	{	printf(" SYMBOL-HORIZONTAL-BAR ");
			fprintf(fp, " SYMBOL-HORIZONTAL-BAR 	%s\n", yytext);
		}
\+	{	printf(" SYMBOL-PLUS ");
			fprintf(fp, " SYMBOL-PLUS 	%s\n", yytext);	
		}
#	{	printf(" SYMBOL-SHARP ");
			fprintf(fp, " SYMBOL-SHARP 	%s\n", yytext);	 
		}
\$	{	printf(" SYMBOL-DOLLAR ");
			fprintf(fp, " SYMBOL-DOLLAR 	%s\n", yytext);	
		}
\=	{	printf(" SYMBOL-EQUAL-TO ");
			fprintf(fp, " SYMBOL-EQUAL-TO 	%s\n", yytext);	
		}
%	{	printf(" SYMBOL-PERCENT ");
			fprintf(fp, " SYMBOL-PERCENT 	%s\n", yytext);	
		}
—	{	printf(" SYMBOL-EMDASH ");
			fprintf(fp, " SYMBOL-EMDASH 	%s\n", yytext);	
		}
β[^-]	{	printf(" SYMBOL-BETA ");
			fprintf(fp, " SYMBOL-BETA 	%s\n", yytext);	
		}
\~	{	printf(" SYMBOL-TELDA ");
			fprintf(fp, " SYMBOL-TELDA	%s\n", yytext);	
		}		
α	{	printf(" SYMBOL-ALPHA ");
			fprintf(fp, " SYMBOL-ALPHA 	%s\n", yytext);	
		}
δ	{	printf(" SYMBOL-DELTA ");
			fprintf(fp, " SYMBOL-DELTA 	%s\n", yytext);
		}
γ	{	printf(" SYMBOL-GAMMA ");
			fprintf(fp, " SYMBOL-GAMMA 	%s\n", yytext);
		}
ε	{	printf(" SYMBOL-EPSILION ");
			fprintf(fp, " SYMBOL-EPSILION 	%s\n", yytext);
		}
ζ	{	printf(" SYMBOL-ZETA ");
			fprintf(fp, " SYMBOL-ZETA 	%s\n", yytext);
		}
η	{	printf(" SYMBOL-ETA ");
			fprintf(fp, " SYMBOL-ETA 	%s\n", yytext);
		}
θ	{	printf(" SYMBOL-THETA ");
			fprintf(fp, " SYMBOL-THETA 	%s\n", yytext);
		}
ι	{	printf(" SYMBOL-IOTA ");
			fprintf(fp, " SYMBOL-IOTA 	%s\n", yytext);
		}
κ	{	printf(" SYMBOL-KAPPA ");
			fprintf(fp, " SYMBOL-KAPPA 	%s\n", yytext);
		}
λ	{	printf(" SYMBOL-LAMBDA ");
			fprintf(fp, " SYMBOL-LAMBDA 	%s\n", yytext);
		}
μ	{	printf(" SYMBOL-MU ");
			fprintf(fp, " SYMBOL-MU 	%s\n", yytext);
		}
ν	{	printf(" SYMBOL-NU ");
			fprintf(fp, " SYMBOL-NU 	%s\n", yytext);
		}
ξ	{	printf(" SYMBOL-XI ");
			fprintf(fp, " SYMBOL-XI 	%s\n", yytext);
		}
ο	{	printf(" SYMBOL-OMICRON ");
			fprintf(fp, " SYMBOL-OMICRON 	%s\n", yytext);
		}
π	{	printf(" SYMBOL-PI ");
			fprintf(fp, " SYMBOL-PI 	%s\n", yytext);
		}
ρ	{	printf(" SYMBOL-RHO ");
			fprintf(fp, " SYMBOL-RHO 	%s\n", yytext);
		}
σ	{	printf(" SYMBOL-SIGMA ");
			fprintf(fp, " SYMBOL-SIGMA 	%s\n", yytext);
		}
τ	{	printf(" SYMBOL-TAU ");
			fprintf(fp, " SYMBOL-TAU 	%s\n", yytext);
		}
υ	{	printf(" SYMBOL-UPSILON ");
			fprintf(fp, " SYMBOL-UPSILON 	%s\n", yytext);
		}
φ	{	printf(" SYMBOL-PHI ");
			fprintf(fp, " SYMBOL-PHI 	%s\n", yytext);
		}
χ	{	printf(" SYMBOL-CHI ");
			fprintf(fp, " SYMBOL-CHI 	%s\n", yytext);
		}
ψ	{	printf(" SYMBOL-PSI ");
			fprintf(fp, " SYMBOL-PSI 	%s\n", yytext);
		}
ω	{	printf(" SYMBOL-OMEGA ");
			fprintf(fp, " SYMBOL-OMEGA 	%s\n", yytext);
		}
[ ][a-zA-Z0-9]*[/][a-zA-Z0-9]* { 	len=strcspn(yytext, "/");
				strncpy(str, yytext, len); str[len]='\0';

				s1=strchr(yytext, '/')+1;
                                printf(" %s SYMBOL-SLASH %s", str, s1); /*Ex: km/hr  */
				fprintf(fp, " SYMBOL-SLASH 	\\/\n"); 
			}
[ ]*[0-9]+[.][0-9]+	{	len=strcspn(yytext, ".");
				strncpy(str, yytext, len); str[len]='\0';
	
				s1=strchr(yytext, '.')+1;
				printf("%sSYMBOL-DOT%s", str, s1);
				fprintf(fp, "SYMBOL-DOT	.\n");
			}	
%%

main(int argc, char*argv[])
{
  fp=fopen(argv[1], "a");
  yylex();
}