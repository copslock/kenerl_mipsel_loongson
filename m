Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Sep 2004 19:04:58 +0100 (BST)
Received: from 64-60-250-34.cust.telepacific.net ([IPv6:::ffff:64.60.250.34]:45679
	"EHLO panta-1.pantasys.com") by linux-mips.org with ESMTP
	id <S8225210AbUIJSEp>; Fri, 10 Sep 2004 19:04:45 +0100
Received: from [10.1.40.165] ([10.1.40.1]) by panta-1.pantasys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 10 Sep 2004 10:57:47 -0700
Message-ID: <4141ECAC.8070806@pantasys.com>
Date: Fri, 10 Sep 2004 11:04:28 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] make the bcm1250 work
References: <4140C205.7020405@pantasys.com> <20040910075644.GA27574@lst.de> <4141DAD6.8000802@pantasys.com> <20040910175213.GA9910@linux-mips.org>
In-Reply-To: <20040910175213.GA9910@linux-mips.org>
Content-Type: multipart/mixed;
 boundary="------------010900010700090209070200"
X-OriginalArrivalTime: 10 Sep 2004 17:57:47.0718 (UTC) FILETIME=[AE6B6E60:01C4975F]
Return-Path: <peter@pantasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@pantasys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010900010700090209070200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:
> Winners use grep(1) ;-)

guess the old tools still work the best ;-)

> Include/linux/initrd.h.

okay, i've attached a new version of the patch. just a few questions. 
would it make sense to lift __rd_start, __rd_end into initrd.h? also 
would it make sense to add:

#ifdef __INITRD_H

etc stuff to the initrd.h?

peter

--------------010900010700090209070200
Content-Type: text/plain;
 name="p"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p"

Index: arch/mips/pci/pci-sb1250.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/pci/pci-sb1250.c,v
retrieving revision 1.9
diff -u -r1.9 pci-sb1250.c
--- arch/mips/pci/pci-sb1250.c	26 Aug 2004 20:18:00 -0000	1.9
+++ arch/mips/pci/pci-sb1250.c	10 Sep 2004 18:01:29 -0000
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/console.h>
+#include <linux/tty.h>
 
 #include <asm/io.h>
 
Index: arch/mips/sibyte/sb1250/prom.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sibyte/sb1250/prom.c,v
retrieving revision 1.9
diff -u -r1.9 prom.c
--- arch/mips/sibyte/sb1250/prom.c	28 Jan 2004 22:16:39 -0000	1.9
+++ arch/mips/sibyte/sb1250/prom.c	10 Sep 2004 18:01:29 -0000
@@ -23,6 +23,7 @@
 #include <linux/blkdev.h>
 #include <linux/bootmem.h>
 #include <linux/smp.h>
+#include <linux/initrd.h>
 
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
Index: arch/mips/sibyte/swarm/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sibyte/swarm/setup.c,v
retrieving revision 1.31
diff -u -r1.31 setup.c
--- arch/mips/sibyte/swarm/setup.c	26 Aug 2004 20:18:00 -0000	1.31
+++ arch/mips/sibyte/swarm/setup.c	10 Sep 2004 18:01:29 -0000
@@ -27,6 +27,8 @@
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
+#include <linux/tty.h>
+#include <linux/initrd.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -50,6 +52,10 @@
 extern int m41t81_set_time(unsigned long);
 extern unsigned long m41t81_get_time(void);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+extern void * __rd_start, * __rd_end;
+#endif
+
 const char *get_system_type(void)
 {
 	return "SiByte " SIBYTE_BOARD_NAME;

--------------010900010700090209070200--
