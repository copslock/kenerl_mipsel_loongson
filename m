Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f43HGhF08750
	for linux-mips-outgoing; Thu, 3 May 2001 10:16:43 -0700
Received: from gw-us4.philips.com (gw-us4.philips.com [63.114.235.90])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f43HGfF08747
	for <linux-mips@oss.sgi.com>; Thu, 3 May 2001 10:16:41 -0700
Received: from smtprelay-us1.philips.com (localhost.philips.com [127.0.0.1])
          by gw-us4.philips.com with ESMTP id MAA29243;
          Thu, 3 May 2001 12:16:30 -0500 (CDT)
          (envelope-from anthony.wei@philips.com)
From: anthony.wei@philips.com
Received: from smtprelay-nam2.philips.com(167.81.233.16) by gw-us4.philips.com via mwrap (4.0a)
	id xma029234; Thu, 3 May 01 12:16:30 -0500
Received: from AMLMS01.DIAMOND.PHILIPS.COM (amlms01sv1.diamond.philips.com [161.88.79.213]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id MAA00538; Thu, 3 May 2001 12:16:29 -0500 (CDT)
Received: by AMLMS01.DIAMOND.PHILIPS.COM (Soft-Switch LMS 4.0) with snapi
          via AMEC id 0056910011804600; Thu, 3 May 2001 12:19:21 -0500
To: <linux-mips@oss.sgi.com>, <linux-mips@fnet.fr>
Cc: <brad@ltc.com>
Subject: Has anyone successfully reduced the size of libc.so?
Message-ID: <0056910011804600000002L102*@MHS>
Date: Thu, 3 May 2001 12:19:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; name="MEMO 05/03/01 12:16:08"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f43HGgF08748
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I am trying to create a stripped version of  libc.so  from glibc.2.1.95 src, by including only minimal symbols.
	original full size libc.so: 				7.9 Meg
 	original libc.so but symbols stripped 		1.7 Meg
	(running mipsel-linux-strip libc.so)

Has anyone successfully  reduced the size of the libc.so?

Here is what I did.  I started with glibc 2.1.95 and cross compiled for MIPS.

	A.  Using Bradley D. LaRonde's ramdisk as a model
	B.  Ran strings on /lib/libc-2.0.7.so and /lib/ld-2.0.7.so on LaRonde's ramdisk
	 	Removed  all the messages, leaving mostly  symbols.
	C.  Ran a script, that took the symbols and found the corresponding
		*.os file.  And resolved rescursively all undefined symbols.
	D.  Extracted the commands used to create libc.so & ld.so, from
		the log while cross compiling glibc.  Theses included:
			dl-allobjs.os		libc_pic.a
			librtld.os		ld.so
			libc_pic.os		libc.so
	E.  Replaced */stamp.os with the files found from step C.
	F.  Extracted the symbols required for the ls command., and added to the *.os list.  
		This brought the size of the libc.so back to the original size 1.7Meg (stripped)).
	


Thanks.

Anthony Wei
Philips Digital Network
1000 West Maude Avenue     W3-948
Sunnyvale, CA 94085-2810
+1-408-617-1673
