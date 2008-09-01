Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2008 14:24:24 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:37085 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20032689AbYIANWo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2008 14:22:44 +0100
Received: from localhost.localdomain (p5198-ipad203funabasi.chiba.ocn.ne.jp [222.146.84.198])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6A6ACB646; Mon,  1 Sep 2008 22:22:39 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 5/6] TXx9: Add RBTX4939 board support
Date:	Mon,  1 Sep 2008 22:22:40 +0900
Message-Id: <1220275361-5001-5-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Makefile               |    8 +-
 arch/mips/txx9/Kconfig           |    8 +
 arch/mips/txx9/generic/setup.c   |    5 +
 arch/mips/txx9/rbtx4939/Makefile |    3 +
 arch/mips/txx9/rbtx4939/irq.c    |   96 ++++++++++++
 arch/mips/txx9/rbtx4939/prom.c   |   17 ++
 arch/mips/txx9/rbtx4939/setup.c  |  306 ++++++++++++++++++++++++++++++++++++++
 include/asm-mips/txx9/boards.h   |    3 +
 include/asm-mips/txx9/rbtx4939.h |  133 +++++++++++++++++
 9 files changed, 573 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/txx9/rbtx4939/Makefile
 create mode 100644 arch/mips/txx9/rbtx4939/irq.c
 create mode 100644 arch/mips/txx9/rbtx4939/prom.c
 create mode 100644 arch/mips/txx9/rbtx4939/setup.c
 create mode 100644 include/asm-mips/txx9/rbtx4939.h

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9aab51c..87f6722 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -567,15 +567,11 @@ cflags-$(CONFIG_MIKROTIK_RB532) += -Iinclude/asm-mips/mach-rc32434
 load-$(CONFIG_MIKROTIK_RB532)	+= 0xffffffff80101000
 
 #
-# Toshiba RBTX4927 board or
-# Toshiba RBTX4937 board
+# Toshiba RBTX49XX boards
 #
 core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/txx9/rbtx4927/
-
-#
-# Toshiba RBTX4938 board
-#
 core-$(CONFIG_TOSHIBA_RBTX4938) += arch/mips/txx9/rbtx4938/
+core-$(CONFIG_TOSHIBA_RBTX4939) += arch/mips/txx9/rbtx4939/
 
 cflags-y			+= -Iinclude/asm-mips/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 58691a1..17052db 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -45,6 +45,14 @@ config TOSHIBA_RBTX4938
 	  This Toshiba board is based on the TX4938 processor. Say Y here to
 	  support this machine type
 
+config TOSHIBA_RBTX4939
+	bool "Toshiba RBTX4939 bobard"
+	depends on MACH_TX49XX
+	select SOC_TX4939
+	help
+	  This Toshiba board is based on the TX4939 processor. Say Y here to
+	  support this machine type
+
 config SOC_TX3927
 	bool
 	select CEVT_TXX9
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index b25b479..8731e16 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -371,6 +371,11 @@ static void __init select_board(void)
 		txx9_board_vec = &rbtx4938_vec;
 		break;
 #endif
+#ifdef CONFIG_TOSHIBA_RBTX4939
+	case 0x4939:
+		txx9_board_vec = &rbtx4939_vec;
+		break;
+#endif
 	}
 #endif
 }
