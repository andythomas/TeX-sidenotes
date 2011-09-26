#include <stdio.h>
#include "ebook_parser.tab.h"
#include "ebook_lexer.h"

int ebook_yyparse(ebook_lexer  *qlex);

int main(int argc, char** argv) 
{
	ebook_lexer qlex;
    
    QUEX_NAME(construct_file_name)(&qlex, argc == 1 ? "example.txt" : argv[1], 0x0, false);

    printf("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
    printf("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">\n");
    printf("<html xmlns=\"http://www.w3.org/1999/xhtml\">\n");
    printf("<head>\n");
    printf("<title>ebook-test</title>\n");
    printf("<link href=\"caesar.css\" rel=\"stylesheet\" type=\"text/css\" />");
    printf("</head>\n");
    printf("<body>\n");

	int ret = ebook_yyparse(&qlex);
	if (ret!=0)
	{
		printf("Some error in yyparse\n");
		return ret;
	}
    printf("</p>");
    printf("</body>");
    printf("</html>");
    QUEX_NAME(destruct)(&qlex);
	return 0;
}
