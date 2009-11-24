Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 02:42:55 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33888 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1493513AbZKXBmw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 02:42:52 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAO1h3qH004287;
	Tue, 24 Nov 2009 01:43:03 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAO1h349004285;
	Tue, 24 Nov 2009 01:43:03 GMT
Date:	Tue, 24 Nov 2009 01:43:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Subject: [PATCH] MIPS: IP22/IP28 Disable EARLY_PRINTK on make the system
	boot
Message-ID: <20091124014303.GB3991@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From: Martin Michlmayr <tbm@cyrius.com>

Some Debian users have reported that the kernel hangs early during boot on
some IP22 systems.  Thomas Bogendoerfer found that this is due to a "bad
interaction between CONFIG_EARLY_PRINTK and overwritten prom memory during
early boot".  Since there's no fix yet, disable CONFIG_EARLY_PRINTK for now.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Cc: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-mips@linux-mips.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
This version also disables early printk for IP28.

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1aad0d9..ffdd651 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -358,7 +358,14 @@ config SGI_IP22
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_R4X00
 	select SYS_HAS_CPU_R5000
-	select SYS_HAS_EARLY_PRINTK
+	#
+	# Disable EARLY_PRINTK for now since it leads to overwritten prom
+	# memory during early boot on some machines.
+	#
+	# See http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20091119164009.GA15038%40deprecation.cyrius.com
+	# for a more details discussion
+	#
+	# select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -410,7 +417,14 @@ config SGI_IP28
 	select SGI_HAS_ZILOG
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_R10000
-	select SYS_HAS_EARLY_PRINTK
+	#
+	# Disable EARLY_PRINTK for now since it leads to overwritten prom
+	# memory during early boot on some machines.
+	#
+	# See http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20091119164009.GA15038%40deprecation.cyrius.com
+	# for a more details discussion
+	#
+	# select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
       help
