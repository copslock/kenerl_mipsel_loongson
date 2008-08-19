Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:59:24 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:9169 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580945AbYHSNz0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:26 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id B55A4C231; Tue, 19 Aug 2008 22:55:17 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 07/14] TXx9: Add mtd support
Date:	Tue, 19 Aug 2008 22:55:11 +0900
Message-Id: <1219154118-21193-7-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add helper routines to register physmap-flash platform devices for NOR
flashes.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c        |   41 +++++++++++++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx3927.c |   14 +++++++++++
 arch/mips/txx9/generic/setup_tx4927.c |   14 +++++++++++
 arch/mips/txx9/generic/setup_tx4938.c |   14 +++++++++++
 arch/mips/txx9/jmr3927/setup.c        |    9 +++++++
 arch/mips/txx9/rbtx4927/setup.c       |    9 +++++++
 arch/mips/txx9/rbtx4938/setup.c       |   38 ++++++++++++++++++++++++++++++
 include/asm-mips/txx9/generic.h       |    4 +++
 include/asm-mips/txx9/tx3927.h        |    2 +
 include/asm-mips/txx9/tx4927.h        |    3 ++
 include/asm-mips/txx9/tx4938.h        |    2 +
 11 files changed, 150 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 7021215..a471a28 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
+#include <linux/mtd/physmap.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/reboot.h>
@@ -592,3 +593,43 @@ static unsigned long __swizzle_addr_none(unsigned long port)
 unsigned long (*__swizzle_addr_b)(unsigned long port) = __swizzle_addr_none;
 EXPORT_SYMBOL(__swizzle_addr_b);
 #endif
+
+void __init txx9_physmap_flash_init(int no, unsigned long addr,
+				    unsigned long size,
+				    const struct physmap_flash_data *pdata)
+{
+#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
+	struct resource res = {
+		.start = addr,
+		.end = addr + size - 1,
+		.flags = IORESOURCE_MEM,
+	};
+	struct platform_device *pdev;
+#ifdef CONFIG_MTD_PARTITIONS
+	static struct mtd_partition parts[2];
+	struct physmap_flash_data pdata_part;
+
+	/* If this area contained boot area, make separate partition */
+	if (pdata->nr_parts == 0 && !pdata->parts &&
+	    addr < 0x1fc00000 && addr + size > 0x1fc00000 &&
+	    !parts[0].name) {
+		parts[0].name = "boot";
+		parts[0].offset = 0x1fc00000 - addr;
+		parts[0].size = addr + size - 0x1fc00000;
+		parts[1].name = "user";
+		parts[1].offset = 0;
+		parts[1].size = 0x1fc00000 - addr;
+		pdata_part = *pdata;
+		pdata_part.nr_parts = ARRAY_SIZE(parts);
+		pdata_part.parts = parts;
+		pdata = &pdata_part;
+	}
+#endif
+	pdev = platform_device_alloc("physmap-flash", no);
+	if (!pdev ||
+	    platform_device_add_resources(pdev, &res, 1) ||
+	    platform_device_add_data(pdev, pdata, sizeof(*pdata)) ||
+	    platform_device_add(pdev))
+		platform_device_put(pdev);
+#endif
+}
diff --git a/arch/mips/txx9/generic/setup_tx3927.c b/arch/mips/txx9/generic/setup_tx3927.c
index 06c4925..9505d58 100644
--- a/arch/mips/txx9/generic/setup_tx3927.c
+++ b/arch/mips/txx9/generic/setup_tx3927.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/param.h>
 #include <linux/io.h>
+#include <linux/mtd/physmap.h>
 #include <asm/mipsregs.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
@@ -121,3 +122,16 @@ void __init tx3927_sio_init(unsigned int sclk, unsigned int cts_mask)
 			      TXX9_IRQ_BASE + TX3927_IR_SIO(i),
 			      i, sclk, (1 << i) & cts_mask);
 }
+
+void __init tx3927_mtd_init(int ch)
+{
+	struct physmap_flash_data pdata = {
+		.width = TX3927_ROMC_WIDTH(ch) / 8,
+	};
+	unsigned long start = txx9_ce_res[ch].start;
+	unsigned long size = txx9_ce_res[ch].end - start + 1;
+
+	if (!(tx3927_romcptr->cr[ch] & 0x8))
+		return;	/* disabled */
+	txx9_physmap_flash_init(ch, start, size, &pdata);
+}
diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index e679c79..0840ef9 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -14,6 +14,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/param.h>
+#include <linux/mtd/physmap.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
@@ -187,3 +188,16 @@ void __init tx4927_sio_init(unsigned int sclk, unsigned int cts_mask)
 			      TXX9_IRQ_BASE + TX4927_IR_SIO(i),
 			      i, sclk, (1 << i) & cts_mask);
 }
