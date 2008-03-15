Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Mar 2008 11:29:00 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:23978 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28590947AbYCOL25 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 15 Mar 2008 11:28:57 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JaUZM-0004ow-00; Sat, 15 Mar 2008 12:28:56 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 55750C2360; Sat, 15 Mar 2008 12:28:51 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] check for gcc r10k-cache-barrier support
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080315112851.55750C2360@solo.franken.de>
Date:	Sat, 15 Mar 2008 12:28:51 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Check whether gcc supports -mr10-cache-barrier=1 and issue a cleaner
error message if not. This option is needed to build working SGI IP28
kernels.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/Makefile |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 72097da..1c62381 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -482,10 +482,13 @@ endif
 # be 16kb aligned or the handling of the current variable will break.
 # Simplified: what IP22 does at 128MB+ in ksegN, IP28 does at 512MB+ in xkphys
 #
-#core-$(CONFIG_SGI_IP28)		+= arch/mips/sgi-ip22/ arch/mips/arc/arc_con.o
+ifdef CONFIG_SGI_IP28
+  ifeq ($(call cc-option-yn,-mr10k-cache-barrier=1), n)
+      $(error gcc doesn't support needed option -mr10k-cache-barrier=1)
+  endif
+endif
 core-$(CONFIG_SGI_IP28)		+= arch/mips/sgi-ip22/
 cflags-$(CONFIG_SGI_IP28)	+= -mr10k-cache-barrier=1 -Iinclude/asm-mips/mach-ip28
-#cflags-$(CONFIG_SGI_IP28)	+= -Iinclude/asm-mips/mach-ip28
 load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000
 
 #
