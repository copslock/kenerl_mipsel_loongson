Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 19:09:38 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:301 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20024888AbYG1SJf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2008 19:09:35 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Mon, 28 Jul 2008 18:09:26 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 28 Jul 2008 13:09:26 -0500
Subject: [PATCH v2 1/1][MIPS] Initialization of Alchemy boards
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, dmitri.vorobiev@movial.fi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date:	Mon, 28 Jul 2008 13:09:26 -0500
Message-Id: <1217268566.19887.3.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

  An earlier update changed some calls from simple_strotl to
strict_strtol but did not account for the differences in the syntax
between the calls.simple_strotl returns the integer; strict_strtol
returns an error code and takes a pointer to the result.  As it was,
NULL was being passed in place of the result, which led to failures
during kernel initialization when using YAMON.

Signed-off-by:  Kevin Hickey <khickey@rmicorp.com>

 arch/mips/au1000/db1x00/init.c  |    2 +-
 arch/mips/au1000/mtx-1/init.c   |    2 +-
 arch/mips/au1000/pb1000/init.c  |    2 +-
 arch/mips/au1000/pb1100/init.c  |    2 +-
 arch/mips/au1000/pb1200/init.c  |    2 +-
 arch/mips/au1000/pb1500/init.c  |    2 +-
 arch/mips/au1000/pb1550/init.c  |    2 +-
 arch/mips/au1000/xxs1500/init.c |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/au1000/db1x00/init.c
b/arch/mips/au1000/db1x00/init.c
index 5ebe0de..8474135 100644
--- a/arch/mips/au1000/db1x00/init.c
+++ b/arch/mips/au1000/db1x00/init.c
@@ -57,6 +57,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff --git a/arch/mips/au1000/mtx-1/init.c
b/arch/mips/au1000/mtx-1/init.c
index 33a4aeb..3bae13c 100644
--- a/arch/mips/au1000/mtx-1/init.c
+++ b/arch/mips/au1000/mtx-1/init.c
@@ -55,6 +55,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff --git a/arch/mips/au1000/pb1000/init.c
b/arch/mips/au1000/pb1000/init.c
index 3837365..8a9c7d5 100644
--- a/arch/mips/au1000/pb1000/init.c
+++ b/arch/mips/au1000/pb1000/init.c
@@ -52,6 +52,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff --git a/arch/mips/au1000/pb1100/init.c
b/arch/mips/au1000/pb1100/init.c
index 8355483..7c67923 100644
--- a/arch/mips/au1000/pb1100/init.c
+++ b/arch/mips/au1000/pb1100/init.c
@@ -54,7 +54,7 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff --git a/arch/mips/au1000/pb1200/init.c
b/arch/mips/au1000/pb1200/init.c
index 09fd63b..e9b2a0f 100644
--- a/arch/mips/au1000/pb1200/init.c
+++ b/arch/mips/au1000/pb1200/init.c
@@ -53,6 +53,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x08000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff --git a/arch/mips/au1000/pb1500/init.c
b/arch/mips/au1000/pb1500/init.c
index 49f51e1..3b6e395 100644
--- a/arch/mips/au1000/pb1500/init.c
+++ b/arch/mips/au1000/pb1500/init.c
@@ -53,6 +53,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x04000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff --git a/arch/mips/au1000/pb1550/init.c
b/arch/mips/au1000/pb1550/init.c
index 1b5f584..e1055a1 100644
--- a/arch/mips/au1000/pb1550/init.c
+++ b/arch/mips/au1000/pb1550/init.c
@@ -53,6 +53,6 @@ void __init prom_init(void)
 	if (!memsize_str)
 		memsize = 0x08000000;
 	else
-		memsize = strict_strtol(memsize_str, 0, NULL);
+		strict_strtol(memsize_str, 0, &memsize);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff --git a/arch/mips/au1000/xxs1500/init.c
b/arch/mips/au1000/xxs1500/init.c
index b849bf5..7516434 100644
--- a/arch/mips/au1000/xxs1500/init.c
+++ b/arch/mips/au1000/xxs1500/init.c
@@ -53,6 +53,6 @@ void __init prom_init(void)
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
