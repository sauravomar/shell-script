read filename

echo $filename

[ ! -f "$filename" ] && echo "invalid file" && exit 1;
cat "$filename" |   awk  '{print $4}' | sed 's/[][]//g' | uniq -d >> req_"$filename";