diff --git a/arch/mips/txx9/rbtx4939/Makefile b/arch/mips/txx9/rbtx4939/Makefile
new file mode 100644
index 0000000..3232cd0
--- /dev/null
+++ b/arch/mips/txx9/rbtx4939/Makefile
@@ -0,0 +1,3 @@
+obj-y	 += irq.o setup.o prom.o
+
+EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/txx9/rbtx4939/irq.c b/arch/mips/txx9/rbtx4939/irq.c
new file mode 100644
index 0000000..500cc0a
--- /dev/null
+++ b/arch/mips/txx9/rbtx4939/irq.c
@@ -0,0 +1,96 @@
+/*
+ * Toshiba RBTX4939 interrupt routines
+ * Based on linux/arch/mips/txx9/rbtx4938/irq.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * Copyright (C) 2000-2001,2005-2006 Toshiba Corporation
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <asm/mipsregs.h>
+#include <asm/txx9/rbtx4939.h>
+
+/*
+ * RBTX4939 IOC controller definition
+ */
+
+static void rbtx4939_ioc_irq_unmask(unsigned int irq)
+{
+	int ioc_nr = irq - RBTX4939_IRQ_IOC;
+
+	writeb(readb(rbtx4939_ien_addr) | (1 << ioc_nr), rbtx4939_ien_addr);
+}
+
+static void rbtx4939_ioc_irq_mask(unsigned int irq)
+{
+	int ioc_nr = irq - RBTX4939_IRQ_IOC;
+
+	writeb(readb(rbtx4939_ien_addr) & ~(1 << ioc_nr), rbtx4939_ien_addr);
+	mmiowb();
+}
+
+static struct irq_chip rbtx4939_ioc_irq_chip = {
+	.name		= "IOC",
+	.ack		= rbtx4939_ioc_irq_mask,
+	.mask		= rbtx4939_ioc_irq_mask,
+	.mask_ack	= rbtx4939_ioc_irq_mask,
+	.unmask		= rbtx4939_ioc_irq_unmask,
+};
+
+
+static inline int rbtx4939_ioc_irqroute(void)
+{
+	unsigned char istat = readb(rbtx4939_ifac2_addr);
+
+	if (unlikely(istat == 0))
+		return -1;
+	return RBTX4939_IRQ_IOC + __fls8(istat);
+}
+
+static int rbtx4939_irq_dispatch(int pending)
+{
+	int irq;
+
+	if (pending & CAUSEF_IP7)
+		return MIPS_CPU_IRQ_BASE + 7;
+	irq = tx4939_irq();
+	if (likely(irq >= 0)) {
+		/* redirect IOC interrupts */
+		switch (irq) {
+		case RBTX4939_IRQ_IOCINT:
+			irq = rbtx4939_ioc_irqroute();
+			break;
+		}
+	} else if (pending & CAUSEF_IP0)
+		irq = MIPS_CPU_IRQ_BASE + 0;
+	else if (pending & CAUSEF_IP1)
+		irq = MIPS_CPU_IRQ_BASE + 1;
+	else
+		irq = -1;
+	return irq;
+}
+
+void __init rbtx4939_irq_setup(void)
+{
+	int i;
+
+	/* mask all IOC interrupts */
+	writeb(0, rbtx4939_ien_addr);
+
+	/* clear SoftInt interrupts */
+	writeb(0, rbtx4939_softint_addr);
+
+	txx9_irq_dispatch = rbtx4939_irq_dispatch;
+
+	tx4939_irq_init();
+	for (i = RBTX4939_IRQ_IOC;
+	     i < RBTX4939_IRQ_IOC + RBTX4939_NR_IRQ_IOC; i++)
+		set_irq_chip_and_handler(i, &rbtx4939_ioc_irq_chip,
+					 handle_level_irq);
+
+	set_irq_chained_handler(RBTX4939_IRQ_IOCINT, handle_simple_irq);
+}
diff --git a/arch/mips/txx9/rbtx4939/prom.c b/arch/mips/txx9/rbtx4939/prom.c
new file mode 100644
index 0000000..bd277ec
--- /dev/null
+++ b/arch/mips/txx9/rbtx4939/prom.c
@@ -0,0 +1,17 @@
+/*
+ * rbtx4939 specific prom routines
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/init.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/rbtx4939.h>
+
+void __init rbtx4939_prom_init(void)
+{
+	tx4939_add_memory_regions();
+	txx9_sio_putchar_init(TX4939_SIO_REG(0) & 0xfffffffffULL);
+}
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
new file mode 100644
index 0000000..277864d
--- /dev/null
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -0,0 +1,306 @@
+/*
+ * Toshiba RBTX4939 setup routines.
+ * Based on linux/arch/mips/txx9/rbtx4938/setup.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * Copyright (C) 2000-2001,2005-2007 Toshiba Corporation
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <asm/reboot.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/pci.h>
+#include <asm/txx9/rbtx4939.h>
+
+static void rbtx4939_machine_restart(char *command)
+{
+	local_irq_disable();
+	writeb(1, rbtx4939_reseten_addr);
+	writeb(1, rbtx4939_softreset_addr);
+	while (1)
+		;
+}
+
+static void __init rbtx4939_time_init(void)
+{
+	tx4939_time_init(0);
+}
+
+static void __init rbtx4939_pci_setup(void)
+{
+#ifdef CONFIG_PCI
+	int extarb = !(__raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_PCIARB);
+	struct pci_controller *c = &txx9_primary_pcic;
+
+	register_pci_controller(c);
+
+	tx4939_report_pciclk();
+	tx4927_pcic_setup(tx4939_pcicptr, c, extarb);
+	if (!(__raw_readq(&tx4939_ccfgptr->pcfg) & TX4939_PCFG_ATA1MODE) &&
+	    (__raw_readq(&tx4939_ccfgptr->pcfg) &
+	     (TX4939_PCFG_ET0MODE | TX4939_PCFG_ET1MODE))) {
+		tx4939_report_pci1clk();
+
+		/* mem:64K(max), io:64K(max) (enough for ETH0,ETH1) */
+		c = txx9_alloc_pci_controller(NULL, 0, 0x10000, 0, 0x10000);
+		register_pci_controller(c);
+		tx4927_pcic_setup(tx4939_pcic1ptr, c, 0);
+	}
+
+	tx4939_setup_pcierr_irq();
+#endif /* CONFIG_PCI */
+}
+
+static unsigned long long default_ebccr[] __initdata = {
+	0x01c0000000007608ULL, /* 64M ROM */
+	0x017f000000007049ULL, /* 1M IOC */
+	0x0180000000408608ULL, /* ISA */
+	0,
+};
+
+static void __init rbtx4939_ebusc_setup(void)
+{
+	int i;
+	unsigned int sp;
+
+	/* use user-configured speed */
+	sp = TX4939_EBUSC_CR(0) & 0x30;
+	default_ebccr[0] |= sp;
+	default_ebccr[1] |= sp;
+	default_ebccr[2] |= sp;
+	/* initialise by myself */
+	for (i = 0; i < ARRAY_SIZE(default_ebccr); i++) {
+		if (default_ebccr[i])
+			____raw_writeq(default_ebccr[i],
+				       &tx4939_ebuscptr->cr[i]);
+		else
+			____raw_writeq(____raw_readq(&tx4939_ebuscptr->cr[i])
+				       & ~8,
+				       &tx4939_ebuscptr->cr[i]);
+	}
+}
+
+static void __init rbtx4939_update_ioc_pen(void)
+{
+	__u64 pcfg = ____raw_readq(&tx4939_ccfgptr->pcfg);
+	__u64 ccfg = ____raw_readq(&tx4939_ccfgptr->ccfg);
+	__u8 pe1 = readb(rbtx4939_pe1_addr);
+	__u8 pe2 = readb(rbtx4939_pe2_addr);
+	__u8 pe3 = readb(rbtx4939_pe3_addr);
+	if (pcfg & TX4939_PCFG_ATA0MODE)
+		pe1 |= RBTX4939_PE1_ATA(0);
+	else
+		pe1 &= ~RBTX4939_PE1_ATA(0);
+	if (pcfg & TX4939_PCFG_ATA1MODE) {
+		pe1 |= RBTX4939_PE1_ATA(1);
+		pe1 &= ~(RBTX4939_PE1_RMII(0) | RBTX4939_PE1_RMII(1));
+	} else {
+		pe1 &= ~RBTX4939_PE1_ATA(1);
+		if (pcfg & TX4939_PCFG_ET0MODE)
+			pe1 |= RBTX4939_PE1_RMII(0);
+		else
+			pe1 &= ~RBTX4939_PE1_RMII(0);
+		if (pcfg & TX4939_PCFG_ET1MODE)
+			pe1 |= RBTX4939_PE1_RMII(1);
+		else
+			pe1 &= ~RBTX4939_PE1_RMII(1);
+	}
+	if (ccfg & TX4939_CCFG_PTSEL)
+		pe3 &= ~(RBTX4939_PE3_VP | RBTX4939_PE3_VP_P |
+			 RBTX4939_PE3_VP_S);
+	else {
+		__u64 vmode = pcfg &
+			(TX4939_PCFG_VSSMODE | TX4939_PCFG_VPSMODE);
+		if (vmode == 0)
+			pe3 &= ~(RBTX4939_PE3_VP | RBTX4939_PE3_VP_P |
+				 RBTX4939_PE3_VP_S);
+		else if (vmode == TX4939_PCFG_VPSMODE) {
+			pe3 |= RBTX4939_PE3_VP_P;
+			pe3 &= ~(RBTX4939_PE3_VP | RBTX4939_PE3_VP_S);
+		} else if (vmode == TX4939_PCFG_VSSMODE) {
+			pe3 |= RBTX4939_PE3_VP | RBTX4939_PE3_VP_S;
+			pe3 &= ~RBTX4939_PE3_VP_P;
+		} else {
+			pe3 |= RBTX4939_PE3_VP | RBTX4939_PE3_VP_P;
+			pe3 &= ~RBTX4939_PE3_VP_S;
+		}
+	}
+	if (pcfg & TX4939_PCFG_SPIMODE) {
+		if (pcfg & TX4939_PCFG_SIO2MODE_GPIO)
+			pe2 &= ~(RBTX4939_PE2_SIO2 | RBTX4939_PE2_SIO0);
+		else {
+			if (pcfg & TX4939_PCFG_SIO2MODE_SIO2) {
+				pe2 |= RBTX4939_PE2_SIO2;
+				pe2 &= ~RBTX4939_PE2_SIO0;
+			} else {
+				pe2 |= RBTX4939_PE2_SIO0;
+				pe2 &= ~RBTX4939_PE2_SIO2;
+			}
+		}
+		if (pcfg & TX4939_PCFG_SIO3MODE)
+			pe2 |= RBTX4939_PE2_SIO3;
+		else
+			pe2 &= ~RBTX4939_PE2_SIO3;
+		pe2 &= ~RBTX4939_PE2_SPI;
+	} else {
+		pe2 |= RBTX4939_PE2_SPI;
+		pe2 &= ~(RBTX4939_PE2_SIO3 | RBTX4939_PE2_SIO2 |
+			 RBTX4939_PE2_SIO0);
+	}
+	if ((pcfg & TX4939_PCFG_I2SMODE_MASK) == TX4939_PCFG_I2SMODE_GPIO)
+		pe2 |= RBTX4939_PE2_GPIO;
+	else
+		pe2 &= ~RBTX4939_PE2_GPIO;
+	writeb(pe1, rbtx4939_pe1_addr);
+	writeb(pe2, rbtx4939_pe2_addr);
+	writeb(pe3, rbtx4939_pe3_addr);
+}
+
+#define RBTX4939_MAX_7SEGLEDS	8
+
+#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+static u8 led_val[RBTX4939_MAX_7SEGLEDS];
+struct rbtx4939_led_data {
+	struct led_classdev cdev;
+	char name[32];
+	unsigned int num;
+};
+
+/* Use "dot" in 7seg LEDs */
+static void rbtx4939_led_brightness_set(struct led_classdev *led_cdev,
+					enum led_brightness value)
+{
+	struct rbtx4939_led_data *led_dat =
+		container_of(led_cdev, struct rbtx4939_led_data, cdev);
+	unsigned int num = led_dat->num;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	led_val[num] = (led_val[num] & 0x7f) | (value ? 0x80 : 0);
+	writeb(led_val[num], rbtx4939_7seg_addr(num / 4, num % 4));
+	local_irq_restore(flags);
+}
+
+static int __init rbtx4939_led_probe(struct platform_device *pdev)
+{
+	struct rbtx4939_led_data *leds_data;
+	int i;
+	static char *default_triggers[] __initdata = {
+		"heartbeat",
+		"ide-disk",
+		"nand-disk",
+	};
+
+	leds_data = kzalloc(sizeof(*leds_data) * RBTX4939_MAX_7SEGLEDS,
+			    GFP_KERNEL);
+	if (!leds_data)
+		return -ENOMEM;
+	for (i = 0; i < RBTX4939_MAX_7SEGLEDS; i++) {
+		int rc;
+		struct rbtx4939_led_data *led_dat = &leds_data[i];
+
+		led_dat->num = i;
+		led_dat->cdev.brightness_set = rbtx4939_led_brightness_set;
+		sprintf(led_dat->name, "rbtx4939:amber:%u", i);
+		led_dat->cdev.name = led_dat->name;
+		if (i < ARRAY_SIZE(default_triggers))
+			led_dat->cdev.default_trigger = default_triggers[i];
+		rc = led_classdev_register(&pdev->dev, &led_dat->cdev);
+		if (rc < 0)
+			return rc;
+		led_dat->cdev.brightness_set(&led_dat->cdev, 0);
+	}
+	return 0;
+
+}
+
+static struct platform_driver rbtx4939_led_driver = {
+	.driver  = {
+		.name = "rbtx4939-led",
+		.owner = THIS_MODULE,
+	},
+};
+
+static void __init rbtx4939_led_setup(void)
+{
+	platform_device_register_simple("rbtx4939-led", -1, NULL, 0);
+	platform_driver_probe(&rbtx4939_led_driver, rbtx4939_led_probe);
+}
+#else
+static inline void rbtx4939_led_setup(void)
+{
+}
+#endif
+
+static void __init rbtx4939_arch_init(void)
+{
+	rbtx4939_pci_setup();
+}
+
+static void __init rbtx4939_device_init(void)
+{
+#if defined(CONFIG_TC35815) || defined(CONFIG_TC35815_MODULE)
+	int i, j;
+	unsigned char ethaddr[2][6];
+	for (i = 0; i < 2; i++) {
+		unsigned long area = CKSEG1 + 0x1fff0000 + (i * 0x10);
+		if (readb(rbtx4939_bdipsw_addr) & 8) {
+			u16 buf[3];
+			area -= 0x03000000;
+			for (j = 0; j < 3; j++)
+				buf[j] = le16_to_cpup((u16 *)(area + j * 2));
+			memcpy(ethaddr[i], buf, 6);
+		} else
+			memcpy(ethaddr[i], (void *)area, 6);
+	}
+	tx4939_ethaddr_init(ethaddr[0], ethaddr[1]);
+#endif
+	rbtx4939_led_setup();
+	tx4939_wdt_init();
+}
+
+static void __init rbtx4939_setup(void)
+{
+	rbtx4939_ebusc_setup();
+	/* always enable ATA0 */
+	txx9_set64(&tx4939_ccfgptr->pcfg, TX4939_PCFG_ATA0MODE);
+	rbtx4939_update_ioc_pen();
+	if (txx9_master_clock == 0)
+		txx9_master_clock = 20000000;
+	tx4939_setup();
+
+	_machine_restart = rbtx4939_machine_restart;
+
+	pr_info("RBTX4939 (Rev %02x) --- FPGA(Rev %02x) DIPSW:%02x,%02x\n",
+		readb(rbtx4939_board_rev_addr), readb(rbtx4939_ioc_rev_addr),
+		readb(rbtx4939_udipsw_addr), readb(rbtx4939_bdipsw_addr));
+
+#ifdef CONFIG_PCI
+	txx9_alloc_pci_controller(&txx9_primary_pcic, 0, 0, 0, 0);
+	txx9_board_pcibios_setup = tx4927_pcibios_setup;
+#else
+	set_io_port_base(RBTX4939_ETHER_BASE);
+#endif
+
+	tx4939_sio_init(TX4939_SCLK0(txx9_master_clock), 0);
+}
+
+struct txx9_board_vec rbtx4939_vec __initdata = {
+	.system = "Tothiba RBTX4939",
+	.prom_init = rbtx4939_prom_init,
+	.mem_setup = rbtx4939_setup,
+	.irq_setup = rbtx4939_irq_setup,
+	.time_init = rbtx4939_time_init,
+	.device_init = rbtx4939_device_init,
+	.arch_init = rbtx4939_arch_init,
+#ifdef CONFIG_PCI
+	.pci_map_irq = tx4939_pci_map_irq,
+#endif
+};
diff --git a/include/asm-mips/txx9/boards.h b/include/asm-mips/txx9/boards.h
index 4abc814..cbe9476 100644
--- a/include/asm-mips/txx9/boards.h
+++ b/include/asm-mips/txx9/boards.h
@@ -8,3 +8,6 @@ BOARD_VEC(rbtx4937_vec)
 #ifdef CONFIG_TOSHIBA_RBTX4938
 BOARD_VEC(rbtx4938_vec)
 #endif
