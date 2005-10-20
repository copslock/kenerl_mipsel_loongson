Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 20:59:25 +0100 (BST)
Received: from [85.21.88.2] ([85.21.88.2]:63107 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S3465726AbVJTT7I (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2005 20:59:08 +0100
Received: (qmail 23032 invoked from network); 20 Oct 2005 19:59:00 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 20 Oct 2005 19:59:00 -0000
Message-ID: <4357F774.9010208@ru.mvista.com>
Date:	Fri, 21 Oct 2005 00:00:52 +0400
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: RTSoft, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS Development <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>
Subject: Misc. AMD DBAu1550 fixes
Content-Type: multipart/mixed;
 boundary="------------000304060304090002040701"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000304060304090002040701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     Here's a couple of DBAu1550 fixes: the first one fixes BCSR accesses in
the board setup/reset code (the registers are actually 16-bit, and their
addresses are different between DBAu1550 and other DBAu1xx0 boards), the
second one just selects the proper machine type for DBAu1550.

WBR, Sergei




--------------000304060304090002040701
Content-Type: text/plain;
 name="db1550-bcsr-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="db1550-bcsr-fix.patch"

Index: linux/arch/mips/au1000/db1x00/board_setup.c
===================================================================
--- linux.orig/arch/mips/au1000/db1x00/board_setup.c
+++ linux/arch/mips/au1000/db1x00/board_setup.c
@@ -45,13 +45,12 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/db1x00.h>
 
-/* not correct for db1550 */
-static BCSR * const bcsr = (BCSR *)0xAE000000;
+static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
 
 void board_reset (void)
 {
 	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
-	au_writel(0x00000000, 0xAE00001C);
+	bcsr->swreset = 0x0000);
 }
 
 void __init board_setup(void)
@@ -75,7 +75,7 @@ void __init board_setup(void)
 	bcsr->resets |= BCSR_RESETS_IRDA_MODE_OFF;
 	au_sync();
 #endif
-	au_writel(0, 0xAE000010); /* turn off pcmcia power */
+	bcsr->pcmcia = 0x0000; /* turn off PCMCIA power */
 
 #ifdef CONFIG_MIPS_MIRAGE
 	/* enable GPIO[31:0] inputs */





--------------000304060304090002040701
Content-Type: text/plain;
 name="db1550-platform.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="db1550-platform.patch"

Index: linux/arch/mips/au1000/db1x00/init.c
===================================================================
--- linux.orig/arch/mips/au1000/db1x00/init.c
+++ linux/arch/mips/au1000/db1x00/init.c
@@ -61,7 +61,11 @@ void __init prom_init(void)
 	prom_envp = (char **) fw_arg2;
 
 	mips_machgroup = MACH_GROUP_ALCHEMY;
-	mips_machtype = MACH_DB1000;	/* set the platform # */
+#ifdef CONFIG_MIPS_DB1550
+	mips_machtype = MACH_DB1550;
+#else
+ 	mips_machtype = MACH_DB1000;	/* set the platform # */
+#endif
 
 	prom_init_cmdline();
 





--------------000304060304090002040701--
