## rapidograph

ooc static web framework

### Structure

A rapidograph app is made up of four parts, each having a very important role.
Those parts are: a Source, a Ruler, at least one Ink and a Paper. (Please open an issue if you find more clever names :P)

A source is what triggers the website generation. The source can be a directory/file an HTTP request/server or anything else you can imagine.
The job of the source is to parse the data it is meant to interpret into variables and find out what template should be used for HTML generation.

An ink, given a number of variables, generates a file (HTML,JS,CSS,...) out of a specific template type.
For example, a Mustache ink, given an array of variables and a Mustache template file could generate your HTML pages

Papers are used to finally publish your website. Example papers are a local directory paper, an HTML server paper, an FTP paper,...

Finally, a ruler is what links all the parts of your app together. It takes orders from the source, and using links you provide, passes variables
to inks and the generated files to a paper to finally publish your website.

### Authors

  * Alexandros Naskos

