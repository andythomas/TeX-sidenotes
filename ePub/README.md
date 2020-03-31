# Caesar epub

This is work-in-progress trying an automatic generation of an e-book (epub file) using LuaLaTeX. In the end, the same source code should be able to generate either the e-book or a pdf-document.

## Style elements of the source file

Required elements:

* title
* author
* publisher

## The epub directory structure

We use the following directory structure:

    ePub
    |-- mimetype
    |-- META-INF
       |-- container.xml
    |-- OEBPS
       |-- content.opf

    