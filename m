Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 00:38:51 +0000 (GMT)
Received: from zok.SGI.COM ([IPv6:::ffff:204.94.215.101]:22711 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225198AbTBTAiu>;
	Thu, 20 Feb 2003 00:38:50 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1K0clKp008083;
	Wed, 19 Feb 2003 16:38:47 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA27000; Thu, 20 Feb 2003 11:38:45 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1K0ceuP017921;
	Thu, 20 Feb 2003 11:38:41 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1K0cdav017919;
	Thu, 20 Feb 2003 11:38:39 +1100
Date: Thu, 20 Feb 2003 11:38:39 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Linux-MIPS <linux-mips@linux-mips.org>
Cc: ralf@linux-mips.org
Subject: [patch] bogus ramdisk sanity check on ip27
Message-ID: <20030220003839.GF915@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

There is currently a check that the ramdisk image resides at a sane
memory address, below "max_pfn".  However, max_pfn isn't initialized
(and apparently isn't relevant) for ip27.  The only assignments to
max_pfn lie inside #ifndef CONFIG_SGI_IP27.

Therefore, this test is bogus, so here's a patch to
#ifndef CONFIG_SGI_IP27 it.

This patch applies cleanly on 2.4.x and 2.5.x (at a different offset).

Cheers,
Andrew

diff -u -r1.31.2.25 setup.c
--- arch/mips64/kernel/setup.c	22 Jan 2003 05:11:38 -0000	1.31.2.25
+++ arch/mips64/kernel/setup.c	20 Feb 2003 00:05:41 -0000
@@ -358,6 +358,8 @@
 		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
 		       (void *)initrd_start,
 		       initrd_size);
+/* FIXME: is this right? */
+#ifndef CONFIG_SGI_IP27
 		if (CPHYSADDR(initrd_end) > PFN_PHYS(max_pfn)) {
 			printk("initrd extends beyond end of memory "
 			       "(0x%p > 0x%p)\ndisabling initrd\n",
@@ -365,6 +367,7 @@
 			       (void *)PFN_PHYS(max_pfn));
 			initrd_start = 0;
 		}
+#endif /* !CONFIG_SGI_IP27 */
 	}
 #endif
 }
