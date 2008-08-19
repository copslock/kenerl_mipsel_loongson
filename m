Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:56:12 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:23247 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580895AbYHSNzU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:20 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C91F5B5BB; Tue, 19 Aug 2008 22:55:14 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 02/14] TXx9: Improve handling of built-in and command-line args
Date:	Tue, 19 Aug 2008 22:55:06 +0900
Message-Id: <1219154118-21193-2-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Make prom_init_cmdline() static and be called from prom_init.
* Append built-in args if the first character was '+'.
* Drop command-line args if the first character of built-in was '-'.
* Enclose args include spaces by quotes.
* TX4938_NAND_BOOT is no longer needed.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/Kconfig          |    7 ------
 arch/mips/txx9/generic/setup.c  |   42 ++++++++++++++++++++++++++++----------
 arch/mips/txx9/jmr3927/prom.c   |    1 -
 arch/mips/txx9/rbtx4927/prom.c  |    1 -
 arch/mips/txx9/rbtx4938/prom.c  |    3 --
 include/asm-mips/txx9/generic.h |    1 -
 6 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 840fe75..6fb2ef0 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -97,13 +97,6 @@ config TOSHIBA_RBTX4938_MPLEX_ATA
 
 endchoice
 
-config TX4938_NAND_BOOT
-	depends on EXPERIMENTAL && TOSHIBA_RBTX4938_MPLEX_NAND
-	bool "NAND Boot Support (EXPERIMENTAL)"
-	help
-	  This is only for Toshiba RBTX4938 reference board, which has NAND IPL.
-	  Select this option if you need to use NAND boot.
-
 endif
 
 config PCI_TX4927
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 0afe94c..b75022b 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -126,31 +126,51 @@ extern struct txx9_board_vec rbtx4938_vec;
 struct txx9_board_vec *txx9_board_vec __initdata;
 static char txx9_system_type[32];
 
-void __init prom_init_cmdline(void)
+static void __init prom_init_cmdline(void)
 {
 	int argc = (int)fw_arg0;
-	char **argv = (char **)fw_arg1;
+	int *argv32 = (int *)fw_arg1;
 	int i;			/* Always ignore the "-c" at argv[0] */
-#ifdef CONFIG_64BIT
-	char *fixed_argv[32];
-	for (i = 0; i < argc; i++)
-		fixed_argv[i] = (char *)(long)(*((__s32 *)argv + i));
-	argv = fixed_argv;
-#endif
+	char builtin[CL_SIZE];
 
 	/* ignore all built-in args if any f/w args given */
-	if (argc > 1)
-		*arcs_cmdline = '\0';
+	/*
+	 * But if built-in strings was started with '+', append them
+	 * to command line args.  If built-in was started with '-',
+	 * ignore all f/w args.
+	 */
+	builtin[0] = '\0';
+	if (arcs_cmdline[0] == '+')
+		strcpy(builtin, arcs_cmdline + 1);
+	else if (arcs_cmdline[0] == '-') {
+		strcpy(builtin, arcs_cmdline + 1);
+		argc = 0;
+	} else if (argc <= 1)
+		strcpy(builtin, arcs_cmdline);
+	arcs_cmdline[0] = '\0';
 
 	for (i = 1; i < argc; i++) {
+		char *str = (char *)(long)argv32[i];
 		if (i != 1)
 			strcat(arcs_cmdline, " ");
-		strcat(arcs_cmdline, argv[i]);
+		if (strchr(str, ' ')) {
+			strcat(arcs_cmdline, "\"");
+			strcat(arcs_cmdline, str);
+			strcat(arcs_cmdline, "\"");
+		} else
+			strcat(arcs_cmdline, str);
+	}
+	/* append saved builtin args */
+	if (builtin[0]) {
+		if (arcs_cmdline[0])
+			strcat(arcs_cmdline, " ");
+		strcat(arcs_cmdline, builtin);
 	}
 }
 
 void __init prom_init(void)
 {
+	prom_init_cmdline();
 #ifdef CONFIG_CPU_TX39XX
 	txx9_board_vec = &jmr3927_vec;
 #endif
diff --git a/arch/mips/txx9/jmr3927/prom.c b/arch/mips/txx9/jmr3927/prom.c
index 70c4c8e..c899c0c 100644
--- a/arch/mips/txx9/jmr3927/prom.c
+++ b/arch/mips/txx9/jmr3927/prom.c
@@ -47,7 +47,6 @@ void __init jmr3927_prom_init(void)
 	if ((tx3927_ccfgptr->ccfg & TX3927_CCFG_TLBOFF) == 0)
 		printk(KERN_ERR "TX3927 TLB off\n");
 
-	prom_init_cmdline();
 	add_memory_region(0, JMR3927_SDRAM_SIZE, BOOT_MEM_RAM);
 	txx9_sio_putchar_init(TX3927_SIO_REG(1));
 }
diff --git a/arch/mips/txx9/rbtx4927/prom.c b/arch/mips/txx9/rbtx4927/prom.c
index 1dc0a5b..cc97c6a 100644
--- a/arch/mips/txx9/rbtx4927/prom.c
+++ b/arch/mips/txx9/rbtx4927/prom.c
@@ -36,7 +36,6 @@
 
 void __init rbtx4927_prom_init(void)
 {
-	prom_init_cmdline();
 	add_memory_region(0, tx4927_get_mem_size(), BOOT_MEM_RAM);
 	txx9_sio_putchar_init(TX4927_SIO_REG(0) & 0xfffffffffULL);
 }
diff --git a/arch/mips/txx9/rbtx4938/prom.c b/arch/mips/txx9/rbtx4938/prom.c
index d73123c..bcb4692 100644
--- a/arch/mips/txx9/rbtx4938/prom.c
+++ b/arch/mips/txx9/rbtx4938/prom.c
@@ -18,9 +18,6 @@
 
 void __init rbtx4938_prom_init(void)
 {
-#ifndef CONFIG_TX4938_NAND_BOOT
-	prom_init_cmdline();
-#endif
 	add_memory_region(0, tx4938_get_mem_size(), BOOT_MEM_RAM);
 	txx9_sio_putchar_init(TX4938_SIO_REG(0) & 0xfffffffffULL);
 }
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index 5b1ccf9..c9eed7e 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -42,7 +42,6 @@ struct txx9_board_vec {
 };
 extern struct txx9_board_vec *txx9_board_vec;
 extern int (*txx9_irq_dispatch)(int pending);
-void prom_init_cmdline(void);
 char *prom_getcmdline(void);
 void txx9_wdt_init(unsigned long base);
 void txx9_spi_init(int busid, unsigned long base, int irq);
-- 
1.5.6.3
