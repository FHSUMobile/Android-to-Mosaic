#!/bin/bash

echo "Where is your project located?"
read project_location

project_name=${project_location##*/} 


cd ~/

if [ ! -d "MosaicAndroid" ]; then
	curl -L -o AndroidMosaicSDK.zip https://www.dropbox.com/s/azm2i5xw8it153s/AndroidMosaicSDK.zip?dl=1
	mkdir MosaicAndroid
	cd MosaicAndroid 
	unzip ~/AndroidMosaicSDK
	rm ~/AndroidMosaicSDK.zip
	mv "AndroidMosaicSDK 2" "AndroidMosaicSDK"
fi



cp -r $project_location ~/MosaicAndroid/AndroidMosaicSDK/modules/


cp ~/MosaicAndroid/AndroidMosaicSDK/Samples/build.xml ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/build.xml

# steps 6&7 of prep go here

# step 9 check skipped

cp ~/MosaicAndroid/AndroidMosaicSDK/mosaicsdk-*.jar ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/libs/


#this next section of the script I found on the Web!
prefix=$project_name"_"
for file in ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/res/*/*; do
    dir=$(dirname "$file")
    base=$(basename "$file")
    dest="$dir"/"$prefix""$base"
    mv "$file" "$dest"  # remove "echo" after testing
done

LANG=C sed -i '' s/"id\/"/"id\/"$project_name"_"/g ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/res/*/*

LANG=C sed -i '' s/"name=\""/"name=\""$project_name"_"/g ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/res/*/*


LANG=C sed -i '' s/"@string\/"/"@string\/"$project_name"_"/g ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/AndroidManifest.xml

LANG=C sed -i '' s/"@style\/"/"@style\/"$project_name"_"/g ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/AndroidManifest.xml

LANG=C sed -i '' s/"@drawable\/"/"@drawable\/"$project_name"_"/g ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/AndroidManifest.xml


LANG=C sed -i '' s/"@string\/"/"@string\/"$project_name"_"/g ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/res/layout/*

LANG=C sed -i '' s/"@array\/"/"@array\/"$project_name"_"/g ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/res/layout/*


LANG=C sed -i '' 's/R.id.\(.*\))/Mosaic.getResId(this, Mosaic.ID_RESOURCE, \"\1\"))/g' ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/src/com/*/*/*

LANG=C sed -i '' 's/R.layout.\(.*\))/Mosaic.getResId(this, Mosaic.LAYOUT_RESOURCE, \"\1\"))/g' ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/src/com/*/*/*

LANG=C sed -i '' 's/R.menu.\(.*\))/Mosaic.getResId(this, Mosaic.MENU_RESOURCE, \"\1\"))/g' ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/src/com/*/*/*

echo "Where is your Android SDK located?"
read sdk_location

export SDK_DIR=$sdk_location/sdk/

cd ~/MosaicAndroid/AndroidMosaicSDK/modules/$project_name/

ant validate










