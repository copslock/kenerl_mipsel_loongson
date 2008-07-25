Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 17:12:14 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:59032 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20032061AbYGYQMM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2008 17:12:12 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Fri, 25 Jul 2008 16:12:05 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 25 Jul 2008 11:13:50 -0500
Subject: [PATCH 1/1] Initialization of Alchemy boards
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date:	Fri, 25 Jul 2008 11:13:50 -0500
Message-Id: <1217002430.10968.30.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

I found this when I updated to version 2.6.26.  None of my development
boards would boot.  It appears that a previous update changed some calls
to simple_strtol to strict_strtol but did not account for the different
call semantics.

Index: arch/mips/au1000/pb1000/init.c
===================================================================
--- arch/mips/au1000/pb1000/init.c
+++ arch/mips/au1000/pb1000/init.c
@@ -52,6 +52,6 @@
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: arch/mips/au1000/pb1100/init.c
===================================================================
--- arch/mips/au1000/pb1100/init.c
+++ arch/mips/au1000/pb1100/init.c
@@ -54,7 +54,7 @@
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: arch/mips/au1000/pb1200/init.c
===================================================================
--- arch/mips/au1000/pb1200/init.c
+++ arch/mips/au1000/pb1200/init.c
@@ -53,6 +53,6 @@
 	if (!memsize_str)
 		memsize = 0x08000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: arch/mips/au1000/mtx-1/init.c
===================================================================
--- arch/mips/au1000/mtx-1/init.c
+++ arch/mips/au1000/mtx-1/init.c
@@ -55,6 +55,6 @@
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: arch/mips/au1000/pb1500/init.c
===================================================================
--- arch/mips/au1000/pb1500/init.c
+++ arch/mips/au1000/pb1500/init.c
@@ -53,6 +53,6 @@
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: arch/mips/au1000/xxs1500/init.c
===================================================================
--- arch/mips/au1000/xxs1500/init.c
+++ arch/mips/au1000/xxs1500/init.c
@@ -53,6 +53,6 @@
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: arch/mips/au1000/pb1550/init.c
===================================================================
--- arch/mips/au1000/pb1550/init.c
+++ arch/mips/au1000/pb1550/init.c
@@ -53,6 +53,6 @@
 	if (!memsize_str)
 		memsize = 0x08000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
Index: arch/mips/au1000/db1x00/init.c
===================================================================
--- arch/mips/au1000/db1x00/init.c
+++ arch/mips/au1000/db1x00/init.c
@@ -57,6 +57,6 @@
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }

-- 
Kevin Hickey
﻿Alchemy Solutions
RMI Corporation
khickey@RMICorp.com
P: 512.691.8044
