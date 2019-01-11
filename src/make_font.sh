#!/usr/bin/env bash
#
# copyright (c) 2013 by Roderick W. Smith
#
# This program is licensed under the terms of the GNU GPL, version 3,
# or (at your option) any later version.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

# Program to generate a PNG file suitable for use as a rEFInd font
# To obtain a list of available font names, type:
#
# convert -list font | less
#
# The font used MUST be a monospaced font; searching for the string
# "Mono" will turn up most suitable candidates.
#
# Usage:
# ./make_font.sh font-name font-size bitmap-filename.png
#
# This script is part of the rEFInd package. Version numbers refer to
# the rEFInd version with which the script was released.
#
# Version history:
#
#  0.6.6  -  Initial release

# Edited by Patrick Collins:
# Removed y-offset option; automatically vertically centering the text instead.
# Minor formatting and simplification..

if [[ $# != 3 ]] ; then
    echo "Usage: $0 font-name font-size bitmap-filename.png"
    echo "    font-name: Name of font (use 'convert -list font | less' to get list)"
    echo "               NOTE: Font MUST be monospaced!"
    echo "    font-size: Font size in points"
    echo "    bitmap-filename.png: output filename"
    echo ""
    exit 1
fi

Convert=`which convert 2> /dev/null`
if [[ ! -x $Convert ]] ; then
    echo "The 'convert' program is required but could not be found. It's part of the"
    echo "ImagMagick program, usually installed in the 'imagemagick' package."
    echo ""
    exit 1
fi


FontName=$1
Height=$(((3*$2)/2))
OutputFilename=$3
let CellWidth=(${Height}*6+5)/10
let Width=${CellWidth}*96
echo "Creating ${Width}x${Height} font bitmap...."
set -f
set +H

FontChars=( '!' '\"' '#' '\$' '%' '&' "\'" '(' ')' '*' '+' ',' '-' '.' '/' '0' '1' '2' '3' '4' '5' '6' '7' '8' '9' ':' ';' '<' '=' '>' '?' '@' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' '[' '\\\\' ']' '^' '_' '\`' 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' '{' '|' '}' '~' '?' )

DrawCommands=""
Offset=$CellWidth
for char in ${FontChars[@]} ; do
    DrawCommands="${DrawCommands} -draw \"text $Offset,0 '$char'\""
    Offset=$(($CellWidth+$Offset))
done

#Works when pasted into console; but not in this script. No time to troubleshoot. Using worse but working implementation below.
#$Convert -size ${Width}x${Height} xc:transparent -gravity SouthWest -font '${FontName}' -pointsize ${Height} ${DrawCommands} '${OutputFilename}'
OffsetY=$(($Height/-10))

$Convert -size ${Width}x${Height} xc:transparent -gravity West -font ${FontName} -pointsize ${Height} -draw "text $((1*$CellWidth)),$OffsetY '!'" -draw "text $((2*$CellWidth)),$OffsetY '\"'" -draw "text $((3*$CellWidth)),$OffsetY '#'" -draw "text $((4*$CellWidth)),$OffsetY '\$'" -draw "text $((5*$CellWidth)),$OffsetY '%'" -draw "text $((6*$CellWidth)),$OffsetY '&'" -draw "text $((7*$CellWidth)),$OffsetY '\''" -draw "text $((8*$CellWidth)),$OffsetY '('" -draw "text $((9*$CellWidth)),$OffsetY ')'" -draw "text $((10*$CellWidth)),$OffsetY '*'" -draw "text $((11*$CellWidth)),$OffsetY '+'" -draw "text $((12*$CellWidth)),$OffsetY ','" -draw "text $((13*$CellWidth)),$OffsetY '-'" -draw "text $((14*$CellWidth)),$OffsetY '.'" -draw "text $((15*$CellWidth)),$OffsetY '/'" -draw "text $((16*$CellWidth)),$OffsetY '0'" -draw "text $((17*$CellWidth)),$OffsetY '1'" -draw "text $((18*$CellWidth)),$OffsetY '2'" -draw "text $((19*$CellWidth)),$OffsetY '3'" -draw "text $((20*$CellWidth)),$OffsetY '4'" -draw "text $((21*$CellWidth)),$OffsetY '5'" -draw "text $((22*$CellWidth)),$OffsetY '6'" -draw "text $((23*$CellWidth)),$OffsetY '7'" -draw "text $((24*$CellWidth)),$OffsetY '8'" -draw "text $((25*$CellWidth)),$OffsetY '9'" -draw "text $((26*$CellWidth)),$OffsetY ':'" -draw "text $((27*$CellWidth)),$OffsetY ';'" -draw "text $((28*$CellWidth)),$OffsetY '<'" -draw "text $((29*$CellWidth)),$OffsetY '='" -draw "text $((30*$CellWidth)),$OffsetY '>'" -draw "text $((31*$CellWidth)),$OffsetY '?'" -draw "text $((32*$CellWidth)),$OffsetY '@'" -draw "text $((33*$CellWidth)),$OffsetY 'A'" -draw "text $((34*$CellWidth)),$OffsetY 'B'" -draw "text $((35*$CellWidth)),$OffsetY 'C'" -draw "text $((36*$CellWidth)),$OffsetY 'D'" -draw "text $((37*$CellWidth)),$OffsetY 'E'" -draw "text $((38*$CellWidth)),$OffsetY 'F'" -draw "text $((39*$CellWidth)),$OffsetY 'G'" -draw "text $((40*$CellWidth)),$OffsetY 'H'" -draw "text $((41*$CellWidth)),$OffsetY 'I'" -draw "text $((42*$CellWidth)),$OffsetY 'J'" -draw "text $((43*$CellWidth)),$OffsetY 'K'" -draw "text $((44*$CellWidth)),$OffsetY 'L'" -draw "text $((45*$CellWidth)),$OffsetY 'M'" -draw "text $((46*$CellWidth)),$OffsetY 'N'" -draw "text $((47*$CellWidth)),$OffsetY 'O'" -draw "text $((48*$CellWidth)),$OffsetY 'P'" -draw "text $((49*$CellWidth)),$OffsetY 'Q'" -draw "text $((50*$CellWidth)),$OffsetY 'R'" -draw "text $((51*$CellWidth)),$OffsetY 'S'" -draw "text $((52*$CellWidth)),$OffsetY 'T'" -draw "text $((53*$CellWidth)),$OffsetY 'U'" -draw "text $((54*$CellWidth)),$OffsetY 'V'" -draw "text $((55*$CellWidth)),$OffsetY 'W'" -draw "text $((56*$CellWidth)),$OffsetY 'X'" -draw "text $((57*$CellWidth)),$OffsetY 'Y'" -draw "text $((58*$CellWidth)),$OffsetY 'Z'" -draw "text $((59*$CellWidth)),$OffsetY '['" -draw "text $((60*$CellWidth)),$OffsetY '\\\\'" -draw "text $((61*$CellWidth)),$OffsetY ']'" -draw "text $((62*$CellWidth)),$OffsetY '^'" -draw "text $((63*$CellWidth)),$OffsetY '_'" -draw "text $((64*$CellWidth)),$OffsetY '\`'" -draw "text $((65*$CellWidth)),$OffsetY 'a'" -draw "text $((66*$CellWidth)),$OffsetY 'b'" -draw "text $((67*$CellWidth)),$OffsetY 'c'" -draw "text $((68*$CellWidth)),$OffsetY 'd'" -draw "text $((69*$CellWidth)),$OffsetY 'e'" -draw "text $((70*$CellWidth)),$OffsetY 'f'" -draw "text $((71*$CellWidth)),$OffsetY 'g'" -draw "text $((72*$CellWidth)),$OffsetY 'h'" -draw "text $((73*$CellWidth)),$OffsetY 'i'" -draw "text $((74*$CellWidth)),$OffsetY 'j'" -draw "text $((75*$CellWidth)),$OffsetY 'k'" -draw "text $((76*$CellWidth)),$OffsetY 'l'" -draw "text $((77*$CellWidth)),$OffsetY 'm'" -draw "text $((78*$CellWidth)),$OffsetY 'n'" -draw "text $((79*$CellWidth)),$OffsetY 'o'" -draw "text $((80*$CellWidth)),$OffsetY 'p'" -draw "text $((81*$CellWidth)),$OffsetY 'q'" -draw "text $((82*$CellWidth)),$OffsetY 'r'" -draw "text $((83*$CellWidth)),$OffsetY 's'" -draw "text $((84*$CellWidth)),$OffsetY 't'" -draw "text $((85*$CellWidth)),$OffsetY 'u'" -draw "text $((86*$CellWidth)),$OffsetY 'v'" -draw "text $((87*$CellWidth)),$OffsetY 'w'" -draw "text $((88*$CellWidth)),$OffsetY 'x'" -draw "text $((89*$CellWidth)),$OffsetY 'y'" -draw "text $((90*$CellWidth)),$OffsetY 'z'" -draw "text $((91*$CellWidth)),$OffsetY '{'" -draw "text $((92*$CellWidth)),$OffsetY '|'" -draw "text $((93*$CellWidth)),$OffsetY '}'" -draw "text $((94*$CellWidth)),$OffsetY '~'" -draw "text $((95*$CellWidth)),$OffsetY '?'" ${OutputFilename}

set +f
set -H