+#ifdef CONFIG_TOSHIBA_RBTX4939
+BOARD_VEC(rbtx4939_vec)
+#endif
diff --git a/include/asm-mips/txx9/rbtx4939.h b/include/asm-mips/txx9/rbtx4939.h
new file mode 100644
index 0000000..1acf428
--- /dev/null
+++ b/include/asm-mips/txx9/rbtx4939.h
@@ -0,0 +1,133 @@
+/*
+ * Definitions for RBTX4939
+ *
+ * (C) Copyright TOSHIBA CORPORATION 2005-2006
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __ASM_TXX9_RBTX4939_H
+#define __ASM_TXX9_RBTX4939_H
+
+#include <asm/addrspace.h>
+#include <asm/txx9irq.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/tx4939.h>
+
+/* Address map */
+#define RBTX4939_IOC_REG_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000000)
+#define RBTX4939_BOARD_REV_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000000)
+#define RBTX4939_IOC_REV_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000002)
+#define RBTX4939_CONFIG1_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000004)
+#define RBTX4939_CONFIG2_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000006)
+#define RBTX4939_CONFIG3_ADDR	(IO_BASE + TXX9_CE(1) + 0x00000008)
+#define RBTX4939_CONFIG4_ADDR	(IO_BASE + TXX9_CE(1) + 0x0000000a)
+#define RBTX4939_USTAT_ADDR	(IO_BASE + TXX9_CE(1) + 0x00001000)
+#define RBTX4939_UDIPSW_ADDR	(IO_BASE + TXX9_CE(1) + 0x00001002)
+#define RBTX4939_BDIPSW_ADDR	(IO_BASE + TXX9_CE(1) + 0x00001004)
+#define RBTX4939_IEN_ADDR	(IO_BASE + TXX9_CE(1) + 0x00002000)
+#define RBTX4939_IPOL_ADDR	(IO_BASE + TXX9_CE(1) + 0x00002002)
+#define RBTX4939_IFAC1_ADDR	(IO_BASE + TXX9_CE(1) + 0x00002004)
+#define RBTX4939_IFAC2_ADDR	(IO_BASE + TXX9_CE(1) + 0x00002006)
+#define RBTX4939_SOFTINT_ADDR	(IO_BASE + TXX9_CE(1) + 0x00003000)
+#define RBTX4939_ISASTAT_ADDR	(IO_BASE + TXX9_CE(1) + 0x00004000)
+#define RBTX4939_PCISTAT_ADDR	(IO_BASE + TXX9_CE(1) + 0x00004002)
+#define RBTX4939_ROME_ADDR	(IO_BASE + TXX9_CE(1) + 0x00004004)
+#define RBTX4939_SPICS_ADDR	(IO_BASE + TXX9_CE(1) + 0x00004006)
+#define RBTX4939_AUDI_ADDR	(IO_BASE + TXX9_CE(1) + 0x00004008)
+#define RBTX4939_ISAGPIO_ADDR	(IO_BASE + TXX9_CE(1) + 0x0000400a)
+#define RBTX4939_PE1_ADDR	(IO_BASE + TXX9_CE(1) + 0x00005000)
+#define RBTX4939_PE2_ADDR	(IO_BASE + TXX9_CE(1) + 0x00005002)
+#define RBTX4939_PE3_ADDR	(IO_BASE + TXX9_CE(1) + 0x00005004)
+#define RBTX4939_VP_ADDR	(IO_BASE + TXX9_CE(1) + 0x00005006)
+#define RBTX4939_VPRESET_ADDR	(IO_BASE + TXX9_CE(1) + 0x00005008)
+#define RBTX4939_VPSOUT_ADDR	(IO_BASE + TXX9_CE(1) + 0x0000500a)
+#define RBTX4939_VPSIN_ADDR	(IO_BASE + TXX9_CE(1) + 0x0000500c)
+#define RBTX4939_7SEG_ADDR(s, ch)	\
+	(IO_BASE + TXX9_CE(1) + 0x00006000 + (s) * 16 + ((ch) & 3) * 2)
+#define RBTX4939_SOFTRESET_ADDR	(IO_BASE + TXX9_CE(1) + 0x00007000)
+#define RBTX4939_RESETEN_ADDR	(IO_BASE + TXX9_CE(1) + 0x00007002)
+#define RBTX4939_RESETSTAT_ADDR	(IO_BASE + TXX9_CE(1) + 0x00007004)
+#define RBTX4939_ETHER_BASE	(IO_BASE + TXX9_CE(1) + 0x00020000)
+
+/* Ethernet port address */
+#define RBTX4939_ETHER_ADDR	(RBTX4939_ETHER_BASE + 0x300)
+
+/* bits for IEN/IPOL/IFAC */
+#define RBTX4938_INTB_ISA0	0
+#define RBTX4938_INTB_ISA11	1
+#define RBTX4938_INTB_ISA12	2
+#define RBTX4938_INTB_ISA15	3
+#define RBTX4938_INTB_I2S	4
+#define RBTX4938_INTB_SW	5
+#define RBTX4938_INTF_ISA0	(1 << RBTX4938_INTB_ISA0)
+#define RBTX4938_INTF_ISA11	(1 << RBTX4938_INTB_ISA11)
+#define RBTX4938_INTF_ISA12	(1 << RBTX4938_INTB_ISA12)
+#define RBTX4938_INTF_ISA15	(1 << RBTX4938_INTB_ISA15)
+#define RBTX4938_INTF_I2S	(1 << RBTX4938_INTB_I2S)
+#define RBTX4938_INTF_SW	(1 << RBTX4938_INTB_SW)
+
+/* bits for PE1,PE2,PE3 */
+#define RBTX4939_PE1_ATA(ch)	(0x01 << (ch))
+#define RBTX4939_PE1_RMII(ch)	(0x04 << (ch))
+#define RBTX4939_PE2_SIO0	0x01
+#define RBTX4939_PE2_SIO2	0x02
+#define RBTX4939_PE2_SIO3	0x04
+#define RBTX4939_PE2_CIR	0x08
+#define RBTX4939_PE2_SPI	0x10
+#define RBTX4939_PE2_GPIO	0x20
+#define RBTX4939_PE3_VP	0x01
+#define RBTX4939_PE3_VP_P	0x02
+#define RBTX4939_PE3_VP_S	0x04
+
+#define rbtx4939_board_rev_addr	((u8 __iomem *)RBTX4939_BOARD_REV_ADDR)
+#define rbtx4939_ioc_rev_addr	((u8 __iomem *)RBTX4939_IOC_REV_ADDR)
+#define rbtx4939_config1_addr	((u8 __iomem *)RBTX4939_CONFIG1_ADDR)
+#define rbtx4939_config2_addr	((u8 __iomem *)RBTX4939_CONFIG2_ADDR)
+#define rbtx4939_config3_addr	((u8 __iomem *)RBTX4939_CONFIG3_ADDR)
+#define rbtx4939_config4_addr	((u8 __iomem *)RBTX4939_CONFIG4_ADDR)
+#define rbtx4939_ustat_addr	((u8 __iomem *)RBTX4939_USTAT_ADDR)
+#define rbtx4939_udipsw_addr	((u8 __iomem *)RBTX4939_UDIPSW_ADDR)
+#define rbtx4939_bdipsw_addr	((u8 __iomem *)RBTX4939_BDIPSW_ADDR)
+#define rbtx4939_ien_addr	((u8 __iomem *)RBTX4939_IEN_ADDR)
+#define rbtx4939_ipol_addr	((u8 __iomem *)RBTX4939_IPOL_ADDR)
+#define rbtx4939_ifac1_addr	((u8 __iomem *)RBTX4939_IFAC1_ADDR)
+#define rbtx4939_ifac2_addr	((u8 __iomem *)RBTX4939_IFAC2_ADDR)
+#define rbtx4939_softint_addr	((u8 __iomem *)RBTX4939_SOFTINT_ADDR)
+#define rbtx4939_isastat_addr	((u8 __iomem *)RBTX4939_ISASTAT_ADDR)
+#define rbtx4939_pcistat_addr	((u8 __iomem *)RBTX4939_PCISTAT_ADDR)
+#define rbtx4939_rome_addr	((u8 __iomem *)RBTX4939_ROME_ADDR)
+#define rbtx4939_spics_addr	((u8 __iomem *)RBTX4939_SPICS_ADDR)
+#define rbtx4939_audi_addr	((u8 __iomem *)RBTX4939_AUDI_ADDR)
+#define rbtx4939_isagpio_addr	((u8 __iomem *)RBTX4939_ISAGPIO_ADDR)
+#define rbtx4939_pe1_addr	((u8 __iomem *)RBTX4939_PE1_ADDR)
+#define rbtx4939_pe2_addr	((u8 __iomem *)RBTX4939_PE2_ADDR)
+#define rbtx4939_pe3_addr	((u8 __iomem *)RBTX4939_PE3_ADDR)
+#define rbtx4939_vp_addr	((u8 __iomem *)RBTX4939_VP_ADDR)
+#define rbtx4939_vpreset_addr	((u8 __iomem *)RBTX4939_VPRESET_ADDR)
+#define rbtx4939_vpsout_addr	((u8 __iomem *)RBTX4939_VPSOUT_ADDR)
+#define rbtx4939_vpsin_addr	((u8 __iomem *)RBTX4939_VPSIN_ADDR)
+#define rbtx4939_7seg_addr(s, ch) \
+				((u8 __iomem *)RBTX4939_7SEG_ADDR(s, ch))
+#define rbtx4939_softreset_addr	((u8 __iomem *)RBTX4939_SOFTRESET_ADDR)
+#define rbtx4939_reseten_addr	((u8 __iomem *)RBTX4939_RESETEN_ADDR)
+#define rbtx4939_resetstat_addr	((u8 __iomem *)RBTX4939_RESETSTAT_ADDR)
+
+/*
+ * IRQ mappings
+ */
+#define RBTX4939_NR_IRQ_IOC	8
+
+#define RBTX4939_IRQ_IOC	(TXX9_IRQ_BASE + TX4939_NUM_IR)
+#define RBTX4939_IRQ_END	(RBTX4939_IRQ_IOC + RBTX4939_NR_IRQ_IOC)
+
+/* IOC (ISA, etc) */
+#define RBTX4939_IRQ_IOCINT	(TXX9_IRQ_BASE + TX4939_IR_INT(0))
+/* Onboard 10M Ether */
+#define RBTX4939_IRQ_ETHER	(TXX9_IRQ_BASE + TX4939_IR_INT(1))
+
+void rbtx4939_prom_init(void);
+void rbtx4939_irq_setup(void);
+
+#endif /* __ASM_TXX9_RBTX4939_H */
-- 
1.5.6.3
