Received:  by oss.sgi.com id <S305167AbQBSJHA>;
	Sat, 19 Feb 2000 01:07:00 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:23402 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQBSJGl>;
	Sat, 19 Feb 2000 01:06:41 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA12393; Sat, 19 Feb 2000 01:02:10 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA88436
	for linux-list;
	Fri, 18 Feb 2000 13:29:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA03764
	for <linux@engr.sgi.com>;
	Fri, 18 Feb 2000 13:29:40 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA07862
	for <linux@engr.sgi.com>; Fri, 18 Feb 2000 13:29:43 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-2.uni-koblenz.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id WAA01867;
	Fri, 18 Feb 2000 22:29:22 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407899AbQBRM7H>;
	Fri, 18 Feb 2000 13:59:07 +0100
Date:   Fri, 18 Feb 2000 13:59:07 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: copy_from_user() bugfix
Message-ID: <20000218135907.A21082@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
X-Mailer: Mutt 1.0pre3us
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii

Appended are two patches, one for Linux 2.2 and one for 2.3, which fix
a bug copy_from_user / __copy_from_user.  When used in a module these
two functions may return a wrong result in the error case.

  Ralf

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.2"

Index: include/asm-mips/uaccess.h
===================================================================
RCS file: /usr/src/cvs/linux/include/asm-mips/uaccess.h,v
retrieving revision 1.16.2.1
diff -u -r1.16.2.1 uaccess.h
--- uaccess.h	1999/10/21 21:26:27	1.16.2.1
+++ uaccess.h	2000/02/18 12:43:41
@@ -322,10 +322,12 @@
 		"move\t$4, %1\n\t" \
 		"move\t$5, %2\n\t" \
 		"move\t$6, %3\n\t" \
+		".set\tnoreorder\n\t" \
 		".set\tnoat\n\t" \
+		__MODULE_JAL(__copy_user) \
 		"addu\t$1, %2, %3\n\t" \
 		".set\tat\n\t" \
-		__MODULE_JAL(__copy_user) \
+		".set\treorder\n\t" \
 		"move\t%0, $6" \
 		: "=r" (__cu_len) \
 		: "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \
@@ -369,10 +371,12 @@
 			"move\t$4, %1\n\t" \
 			"move\t$5, %2\n\t" \
 			"move\t$6, %3\n\t" \
+			".set\tnoreorder\n\t" \
 			".set\tnoat\n\t" \
+			__MODULE_JAL(__copy_user) \
 			"addu\t$1, %2, %3\n\t" \
 			".set\tat\n\t" \
-			__MODULE_JAL(__copy_user) \
+			".set\treorder\n\t" \
 			"move\t%0, $6" \
 			: "=r" (__cu_len) \
 			: "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.3"

Index: include/asm-mips/uaccess.h
===================================================================
RCS file: /usr/src/cvs/linux/include/asm-mips/uaccess.h,v
retrieving revision 1.18
diff -u -r1.18 uaccess.h
--- uaccess.h	1999/11/19 20:35:48	1.18
+++ uaccess.h	2000/02/18 12:44:43
@@ -323,10 +323,12 @@
 		"move\t$4, %1\n\t" \
 		"move\t$5, %2\n\t" \
 		"move\t$6, %3\n\t" \
+		".set\tnoreorder\n\t" \
 		".set\tnoat\n\t" \
+		__MODULE_JAL(__copy_user) \
 		"addu\t$1, %2, %3\n\t" \
 		".set\tat\n\t" \
-		__MODULE_JAL(__copy_user) \
+		".set\treorder\n\t" \
 		"move\t%0, $6" \
 		: "=r" (__cu_len) \
 		: "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \
@@ -370,10 +372,12 @@
 			"move\t$4, %1\n\t" \
 			"move\t$5, %2\n\t" \
 			"move\t$6, %3\n\t" \
+			".set\tnoreorder\n\t" \
 			".set\tnoat\n\t" \
+			__MODULE_JAL(__copy_user) \
 			"addu\t$1, %2, %3\n\t" \
 			".set\tat\n\t" \
-			__MODULE_JAL(__copy_user) \
+			".set\treorder\n\t" \
 			"move\t%0, $6" \
 			: "=r" (__cu_len) \
 			: "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \
Index: include/asm-mips64/uaccess.h
===================================================================
RCS file: /usr/src/cvs/linux/include/asm-mips64/uaccess.h,v
retrieving revision 1.4
diff -u -r1.4 uaccess.h
--- uaccess.h	1999/11/19 20:35:49	1.4
+++ uaccess.h	2000/02/18 12:48:43
@@ -261,10 +261,12 @@
 		"move\t$4, %1\n\t" \
 		"move\t$5, %2\n\t" \
 		"move\t$6, %3\n\t" \
+		".set\tnoreorder\n\t" \
 		".set\tnoat\n\t" \
-		"addu\t$1, %2, %3\n\t" \
-		".set\tat\n\t" \
 		__MODULE_JAL(__copy_user) \
+		"daddu\t$1, %2, %3\n\t" \
+		".set\tat\n\t" \
+		".set\treorder\n\t" \
 		"move\t%0, $6" \
 		: "=r" (__cu_len) \
 		: "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \
@@ -308,10 +310,12 @@
 			"move\t$4, %1\n\t" \
 			"move\t$5, %2\n\t" \
 			"move\t$6, %3\n\t" \
+			".set\tnoreorder\n\t" \
 			".set\tnoat\n\t" \
-			"addu\t$1, %2, %3\n\t" \
-			".set\tat\n\t" \
 			__MODULE_JAL(__copy_user) \
+			"daddu\t$1, %2, %3\n\t" \
+			".set\tat\n\t" \
+			".set\treorder\n\t" \
 			"move\t%0, $6" \
 			: "=r" (__cu_len) \
 			: "r" (__cu_to), "r" (__cu_from), "r" (__cu_len) \

--AqsLC8rIMeq19msA--
