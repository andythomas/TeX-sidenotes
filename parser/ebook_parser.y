%defines
%debug
%pure-parser
%error-verbose
%lex-param {ebook_lexer  *qlex}
%parse-param {ebook_lexer  *qlex}
%name-prefix="ebook_yy"

%{
#include "ebook_lexer.h"
#include <stdio.h>
#include <math.h>
#include <errno.h>
%}

%union
{
	const char* str;
};

%{
int figure_counter=1;
char figure_labels[200][20];
int  ebook_yylex(YYSTYPE *yylval, ebook_lexer *qlex);
void ebook_yyerror(ebook_lexer *qlex, const char* m);
int ebook_ref(const char* label);
void ebook_textgraphics(const char* filename, const char* caption, const char *label,  const char* width);
void ebook_sidegraphics(const char* filename, const char* caption, const char* label);
%}

%type<str> doc arg group textgraphics emph quotetext sidecite textsc

%token<str> TKN_TEXT TKN_COMMAND
%token TKN_MY_FAILURE_ID TKN_CHAPTER TKN_SECTION TKN_TEXTGRAPHICS TKN_SIDETABLE TKN_PARAGRAPH TKN_INCLUDEGRAPHICS TKN_SIDEGRAPHICS
%token TKN_EMPH TKN_QUOTETEXT TKN_SIDECITE TKN_REF TKN_TEXTSC
%%

%start input;

input:    /* empty */
        | input doc
;

doc:      TKN_COMMAND           {printf("zz.");}
        | chapter               {}
        | section               {}
        | textgraphics          {}
        | sidegraphics          {}
        | sidetable             {}
        | includegraphics       {}
        | emph                  {printf("%s", $1);}
        | quotetext             {printf("%s", $1);}
        | textsc                {printf("%s", $1);}
        | sidecite              {printf(" [%s]", $1);}
        | ref                   {}
        | TKN_TEXT              {printf("%s", $1);}
        | TKN_PARAGRAPH         {printf("</p>\n<p class=\"body\">");}
        | '{'                   {printf("{");}
        | '}'                   {printf("}");}
        | '['                   {printf("[");}
        | ']'                   {printf("]");}
        | '\n'                  {printf("\n");}
;

textsc:     TKN_TEXTSC '{' TKN_TEXT '}'     {sprintf($$, "<span class=\"small-caps\">%s</span>", $3);}
;

ref:        TKN_REF '{' TKN_TEXT '}'        {printf("<a href=\"#%s\">%i</a>", $3, ebook_ref($3));}
;

sidecite:       TKN_SIDECITE '{' TKN_TEXT '}'       {$$ = $3}
            |   TKN_SIDECITE '[' arg ']' '{' TKN_TEXT '}'  {sprintf($$, "%s %s", $3, $6);}
;

emph:       TKN_EMPH '{' TKN_TEXT '}'       {sprintf($$, "<em>%s</em>", $3);}
;

quotetext:      TKN_QUOTETEXT '{' arg '}'      {sprintf($$, "<q>%s</q>", $3);}
;

sidegraphics:     TKN_SIDEGRAPHICS '{' TKN_TEXT '}' '{' arg '}' '{' '}' '{' '}'     {ebook_sidegraphics($3, $6, $3);}
                | TKN_SIDEGRAPHICS '{' TKN_TEXT '}' '{' arg '}' '{' TKN_TEXT '}' '{' '}'     {ebook_sidegraphics($3, $6, $9);}
                | TKN_SIDEGRAPHICS '{' TKN_TEXT '}' '{' arg '}' '{' TKN_TEXT '}' '{' TKN_TEXT '}'     {ebook_sidegraphics($3, $6, $9);}
;

// EINE DER GRÖSSEREN BAUSTELLEN, MACRO IN TEX HINZUFÜGEN
sidetable:     TKN_SIDETABLE '{' TKN_TEXT '}' '{' arg '}' '{' '}' '{' '}'     //{ebook_sidegraphics($3, $6, $3);}
;

