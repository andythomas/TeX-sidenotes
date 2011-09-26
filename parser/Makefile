# PURPOSE: Makefile Demo Application of Quex
#
# ABSOLUTELY NO WARRANTY
#_______________________________________________________________________________
.PHONY: clean GENERATE_LEXER GENERATE_PARSER

ifndef QUEX_PATH
    $(error The environment variable QUEX_PATH is not defined!)
endif

# (*) SETUP ____________________________________________________________________

# -- FILES PRODUCED BY QUEX
LEXER_NAME		= ebook_lexer# NOTE: a whitespace after this name creates chaos!
LEXER_SOURCES	= $(LEXER_NAME).c         

TOKEN_FILE     = ebook_token-ids
PARSER_NAME	   = ebook_parser
PARSER_SOURCES = $(PARSER_NAME).tab.c

# -- OUTPUT
APPLICATION    = lexer

# (*) COMPILER SETTINGS ________________________________________________________
#     (change COMPILER to whatever you use as compiler on the command line,
#      e.g. "make COMPILER=icpc" will use intel's c++ compiler)
COMPILER = gcc -ggdb -Wall

ifdef ASSERTS_ENABLED_F
	CCFLAG_ASSERTS=# By default asserts are enabled
else 
	CCFLAG_ASSERTS=-DQUEX_OPTION_ASSERTS_DISABLED
endif

CC = $(COMPILER) -c -I./ -I$(QUEX_PATH) $(CCFLAG_ASSERTS) \
       -Wall -Wconversion
       # -DQUEX_OPTION_ASSERTS_DISABLED
       # -DQUEX_OPTION_ASSERTS_WARNING_MESSAGE_DISABLED \

LD = $(COMPILER) 

# (*) RULES ____________________________________________________________________
# -- application
$(APPLICATION): main.o $(LEXER_NAME).o $(PARSER_NAME).tab.o
	$(LD) -o $(APPLICATION) main.o $(LEXER_NAME).o $(PARSER_NAME).tab.o -lm

%.o: %.c $(LEXER_SOURCES) $(PARSER_SOURCES)
	$(CC) $< -o $@ # -DQUEX_OPTION_DEBUG_SHOW

$(LEXER_SOURCES):  GENERATE_LEXER

$(PARSER_SOURCES): GENERATE_PARSER

GENERATE_LEXER: ebook_lexer.qx 
	quex -i $< --engine $(LEXER_NAME) --token-prefix TKN_ \
          --foreign-token-id-file ebook_token-ids.h                   \
		  --language C         

GENERATE_PARSER:  ebook_parser.y
	bison $<

# (*) HELPERS __________________________________________________________________
clean:	
	touch ebook_lexer.qx
	rm -f ebook_lexer.h
	rm -f ebook_lexer-configuration.h
	rm -f ebook_lexer-token.h
	rm -f ebook_lexer.c
	rm -f ebook_lexer-token_ids.h
	rm -f ebook_parser.tab.c
	rm -f ebook_parser.tab.h
	rm -f $(LEXER_NAME)-token
	rm -f *.o
	rm -f $(APPLICATION)
	rm -f *.bak
