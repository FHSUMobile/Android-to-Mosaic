#!/bin/bash

echo "Where is your project located?"
read project_location

project_name=${project_location##*/} 



if [ ! -d "MosaicAndroid" ]; then
	curl -L -o AndroidMosaicSDK.zip https://www.dropbox.com/s/azm2i5xw8it153s/AndroidMosaicSDK.zip?dl=1
	mkdir MosaicAndroid
	cd MosaicAndroid 
	unzip ~/AndroidMosaicSDK
	rm ~/AndroidMosaicSDK.zip
	mv "AndroidMosaicSDK 2" "AndroidMosaicSDK"
fi



cp -r $project_location /Users/nick/MosaicAndroid/AndroidMosaicSDK/modules/


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

