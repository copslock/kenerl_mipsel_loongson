Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2004 21:50:32 +0100 (BST)
Received: from 64-60-250-34.cust.telepacific.net ([IPv6:::ffff:64.60.250.34]:11072
	"EHLO panta-1.pantasys.com") by linux-mips.org with ESMTP
	id <S8225196AbUIIUu2>; Thu, 9 Sep 2004 21:50:28 +0100
Received: from [10.1.40.165] ([10.1.40.1]) by panta-1.pantasys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 9 Sep 2004 13:43:33 -0700
Message-ID: <4140C205.7020405@pantasys.com>
Date: Thu, 09 Sep 2004 13:50:13 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
Subject: [PATCH 2.6] make the bcm1250 work
Content-Type: multipart/mixed;
 boundary="------------070608060601050109010704"
X-OriginalArrivalTime: 09 Sep 2004 20:43:33.0500 (UTC) FILETIME=[AC2793C0:01C496AD]
Return-Path: <peter@pantasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@pantasys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070608060601050109010704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ralf,

I have been playing with a bcm1250 from broadcom. These are patches I 
needed to get things to compile correctly. After applying the to patches 
above I can build fine.

thanks,

peter

Signed-off-by: Peter Buckingham <peter@pantasys.com>

--------------070608060601050109010704
Content-Type: text/plain;
 name="p"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p"

Index: arch/mips/sibyte/sb1250/prom.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sibyte/sb1250/prom.c,v
retrieving revision 1.9
diff -p -u -r1.9 prom.c
--- arch/mips/sibyte/sb1250/prom.c	28 Jan 2004 22:16:39 -0000	1.9
+++ arch/mips/sibyte/sb1250/prom.c	9 Sep 2004 18:42:13 -0000
@@ -29,6 +29,7 @@
 
 #ifdef CONFIG_EMBEDDED_RAMDISK
 /* These are symbols defined by the ramdisk linker script */
+extern unsigned long initrd_start, initrd_end;
 extern unsigned char __rd_start;
 extern unsigned char __rd_end;
 #endif
Index: arch/mips/sibyte/swarm/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sibyte/swarm/setup.c,v
retrieving revision 1.31
diff -p -u -r1.31 setup.c
--- arch/mips/sibyte/swarm/setup.c	26 Aug 2004 20:18:00 -0000	1.31
+++ arch/mips/sibyte/swarm/setup.c	9 Sep 2004 18:42:13 -0000
@@ -27,6 +27,7 @@
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
+#include <linux/tty.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -50,6 +51,11 @@ extern int m41t81_probe(void);
 extern int m41t81_set_time(unsigned long);
 extern unsigned long m41t81_get_time(void);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+extern unsigned long initrd_start, initrd_end;
+extern void * __rd_start, * __rd_end;
+#endif
+
 const char *get_system_type(void)
 {
 	return "SiByte " SIBYTE_BOARD_NAME;

--------------070608060601050109010704
Content-Type: text/plain;
 name="p1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p1"

Index: arch/mips/pci/pci-sb1250.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/pci/pci-sb1250.c,v
retrieving revision 1.9
diff -p -u -r1.9 pci-sb1250.c
--- arch/mips/pci/pci-sb1250.c	26 Aug 2004 20:18:00 -0000	1.9
+++ arch/mips/pci/pci-sb1250.c	9 Sep 2004 18:45:11 -0000
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/console.h>
+#include <linux/tty.h> //pmb 20040824
 
 #include <asm/io.h>
 

--------------070608060601050109010704--