+
+void __init tx4927_mtd_init(int ch)
+{
+	struct physmap_flash_data pdata = {
+		.width = TX4927_EBUSC_WIDTH(ch) / 8,
+	};
+	unsigned long start = txx9_ce_res[ch].start;
+	unsigned long size = txx9_ce_res[ch].end - start + 1;
+
+	if (!(TX4927_EBUSC_CR(ch) & 0x8))
+		return;	/* disabled */
+	txx9_physmap_flash_init(ch, start, size, &pdata);
+}
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index 95c058f..630a7aa 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -14,6 +14,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/param.h>
+#include <linux/mtd/physmap.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
@@ -269,3 +270,16 @@ void __init tx4938_ethaddr_init(unsigned char *addr0, unsigned char *addr1)
 	if (addr1 && (pcfg & TX4938_PCFG_ETH1_SEL))
 		txx9_ethaddr_init(TXX9_IRQ_BASE + TX4938_IR_ETH1, addr1);
 }
+
+void __init tx4938_mtd_init(int ch)
+{
+	struct physmap_flash_data pdata = {
+		.width = TX4938_EBUSC_WIDTH(ch) / 8,
+	};
+	unsigned long start = txx9_ce_res[ch].start;
+	unsigned long size = txx9_ce_res[ch].end - start + 1;
+
+	if (!(TX4938_EBUSC_CR(ch) & 0x8))
+		return;	/* disabled */
+	txx9_physmap_flash_init(ch, start, size, &pdata);
+}
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 2e40a92..0f3843c 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -190,11 +190,20 @@ static void __init jmr3927_rtc_init(void)
 	platform_device_register_simple("rtc-ds1742", -1, &res, 1);
 }
 
+static void __init jmr3927_mtd_init(void)
+{
+	int i;
+
+	for (i = 0; i < 2; i++)
+		tx3927_mtd_init(i);
+}
+
 static void __init jmr3927_device_init(void)
 {
 	__swizzle_addr_b = jmr3927_swizzle_addr_b;
 	jmr3927_rtc_init();
 	tx3927_wdt_init();
+	jmr3927_mtd_init();
 }
 
 struct txx9_board_vec jmr3927_vec __initdata = {
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 0464a39..abe32c1 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -307,11 +307,20 @@ static void __init rbtx4927_ne_init(void)
 	platform_device_register_simple("ne", -1, res, ARRAY_SIZE(res));
 }
 
+static void __init rbtx4927_mtd_init(void)
+{
+	int i;
+
+	for (i = 0; i < 2; i++)
+		tx4927_mtd_init(i);
+}
+
 static void __init rbtx4927_device_init(void)
 {
 	toshiba_rbtx4927_rtc_init();
 	rbtx4927_ne_init();
 	tx4927_wdt_init();
+	rbtx4927_mtd_init();
 }
 
 struct txx9_board_vec rbtx4927_vec __initdata = {
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 9ab48de..e7bc5b8 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/mtd/physmap.h>
 
 #include <asm/reboot.h>
 #include <asm/io.h>
@@ -294,6 +295,42 @@ static int __init rbtx4938_spi_init(void)
 	return 0;
 }
 
+static void __init rbtx4938_mtd_init(void)
+{
+	struct physmap_flash_data pdata = {
+		.width = 4,
+	};
+
+	switch (readb(rbtx4938_bdipsw_addr) & 7) {
+	case 0:
+		/* Boot */
+		txx9_physmap_flash_init(0, 0x1fc00000, 0x400000, &pdata);
+		/* System */
+		txx9_physmap_flash_init(1, 0x1e000000, 0x1000000, &pdata);
+		break;
+	case 1:
+		/* System */
+		txx9_physmap_flash_init(0, 0x1f000000, 0x1000000, &pdata);
+		/* Boot */
+		txx9_physmap_flash_init(1, 0x1ec00000, 0x400000, &pdata);
+		break;
+	case 2:
+		/* Ext */
+		txx9_physmap_flash_init(0, 0x1f000000, 0x1000000, &pdata);
+		/* System */
+		txx9_physmap_flash_init(1, 0x1e000000, 0x1000000, &pdata);
+		/* Boot */
+		txx9_physmap_flash_init(2, 0x1dc00000, 0x400000, &pdata);
+		break;
+	case 3:
+		/* Boot */
+		txx9_physmap_flash_init(1, 0x1bc00000, 0x400000, &pdata);
+		/* System */
+		txx9_physmap_flash_init(2, 0x1a000000, 0x1000000, &pdata);
+		break;
+	}
+}
+
 static void __init rbtx4938_arch_init(void)
 {
 	gpiochip_add(&rbtx4938_spi_gpio_chip);
@@ -306,6 +343,7 @@ static void __init rbtx4938_device_init(void)
 	rbtx4938_ethaddr_init();
 	rbtx4938_ne_init();
 	tx4938_wdt_init();
+	rbtx4938_mtd_init();
 }
 
 struct txx9_board_vec rbtx4938_vec __initdata = {
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index 0a225bf..1982c44 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -59,4 +59,8 @@ static inline void txx9_sio_putchar_init(unsigned long baseaddr)
 }
 #endif
 
