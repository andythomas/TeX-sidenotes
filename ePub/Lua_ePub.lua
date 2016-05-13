-- Lua script for creating neessary directorys and files for ePub

--use pandoc to convert tex file into xhtml
os.execute("pandoc -o output.xhtml Lua_ePub.tex")


-- put current working directory as string in workingdir
tex_dir = lfs.currentdir()

-- creating file mimetype
datei = io.open("mimetype","w")
datei:write("application/ebub+zip")
datei:close()


--creating "META-INF" directory
metadir = [[META-INF]]
lfs.mkdir (metadir)


--creating "container.xml" in the META-INF directory
lfs.chdir(metadir)
datei = io.open("container.xml","w")
container = [[<?xml version="1.0"?>
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
<rootfiles>
<rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml"/>
</rootfiles>
</container>]]
datei:write(container)
datei:close()
lfs.chdir(tex_dir)

--creating "OEBPS" directory
lfs.mkdir ("OEBPS")



--creating toc.ncx

--setting the head part, all entries are necessary (totalPageCount & maxPageCount can be equal zero)
uid = [[550e8400-e29b-11d4-a716-446655440000]]
depth = "2"
totalPageCount = "0"
maxPageNumber = "0"

--setting the title
file = io.open("title.dat","r")
title = file:read()
file:close()
--navMap

--fill information in file
lfs.chdir("OEBPS")
datei = io.open("toc.ncx","w")
container = [[<?xml version="1.0"?>
<!DOCTYPE ncx PUBLIC "-//NISO//DTD ncx 2005-1//EN" "http://www.daisy.org/z3986/2005/ncx-2005-1.dtd">
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1"><head><meta name="dtb:uid" content="]]..uid..[["/>
<meta name="dtb:depth" content="]]..depth..[["/>
<meta name="dtb:totalPageCount" content="]]..totalPageCount..[["/>
<meta name="dtb:maxPageNumber" content="]]..maxPageNumber..[["/>
</head>
<docTitle>
<text>]]..title..[[</text>
</docTitle>
<navMap>
<navPoint id="navpoint" playOrder="1">
<navLabel><text>]]..title..[[</text></navLabel><content src="Walden_c0.xhtml#toc-anchor"/>
</navPoint>

</navMap>
</ncx>]]
datei:write(container)
datei:close()
lfs.chdir(tex_dir)


