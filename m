Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Dec 2004 00:22:15 +0000 (GMT)
Received: from sccimhc92.asp.att.net ([IPv6:::ffff:63.240.76.166]:28103 "EHLO
	sccimhc92.asp.att.net") by linux-mips.org with ESMTP
	id <S8225409AbULCAWK>; Fri, 3 Dec 2004 00:22:10 +0000
Received: from sartre.dgate.org (12-221-104-195.client.insightbb.com[12.221.104.195])
          by sccimhc92.asp.att.net (sccimhc92) with ESMTP
          id <20041203002204i92002blhue>; Fri, 3 Dec 2004 00:22:04 +0000
Received: from brg by sartre.dgate.ORG with local (Exim 3.36 #1 (Debian))
	id 1Ca1D2-00079J-00
	for <linux-mips@linux-mips.org>; Thu, 02 Dec 2004 18:22:04 -0600
Date: Thu, 2 Dec 2004 18:22:04 -0600
From: "Brian R. Gaeke" <brg@dgate.org>
To: linux-mips@linux-mips.org
Subject: drivers/tc patch for DS5000/200
Message-ID: <20041203002203.GB26830@sartre.insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5i
Return-Path: <brg@dgate.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brg@dgate.org
Precedence: bulk
X-list: linux-mips


Hi linux-mips list,

First, I want to say, Linux/MIPS is great stuff - thanks for all your
hard work, folks!

Now, it is my understanding that, having a pre-REX PROM, the DECstation
5000/200 would not be able to successfully execute the REX calls
(rex_gettcinfo(), rex_slot_address()) in drivers/tc/tc.c.  Therefore,
I have found it necessary to use a patched kernel in my efforts to boot
Linux on VMIPS (http://www.dgate.org/vmips), which has lately gained some
(limited) DECstation 5000/200 emulation capabilities.

If you find this patch useful, you're quite welcome to it.  I'm also
interested in hearing from anyone who has access to a 5000/200 who can
tell me whether I'm right or wrong, as I only have old manuals and
header files to work from.

-Brian Gaeke

-- 
Brian R. Gaeke, brg at dgate.org -- GnuPG encrypted mail gleefully accepted

Index: tc.c
===================================================================
RCS file: /home/cvs/linux/drivers/tc/tc.c,v
retrieving revision 1.7.2.8
diff -u -a -d -p -r1.7.2.8 tc.c
--- tc.c	11 Aug 2003 11:52:38 -0000	1.7.2.8
+++ tc.c	3 Dec 2004 00:14:56 -0000
@@ -32,6 +32,7 @@ MODULE_LICENSE("GPL");
 slot_info tc_bus[MAX_SLOT];
 static int num_tcslots;
 static tcinfo *info;
+static tcinfo ds5000_200_info;
 
 unsigned long system_base;
 
@@ -196,8 +197,18 @@ void __init tc_init(void)
 		tc_bus[i].flags = FREE;
 	}
 
-	info = (tcinfo *) rex_gettcinfo();
-	slot0addr = (unsigned long)KSEG1ADDR(rex_slot_address(0));
+	if (mips_machtype != MACH_DS5000_200) {
+		info = (tcinfo *) rex_gettcinfo();
+		slot0addr = (unsigned long)KSEG1ADDR(rex_slot_address(0));
+	} else {
+		/* Hardcode these, because the old PROM lacks gettcinfo(). */
+		ds5000_200_info.revision = 0;
+		ds5000_200_info.parity = 0;
+		ds5000_200_info.clk_period = 40;
+		ds5000_200_info.slot_size = 4;
+		info = &ds5000_200_info;
+		slot0addr = 0xbe000000;
+	}
 
 	switch (mips_machtype) {
 	case MACH_DS5000_200:
