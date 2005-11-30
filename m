Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2005 13:28:19 +0000 (GMT)
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:11763
	"EHLO lexbox.fr") by ftp.linux-mips.org with ESMTP id S8133842AbVK3N2C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Nov 2005 13:28:02 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: DbAu1550 copy file corruption
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date:	Wed, 30 Nov 2005 14:27:43 +0100
Message-ID: <17AB476A04B7C842887E0EB1F268111E027199@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DbAu1550 copy file corruption
thread-index: AcX1lsl8tmWJBo5gSmGMP3cNVuA5+wAGv+AA
From:	"David Sanchez" <david.sanchez@lexbox.fr>
To:	<linux-mips@linux-mips.org>
Return-Path: <david.sanchez@lexbox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.sanchez@lexbox.fr
Precedence: bulk
X-list: linux-mips

Hi,

I forgot to mention that I'm making my test on a ext2 filesystem...

More can somebody launch the test on another Alchemy board ? Dbau1500, Dbau1200, etc...

Thanks

David

-----Message d'origine-----
De : David Sanchez 
Envoyé : mercredi 30 novembre 2005 11:14
À : 'linux-mips@linux-mips.org'
Objet : DbAu1550 copy file corruption

Hi,

I still have a problem of file corruption after a big copy (around 300M) and no solution at this time...

Who have a dbau1550 and who could try the following script to check copies on big files?


####################################
#!/bin/sh

path_file=$1
if test -z $path_file ; then
	path_file=`pwd`
fi

# You can modify the source and the destination filename, the source file 
# size and the number of iterations.

# Source and destination filename
src_file=${path_file}/src_test_file
dst_file=${path_file}/dst_test_file
# Source file size: 300M
src_file_size=300000
# Number of iterations
let max_it=50

# Create source file
if test ! -f ${src_file} ; then
	echo "* Generating ${src_file}..."
	dd bs=1024 count=${src_file_size} if=/dev/urandom of=${src_file}
	echo ""
fi

# Check if source exists
if test -f ${src_file} ; then
	echo "* Check copy from $src_file to $dst_file:"
	echo ""
else
	echo "$src_file does NOT exist" ; exec false
fi

# Clear destination
if test -f ${dst_file} ; then
	rm ${dst_file}
fi

# Go
let i=0
let nb_err=0
while [ $i -lt $max_it ]
do
	cp ${src_file} ${dst_file}
	cmp ${src_file} ${dst_file}
	if [ $? -eq 0 ]
		then
			echo ${src_file} ${dst_file} IDENTICAL
		else
			let nb_err=nb_err+1
		fi
	rm ${dst_file}
	let i=i+1
done

# Result
echo ""
echo "Done"
echo -e "\t$nb_err error(s) over $max_it iteration(s)"
echo ""
####################################

On my DbAu155 + Sata HDD on PDC20579 + Linux Kernel 2.6.10 + busybox 1.0:
Each destination differs from the source:

####################################
* Generating ./src_test_file...
300000+0 records in
300000+0 records out

* Check copy from ./src_test_file to ./dst_test_file:

./src_test_file ./dst_test_file differ: char 10388254, line 40877
./src_test_file ./dst_test_file differ: char 69932960, line 274140
./src_test_file ./dst_test_file differ: char 36867840, line 144723
...

Done
        50 error(s) over 50 iteration(s)
####################################

Thanks'

David
