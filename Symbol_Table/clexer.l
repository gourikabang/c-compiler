D			[0-9]
L			[a-zA-Z_]

%{

#include "y.tab.h"
#include "definition.h"
extern YYSTYPE yylval;
int LINE=1;
%}

%%
"char"		{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=CHAR;return(CHAR); }
"else"		{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=ELSE;return(ELSE); }
"float"		{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=FLOAT;return(FLOAT); }
"for"		{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=FOR;return(FOR); }
"if"		{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=IF;return(IF); }
"int"		{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=INT;return(INT); }
"return"	{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=RETURN;return(RETURN); }
"void"		{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=VOID;return(VOID); }
"while"		{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=WHILE;return(WHILE); }
{L}({L}|{D})*	{ yylval.Sval.text=strdup(yytext); yylval.Sval.type=IDENTIFIER;return(IDENTIFIER); }

{D}*"."{D}+	{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=FLOAT;return(CONSTANT); }

{D}+		{ yylval.Sval.text=strdup(yytext); yylval.Sval.type=INT;return(CONSTANT); }
'(\\[t0n'"\\]|[^\\'])'	{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=CHAR;return(CONSTANT); }

\"(\\.|[^\\"])*\"	{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=STRING_LITERAL;return(STRING_LITERAL); }

"++"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=INC_OP;return(INC_OP); }
"--"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=DEC_OP;return(DEC_OP); }
"&&"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=AND_OP;return(AND_OP); }
"||"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=OR_OP;return(OR_OP); }
"<="			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=LE_OP;return(LE_OP); }
">="			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=GE_OP;return(GE_OP); }
"=="			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=EQ_OP;return(EQ_OP); }
"!="			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=NE_OP;return(NE_OP); }
";"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return(';'); }
("{")			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1; return('{'); }
("}")			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('}'); }
","			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return(','); }
"="			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('='); }
"("			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('('); }
")"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return(')'); }
("[")			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('['); }
("]")			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return(']'); }
"!"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('!'); }
"-"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('-'); }
"+"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('+'); }
"*"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('*'); }
"/"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('/'); }
"<"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('<'); }
">"			{  yylval.Sval.text=strdup(yytext); yylval.Sval.type=-1;return('>'); }

[ \t\v\n\f]		{  }
.			{ /* ignore bad characters */ }

%%

yywrap()
{
	return(1);
}

