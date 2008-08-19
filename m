Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:56:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:4560 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580942AbYHSNzV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:21 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 86A1EB637; Tue, 19 Aug 2008 22:55:16 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 05/14] TXx9: Cache fixup
Date:	Tue, 19 Aug 2008 22:55:09 +0900
Message-Id: <1219154118-21193-5-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

TX39/TX49 can enable/disable I/D cache at runtime.  Add kernel options
to control them.  This is useful to debug some cache-related issues,
such as aliasing or I/D coherency.  Also enable CWF bit for TX49 SoCs.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c        |  113 +++++++++++++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx3927.c |   18 +++---
 arch/mips/txx9/generic/setup_tx4927.c |    1 +
 arch/mips/txx9/generic/setup_tx4938.c |    1 +
 arch/mips/txx9/jmr3927/setup.c        |   11 +---
 arch/mips/txx9/rbtx4927/setup.c       |    6 --
 6 files changed, 124 insertions(+), 26 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index af97514..48aba94 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -25,6 +25,7 @@
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/reboot.h>
+#include <asm/r4kcache.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #ifdef CONFIG_CPU_TX49XX
@@ -185,6 +186,110 @@ static void __init prom_init_cmdline(void)
 	}
 }
 
+static int txx9_ic_disable __initdata;
+static int txx9_dc_disable __initdata;
+
+#if defined(CONFIG_CPU_TX49XX)
+/* flush all cache on very early stage (before 4k_cache_init) */
+static void __init early_flush_dcache(void)
+{
+	unsigned int conf = read_c0_config();
+	unsigned int dc_size = 1 << (12 + ((conf & CONF_DC) >> 6));
+	unsigned int linesz = 32;
+	unsigned long addr, end;
+
+	end = INDEX_BASE + dc_size / 4;
+	/* 4way, waybit=0 */
+	for (addr = INDEX_BASE; addr < end; addr += linesz) {
+		cache_op(Index_Writeback_Inv_D, addr | 0);
+		cache_op(Index_Writeback_Inv_D, addr | 1);
+		cache_op(Index_Writeback_Inv_D, addr | 2);
+		cache_op(Index_Writeback_Inv_D, addr | 3);
+	}
+}
+
+static void __init txx9_cache_fixup(void)
+{
+	unsigned int conf;
+
+	conf = read_c0_config();
+	/* flush and disable */
+	if (txx9_ic_disable) {
+		conf |= TX49_CONF_IC;
+		write_c0_config(conf);
+	}
+	if (txx9_dc_disable) {
+		early_flush_dcache();
+		conf |= TX49_CONF_DC;
+		write_c0_config(conf);
+	}
+
+	/* enable cache */
+	conf = read_c0_config();
+	if (!txx9_ic_disable)
+		conf &= ~TX49_CONF_IC;
+	if (!txx9_dc_disable)
+		conf &= ~TX49_CONF_DC;
+	write_c0_config(conf);
+
+	if (conf & TX49_CONF_IC)
+		pr_info("TX49XX I-Cache disabled.\n");
+	if (conf & TX49_CONF_DC)
+		pr_info("TX49XX D-Cache disabled.\n");
+}
+#elif defined(CONFIG_CPU_TX39XX)
+/* flush all cache on very early stage (before tx39_cache_init) */
+static void __init early_flush_dcache(void)
+{
+	unsigned int conf = read_c0_config();
+	unsigned int dc_size = 1 << (10 + ((conf & TX39_CONF_DCS_MASK) >>
+					   TX39_CONF_DCS_SHIFT));
+	unsigned int linesz = 16;
+	unsigned long addr, end;
+
+	end = INDEX_BASE + dc_size / 2;
+	/* 2way, waybit=0 */
+	for (addr = INDEX_BASE; addr < end; addr += linesz) {
+		cache_op(Index_Writeback_Inv_D, addr | 0);
+		cache_op(Index_Writeback_Inv_D, addr | 1);
+	}
+}
+
+static void __init txx9_cache_fixup(void)
+{
+	unsigned int conf;
+
+	conf = read_c0_config();
+	/* flush and disable */
+	if (txx9_ic_disable) {
+		conf &= ~TX39_CONF_ICE;
+		write_c0_config(conf);
+	}
+	if (txx9_dc_disable) {
+		early_flush_dcache();
+		conf &= ~TX39_CONF_DCE;
+		write_c0_config(conf);
+	}
+
+	/* enable cache */
+	conf = read_c0_config();
+	if (!txx9_ic_disable)
+		conf |= TX39_CONF_ICE;
+	if (!txx9_dc_disable)
+		conf |= TX39_CONF_DCE;
+	write_c0_config(conf);
+
+	if (!(conf & TX39_CONF_ICE))
+		pr_info("TX39XX I-Cache disabled.\n");
+	if (!(conf & TX39_CONF_DCE))
+		pr_info("TX39XX D-Cache disabled.\n");
+}
+#else
+static inline void txx9_cache_fixup(void)
+{
+}
+#endif
+
 static void __init preprocess_cmdline(void)
 {
 	char cmdline[CL_SIZE];
@@ -203,11 +308,19 @@ static void __init preprocess_cmdline(void)
 			if (strict_strtoul(str + 10, 10, &val) == 0)
 				txx9_master_clock = val;
 			continue;
+		} else if (strcmp(str, "icdisable") == 0) {
+			txx9_ic_disable = 1;
+			continue;
+		} else if (strcmp(str, "dcdisable") == 0) {
+			txx9_dc_disable = 1;
+			continue;
 		}
 		if (arcs_cmdline[0])
 			strcat(arcs_cmdline, " ");
 		strcat(arcs_cmdline, str);
 	}
