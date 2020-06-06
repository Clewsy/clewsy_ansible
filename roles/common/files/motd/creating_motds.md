# Install viu to convert images.
https://github.com/atanunq/viu/releases

# Run command to convert a png (with transparency) into a bash-parsable text file:

```shell
$ viu -t b4t-cam.png -w 80 | sed 's/\x1b\[/\x5c\x30\x33\x33\[/g' > motd_b4t-cam
```
* -t to preserve png transparenct
* -w or -h to define output width or height
* sed 's/\x1b\[/\x5c\x30\x33\x33\[/g' to convert literal escape codes (hex 0x1B) to escape codes readable by bash scripts.

# Test output file:
```shell
$IFS='%' #Temporarily change internal field separator to allow output of consolidated whitespace.
$echo -e $(cat motd_b4t-cam)
```
