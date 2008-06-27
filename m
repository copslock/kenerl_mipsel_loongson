Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2008 22:52:44 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:42644 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20031750AbYF0Vwg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2008 22:52:36 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KCLrr-0003ac-00; Fri, 27 Jun 2008 23:52:31 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id D1B5EE2F71; Fri, 27 Jun 2008 23:52:26 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP22: Fix crashes due to wrong L1_CACHE_BYTES
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080627215226.D1B5EE2F71@solo.franken.de>
Date:	Fri, 27 Jun 2008 23:52:26 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

The introduction of a real dma cache invalidate makes it important
to have a correct cache line size, otherwise the kernel will gives
out two memory segment, which might share one cache line. The R4400
Indy/Indigo2 CPU modules are using a second level cache line size
of 128 bytes, so MIPS_L1_CACHE_SHIFT needs to be bumped up to 7 for
IP22.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e5a7c5d..24c5dee 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1006,7 +1006,7 @@ config BOOT_ELF32
 config MIPS_L1_CACHE_SHIFT
 	int
 	default "4" if MACH_DECSTATION
-	default "7" if SGI_IP27 || SGI_IP28 || SNI_RM
+	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM
 	default "4" if PMC_MSP4200_EVAL
 	default "5"
 
