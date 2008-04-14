Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 13:48:23 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:39667 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023615AbYDNMsU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Apr 2008 13:48:20 +0100
Received: from localhost (p6040-ipad303funabasi.chiba.ocn.ne.jp [123.217.152.40])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F0E59AA61; Mon, 14 Apr 2008 21:48:12 +0900 (JST)
Date:	Mon, 14 Apr 2008 21:49:07 +0900 (JST)
Message-Id: <20080414.214907.07642439.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rbtx4938: misc cleanups
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
X-archive-position: 18909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Do not use non-standard I/O accessors, such as reg_rd08, etc.
* Kill unnecessary wbflush()
* Kill tx4938_mips.h
* Kill unnecessary includes

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Patch against linux-queue tree.

 arch/mips/tx4938/common/dbgio.c           |    4 +-
 arch/mips/tx4938/common/prom.c            |   11 +----
 arch/mips/tx4938/toshiba_rbtx4938/irq.c   |   46 ++++----------------
 arch/mips/tx4938/toshiba_rbtx4938/setup.c |   66 +++++++++++++----------------
 include/asm-mips/tx4938/rbtx4938.h        |   58 +++++++++----------------
 include/asm-mips/tx4938/tx4938.h          |   24 ----------
 include/asm-mips/tx4938/tx4938_mips.h     |   54 -----------------------
 7 files changed, 63 insertions(+), 200 deletions(-)

diff --git a/arch/mips/tx4938/common/dbgio.c b/arch/mips/tx4938/common/dbgio.c
index bea59ff..33b9c67 100644
--- a/arch/mips/tx4938/common/dbgio.c
+++ b/arch/mips/tx4938/common/dbgio.c
@@ -31,9 +31,7 @@
  * Support for TX4938 in 2.6 - Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
  */
 
-#include <asm/mipsregs.h>
-#include <asm/system.h>
-#include <asm/tx4938/tx4938_mips.h>
+#include <linux/types>
 
 extern u8 txx9_sio_kdbg_rd(void);
 extern int txx9_sio_kdbg_wr( u8 ch );
diff --git a/arch/mips/tx4938/common/prom.c b/arch/mips/tx4938/common/prom.c
index 3189a65..20baeae 100644
--- a/arch/mips/tx4938/common/prom.c
+++ b/arch/mips/tx4938/common/prom.c
@@ -13,13 +13,8 @@
  */
 
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
-#include <asm/tx4938/tx4938.h>
+#include <linux/types.h>
+#include <linux/io.h>
 
 static unsigned int __init
 tx4938_process_sdccr(u64 * addr)
@@ -35,7 +30,7 @@ tx4938_process_sdccr(u64 * addr)
 	unsigned int bc = 4;
 	unsigned int msize = 0;
 
-	val = (*((vu64 *) (addr)));
+	val = ____raw_readq((void __iomem *)addr);
 
 	/* MVMCP -- need #defs for these bits masks */
 	sdccr_ce = ((val & (1 << 10)) >> 10);
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/irq.c b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
index f001850..4d6a8dc 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/irq.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/irq.c
@@ -67,24 +67,7 @@ IRQ  Device
 63 RBTX4938-IOC/07 SWINT
 */
 #include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/ioport.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/timex.h>
-#include <asm/bootinfo.h>
-#include <asm/page.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
-#include <asm/time.h>
-#include <asm/wbflush.h>
-#include <linux/bootmem.h>
 #include <asm/tx4938/rbtx4938.h>
 
 static void toshiba_rbtx4938_irq_ioc_enable(unsigned int irq);
@@ -99,21 +82,16 @@ static struct irq_chip toshiba_rbtx4938_irq_ioc_type = {
 	.unmask = toshiba_rbtx4938_irq_ioc_enable,
 };
 
