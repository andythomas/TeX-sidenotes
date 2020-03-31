--[[
initial version 2020/03/31 Andy Thomas
lua code fragments to generate an ebook
--]]

-- store the file contents in strings
container_string = [[<?xml version="1.0"?>
<container version="1.0"
   xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
   <rootfiles>
      <rootfile full-path="OEBPS/content.opf"
         media-type="application/oebps-package+xml"/>
   </rootfiles>
</container>
]]


-- setting the head part, all entries are necessary
-- (totalPageCount & maxPageCount can be equal zero)
uid = [[550e8400-e29b-11d4-a716-446655440000]]
depth = "2"
totalPageCount = "0"
maxPageNumber = "0"
title = "Testtitle"

--fill information in file

toc_string = [[<?xml version="1.0"?>
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

-- create the subdirectory for all the contents
lfs.mkdir("ePub")
lfs.chdir("ePub")

-- create the required mimetype file
mimetype_fh = io.open("mimetype", "w")
mimetype_fh:write ("application/epub+zip")
mimetype_fh:close()

-- create the META-INF directory
lfs.mkdir("META_INF")
lfs.chdir("META_INF")
-- it needs only one file
container_fh = io.open("container.xml", "w")
container_fh:write (container_string)
container_fh:close()
lfs.chdir("..")

-- create the OEBPS directory
lfs.mkdir("OEBPS")
lfs.chdir("OEBPS")
toc_fh = io.open("toc.ncx","w")
toc_fh:write(toc_string)
toc_fh:close()
lfs.chdir("..")

-- go back
lfs.chdir("..")
