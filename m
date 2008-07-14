Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 14:54:36 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:32463 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28577573AbYGNNye (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 14:54:34 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KIOVd-0003P9-00; Mon, 14 Jul 2008 15:54:33 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id F2578DE7B3; Mon, 14 Jul 2008 15:54:30 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Remove mips_machtype from EMMA2RH machines
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080714135430.F2578DE7B3@solo.franken.de>
Date:	Mon, 14 Jul 2008 15:54:30 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

This is the EMMA2RH part of the mips_machtype removal.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

This patch is against the queue tree.

 arch/mips/emma2rh/common/prom.c |   15 +++++++--------
 include/asm-mips/bootinfo.h     |    5 -----
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/mips/emma2rh/common/prom.c b/arch/mips/emma2rh/common/prom.c
index 0f791eb..38ce477 100644
--- a/arch/mips/emma2rh/common/prom.c
+++ b/arch/mips/emma2rh/common/prom.c
@@ -34,12 +34,11 @@
 
 const char *get_system_type(void)
 {
-	switch (mips_machtype) {
-	case MACH_NEC_MARKEINS:
-		return "NEC EMMA2RH Mark-eins";
-	default:
-		return "Unknown NEC board";
-	}
+#if defined(CONFIG_MARKEINS)
+	return "NEC EMMA2RH Mark-eins";
+#else
+#error  "Unknown NEC board";
+#endif
 }
 
 /* [jsun@junsun.net] PMON passes arguments in C main() style */
@@ -63,10 +62,10 @@ void __init prom_init(void)
 	}
 
 #if defined(CONFIG_MARKEINS)
-	mips_machtype = MACH_NEC_MARKEINS;
 	add_memory_region(0, EMMA2RH_RAM_SIZE, BOOT_MEM_RAM);
+#else
+#error  "Unknown NEC board";
 #endif
-
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
index 653096a..51dbec9 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -47,11 +47,6 @@
 #define  MACH_LASAT_200		1	/* Masquerade PRO/SP200 */
 
 /*
- * Valid machtype for group NEC EMMA2RH
- */
-#define  MACH_NEC_MARKEINS	0	/* NEC EMMA2RH Mark-eins	*/
-
-/*
  * Valid machtype for group PMC-MSP
  */
 #define MACH_MSP4200_EVAL       0	/* PMC-Sierra MSP4200 Evaluation */
