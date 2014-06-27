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
Copyright (c) 2014 Ryan Baumann

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.