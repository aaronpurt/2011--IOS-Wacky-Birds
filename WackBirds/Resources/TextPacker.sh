#!/bin/sh

#  PackTextures.sh
#  Whack-em
#
#  Created by AARON on 4/27/11.
#  Copyright 2011 __MyCompanyName__. All rights reserved.
#!/bin/sh

TP="/usr/local/bin/TexturePacker"

if [ "${ACTION}" = "clean" ]
then
echo "cleaning..."


rm resources/duckLevel*
rm resources/penguinLevel*
rm resources/ravenLevel*
rm resources/vultureLevel*
rm resources/ostrichLevel*
rm resources/sprites*
rm resources/menu*
rm resources/negativeBirds*
rm resources/positiveBirds*
else
echo "building..."


#duck level
${TP} --smart-update \
--format cocos2d \
--data resources/duckLevel.plist \
--sheet resources/duckLevel.pvr.ccz \
--dither-fs-alpha \
--opt RGBA8888 \
imagesGame/backgrounds/duckLevel/*.png

#penguin level
${TP} --smart-update \
--format cocos2d \
--data resources/penguinLevel.plist \
--sheet resources/penguinLevel.pvr.ccz \
--dither-fs-alpha \
--opt RGBA8888 \
imagesGame/backgrounds/penguinLevel/*.png

#raven level
${TP} --smart-update \
--format cocos2d \
--data resources/ravenLevel.plist \
--sheet resources/ravenLevel.pvr.ccz \
--dither-fs-alpha \
--opt RGBA8888 \
imagesGame/backgrounds/ravenLevel/*.png

#vulture level

${TP} --smart-update \
--format cocos2d \
--data resources/vultureLevel.plist \
--sheet resources/vultureLevel.pvr.ccz \
--dither-fs-alpha \
--opt RGBA8888 \
imagesGame/backgrounds/vultureLevel/*.png

#ostrich level
${TP} --smart-update \
--format cocos2d \
--data resources/ostrichLevel.plist \
--sheet resources/ostrichLevel.pvr.ccz \
--dither-fs-alpha \
--opt RGBA8888 \
imagesGame/backgrounds/ostrichLevel/*.png


#---------------------

${TP} --smart-update \
--format cocos2d \
--data resources/negativeBirds.plist \
--sheet resources/negativeBirds.pvr.ccz \
--dither-fs-alpha \
--opt RGBA8888 \
imagesGame/sprites/negativeBirds/*.png


${TP} --smart-update \
--format cocos2d \
--data resources/negativeBirds-hd.plist \
--sheet resources/negativeBirds-hd.pvr.ccz \
--dither-fs-alpha \
--opt RGBA8888 \
imagesGame/sprites/negativeBirds/*.png

${TP} --smart-update \
--format cocos2d \
--data resources/positiveBirds.plist \
--sheet resources/positiveBirds.pvr.ccz \
--dither-fs-alpha \
--opt RGBA8888 \
imagesGame/sprites/positiveBirds/*.png


${TP} --smart-update \
--format cocos2d \
--data resources/menu.plist \
--sheet resources/menu.pvr.ccz \
--dither-fs-alpha \
--opt RGBA8888 \
imagesGame/menu/*.png



fi
exit 0