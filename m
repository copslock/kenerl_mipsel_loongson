Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6ALxERw021481
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 14:59:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6ALxEXv021480
	for linux-mips-outgoing; Wed, 10 Jul 2002 14:59:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6ALx4Rw021469;
	Wed, 10 Jul 2002 14:59:05 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA16556;
	Wed, 10 Jul 2002 15:03:30 -0700
Message-ID: <3D2CAD78.9070609@mvista.com>
Date: Wed, 10 Jul 2002 14:56:08 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com, Ralf Baechle <ralf@oss.sgi.com>
Subject: [2.4 PATCH] pcnet32.c - tx underflow error
Content-Type: multipart/mixed;
 boundary="------------040900060000070504050505"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------040900060000070504050505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a tx underflow error for 79c973 chip.  It essentially delay 
the transmission until the whole packet is received into the on-chip sdram.

The patch is already accepted by Marcelo for the 2.4 tree, I think.

Jun

--------------040900060000070504050505
Content-Type: text/plain;
 name="pcnet32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcnet32.patch"

diff -Nru linux/drivers/net/pcnet32.c.orig linux/drivers/net/pcnet32.c
--- linux/drivers/net/pcnet32.c.orig	Tue Jul  9 15:05:55 2002
+++ linux/drivers/net/pcnet32.c	Tue Jul  9 18:28:19 2002
@@ -569,7 +569,7 @@
 	break;
     case 0x2625:
 	chipname = "PCnet/FAST III 79C973"; /* PCI */
-	fdx = 1; mii = 1;
+	fdx = 1; mii = 1; fset = 1;
 	break;
     case 0x2626:
 	chipname = "PCnet/Home 79C978"; /* PCI */
@@ -613,7 +613,7 @@
     if(fset)
     {
 	a->write_bcr(ioaddr, 18, (a->read_bcr(ioaddr, 18) | 0x0800));
-	a->write_csr(ioaddr, 80, (a->read_csr(ioaddr, 80) & 0x0C00) | 0x0c00);
+	a->write_csr(ioaddr, 80, (a->read_csr(ioaddr, 80) & ~0x0C00) | 0x0c00);
 	dxsuflo = 1;
 	ltint = 1;
     }

--------------040900060000070504050505--
