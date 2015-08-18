# Plunker example mirror 

As plnkr.co can not be accessed SSL-encryped, it is not possible to embed plunker examples on and SSL-excryped page.
We solved this problem with a shell script that mirrors the whole example to a github page and replaces all the relevant urls.


## Configuration

The base path for your mirror MUST be configured before using the mirror script.
Simply copy the sample file `config.sample.sh `:

    cp config.sample.sh config.sh

Edit the BASE_PATH in `config.sh`:

    # PATH FOR URL REPLACEMENTS
    BASE_PATH="<my-github-page-base-path>/"

## Usage

To mirror a plunker example just run the script `mirror-plunker-preview.sh` with the plunker id as single parameter.

     ./mirror-plunker-preview.sh mNPRyvaBQxBrlElCs7UQ

The results looks like this.

* Original plunker URL: [http://embed.plnkr.co/mNPRyvaBQxBrlElCs7UQ/preview](http://embed.plnkr.co/mNPRyvaBQxBrlElCs7UQ/preview )
* New mirrored URL: [https://tilmanpotthof.github.io/plunker-preview-mirror/embed.plnkr.co/mNPRyvaBQxBrlElCs7UQ/preview.html#!//preview](https://tilmanpotthof.github.io/plunker-preview-mirror/embed.plnkr.co/mNPRyvaBQxBrlElCs7UQ/preview.html#!//preview)

## Limitations

Resources that are not referenced in the DOM are not mirrored by `wget` and must be added manually to the run folder.

    echo '{"users":[]}' > run.plnkr.co/plunks/<plunker-id>/users.json


## Small print

* Author: Tilman Potthof [@tilmanpotthof](https://twitter.com/tilmanpotthof) ([blog](http://blog.programmingisart.com/))
* License: MIT - do anything with the code, but don't blame me if it does not work.
* Support: if you find any problems with this module, email / tweet /
[open issue](https://github.com/tilmanpotthof/plunker-preview-mirror/issues) on Github


## MIT License

Copyright (c) 2015 Tilman Potthof

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