-#define TOSHIBA_RBTX4938_IOC_INTR_ENAB 0xb7f02000
-#define TOSHIBA_RBTX4938_IOC_INTR_STAT 0xb7f0200a
-
 int
 toshiba_rbtx4938_irq_nested(int sw_irq)
 {
 	u8 level3;
 
-	level3 = reg_rd08(TOSHIBA_RBTX4938_IOC_INTR_STAT) & 0xff;
-	if (level3) {
+	level3 = readb(rbtx4938_imstat_addr);
+	if (level3)
 		/* must use fls so onboard ATA has priority */
 		sw_irq = TOSHIBA_RBTX4938_IRQ_IOC_BEG + fls(level3) - 1;
-	}
 
-	wbflush();
 	return sw_irq;
 }
 
@@ -144,25 +122,23 @@ toshiba_rbtx4938_irq_ioc_init(void)
 static void
 toshiba_rbtx4938_irq_ioc_enable(unsigned int irq)
 {
-	volatile unsigned char v;
+	unsigned char v;
 
-	v = TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
+	v = readb(rbtx4938_imask_addr);
 	v |= (1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
-	TX4938_WR08(TOSHIBA_RBTX4938_IOC_INTR_ENAB, v);
+	writeb(v, rbtx4938_imask_addr);
 	mmiowb();
-	TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
 }
 
 static void
 toshiba_rbtx4938_irq_ioc_disable(unsigned int irq)
 {
-	volatile unsigned char v;
+	unsigned char v;
 
-	v = TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
+	v = readb(rbtx4938_imask_addr);
 	v &= ~(1 << (irq - TOSHIBA_RBTX4938_IRQ_IOC_BEG));
-	TX4938_WR08(TOSHIBA_RBTX4938_IOC_INTR_ENAB, v);
+	writeb(v, rbtx4938_imask_addr);
 	mmiowb();
-	TX4938_RD08(TOSHIBA_RBTX4938_IOC_INTR_ENAB);
 }
 
 void __init arch_init_irq(void)
@@ -174,14 +150,12 @@ void __init arch_init_irq(void)
 	/* all IRC interrupt mode are Low Active. */
 
 	/* mask all IOC interrupts */
-	*rbtx4938_imask_ptr = 0;
+	writeb(0, rbtx4938_imask_addr);
 
 	/* clear SoftInt interrupts */
-	*rbtx4938_softint_ptr = 0;
+	writeb(0, rbtx4938_softint_addr);
 	tx4938_irq_init();
 	toshiba_rbtx4938_irq_ioc_init();
 	/* Onboard 10M Ether: High Active */
 	set_irq_type(RBTX4938_IRQ_ETHER, IRQF_TRIGGER_HIGH);
-
-	wbflush();
 }
diff --git a/arch/mips/tx4938/toshiba_rbtx4938/setup.c b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
index b38ea5a..2fbf7d4 100644
--- a/arch/mips/tx4938/toshiba_rbtx4938/setup.c
+++ b/arch/mips/tx4938/toshiba_rbtx4938/setup.c
@@ -23,7 +23,6 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 
-#include <asm/wbflush.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/txx9tmr.h>
@@ -91,12 +90,11 @@ void rbtx4938_machine_restart(char *command)
 	local_irq_disable();
 
 	printk("Rebooting...");
-	*rbtx4938_softresetlock_ptr = 1;
-	*rbtx4938_sfvol_ptr = 1;
-	*rbtx4938_softreset_ptr = 1;
-	wbflush();
-
-	while(1);
+	writeb(1, rbtx4938_softresetlock_addr);
+	writeb(1, rbtx4938_sfvol_addr);
+	writeb(1, rbtx4938_softreset_addr);
+	while(1)
+		;
 }
 
 void __init
@@ -488,7 +486,7 @@ static int __init tx4938_pcibios_init(void)
 	}
 
 	/* Reset PCI Bus */
-	*rbtx4938_pcireset_ptr = 0;
+	writeb(0, rbtx4938_pcireset_addr);
 	/* Reset PCIC */
 	tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIRST;
 	if (txboard_pci66_mode > 0)
