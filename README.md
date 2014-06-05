Backpack Export XSLT
====================

Stylesheet for converting your 37signals/Basecamp [Backpack](http://backpackit.com/) export XML into a URL list for downloading assets and images. This is essential for getting a "full" backup of your account without having to go through and click+download every image, attachment, asset, etc. manually. As Backpack is "[retired](https://basecamp.com/backpack-retired)", you may want to do this on a regular basis if you plan to continue using Backpack. Alternately, you may just want to get your data out and retire your account.

USAGE
-----

    saxon -xsl:export2urls.xsl -s:export.xml -o:urls.txt

Now you can download the URLs with a simple bash script, e.g.:

    while read url; do
      wget -x --load-cookies=cookies.txt "$url"
    done < urls.txt

Where cookies.txt is a cookies file you've exported from your browser after logging into Backpack.

If you only have images you can be polite and use something like this for the download command instead:

    wget -x --header='Content-Type: application/xml' --post-data='<request><token>backpackAPItokengoeshere</token></request>' "$url"

But Backpack is already quite rude in not respecting this for non-image assets and only accepting cookie auth, so who cares.

TODO
----

A separate stylesheet/script that takes the export XML and renders nice local static HTML output that includes/links the downloaded images/asssets.