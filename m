Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 17:50:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:37334 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28588255AbYGRQt6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 17:49:58 +0100
Received: from localhost (p8181-ipad203funabasi.chiba.ocn.ne.jp [222.146.87.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4DE99B382; Sat, 19 Jul 2008 01:49:51 +0900 (JST)
Date:	Sat, 19 Jul 2008 01:51:41 +0900 (JST)
Message-Id: <20080719.015141.102579582.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/3] txx9: Cleanups for 64-bit support
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
X-archive-position: 19889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Unify (and fix) mem_tx4938.c and mem_tx4927.c
* Simplify prom_init
* Kill volatiles and unused definitions for tx4927.h and tx4938.h

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/Makefile     |    2 +-
 arch/mips/txx9/generic/mem_tx4927.c |   94 +++------------
 arch/mips/txx9/generic/mem_tx4938.c |  124 ------------------
 arch/mips/txx9/rbtx4927/prom.c      |    6 +-
 arch/mips/txx9/rbtx4938/prom.c      |    6 +-
 arch/mips/txx9/rbtx4938/setup.c     |   11 +-
 include/asm-mips/txx9/tx4927.h      |   48 +++++--
 include/asm-mips/txx9/tx4938.h      |  237 ++++------------------------------
 8 files changed, 86 insertions(+), 442 deletions(-)

diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index 668fdaa..ab274ed 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -5,7 +5,7 @@
 obj-y	+= setup.o
 obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o irq_tx4927.o
-obj-$(CONFIG_SOC_TX4938)	+= mem_tx4938.o irq_tx4938.o
+obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o irq_tx4938.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
 obj-$(CONFIG_KGDB)	+= dbgio.o
 
diff --git a/arch/mips/txx9/generic/mem_tx4927.c b/arch/mips/txx9/generic/mem_tx4927.c
index 12dfc37..ef6ea6e 100644
--- a/arch/mips/txx9/generic/mem_tx4927.c
+++ b/arch/mips/txx9/generic/mem_tx4927.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/mips/tx4927/common/tx4927_prom.c
+ * linux/arch/mips/txx9/generic/mem_tx4927.c
  *
  * common tx4927 memory interface
  *
@@ -32,8 +32,9 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/io.h>
+#include <asm/txx9/tx4927.h>
 
-static unsigned int __init tx4927_process_sdccr(unsigned long addr)
+static unsigned int __init tx4927_process_sdccr(u64 __iomem *addr)
 {
 	u64 val;
 	unsigned int sdccr_ce;
@@ -45,97 +46,32 @@ static unsigned int __init tx4927_process_sdccr(unsigned long addr)
 	unsigned int rs = 0;
 	unsigned int cs = 0;
 	unsigned int mw = 0;
-	unsigned int msize = 0;
 
-	val = __raw_readq((void __iomem *)addr);
+	val = __raw_readq(addr);
 
 	/* MVMCP -- need #defs for these bits masks */
 	sdccr_ce = ((val & (1 << 10)) >> 10);
 	sdccr_bs = ((val & (1 << 8)) >> 8);
 	sdccr_rs = ((val & (3 << 5)) >> 5);
-	sdccr_cs = ((val & (3 << 2)) >> 2);
+	sdccr_cs = ((val & (7 << 2)) >> 2);
 	sdccr_mw = ((val & (1 << 0)) >> 0);
 
 	if (sdccr_ce) {
-		switch (sdccr_bs) {
-		case 0:{
-				bs = 2;
-				break;
-			}
-		case 1:{
-				bs = 4;
-				break;
-			}
-		}
-		switch (sdccr_rs) {
-		case 0:{
-				rs = 2048;
-				break;
-			}
-		case 1:{
-				rs = 4096;
-				break;
-			}
-		case 2:{
-				rs = 8192;
-				break;
-			}
-		case 3:{
-				rs = 0;
-				break;
-			}
-		}
-		switch (sdccr_cs) {
-		case 0:{
-				cs = 256;
-				break;
-			}
-		case 1:{
-				cs = 512;
-				break;
-			}
-		case 2:{
-				cs = 1024;
-				break;
-			}
-		case 3:{
-				cs = 2048;
-				break;
-			}
-		}
-		switch (sdccr_mw) {
-		case 0:{
-				mw = 8;
-				break;
-			}	/* 8 bytes = 64 bits */
-		case 1:{
-				mw = 4;
-				break;
-			}	/* 4 bytes = 32 bits */
-		}
+		bs = 2 << sdccr_bs;
+		rs = 2048 << sdccr_rs;
+		cs = 256 << sdccr_cs;
+		mw = 8 >> sdccr_mw;
 	}
 
-	/*            bytes per chip     MB per chip      num chips */
-	msize = (((rs * cs * mw) / (1024 * 1024)) * bs);
-
-	return (msize);
+	return rs * cs * mw * bs;
 }
 
-
 unsigned int __init tx4927_get_mem_size(void)
 {
-	unsigned int c0;
-	unsigned int c1;
-	unsigned int c2;
-	unsigned int c3;
-	unsigned int total;
-
-	/* MVMCP -- need #defs for these registers */
-	c0 = tx4927_process_sdccr(0xff1f8000);
-	c1 = tx4927_process_sdccr(0xff1f8008);
-	c2 = tx4927_process_sdccr(0xff1f8010);
-	c3 = tx4927_process_sdccr(0xff1f8018);
-	total = c0 + c1 + c2 + c3;
+	unsigned int total = 0;
+	int i;
 
-	return (total);
+	for (i = 0; i < ARRAY_SIZE(tx4927_sdramcptr->cr); i++)
+		total += tx4927_process_sdccr(&tx4927_sdramcptr->cr[i]);
+	return total;
 }
diff --git a/arch/mips/txx9/generic/mem_tx4938.c b/arch/mips/txx9/generic/mem_tx4938.c
deleted file mode 100644
index 20baeae..0000000
--- a/arch/mips/txx9/generic/mem_tx4938.c
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- * linux/arch/mips/tx4938/common/prom.c
- *
- * common tx4938 memory interface
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
-static unsigned int __init
-tx4938_process_sdccr(u64 * addr)
-{
-	u64 val;
-	unsigned int sdccr_ce;
-	unsigned int sdccr_rs;
-	unsigned int sdccr_cs;
-	unsigned int sdccr_mw;
-	unsigned int rs = 0;
-	unsigned int cs = 0;
-	unsigned int mw = 0;
-	unsigned int bc = 4;
-	unsigned int msize = 0;
-
-	val = ____raw_readq((void __iomem *)addr);
-
-	/* MVMCP -- need #defs for these bits masks */
-	sdccr_ce = ((val & (1 << 10)) >> 10);
-	sdccr_rs = ((val & (3 << 5)) >> 5);
-	sdccr_cs = ((val & (7 << 2)) >> 2);
-	sdccr_mw = ((val & (1 << 0)) >> 0);
-
-	if (sdccr_ce) {
-		switch (sdccr_rs) {
-		case 0:{
-				rs = 2048;
-				break;
-			}
-		case 1:{
-				rs = 4096;
-				break;
-			}
-		case 2:{
-				rs = 8192;
-				break;
-			}
-		default:{
-				rs = 0;
-				break;
-			}
-		}
-		switch (sdccr_cs) {
-		case 0:{
-				cs = 256;
-				break;
-			}
-		case 1:{
-				cs = 512;
-				break;
-			}
-		case 2:{
-				cs = 1024;
-				break;
-			}
-		case 3:{
-				cs = 2048;
-				break;
-			}
-		case 4:{
-				cs = 4096;
-				break;
-			}
-		default:{
-				cs = 0;
-				break;
-			}
-		}
-		switch (sdccr_mw) {
-		case 0:{
-				mw = 8;
-				break;
-			}	/* 8 bytes = 64 bits */
-		case 1:{
-				mw = 4;
-				break;
-			}	/* 4 bytes = 32 bits */
-		}
-	}
-
-	/*           bytes per chip    MB per chip          bank count */
-	msize = (((rs * cs * mw) / (1024 * 1024)) * (bc));
-
-	/* MVMCP -- bc hard coded to 4 from table 9.3.1     */
-	/*          boad supports bc=2 but no way to detect */
-
-	return (msize);
-}
-
-unsigned int __init
-tx4938_get_mem_size(void)
-{
-	unsigned int c0;
-	unsigned int c1;
-	unsigned int c2;
-	unsigned int c3;
-	unsigned int total;
-
-	/* MVMCP -- need #defs for these registers */
-	c0 = tx4938_process_sdccr((u64 *) 0xff1f8000);
-	c1 = tx4938_process_sdccr((u64 *) 0xff1f8008);
-	c2 = tx4938_process_sdccr((u64 *) 0xff1f8010);
-	c3 = tx4938_process_sdccr((u64 *) 0xff1f8018);
-	total = c0 + c1 + c2 + c3;
-
-	return (total);
-}
diff --git a/arch/mips/txx9/rbtx4927/prom.c b/arch/mips/txx9/rbtx4927/prom.c
index 942e627..5c0de54 100644
--- a/arch/mips/txx9/rbtx4927/prom.c
+++ b/arch/mips/txx9/rbtx4927/prom.c
@@ -36,10 +36,6 @@
 
 void __init rbtx4927_prom_init(void)
 {
-	extern int tx4927_get_mem_size(void);
-	int msize;
-
 	prom_init_cmdline();
-	msize = tx4927_get_mem_size();
-	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
+	add_memory_region(0, tx4927_get_mem_size(), BOOT_MEM_RAM);
 }
diff --git a/arch/mips/txx9/rbtx4938/prom.c b/arch/mips/txx9/rbtx4938/prom.c
index fbb3745..ee18951 100644
--- a/arch/mips/txx9/rbtx4938/prom.c
+++ b/arch/mips/txx9/rbtx4938/prom.c
@@ -18,12 +18,8 @@
 
 void __init rbtx4938_prom_init(void)
 {
-	extern int tx4938_get_mem_size(void);
-	int msize;
 #ifndef CONFIG_TX4938_NAND_BOOT
 	prom_init_cmdline();
 #endif
-
-	msize = tx4938_get_mem_size();
-	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
+	add_memory_region(0, tx4938_get_mem_size(), BOOT_MEM_RAM);
 }
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index c2da923..c1e076c 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -310,7 +310,7 @@ void __init tx4938_board_setup(void)
 
 	printk(KERN_INFO "%s SDRAMC --", txx9_pcode_str);
 	for (i = 0; i < 4; i++) {
-		unsigned long long cr = tx4938_sdramcptr->cr[i];
+		u64 cr = TX4938_SDRAMC_CR(i);
 		unsigned long ram_base, ram_size;
 		if (!((unsigned long)cr & 0x00000400))
 			continue;	/* disabled */
@@ -318,20 +318,21 @@ void __init tx4938_board_setup(void)
 		ram_size = ((unsigned long)(cr >> 33) + 1) << 21;
 		if (ram_base >= 0x20000000)
 			continue;	/* high memory (ignore) */
-		printk(" CR%d:%016Lx", i, cr);
+		printk(KERN_CONT " CR%d:%016llx", i, cr);
 		tx4938_sdram_resource[i].name = "SDRAM";
 		tx4938_sdram_resource[i].start = ram_base;
 		tx4938_sdram_resource[i].end = ram_base + ram_size - 1;
 		tx4938_sdram_resource[i].flags = IORESOURCE_MEM;
 		request_resource(&iomem_resource, &tx4938_sdram_resource[i]);
 	}
-	printk(" TR:%09Lx\n", tx4938_sdramcptr->tr);
+	printk(KERN_CONT " TR:%09llx\n", ____raw_readq(&tx4938_sdramcptr->tr));
 
 	/* SRAM */
-	if (tx4938_sramcptr->cr & 1) {
+	if (____raw_readq(&tx4938_sramcptr->cr) & 1) {
 		unsigned int size = 0x800;
 		unsigned long base =
-			(tx4938_sramcptr->cr >> (39-11)) & ~(size - 1);
+			(____raw_readq(&tx4938_sramcptr->cr) >> (39-11))
+			& ~(size - 1);
 		tx4938_sram_resource.name = "SRAM";
 		tx4938_sram_resource.start = base;
 		tx4938_sram_resource.end = base + size - 1;
diff --git a/include/asm-mips/txx9/tx4927.h b/include/asm-mips/txx9/tx4927.h
index 46d60af..c921215 100644
--- a/include/asm-mips/txx9/tx4927.h
+++ b/include/asm-mips/txx9/tx4927.h
@@ -32,13 +32,20 @@
 #include <asm/txx9irq.h>
 #include <asm/txx9/tx4927pcic.h>
 
-#define TX4927_SDRAMC_REG	0xff1f8000
-#define TX4927_EBUSC_REG	0xff1f9000
-#define TX4927_PCIC_REG		0xff1fd000
-#define TX4927_CCFG_REG		0xff1fe000
-#define TX4927_IRC_REG		0xff1ff600
+#ifdef CONFIG_64BIT
+#define TX4927_REG_BASE	0xffffffffff1f0000UL
+#else
+#define TX4927_REG_BASE	0xff1f0000UL
+#endif
+#define TX4927_REG_SIZE	0x00010000
+
+#define TX4927_SDRAMC_REG	(TX4927_REG_BASE + 0x8000)
+#define TX4927_EBUSC_REG	(TX4927_REG_BASE + 0x9000)
+#define TX4927_PCIC_REG		(TX4927_REG_BASE + 0xd000)
+#define TX4927_CCFG_REG		(TX4927_REG_BASE + 0xe000)
+#define TX4927_IRC_REG		(TX4927_REG_BASE + 0xf600)
 #define TX4927_NR_TMR	3
-#define TX4927_TMR_REG(ch)	(0xff1ff000 + (ch) * 0x100)
+#define TX4927_TMR_REG(ch)	(TX4927_REG_BASE + 0xf000 + (ch) * 0x100)
 
 #define TX4927_IR_INT(n)	(2 + (n))
 #define TX4927_IR_SIO(n)	(8 + (n))
@@ -49,15 +56,15 @@
 #define TX4927_IRC_INT	2	/* IP[2] in Status register */
 
 struct tx4927_sdramc_reg {
-	volatile unsigned long long cr[4];
-	volatile unsigned long long unused0[4];
-	volatile unsigned long long tr;
-	volatile unsigned long long unused1[2];
-	volatile unsigned long long cmd;
+	u64 cr[4];
+	u64 unused0[4];
+	u64 tr;
+	u64 unused1[2];
+	u64 cmd;
 };
 
 struct tx4927_ebusc_reg {
-	volatile unsigned long long cr[8];
+	u64 cr[8];
 };
 
 struct tx4927_ccfg_reg {
@@ -160,12 +167,24 @@ struct tx4927_ccfg_reg {
 #define TX4927_CLKCTR_SIO0RST	0x00000002
 #define TX4927_CLKCTR_SIO1RST	0x00000001
 
-#define tx4927_sdramcptr	((struct tx4927_sdramc_reg *)TX4927_SDRAMC_REG)
+#define tx4927_sdramcptr \
+		((struct tx4927_sdramc_reg __iomem *)TX4927_SDRAMC_REG)
 #define tx4927_pcicptr \
 		((struct tx4927_pcic_reg __iomem *)TX4927_PCIC_REG)
 #define tx4927_ccfgptr \
 		((struct tx4927_ccfg_reg __iomem *)TX4927_CCFG_REG)
-#define tx4927_ebuscptr		((struct tx4927_ebusc_reg *)TX4927_EBUSC_REG)
+#define tx4927_ebuscptr \
+		((struct tx4927_ebusc_reg __iomem *)TX4927_EBUSC_REG)
+
+#define TX4927_SDRAMC_CR(ch)	__raw_readq(&tx4927_sdramcptr->cr[(ch)])
+#define TX4927_SDRAMC_BA(ch)	((TX4927_SDRAMC_CR(ch) >> 49) << 21)
+#define TX4927_SDRAMC_SIZE(ch)	\
+	((((TX4927_SDRAMC_CR(ch) >> 33) & 0x7fff) + 1) << 21)
+
+#define TX4927_EBUSC_CR(ch)	__raw_readq(&tx4927_ebuscptr->cr[(ch)])
+#define TX4927_EBUSC_BA(ch)	((TX4927_EBUSC_CR(ch) >> 48) << 20)
+#define TX4927_EBUSC_SIZE(ch)	\
+	(0x00100000 << ((unsigned long)(TX4927_EBUSC_CR(ch) >> 8) & 0xf))
 
 /* utilities */
 static inline void txx9_clear64(__u64 __iomem *adr, __u64 bits)
@@ -212,6 +231,7 @@ static inline void tx4927_ccfg_change(__u64 change, __u64 new)
 		       &tx4927_ccfgptr->ccfg);
 }
 
+unsigned int tx4927_get_mem_size(void);
 int tx4927_report_pciclk(void);
 int tx4927_pciclk66_setup(void);
 void tx4927_irq_init(void);
diff --git a/include/asm-mips/txx9/tx4938.h b/include/asm-mips/txx9/tx4938.h
index 12de68a..6690246 100644
--- a/include/asm-mips/txx9/tx4938.h
+++ b/include/asm-mips/txx9/tx4938.h
@@ -15,20 +15,11 @@
 /* some controllers are compatible with 4927 */
 #include <asm/txx9/tx4927.h>
 
-#define tx4938_read_nfmc(addr) (*(volatile unsigned int *)(addr))
-#define tx4938_write_nfmc(b, addr) (*(volatile unsigned int *)(addr)) = (b)
-
-#define TX4938_PCIIO_0 0x10000000
-#define TX4938_PCIIO_1 0x01010000
-#define TX4938_PCIMEM_0 0x08000000
-#define TX4938_PCIMEM_1 0x11000000
-
-#define TX4938_PCIIO_SIZE_0 0x01000000
-#define TX4938_PCIIO_SIZE_1 0x00010000
-#define TX4938_PCIMEM_SIZE_0 0x08000000
-#define TX4938_PCIMEM_SIZE_1 0x00010000
-
-#define TX4938_REG_BASE	0xff1f0000 /* == TX4937_REG_BASE */
+#ifdef CONFIG_64BIT
+#define TX4938_REG_BASE	0xffffffffff1f0000UL /* == TX4937_REG_BASE */
+#else
+#define TX4938_REG_BASE	0xff1f0000UL /* == TX4937_REG_BASE */
+#endif
 #define TX4938_REG_SIZE	0x00010000 /* == TX4937_REG_SIZE */
 
 /* NDFMC, SRAMC, PCIC1, SPIC: TX4938 only */
@@ -49,149 +40,8 @@
 #define TX4938_ACLC_REG		(TX4938_REG_BASE + 0xf700)
 #define TX4938_SPI_REG		(TX4938_REG_BASE + 0xf800)
 
-#define _CONST64(c)	c##ull
-
-#include <asm/byteorder.h>
-
-#ifdef __BIG_ENDIAN
-#define endian_def_l2(e1, e2)	\
-	volatile unsigned long e1, e2
-#define endian_def_s2(e1, e2)	\
-	volatile unsigned short e1, e2
-#define endian_def_sb2(e1, e2, e3)	\
-	volatile unsigned short e1;volatile unsigned char e2, e3
-#define endian_def_b2s(e1, e2, e3)	\
-	volatile unsigned char e1, e2;volatile unsigned short e3
-#define endian_def_b4(e1, e2, e3, e4)	\
-	volatile unsigned char e1, e2, e3, e4
-#else
-#define endian_def_l2(e1, e2)	\
-	volatile unsigned long e2, e1
-#define endian_def_s2(e1, e2)	\
-	volatile unsigned short e2, e1
-#define endian_def_sb2(e1, e2, e3)	\
-	volatile unsigned char e3, e2;volatile unsigned short e1
-#define endian_def_b2s(e1, e2, e3)	\
-	volatile unsigned short e3;volatile unsigned char e2, e1
-#define endian_def_b4(e1, e2, e3, e4)	\
-	volatile unsigned char e4, e3, e2, e1
-#endif
-
-
-struct tx4938_sdramc_reg {
-	volatile unsigned long long cr[4];
-	volatile unsigned long long unused0[4];
-	volatile unsigned long long tr;
-	volatile unsigned long long unused1[2];
-	volatile unsigned long long cmd;
-	volatile unsigned long long sfcmd;
-};
-
-struct tx4938_ebusc_reg {
-	volatile unsigned long long cr[8];
-};
-
-struct tx4938_dma_reg {
-	struct tx4938_dma_ch_reg {
-		volatile unsigned long long cha;
-		volatile unsigned long long sar;
-		volatile unsigned long long dar;
-		endian_def_l2(unused0, cntr);
-		endian_def_l2(unused1, sair);
-		endian_def_l2(unused2, dair);
-		endian_def_l2(unused3, ccr);
-		endian_def_l2(unused4, csr);
-	} ch[4];
-	volatile unsigned long long dbr[8];
-	volatile unsigned long long tdhr;
-	volatile unsigned long long midr;
-	endian_def_l2(unused0, mcr);
-};
-
-struct tx4938_aclc_reg {
-	volatile unsigned long acctlen;
-	volatile unsigned long acctldis;
-	volatile unsigned long acregacc;
-	volatile unsigned long unused0;
-	volatile unsigned long acintsts;
-	volatile unsigned long acintmsts;
-	volatile unsigned long acinten;
-	volatile unsigned long acintdis;
-	volatile unsigned long acsemaph;
-	volatile unsigned long unused1[7];
-	volatile unsigned long acgpidat;
-	volatile unsigned long acgpodat;
-	volatile unsigned long acslten;
-	volatile unsigned long acsltdis;
-	volatile unsigned long acfifosts;
-	volatile unsigned long unused2[11];
-	volatile unsigned long acdmasts;
-	volatile unsigned long acdmasel;
-	volatile unsigned long unused3[6];
-	volatile unsigned long acaudodat;
-	volatile unsigned long acsurrdat;
-	volatile unsigned long accentdat;
-	volatile unsigned long aclfedat;
-	volatile unsigned long acaudiat;
-	volatile unsigned long unused4;
-	volatile unsigned long acmodoat;
-	volatile unsigned long acmodidat;
-	volatile unsigned long unused5[15];
-	volatile unsigned long acrevid;
-};
-
-
-struct tx4938_tmr_reg {
-	volatile unsigned long tcr;
-	volatile unsigned long tisr;
-	volatile unsigned long cpra;
-	volatile unsigned long cprb;
-	volatile unsigned long itmr;
-	volatile unsigned long unused0[3];
-	volatile unsigned long ccdr;
-	volatile unsigned long unused1[3];
-	volatile unsigned long pgmr;
-	volatile unsigned long unused2[3];
-	volatile unsigned long wtmr;
-	volatile unsigned long unused3[43];
-	volatile unsigned long trr;
-};
-
-struct tx4938_sio_reg {
-	volatile unsigned long lcr;
-	volatile unsigned long dicr;
-	volatile unsigned long disr;
-	volatile unsigned long cisr;
-	volatile unsigned long fcr;
-	volatile unsigned long flcr;
-	volatile unsigned long bgr;
-	volatile unsigned long tfifo;
-	volatile unsigned long rfifo;
-};
-
-struct tx4938_ndfmc_reg {
-	endian_def_l2(unused0, dtr);
-	endian_def_l2(unused1, mcr);
-	endian_def_l2(unused2, sr);
-	endian_def_l2(unused3, isr);
-	endian_def_l2(unused4, imr);
-	endian_def_l2(unused5, spr);
-	endian_def_l2(unused6, rstr);
-};
-
-struct tx4938_spi_reg {
-	volatile unsigned long mcr;
-	volatile unsigned long cr0;
-	volatile unsigned long cr1;
-	volatile unsigned long fs;
-	volatile unsigned long unused1;
-	volatile unsigned long sr;
-	volatile unsigned long dr;
-	volatile unsigned long unused2;
-};
-
 struct tx4938_sramc_reg {
-	volatile unsigned long long cr;
+	u64 cr;
 };
 
 struct tx4938_ccfg_reg {
@@ -209,34 +59,6 @@ struct tx4938_ccfg_reg {
 	u64 jmpadr;
 };
 
-#undef endian_def_l2
-#undef endian_def_s2
-#undef endian_def_sb2
-#undef endian_def_b2s
-#undef endian_def_b4
-
-/*
- * NDFMC
- */
-
-/* NDFMCR : NDFMC Mode Control */
-#define TX4938_NDFMCR_WE	0x80
-#define TX4938_NDFMCR_ECC_ALL	0x60
-#define TX4938_NDFMCR_ECC_RESET	0x60
-#define TX4938_NDFMCR_ECC_READ	0x40
-#define TX4938_NDFMCR_ECC_ON	0x20
-#define TX4938_NDFMCR_ECC_OFF	0x00
-#define TX4938_NDFMCR_CE	0x10
-#define TX4938_NDFMCR_BSPRT	0x04
-#define TX4938_NDFMCR_ALE	0x02
-#define TX4938_NDFMCR_CLE	0x01
-
-/* NDFMCR : NDFMC Status */
-#define TX4938_NDFSR_BUSY	0x80
-
-/* NDFMCR : NDFMC Reset */
-#define TX4938_NDFRSTR_RST	0x01
-
 /*
  * IRC
  */
@@ -272,9 +94,9 @@ struct tx4938_ccfg_reg {
  * CCFG
  */
 /* CCFG : Chip Configuration */
-#define TX4938_CCFG_WDRST	_CONST64(0x0000020000000000)
-#define TX4938_CCFG_WDREXEN	_CONST64(0x0000010000000000)
-#define TX4938_CCFG_BCFG_MASK	_CONST64(0x000000ff00000000)
+#define TX4938_CCFG_WDRST	0x0000020000000000ULL
+#define TX4938_CCFG_WDREXEN	0x0000010000000000ULL
+#define TX4938_CCFG_BCFG_MASK	0x000000ff00000000ULL
 #define TX4938_CCFG_TINTDIS	0x01000000
 #define TX4938_CCFG_PCI66	0x00800000
 #define TX4938_CCFG_PCIMODE	0x00400000
@@ -310,12 +132,12 @@ struct tx4938_ccfg_reg {
 #define TX4938_CCFG_ACEHOLD	0x00000001
 
 /* PCFG : Pin Configuration */
-#define TX4938_PCFG_ETH0_SEL	_CONST64(0x8000000000000000)
-#define TX4938_PCFG_ETH1_SEL	_CONST64(0x4000000000000000)
-#define TX4938_PCFG_ATA_SEL	_CONST64(0x2000000000000000)
-#define TX4938_PCFG_ISA_SEL	_CONST64(0x1000000000000000)
-#define TX4938_PCFG_SPI_SEL	_CONST64(0x0800000000000000)
-#define TX4938_PCFG_NDF_SEL	_CONST64(0x0400000000000000)
+#define TX4938_PCFG_ETH0_SEL	0x8000000000000000ULL
+#define TX4938_PCFG_ETH1_SEL	0x4000000000000000ULL
+#define TX4938_PCFG_ATA_SEL	0x2000000000000000ULL
+#define TX4938_PCFG_ISA_SEL	0x1000000000000000ULL
+#define TX4938_PCFG_SPI_SEL	0x0800000000000000ULL
+#define TX4938_PCFG_NDF_SEL	0x0400000000000000ULL
 #define TX4938_PCFG_SDCLKDLY_MASK	0x30000000
 #define TX4938_PCFG_SDCLKDLY(d)	((d)<<28)
 #define TX4938_PCFG_SYSCLKEN	0x08000000
@@ -336,8 +158,8 @@ struct tx4938_ccfg_reg {
 #define TX4938_PCFG_DMASEL3_SIO0	0x00000008
 
 /* CLKCTR : Clock Control */
-#define TX4938_CLKCTR_NDFCKD	_CONST64(0x0001000000000000)
-#define TX4938_CLKCTR_NDFRST	_CONST64(0x0000000100000000)
+#define TX4938_CLKCTR_NDFCKD	0x0001000000000000ULL
+#define TX4938_CLKCTR_NDFRST	0x0000000100000000ULL
 #define TX4938_CLKCTR_ETH1CKD	0x80000000
 #define TX4938_CLKCTR_ETH0CKD	0x40000000
 #define TX4938_CLKCTR_SPICKD	0x20000000
@@ -424,20 +246,16 @@ struct tx4938_ccfg_reg {
 #define TX4938_DMA_CSR_DESERR	0x00000002
 #define TX4938_DMA_CSR_SORERR	0x00000001
 
-#define tx4938_sdramcptr	((struct tx4938_sdramc_reg *)TX4938_SDRAMC_REG)
-#define tx4938_ebuscptr         ((struct tx4938_ebusc_reg *)TX4938_EBUSC_REG)
-#define tx4938_dmaptr(ch)	((struct tx4938_dma_reg *)TX4938_DMA_REG(ch))
-#define tx4938_ndfmcptr		((struct tx4938_ndfmc_reg *)TX4938_NDFMC_REG)
+#define tx4938_sdramcptr	tx4927_sdramcptr
+#define tx4938_ebuscptr		tx4927_ebuscptr
 #define tx4938_pcicptr		tx4927_pcicptr
 #define tx4938_pcic1ptr \
 		((struct tx4927_pcic_reg __iomem *)TX4938_PCIC1_REG)
 #define tx4938_ccfgptr \
 		((struct tx4938_ccfg_reg __iomem *)TX4938_CCFG_REG)
-#define tx4938_sioptr(ch)	((struct tx4938_sio_reg *)TX4938_SIO_REG(ch))
 #define tx4938_pioptr		((struct txx9_pio_reg __iomem *)TX4938_PIO_REG)
-#define tx4938_aclcptr		((struct tx4938_aclc_reg *)TX4938_ACLC_REG)
-#define tx4938_spiptr		((struct tx4938_spi_reg *)TX4938_SPI_REG)
-#define tx4938_sramcptr		((struct tx4938_sramc_reg *)TX4938_SRAMC_REG)
+#define tx4938_sramcptr \
+		((struct tx4938_sramc_reg __iomem *)TX4938_SRAMC_REG)
 
 
 #define TX4938_REV_PCODE()	\
@@ -447,14 +265,15 @@ struct tx4938_ccfg_reg {
 #define tx4938_ccfg_set(bits)	tx4927_ccfg_set(bits)
 #define tx4938_ccfg_change(change, new)	tx4927_ccfg_change(change, new)
 
-#define TX4938_SDRAMC_BA(ch)	((tx4938_sdramcptr->cr[ch] >> 49) << 21)
-#define TX4938_SDRAMC_SIZE(ch)	(((tx4938_sdramcptr->cr[ch] >> 33) + 1) << 21)
+#define TX4938_SDRAMC_CR(ch)	TX4927_SDRAMC_CR(ch)
+#define TX4938_SDRAMC_BA(ch)	TX4927_SDRAMC_BA(ch)
+#define TX4938_SDRAMC_SIZE(ch)	TX4927_SDRAMC_SIZE(ch)
 
-#define TX4938_EBUSC_CR(ch)	__raw_readq(&tx4938_ebuscptr->cr[(ch)])
-#define TX4938_EBUSC_BA(ch)	((tx4938_ebuscptr->cr[ch] >> 48) << 20)
-#define TX4938_EBUSC_SIZE(ch)	\
-	(0x00100000 << ((unsigned long)(tx4938_ebuscptr->cr[ch] >> 8) & 0xf))
+#define TX4938_EBUSC_CR(ch)	TX4927_EBUSC_CR(ch)
+#define TX4938_EBUSC_BA(ch)	TX4927_EBUSC_BA(ch)
+#define TX4938_EBUSC_SIZE(ch)	TX4927_EBUSC_SIZE(ch)
 
+#define tx4938_get_mem_size() tx4927_get_mem_size()
 int tx4938_report_pciclk(void);
 void tx4938_report_pci1clk(void);
 int tx4938_pciclk66_setup(void);