@@ -496,8 +494,8 @@ static int __init tx4938_pcibios_init(void)
 	mdelay(10);
 	/* clear PCIC reset */
 	tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIRST;
-	*rbtx4938_pcireset_ptr = 1;
-	wbflush();
+	writeb(1, rbtx4938_pcireset_addr);
+	mmiowb();
 	tx4938_report_pcic_status1(tx4938_pcicptr);
 
 	tx4938_report_pciclk();
@@ -505,15 +503,15 @@ static int __init tx4938_pcibios_init(void)
 	if (txboard_pci66_mode == 0 &&
 	    txboard_pci66_check(&tx4938_pci_controller[0], 0, 0)) {
 		/* Reset PCI Bus */
-		*rbtx4938_pcireset_ptr = 0;
+		writeb(0, rbtx4938_pcireset_addr);
 		/* Reset PCIC */
 		tx4938_ccfgptr->clkctr |= TX4938_CLKCTR_PCIRST;
 		tx4938_pciclk66_setup();
 		mdelay(10);
 		/* clear PCIC reset */
 		tx4938_ccfgptr->clkctr &= ~TX4938_CLKCTR_PCIRST;
-		*rbtx4938_pcireset_ptr = 1;
-		wbflush();
+		writeb(1, rbtx4938_pcireset_addr);
+		mmiowb();
 		/* Reinitialize PCIC */
 		tx4938_report_pciclk();
 		tx4938_pcic_setup(tx4938_pcicptr, &tx4938_pci_controller[0], io_base[0], extarb);
@@ -774,8 +772,9 @@ void __init tx4938_board_setup(void)
 		txx9_tmr_init(TX4938_TMR_REG(i) & 0xfffffffffULL);
 
 	/* enable DMA */
-	TX4938_WR64(0xff1fb150, TX4938_DMA_MCR_MSTEN);
-	TX4938_WR64(0xff1fb950, TX4938_DMA_MCR_MSTEN);
+	for (i = 0; i < 2; i++)
+		____raw_writeq(TX4938_DMA_MCR_MSTEN,
+			       (void __iomem *)(TX4938_DMA_REG(i) + 0x50));
 
 	/* PIO */
 	__raw_writel(0, &tx4938_pioptr->maskcpu);
@@ -861,10 +860,6 @@ void __init plat_mem_setup(void)
 	if (txx9_master_clock == 0)
 		txx9_master_clock = 25000000; /* 25MHz */
 	tx4938_board_setup();
-	/* setup serial stuff */
-	TX4938_WR(0xff1ff314, 0x00000000);	/* h/w flow control off */
-	TX4938_WR(0xff1ff414, 0x00000000);	/* h/w flow control off */
-
 #ifndef CONFIG_PCI
 	set_io_port_base(RBTX4938_ETHER_BASE);
 #endif
@@ -930,16 +925,16 @@ void __init plat_mem_setup(void)
 	pcfg = tx4938_ccfgptr->pcfg;	/* updated */
 	/* fixup piosel */
 	if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
-	    TX4938_PCFG_ATA_SEL) {
-		*rbtx4938_piosel_ptr = (*rbtx4938_piosel_ptr & 0x03) | 0x04;
-	}
+	    TX4938_PCFG_ATA_SEL)
+		writeb((readb(rbtx4938_piosel_addr) & 0x03) | 0x04,
+		       rbtx4938_piosel_addr);
 	else if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
-	    TX4938_PCFG_NDF_SEL) {
-		*rbtx4938_piosel_ptr = (*rbtx4938_piosel_ptr & 0x03) | 0x08;
-	}
-	else {
-		*rbtx4938_piosel_ptr &= ~(0x08 | 0x04);
-	}
+		 TX4938_PCFG_NDF_SEL)
+		writeb((readb(rbtx4938_piosel_addr) & 0x03) | 0x08,
+		       rbtx4938_piosel_addr);
+	else
+		writeb(readb(rbtx4938_piosel_addr) & ~(0x08 | 0x04),
+		       rbtx4938_piosel_addr);
 
 	rbtx4938_fpga_resource.name = "FPGA Registers";
 	rbtx4938_fpga_resource.start = CPHYSADDR(RBTX4938_FPGA_REG_ADDR);
