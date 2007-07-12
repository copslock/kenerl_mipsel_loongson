Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 18:00:54 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:8151 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022601AbXGLRAv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2007 18:00:51 +0100
Received: from localhost (p7217-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8EDCCA6A9; Fri, 13 Jul 2007 01:59:31 +0900 (JST)
Date:	Fri, 13 Jul 2007 02:00:26 +0900 (JST)
Message-Id: <20070713.020026.95064250.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com, rpjday@mindspring.com
Subject: [PATCH] Kill CONFIG_TX4927BUG_WORKAROUND
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Kill workarounds for very early chip (perhaps pre-TX4927A).

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index 08e53cc..ab72292 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -138,7 +138,6 @@ extern void toshiba_rbtx4927_irq_setup(void);
 char *prom_getcmdline(void);
 
 #ifdef CONFIG_PCI
-#define CONFIG_TX4927BUG_WORKAROUND
 #undef TX4927_SUPPORT_COMMAND_IO
 #undef  TX4927_SUPPORT_PCI_66
 int tx4927_cpu_clock = 100000000;	/* 100MHz */
@@ -669,15 +668,7 @@ void tx4927_pci_setup(void)
 
 	/* PCI->GB mappings (MEM 16MB) -not used */
 	tx4927_pcicptr->p2gm1plbase = 0xffffffff;
-#ifdef CONFIG_TX4927BUG_WORKAROUND
-	/*
-	 * TX4927-PCIC-BUG: P2GM1PUBASE must be 0
-	 * if P2GM0PUBASE was 0.
-	 */
-	tx4927_pcicptr->p2gm1pubase = 0;
-#else
 	tx4927_pcicptr->p2gm1pubase = 0xffffffff;
-#endif
 	tx4927_pcicptr->p2gmgbase[1] = 0;
 
 	/* PCI->GB mappings (MEM 1MB) -not used */
@@ -910,16 +901,6 @@ void __init toshiba_rbtx4927_setup(void)
 	if (tx4927_ccfg_toeon)
 		tx4927_ccfgptr->ccfg |= TX4927_CCFG_TOE;
 
-	/* SDRAMC fixup */
-#ifdef CONFIG_TX4927BUG_WORKAROUND
-	/*
-	 * TX4927-BUG: INF 01-01-18/ BUG 01-01-22
-	 * G-bus timeout error detection is incorrect
-	 */
-	if (tx4927_ccfg_toeon)
-		tx4927_sdramcptr->tr |= 0x02000000;	/* RCD:3tck */
-#endif
-
 	tx4927_pci_setup();
 	if (tx4927_using_backplane == 1)
 		printk("backplane board IS installed\n");
