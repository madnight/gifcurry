![Gifcurry](logo.png)

# Gifcurry

## UI

![UI](ui.gif)

## Sample GIF

![Caminandes: Gran Dillama - Blender Foundation](sample.gif)  
Credit: [Caminandes: Gran Dillama - Blender Foundation](http://www.caminandes.com/)

## Description

Create animated GIFs, overlaid with optional text, from video files.

## CLI Usage

```bash
gifcurry ./in.mp4 ./out.gif start_second duration quality 'Optional top text.' 'Optional bottom text.'
```

## CLI Example

```Bash
~/gifcurry ❯❯❯ gifcurry ./02_gran_dillama_1080p.mp4 ./out.gif 32 8 500 100 'What is' 'Gifcurry?'
 _____ _  __                           
|  __ (_)/ _|                          
| |  \/_| |_ ___ _   _ _ __ _ __ _   _ 
| | __| |  _/ __| | | | '__| '__| | | |
| |_\ \ | || (__| |_| | |  | |  | |_| |
 \____/_|_| \___|\__,_|_|  |_|   \__, |
                                  __/ |
                                 |___/ 

Gifcurry (C) 2016 David Lettier. http://www.lettier.com/

Input file: ./02_gran_dillama_1080p.mp4
Start second: 32
Duration: 8 seconds
GIF width: 500px
Quality: 100.0%
Top text: What is
Bottom text: Gifcurry?

Writing temporary frames to... ./frames3617
Writing your GIF to... ./out.gif
Done.
```

## Dependencies

* [Haskell](https://www.haskell.org/platform/)
  * [System.IO.Temp (temporary)](https://hackage.haskell.org/package/temporary)
  * [Graphics.UI.Gtk (gtk)](https://hackage.haskell.org/package/gtk3)
  * [System.Directory (directory)](https://hackage.haskell.org/package/directory)
  * [gtk2hs-buildtools](https://hackage.haskell.org/package/gtk2hs-buildtools)
* [FFmpeg](https://www.ffmpeg.org/download.html)
* [ImageMagick](http://www.imagemagick.org/script/download.php)
* [GTK+](http://www.gtk.org/download/index.php)

## Install & Run

### Ubuntu/Mint

```
# Install FFmpeg
sudo add-apt-repository ppa:kirillshkrogalev/ffmpeg-next
sudo apt-get update
sudo apt-get install ffmpeg imagemagick
# Find the latest release at https://github.com/lettier/gifcurry/releases
wget gifcurry*.tar.gz
tar xvfz gifcurry*.tar.gz
cd gifcurry*/bin
./gifcurry_gui
./gifcurry_cli
```

### Arch Linux

```
# Install FFmpeg and ImageMagick
# Install yaourt (https://archlinux.fr/yaourt-en)
# AUR package: https://aur.archlinux.org/packages/gifcurry/
yaourt -S gifcurry
gifcurry_gui
gifcurry_cli
```

### Hackage

```
# Install ghc and cabal-install
cabal update
cabal configure
cabal install gtk2hs-buildtools -j
cabal install gifcurry -j
cd ~/.cabal/bin
./gifcurry_gui
./gifcurry_cli
```

### Github

```
# Install ghc and cabal-install
git clone git@github.com:lettier/gifcurry.git
cd gifcurry/
cabal sandbox init
cabal update
cabal configure
cabal install gtk2hs-buildtools -j
cabal install -j
./.cabal-sandbox/bin/gifcurry_gui
./.cabal-sandbox/bin/gifcurry_cli
```

## License

For license information, see [LICENSE](LICENSE).

_(C) 2016 David Lettier._  
http://www.lettier.com/