@@ -948,17 +943,14 @@ void __init plat_mem_setup(void)
 	if (request_resource(&iomem_resource, &rbtx4938_fpga_resource))
 		printk("request resource for fpga failed\n");
 
-	/* disable all OnBoard I/O interrupts */
-	*rbtx4938_imask_ptr = 0;
-
 	_machine_restart = rbtx4938_machine_restart;
 	_machine_halt = rbtx4938_machine_halt;
 	pm_power_off = rbtx4938_machine_power_off;
 
-	*rbtx4938_led_ptr = 0xff;
-	printk("RBTX4938 --- FPGA(Rev %02x)", *rbtx4938_fpga_rev_ptr);
-	printk(" DIPSW:%02x,%02x\n",
-	       *rbtx4938_dipsw_ptr, *rbtx4938_bdipsw_ptr);
+	writeb(0xff, rbtx4938_led_addr);
+	printk(KERN_INFO "RBTX4938 --- FPGA(Rev %02x) DIPSW:%02x,%02x\n",
+	       readb(rbtx4938_fpga_rev_addr),
+	       readb(rbtx4938_dipsw_addr), readb(rbtx4938_bdipsw_addr));
 }
 
 static int __init rbtx4938_ne_init(void)
@@ -1000,12 +992,12 @@ static void rbtx4938_spi_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	u8 val;
 	unsigned long flags;
 	spin_lock_irqsave(&rbtx4938_spi_gpio_lock, flags);
-	val = *rbtx4938_spics_ptr;
+	val = readb(rbtx4938_spics_addr);
 	if (value)
 		val |= 1 << offset;
 	else
 		val &= ~(1 << offset);
-	*rbtx4938_spics_ptr = val;
+	writeb(val, rbtx4938_spics_addr);
 	mmiowb();
 	spin_unlock_irqrestore(&rbtx4938_spi_gpio_lock, flags);
 }
diff --git a/include/asm-mips/tx4938/rbtx4938.h b/include/asm-mips/tx4938/rbtx4938.h
index b180488..dfed7be 100644
--- a/include/asm-mips/tx4938/rbtx4938.h
+++ b/include/asm-mips/tx4938/rbtx4938.h
@@ -67,44 +67,26 @@
 #define RBTX4938_INTF_MODEM	(1 << RBTX4938_INTB_MODEM)
 #define RBTX4938_INTF_SWINT	(1 << RBTX4938_INTB_SWINT)
 