+
+	txx9_cache_fixup();
 }
 
 static void __init select_board(void)
diff --git a/arch/mips/txx9/generic/setup_tx3927.c b/arch/mips/txx9/generic/setup_tx3927.c
index 7bd963d..4bc2f85 100644
--- a/arch/mips/txx9/generic/setup_tx3927.c
+++ b/arch/mips/txx9/generic/setup_tx3927.c
@@ -99,16 +99,14 @@ void __init tx3927_setup(void)
 	txx9_gpio_init(TX3927_PIO_REG, 0, 16);
 
 	conf = read_c0_conf();
-	if (!(conf & TX39_CONF_ICE))
-		printk(KERN_INFO "TX3927 I-Cache disabled.\n");
-	if (!(conf & TX39_CONF_DCE))
-		printk(KERN_INFO "TX3927 D-Cache disabled.\n");
-	else if (!(conf & TX39_CONF_WBON))
-		printk(KERN_INFO "TX3927 D-Cache WriteThrough.\n");
-	else if (!(conf & TX39_CONF_CWFON))
-		printk(KERN_INFO "TX3927 D-Cache WriteBack.\n");
-	else
-		printk(KERN_INFO "TX3927 D-Cache WriteBack (CWF) .\n");
+	if (conf & TX39_CONF_DCE) {
+		if (!(conf & TX39_CONF_WBON))
+			pr_info("TX3927 D-Cache WriteThrough.\n");
+		else if (!(conf & TX39_CONF_CWFON))
+			pr_info("TX3927 D-Cache WriteBack.\n");
+		else
+			pr_info("TX3927 D-Cache WriteBack (CWF) .\n");
+	}
 }
 
 void __init tx3927_time_init(unsigned int evt_tmrnr, unsigned int src_tmrnr)
diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index f80d4b7..e679c79 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -44,6 +44,7 @@ void __init tx4927_setup(void)
 
 	txx9_reg_res_init(TX4927_REV_PCODE(), TX4927_REG_BASE,
 			  TX4927_REG_SIZE);
+	set_c0_config(TX49_CONF_CWFON);
 
 	/* SDRAMC,EBUSC are configured by PROM */
 	for (i = 0; i < 8; i++) {
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index f3040b9..95c058f 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -47,6 +47,7 @@ void __init tx4938_setup(void)
 
 	txx9_reg_res_init(TX4938_REV_PCODE(), TX4938_REG_BASE,
 			  TX4938_REG_SIZE);
+	set_c0_config(TX49_CONF_CWFON);
 
 	/* SDRAMC,EBUSC are configured by PROM */
 	for (i = 0; i < 8; i++) {
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 87db41b..2e40a92 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -62,7 +62,6 @@ static void __init jmr3927_time_init(void)
 }
 
 #define DO_WRITE_THROUGH
-#define DO_ENABLE_CACHE
 
 static void jmr3927_board_init(void);
 
@@ -77,11 +76,6 @@ static void __init jmr3927_mem_setup(void)
 	/* cache setup */
 	{
 		unsigned int conf;
-#ifdef DO_ENABLE_CACHE
-		int mips_ic_disable = 0, mips_dc_disable = 0;
-#else
-		int mips_ic_disable = 1, mips_dc_disable = 1;
-#endif
 #ifdef DO_WRITE_THROUGH
 		int mips_config_cwfon = 0;
 		int mips_config_wbon = 0;
@@ -91,10 +85,7 @@ static void __init jmr3927_mem_setup(void)
 #endif
 
 		conf = read_c0_conf();
-		conf &= ~(TX39_CONF_ICE | TX39_CONF_DCE |
-			  TX39_CONF_WBON | TX39_CONF_CWFON);
-		conf |= mips_ic_disable ? 0 : TX39_CONF_ICE;
-		conf |= mips_dc_disable ? 0 : TX39_CONF_DCE;
+		conf &= ~(TX39_CONF_WBON | TX39_CONF_CWFON);
 		conf |= mips_config_wbon ? TX39_CONF_WBON : 0;
 		conf |= mips_config_cwfon ? TX39_CONF_CWFON : 0;
 
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 5985f33..0464a39 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -186,14 +186,8 @@ static void __init rbtx4937_clock_init(void);
 
 static void __init rbtx4927_mem_setup(void)
 {
-	u32 cp0_config;
 	char *argptr;
 
-	/* enable caches -- HCP5 does this, pmon does not */
-	cp0_config = read_c0_config();
-	cp0_config = cp0_config & ~(TX49_CONF_IC | TX49_CONF_DC);
-	write_c0_config(cp0_config);
-
 	if (TX4927_REV_PCODE() == 0x4927) {
 		rbtx4927_clock_init();
 		tx4927_setup();
-- 
1.5.6.3