+struct physmap_flash_data;
+void txx9_physmap_flash_init(int no, unsigned long addr, unsigned long size,
+			     const struct physmap_flash_data *pdata);
+
 #endif /* __ASM_TXX9_GENERIC_H */
diff --git a/include/asm-mips/txx9/tx3927.h b/include/asm-mips/txx9/tx3927.h
index 587deb9..dc30c8d 100644
--- a/include/asm-mips/txx9/tx3927.h
+++ b/include/asm-mips/txx9/tx3927.h
@@ -325,6 +325,7 @@ struct tx3927_ccfg_reg {
 #define TX3927_ROMC_BA(ch)	(tx3927_romcptr->cr[(ch)] & 0xfff00000)
 #define TX3927_ROMC_SIZE(ch)	\
 	(0x00100000 << ((tx3927_romcptr->cr[(ch)] >> 8) & 0xf))
+#define TX3927_ROMC_WIDTH(ch)	(32 >> ((tx3927_romcptr->cr[(ch)] >> 7) & 0x1))
 
 void tx3927_wdt_init(void);
 void tx3927_setup(void);
@@ -335,5 +336,6 @@ void tx3927_pcic_setup(struct pci_controller *channel,
 		       unsigned long sdram_size, int extarb);
 void tx3927_setup_pcierr_irq(void);
 void tx3927_irq_init(void);
+void tx3927_mtd_init(int ch);
 
 #endif /* __ASM_TXX9_TX3927_H */
diff --git a/include/asm-mips/txx9/tx4927.h b/include/asm-mips/txx9/tx4927.h
index 195f651..36a9241 100644
--- a/include/asm-mips/txx9/tx4927.h
+++ b/include/asm-mips/txx9/tx4927.h
@@ -196,6 +196,8 @@ struct tx4927_ccfg_reg {
 #define TX4927_EBUSC_BA(ch)	((TX4927_EBUSC_CR(ch) >> 48) << 20)
 #define TX4927_EBUSC_SIZE(ch)	\
 	(0x00100000 << ((unsigned long)(TX4927_EBUSC_CR(ch) >> 8) & 0xf))
+#define TX4927_EBUSC_WIDTH(ch)	\
+	(64 >> ((__u32)(TX4927_EBUSC_CR(ch) >> 20) & 0x3))
 
 /* utilities */
 static inline void txx9_clear64(__u64 __iomem *adr, __u64 bits)
@@ -251,5 +253,6 @@ int tx4927_report_pciclk(void);
 int tx4927_pciclk66_setup(void);
 void tx4927_setup_pcierr_irq(void);
 void tx4927_irq_init(void);
+void tx4927_mtd_init(int ch);
 
 #endif /* __ASM_TXX9_TX4927_H */
diff --git a/include/asm-mips/txx9/tx4938.h b/include/asm-mips/txx9/tx4938.h
index 8175d4c..989e775 100644
--- a/include/asm-mips/txx9/tx4938.h
+++ b/include/asm-mips/txx9/tx4938.h
@@ -274,6 +274,7 @@ struct tx4938_ccfg_reg {
 #define TX4938_EBUSC_CR(ch)	TX4927_EBUSC_CR(ch)
 #define TX4938_EBUSC_BA(ch)	TX4927_EBUSC_BA(ch)
 #define TX4938_EBUSC_SIZE(ch)	TX4927_EBUSC_SIZE(ch)
+#define TX4938_EBUSC_WIDTH(ch)	TX4927_EBUSC_WIDTH(ch)
 
 #define tx4938_get_mem_size() tx4927_get_mem_size()
 void tx4938_wdt_init(void);
@@ -289,5 +290,6 @@ struct pci_dev;
 int tx4938_pcic1_map_irq(const struct pci_dev *dev, u8 slot);
 void tx4938_setup_pcierr_irq(void);
 void tx4938_irq_init(void);
+void tx4938_mtd_init(int ch);
 
 #endif
-- 
1.5.6.3
