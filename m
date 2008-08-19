Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:57:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:9937 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580944AbYHSNzY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:24 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7986CB96D; Tue, 19 Aug 2008 22:55:19 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 09/14] RBTX4938: Add TOSHIBA_RBTX4938_MPLEX_KEEP
Date:	Tue, 19 Aug 2008 22:55:13 +0900
Message-Id: <1219154118-21193-9-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add TOSHIBA_RBTX4938_MPLEX_KEEP to keep MPLEX settings by firmware.
Also replace some printk with pr_info.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/Kconfig          |    2 ++
 arch/mips/txx9/rbtx4938/setup.c |   13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 6fb2ef0..aade334 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -94,6 +94,8 @@ config TOSHIBA_RBTX4938_MPLEX_NAND
 	bool "NAND"
 config TOSHIBA_RBTX4938_MPLEX_ATA
 	bool "ATA"
+config TOSHIBA_RBTX4938_MPLEX_KEEP
+	bool "Keep firmware settings"
 
 endchoice
 
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index e7bc5b8..7aba92a 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -174,23 +174,30 @@ static void __init rbtx4938_mem_setup(void)
 #endif
 
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61
-	printk(KERN_INFO "PIOSEL: disabling both ata and nand selection\n");
+	pr_info("PIOSEL: disabling both ATA and NAND selection\n");
 	txx9_clear64(&tx4938_ccfgptr->pcfg,
 		     TX4938_PCFG_NDF_SEL | TX4938_PCFG_ATA_SEL);
 #endif
 
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND
-	printk(KERN_INFO "PIOSEL: enabling nand selection\n");
+	pr_info("PIOSEL: enabling NAND selection\n");
 	txx9_set64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_NDF_SEL);
 	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_ATA_SEL);
 #endif
 
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA
-	printk(KERN_INFO "PIOSEL: enabling ata selection\n");
+	pr_info("PIOSEL: enabling ATA selection\n");
 	txx9_set64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_ATA_SEL);
 	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_NDF_SEL);
 #endif
 
+#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_KEEP
+	pcfg = ____raw_readq(&tx4938_ccfgptr->pcfg);
+	pr_info("PIOSEL: NAND %s, ATA %s\n",
+		(pcfg & TX4938_PCFG_NDF_SEL) ? "enabled" : "disabled",
+		(pcfg & TX4938_PCFG_ATA_SEL) ? "enabled" : "disabled");
+#endif
+
 	rbtx4938_spi_setup();
 	pcfg = ____raw_readq(&tx4938_ccfgptr->pcfg);	/* updated */
 	/* fixup piosel */
-- 
1.5.6.3
