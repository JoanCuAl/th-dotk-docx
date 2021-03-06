DITA to Word plug-in
====================

A DITA-OT plug-in to generate [Office Open XML (OOXML)](https://en.wikipedia.org/wiki/Office_Open_XML) output from DITA source.

Installation
------------

Standard DITA-OT plug-in installation, see [DITA-OT documentation](http://www.dita-ot.org/2.5/dev_ref/plugins-installing.html).
Only latests stable version of DITA-OT is supported, but older version may work.

```shell
$ dita --install com.elovirta.ooxml
```

For older versions of DITA-OT that do not support plug-in registry:

```shell
$ dita -install https://github.com/jelovirt/com.elovirta.ooxml/archive/1.4.0.zip
```

Running
-------

Use the `docx` transtype to create DOCX output.

```shell
$ dita -i guide.ditamap -f docx
```

See [documentation](https://github.com/jelovirt/com.elovirta.ooxml/wiki) for more information.

Donating
--------

Support this project and others by [@jelovirt](https://github.com/jelovirt) via [Paypal](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=jarno%40elovirta%2ecom&lc=FI&item_name=Support%20Open%20Source%20work&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted).

License
-------

The DITA to Word plug-in is released under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)

Post Generation Customization
-------

The first time you open the 2020 definitions word document, you need to follow this steps:
	- Select yes on the first dialog where it asks you to recover the document.
	- Select no on the second dialog where it asks if you want to update the fields on the document.
	- Go to References -> Update Table. Select Update entire table on the dialog and accept.
