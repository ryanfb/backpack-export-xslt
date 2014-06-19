Backpack Export XSLT
====================

This repository contains stylesheets for converting your 37signals/Basecamp [Backpack export XML](https://help.basecamp.com/backpack/questions/255-can-i-export-my-data-out-of-backpack) into usable, complete, static local backups. This is essential for getting a "full" backup of your account without having to go through and click+download every image, attachment, asset, page, etc. manually. As Backpack is "[retired](https://basecamp.com/backpack-retired)", you may want to do this on a regular basis if you plan to continue using Backpack. Alternately, you may just want to get your data out and retire your account.

USAGE
-----

There are two stylesheets included:

* `export2urls.xsl`: for turning your export XML into a list of image, thumbnail, and asset URLs to be downloaded
* `export2html.xsl`: for turning your export XML into static local HTML (references downloaded images/assets)

First, you'll want to generate the list of URLs of data not included in the export XML that you need to download:

    saxon -xsl:export2urls.xsl -s:export.xml -o:urls.txt

Now you can download the URLs with a simple bash script, e.g.:

    while read url; do
      wget -x --load-cookies=cookies.txt "$url"
    done < urls.txt

Where cookies.txt is a cookies file you've exported from your browser after logging into Backpack.

Now that you have all your images and attachments downloaded, generate a static HTML page from your export:

    saxon -xsl:export2html.xsl -s:export.xml -o:index.html

This will generate an index.html and an HTML file for each page.

TODO
----

* Output messages/comments against list items & notes in the HTML

LICENSE
-------
Copyright (c) 2014, Ryan Baumann
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer. 
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.