includegraphics:      TKN_INCLUDEGRAPHICS '{' TKN_TEXT '}'      {printf("<img src=\"images/%s.pdf\" style=\"vertical-align:text-center\" alt=\"%s\" />",$3,$3);}
;

textgraphics:     TKN_TEXTGRAPHICS '{' TKN_TEXT '}' '{' TKN_TEXT '}' '{' TKN_TEXT '}' '{' TKN_TEXT '}'    {ebook_textgraphics($3, $6, $9, $12)}
                | TKN_TEXTGRAPHICS '{' TKN_TEXT '}' '{' TKN_TEXT '}' '{' '}' '{' TKN_TEXT '}'    {ebook_textgraphics($3, $6, "", $11);}
;

chapter:    TKN_CHAPTER '{' arg '}'     {printf("<h1 class=\"header\">%s</h1><p class=\"body\">",$3);}
;

section:    TKN_SECTION '{' arg '}'     {printf("</p><h2 class=\"header\">%s</h2><p class=\"body\">",$3);}
;

arg:          TKN_TEXT          {$$ = $1}
            | TKN_COMMAND       {strcpy($$,"");}
            | textsc            {$$ = $1}
            | emph              {$$ = $1}
            | config            {strcpy($$,"");}
            | group             {$$ = $1}
            | arg arg           {$$ = strcat($1, $2);}
;

group:        '{' arg '}'       {$$ = $2}
;

config:       '[' arg ']'       {}
;

%%

int ebook_ref(const char* label)
{
    int i;
    for (i=1; i<figure_counter; i++)
    {
        if (strcmp(figure_labels[i], label)==0)
            return i;
    }
    return 0;
}

// HIER MUSS DIE GRÖSSENANGABE DER BILDER NOCH RICHTIG REIN.
    // AM BESTEN ALLES ÜBER CLASSES
void ebook_sidegraphics(const char* filename, const char* caption, const char* label)
{
    printf("</p>");
    printf("<div class=\"keep\" style=\"\" >");
    printf("<table class=\"sidefigure\"><tr><th>");
    printf("<img class=\"sidefigure\" src=\"images/%s.pdf\" id=\"%s\" alt=\"%s\" />", filename, label, filename);
    printf("</th><th>");
    printf("<p class=\"caption\">Abbildung %i: %s</p>", figure_counter, caption);
    printf("</th></tr></table>");
    printf("</div>");
    printf("<p class=\"body\">");

    strcpy(figure_labels[figure_counter], label);
    figure_counter++;
}

void ebook_textgraphics(const char* filename, const char* caption, const char *label, const char* width)
{
    printf("</p><div class=\"keep\" style=\" \" >");
    printf("<img style=\"width:100px\" src=\"images/%s\" id=\"%s\" alt=\"%s\" />", filename, label, filename);
    printf("<p class=\"caption\">Abbildung %i: %s</p>", figure_counter, caption);
    printf("</div><p class=\"body\">");
    strcpy(figure_labels[figure_counter], label);
    figure_counter++;
}

void ebook_yyerror(ebook_lexer *qlex, const char*  m)
{
	printf("Parsing error at %i:%i: %s", 
           (int)qlex->counter._line_number_at_begin, (int)qlex->counter._column_number_at_begin, m);
           
}

int ebook_yylex(YYSTYPE *yylval, ebook_lexer *qlex)
{
	QUEX_TYPE_TOKEN* token;

	QUEX_NAME(receive)(qlex, &token);

	if (strlen((char*)token->text) > 0 )
	{

		yylval->str = (char*)malloc((size_t)(strlen((char*)token->text)+1));
        memcpy((void*)yylval->str, (void*)token->text, (size_t)(strlen((char*)token->text) + 1));
	}
	return (int)token->_id;
}