-#define rbtx4938_fpga_rev_ptr	\
-	((volatile unsigned char *)RBTX4938_FPGA_REV_ADDR)
-#define rbtx4938_led_ptr	\
-	((volatile unsigned char *)RBTX4938_LED_ADDR)
-#define rbtx4938_dipsw_ptr	\
-	((volatile unsigned char *)RBTX4938_DIPSW_ADDR)
-#define rbtx4938_bdipsw_ptr	\
-	((volatile unsigned char *)RBTX4938_BDIPSW_ADDR)
-#define rbtx4938_imask_ptr	\
-	((volatile unsigned char *)RBTX4938_IMASK_ADDR)
-#define rbtx4938_imask2_ptr	\
-	((volatile unsigned char *)RBTX4938_IMASK2_ADDR)
-#define rbtx4938_intpol_ptr	\
-	((volatile unsigned char *)RBTX4938_INTPOL_ADDR)
-#define rbtx4938_istat_ptr	\
-	((volatile unsigned char *)RBTX4938_ISTAT_ADDR)
-#define rbtx4938_istat2_ptr	\
-	((volatile unsigned char *)RBTX4938_ISTAT2_ADDR)
-#define rbtx4938_imstat_ptr	\
-	((volatile unsigned char *)RBTX4938_IMSTAT_ADDR)
-#define rbtx4938_imstat2_ptr	\
-	((volatile unsigned char *)RBTX4938_IMSTAT2_ADDR)
-#define rbtx4938_softint_ptr	\
-	((volatile unsigned char *)RBTX4938_SOFTINT_ADDR)
-#define rbtx4938_piosel_ptr	\
-	((volatile unsigned char *)RBTX4938_PIOSEL_ADDR)
-#define rbtx4938_spics_ptr	\
-	((volatile unsigned char *)RBTX4938_SPICS_ADDR)
-#define rbtx4938_sfpwr_ptr	\
-	((volatile unsigned char *)RBTX4938_SFPWR_ADDR)
-#define rbtx4938_sfvol_ptr	\
-	((volatile unsigned char *)RBTX4938_SFVOL_ADDR)
-#define rbtx4938_softreset_ptr	\
-	((volatile unsigned char *)RBTX4938_SOFTRESET_ADDR)
-#define rbtx4938_softresetlock_ptr	\
-	((volatile unsigned char *)RBTX4938_SOFTRESETLOCK_ADDR)
-#define rbtx4938_pcireset_ptr	\
-	((volatile unsigned char *)RBTX4938_PCIRESET_ADDR)
+#define rbtx4938_fpga_rev_addr	((__u8 __iomem *)RBTX4938_FPGA_REV_ADDR)
+#define rbtx4938_led_addr	((__u8 __iomem *)RBTX4938_LED_ADDR)
+#define rbtx4938_dipsw_addr	((__u8 __iomem *)RBTX4938_DIPSW_ADDR)
+#define rbtx4938_bdipsw_addr	((__u8 __iomem *)RBTX4938_BDIPSW_ADDR)
+#define rbtx4938_imask_addr	((__u8 __iomem *)RBTX4938_IMASK_ADDR)
+#define rbtx4938_imask2_addr	((__u8 __iomem *)RBTX4938_IMASK2_ADDR)
+#define rbtx4938_intpol_addr	((__u8 __iomem *)RBTX4938_INTPOL_ADDR)
+#define rbtx4938_istat_addr	((__u8 __iomem *)RBTX4938_ISTAT_ADDR)
+#define rbtx4938_istat2_addr	((__u8 __iomem *)RBTX4938_ISTAT2_ADDR)
+#define rbtx4938_imstat_addr	((__u8 __iomem *)RBTX4938_IMSTAT_ADDR)
+#define rbtx4938_imstat2_addr	((__u8 __iomem *)RBTX4938_IMSTAT2_ADDR)
+#define rbtx4938_softint_addr	((__u8 __iomem *)RBTX4938_SOFTINT_ADDR)
+#define rbtx4938_piosel_addr	((__u8 __iomem *)RBTX4938_PIOSEL_ADDR)
+#define rbtx4938_spics_addr	((__u8 __iomem *)RBTX4938_SPICS_ADDR)
+#define rbtx4938_sfpwr_addr	((__u8 __iomem *)RBTX4938_SFPWR_ADDR)
+#define rbtx4938_sfvol_addr	((__u8 __iomem *)RBTX4938_SFVOL_ADDR)
+#define rbtx4938_softreset_addr	((__u8 __iomem *)RBTX4938_SOFTRESET_ADDR)
+#define rbtx4938_softresetlock_addr	\
+				((__u8 __iomem *)RBTX4938_SOFTRESETLOCK_ADDR)
+#define rbtx4938_pcireset_addr	((__u8 __iomem *)RBTX4938_PCIRESET_ADDR)
 
 /*
  * IRQ mappings
diff --git a/include/asm-mips/tx4938/tx4938.h b/include/asm-mips/tx4938/tx4938.h
index a05f031..e8807f5 100644
--- a/include/asm-mips/tx4938/tx4938.h
+++ b/include/asm-mips/tx4938/tx4938.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_TX_BOARDS_TX4938_H
 #define __ASM_TX_BOARDS_TX4938_H
 
-#include <asm/tx4938/tx4938_mips.h>
-
 #define tx4938_read_nfmc(addr) (*(volatile unsigned int *)(addr))
 #define tx4938_write_nfmc(b, addr) (*(volatile unsigned int *)(addr)) = (b)
 
@@ -54,28 +52,6 @@
 #define TX4938_ACLC_REG		(TX4938_REG_BASE + 0xf700)
 #define TX4938_SPI_REG		(TX4938_REG_BASE + 0xf800)
 
-#ifndef _LANGUAGE_ASSEMBLY
-#include <asm/byteorder.h>
-
-#define TX4938_MKA(x) ((u32)( ((u32)(TX4938_REG_BASE)) | ((u32)(x)) ))
-
-#define TX4938_RD08( reg      )   (*(vu08*)(reg))
-#define TX4938_WR08( reg, val )  ((*(vu08*)(reg))=(val))
-
-#define TX4938_RD16( reg      )   (*(vu16*)(reg))
-#define TX4938_WR16( reg, val )  ((*(vu16*)(reg))=(val))
-
-#define TX4938_RD32( reg      )   (*(vu32*)(reg))
-#define TX4938_WR32( reg, val )  ((*(vu32*)(reg))=(val))
-
-#define TX4938_RD64( reg      )   (*(vu64*)(reg))
-#define TX4938_WR64( reg, val )  ((*(vu64*)(reg))=(val))
-
-#define TX4938_RD( reg      ) TX4938_RD32( reg )
-#define TX4938_WR( reg, val ) TX4938_WR32( reg, val )
-
-#endif /* !__ASSEMBLY__ */
-
 #ifdef __ASSEMBLY__
 #define _CONST64(c)	c
 #else
