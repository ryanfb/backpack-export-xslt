Backpack Export XSLT
====================

Stylesheets for converting your 37signals/Basecamp [Backpack export XML](https://help.basecamp.com/backpack/questions/255-can-i-export-my-data-out-of-backpack) into usable, complete, static local backups. This is essential for getting a "full" backup of your account without having to go through and click+download every image, attachment, asset, page, etc. manually. As Backpack is "[retired](https://basecamp.com/backpack-retired)", you may want to do this on a regular basis if you plan to continue using Backpack. Alternately, you may just want to get your data out and retire your account.

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

TODO
----

* Output messages/comments against list items & notes in the HTML
* Paginate HTML by original Backpack page with searchable bootstrap-select and fragment URLs
* Add XSL params for output of a single page by ID/title (for archiving and sharing)