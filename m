Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2004 21:27:30 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:58352 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8224989AbULFV1X>; Mon, 6 Dec 2004 21:27:23 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iB6LRLdh011398
	for <linux-mips@linux-mips.org>; Mon, 6 Dec 2004 13:27:21 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iB6LRKIY011396
	for linux-mips@linux-mips.org; Mon, 6 Dec 2004 13:27:20 -0800
Date: Mon, 6 Dec 2004 13:27:20 -0800
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Subject: [PATCH] Ocelot-3 supports 256 MB memory
Message-ID: <20041206212720.GA11390@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

Small patch for Ocelot-3 to support 256 MB memory. Please apply ...

Thanks
Manish Lachwani


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-ocelot3-mem

--- arch/mips/momentum/ocelot_3/setup.c.orig	2004-12-06 13:18:44.000000000 -0800
+++ arch/mips/momentum/ocelot_3/setup.c	2004-12-06 13:18:57.000000000 -0800
@@ -390,8 +390,8 @@
 	printk("  - Boot flash write jumper: %s\n", (tmpword&0x40)?"installed":"absent");
 	printk("  - L3 cache size: %d MB\n", (1<<((tmpword&12) >> 2))&~1);
 
-	/* Support for 128 MB memory */
-	add_memory_region(0x0, 0x08000000, BOOT_MEM_RAM);
+	/* Support for 256 MB memory */
+	add_memory_region(0x0, 0x10000000, BOOT_MEM_RAM);
 
 	return 0;
 }

--d6Gm4EdcadzBjdND--