diff --git a/include/asm-mips/tx4938/tx4938_mips.h b/include/asm-mips/tx4938/tx4938_mips.h
deleted file mode 100644
index f346ff5..0000000
--- a/include/asm-mips/tx4938/tx4938_mips.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * linux/include/asm-mips/tx4938/tx4938_mips.h
- * Generic bitmask definitions
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-
-#ifndef TX4938_TX4938_MIPS_H
-#define TX4938_TX4938_MIPS_H
-#ifndef __ASSEMBLY__
-
-#define reg_rd08(r)    ((u8 )(*((vu8 *)(r))))
-#define reg_rd16(r)    ((u16)(*((vu16*)(r))))
-#define reg_rd32(r)    ((u32)(*((vu32*)(r))))
-#define reg_rd64(r)    ((u64)(*((vu64*)(r))))
-
-#define reg_wr08(r, v)  ((*((vu8 *)(r)))=((u8 )(v)))
-#define reg_wr16(r, v)  ((*((vu16*)(r)))=((u16)(v)))
-#define reg_wr32(r, v)  ((*((vu32*)(r)))=((u32)(v)))
-#define reg_wr64(r, v)  ((*((vu64*)(r)))=((u64)(v)))
-
-typedef volatile __signed char vs8;
-typedef volatile unsigned char vu8;
-
-typedef volatile __signed short vs16;
-typedef volatile unsigned short vu16;
-
-typedef volatile __signed int vs32;
-typedef volatile unsigned int vu32;
-
-typedef s8 s08;
-typedef vs8 vs08;
-
-typedef u8 u08;
-typedef vu8 vu08;
-
-#if (_MIPS_SZLONG == 64)
-
-typedef volatile __signed__ long vs64;
-typedef volatile unsigned long vu64;
-
-#else
-
-typedef volatile __signed__ long long vs64;
-typedef volatile unsigned long long vu64;
-
-#endif
-#endif
-#endif
