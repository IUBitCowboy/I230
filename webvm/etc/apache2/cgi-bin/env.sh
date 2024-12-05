#!/bin/bash

echo "Content-type: text/html"
echo ""

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>Environment Variables</title>'
echo '<style>'
echo 'body { background-color: '
case $SERVER_PORT in
	# noauth background color
	80) echo '#ffff80; '
	;;
	# basic auth background color
	8080) echo '#b3d9ff'
	;;
	# CAS auth background color
	8090) echo '#ccffe6'
	;;
	# https background color
	443) echo '#ffb3b3'
	;;
esac
# echo '#ffff80; '
echo  '} </style>'

echo '</head>'
echo '<body>'
case $SERVER_PORT in
	443|8080)
	echo '<a href="/index.html">BACK</a><p><p>'
	;;
esac

if [ $REQUEST_METHOD == "POST" ]; then
	read -n $CONTENT_LENGTH QUERY_STRING_POST
fi

echo 'Environment Variables:'
echo '<pre>'
if [ $REQUEST_METHOD == "POST" ]; then
	echo "QUERY_STRING_POST=${QUERY_STRING_POST}"
	
	case $QUERY_STRING_POST in
		*frican*|*uropean*)	echo "<strong>Well, you have to know these things when you're a king, you know.</strong><br>"
		;;
	esac
fi

/usr/bin/env
echo '</pre>'

echo '</body>'
echo '</html>'

exit 0