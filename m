Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 11:41:30 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:33383 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491204Ab1HLJj6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2011 11:39:58 +0200
Received: by fxd20 with SMTP id 20so2860485fxd.36
        for <multiple recipients>; Fri, 12 Aug 2011 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=h2zl1cyyi7mkIWohv6iAeKp91chPyCn3+OD8z0EMuW4=;
        b=g6AyXSL8B7azCeLJ/LtcOitkbr751XxASlLBUindvAZAHYH6+gufr8lgLUyXpCqKGP
         Wf0IJoIwdl4q/6/Zzc4e4tM7xNZ3+yZauxEprCc4IEDHnas0hlfJssG+eK9tF9lzfR8e
         0njjGVSOqIIKKscIiMDMPOrqUqm+ZTzuWsBLs=
Received: by 10.223.76.137 with SMTP id c9mr1007358fak.62.1313141992794;
        Fri, 12 Aug 2011 02:39:52 -0700 (PDT)
Received: from localhost.localdomain (178-191-11-228.adsl.highway.telekom.at [178.191.11.228])
        by mx.google.com with ESMTPS id s14sm467338fah.29.2011.08.12.02.39.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 02:39:51 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@suse.de> (USB glue parts)
Subject: [PATCH 1/8] MIPS: Alchemy: abstract USB block control register access
Date:   Fri, 12 Aug 2011 11:39:38 +0200
Message-Id: <1313141985-5830-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
References: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9264

Alchemy chips have one or more registers which control access
to the usb blocks as well as PHY configuration.  I don't want
the OHCI/EHCI glues to know about the different registers and bits;
new arch code hides the gory details of USB configuration from them.

Cc: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>  (USB glue parts)
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
CC'ed Greg for an Ack on the USB glue parts.  I'd like this to go through the
 MIPS tree since other changes in it depend on it.

 arch/mips/alchemy/common/Makefile          |    2 +-
 arch/mips/alchemy/common/dma.c             |   12 +-
 arch/mips/alchemy/common/power.c           |   42 ----
 arch/mips/alchemy/common/usb.c             |  337 ++++++++++++++++++++++++++++
 arch/mips/include/asm/mach-au1x00/au1000.h |   84 ++------
 drivers/usb/host/ehci-au1xxx.c             |   77 +------
 drivers/usb/host/ohci-au1xxx.c             |  110 +--------
 7 files changed, 382 insertions(+), 282 deletions(-)
 create mode 100644 arch/mips/alchemy/common/usb.c

diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index 62f0d39..31728e0 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -6,7 +6,7 @@
 #
 
 obj-y += prom.o time.o clocks.o platform.o power.o setup.o \
-	sleeper.o dma.o dbdma.o
+	sleeper.o dma.o dbdma.o usb.o
 
 obj-$(CONFIG_ALCHEMY_GPIOINT_AU1000) += irq.o
 
diff --git a/arch/mips/alchemy/common/dma.c b/arch/mips/alchemy/common/dma.c
index 347980e..6652a23 100644
--- a/arch/mips/alchemy/common/dma.c
+++ b/arch/mips/alchemy/common/dma.c
@@ -88,12 +88,12 @@ static const struct dma_dev {
 	{ AU1000_AC97_PHYS_ADDR + 0x08, DMA_DW16 | DMA_DR },	/* AC97 RX c */
 	{ AU1000_UART3_PHYS_ADDR + 0x04, DMA_DW8 | DMA_NC },	/* UART3_TX */
 	{ AU1000_UART3_PHYS_ADDR + 0x00, DMA_DW8 | DMA_NC | DMA_DR }, /* UART3_RX */
-	{ AU1000_USBD_PHYS_ADDR + 0x00, DMA_DW8 | DMA_NC | DMA_DR }, /* EP0RD */
-	{ AU1000_USBD_PHYS_ADDR + 0x04, DMA_DW8 | DMA_NC }, /* EP0WR */
-	{ AU1000_USBD_PHYS_ADDR + 0x08, DMA_DW8 | DMA_NC }, /* EP2WR */
-	{ AU1000_USBD_PHYS_ADDR + 0x0c, DMA_DW8 | DMA_NC }, /* EP3WR */
-	{ AU1000_USBD_PHYS_ADDR + 0x10, DMA_DW8 | DMA_NC | DMA_DR }, /* EP4RD */
-	{ AU1000_USBD_PHYS_ADDR + 0x14, DMA_DW8 | DMA_NC | DMA_DR }, /* EP5RD */
+	{ AU1000_USB_UDC_PHYS_ADDR + 0x00, DMA_DW8 | DMA_NC | DMA_DR }, /* EP0RD */
+	{ AU1000_USB_UDC_PHYS_ADDR + 0x04, DMA_DW8 | DMA_NC }, /* EP0WR */
+	{ AU1000_USB_UDC_PHYS_ADDR + 0x08, DMA_DW8 | DMA_NC }, /* EP2WR */
+	{ AU1000_USB_UDC_PHYS_ADDR + 0x0c, DMA_DW8 | DMA_NC }, /* EP3WR */
+	{ AU1000_USB_UDC_PHYS_ADDR + 0x10, DMA_DW8 | DMA_NC | DMA_DR }, /* EP4RD */
+	{ AU1000_USB_UDC_PHYS_ADDR + 0x14, DMA_DW8 | DMA_NC | DMA_DR }, /* EP5RD */
 	/* on Au1500, these 2 are DMA_REQ2/3 (GPIO208/209) instead! */
 	{ AU1000_I2S_PHYS_ADDR + 0x00, DMA_DW32 | DMA_NC},	/* I2S TX */
 	{ AU1000_I2S_PHYS_ADDR + 0x00, DMA_DW32 | DMA_NC | DMA_DR}, /* I2S RX */
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index 9ec8559..bdd6651 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -47,7 +47,6 @@
  * We only have to save/restore registers that aren't otherwise
  * done as part of a driver pm_* function.
  */
-static unsigned int sleep_usb[2];
 static unsigned int sleep_sys_clocks[5];
 static unsigned int sleep_sys_pinfunc;
 static unsigned int sleep_static_memctlr[4][3];
@@ -55,31 +54,6 @@ static unsigned int sleep_static_memctlr[4][3];
 
 static void save_core_regs(void)
 {
-#ifndef CONFIG_SOC_AU1200
-	/* Shutdown USB host/device. */
-	sleep_usb[0] = au_readl(USB_HOST_CONFIG);
-
-	/* There appears to be some undocumented reset register.... */
-	au_writel(0, 0xb0100004);
-	au_sync();
-	au_writel(0, USB_HOST_CONFIG);
-	au_sync();
-
-	sleep_usb[1] = au_readl(USBD_ENABLE);
-	au_writel(0, USBD_ENABLE);
-	au_sync();
-
-#else	/* AU1200 */
-
-	/* enable access to OTG mmio so we can save OTG CAP/MUX.
-	 * FIXME: write an OTG driver and move this stuff there!
-	 */
-	au_writel(au_readl(USB_MSR_BASE + 4) | (1 << 6), USB_MSR_BASE + 4);
-	au_sync();
-	sleep_usb[0] = au_readl(0xb4020020);	/* OTG_CAP */
-	sleep_usb[1] = au_readl(0xb4020024);	/* OTG_MUX */
-#endif
-
 	/* Clocks and PLLs. */
 	sleep_sys_clocks[0] = au_readl(SYS_FREQCTRL0);
 	sleep_sys_clocks[1] = au_readl(SYS_FREQCTRL1);
@@ -123,22 +97,6 @@ static void restore_core_regs(void)
 	au_writel(sleep_sys_pinfunc, SYS_PINFUNC);
 	au_sync();
 
-#ifndef CONFIG_SOC_AU1200
-	au_writel(sleep_usb[0], USB_HOST_CONFIG);
-	au_writel(sleep_usb[1], USBD_ENABLE);
-	au_sync();
-#else
-	/* enable access to OTG memory */
-	au_writel(au_readl(USB_MSR_BASE + 4) | (1 << 6), USB_MSR_BASE + 4);
-	au_sync();
-
-	/* restore OTG caps and port mux. */
-	au_writel(sleep_usb[0], 0xb4020020 + 0);	/* OTG_CAP */
-	au_sync();
-	au_writel(sleep_usb[1], 0xb4020020 + 4);	/* OTG_MUX */
-	au_sync();
-#endif
-
 	/* Restore the static memory controller configuration. */
 	au_writel(sleep_static_memctlr[0][0], MEM_STCFG0);
 	au_writel(sleep_static_memctlr[0][1], MEM_STTIME0);
diff --git a/arch/mips/alchemy/common/usb.c b/arch/mips/alchemy/common/usb.c
new file mode 100644
index 0000000..b4192c9
--- /dev/null
+++ b/arch/mips/alchemy/common/usb.c
@@ -0,0 +1,337 @@
+/*
+ * USB block power/access management abstraction.
+ *
+ * Au1000+: The OHCI block control register is at the far end of the OHCI memory
+ *	    area. Au1550 has OHCI on different base address. No need to handle
+ *	    UDC here.
+ * Au1200:  one register to control access and clocks to O/EHCI, UDC and OTG
+ *	    as well as the PHY for EHCI and UDC.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
+#include <asm/mach-au1x00/au1000.h>
+
+/* control register offsets */
+#define AU1000_OHCICFG	0x7fffc
+#define AU1550_OHCICFG	0x07ffc
+#define AU1200_USBCFG	0x04
+
+/* Au1000 USB block config bits */
+#define USBHEN_RD	(1 << 4)		/* OHCI reset-done indicator */
+#define USBHEN_CE	(1 << 3)		/* OHCI block clock enable */
+#define USBHEN_E	(1 << 2)		/* OHCI block enable */
+#define USBHEN_C	(1 << 1)		/* OHCI block coherency bit */
+#define USBHEN_BE	(1 << 0)		/* OHCI Big-Endian */
+
+/* Au1200 USB config bits */
+#define USBCFG_PFEN	(1 << 31)		/* prefetch enable (undoc) */
+#define USBCFG_RDCOMB	(1 << 30)		/* read combining (undoc) */
+#define USBCFG_UNKNOWN	(5 << 20)		/* unknown, leave this way */
+#define USBCFG_SSD	(1 << 23)		/* serial short detect en */
+#define USBCFG_PPE	(1 << 19)		/* HS PHY PLL */
+#define USBCFG_UCE	(1 << 18)		/* UDC clock enable */
+#define USBCFG_ECE	(1 << 17)		/* EHCI clock enable */
+#define USBCFG_OCE	(1 << 16)		/* OHCI clock enable */
+#define USBCFG_FLA(x)	(((x) & 0x3f) << 8)
+#define USBCFG_UCAM	(1 << 7)		/* coherent access (undoc) */
+#define USBCFG_GME	(1 << 6)		/* OTG mem access */
+#define USBCFG_DBE	(1 << 5)		/* UDC busmaster enable */
+#define USBCFG_DME	(1 << 4)		/* UDC mem enable */
+#define USBCFG_EBE	(1 << 3)		/* EHCI busmaster enable */
+#define USBCFG_EME	(1 << 2)		/* EHCI mem enable */
+#define USBCFG_OBE	(1 << 1)		/* OHCI busmaster enable */
+#define USBCFG_OME	(1 << 0)		/* OHCI mem enable */
+#define USBCFG_INIT_AU1200	(USBCFG_PFEN | USBCFG_RDCOMB | USBCFG_UNKNOWN |\
+				 USBCFG_SSD | USBCFG_FLA(0x20) | USBCFG_UCAM | \
+				 USBCFG_GME | USBCFG_DBE | USBCFG_DME |	       \
+				 USBCFG_EBE | USBCFG_EME | USBCFG_OBE |	       \
+				 USBCFG_OME)
+
+
+static DEFINE_SPINLOCK(alchemy_usb_lock);
+
+
+static inline void __au1200_ohci_control(void __iomem *base, int enable)
+{
+	unsigned long r = __raw_readl(base + AU1200_USBCFG);
+	if (enable) {
+		__raw_writel(r | USBCFG_OCE, base + AU1200_USBCFG);
+		wmb();
+		udelay(2000);
+	} else {
+		__raw_writel(r & ~USBCFG_OCE, base + AU1200_USBCFG);
+		wmb();
+		udelay(1000);
+	}
+}
+
+static inline void __au1200_ehci_control(void __iomem *base, int enable)
+{
+	unsigned long r = __raw_readl(base + AU1200_USBCFG);
+	if (enable) {
+		__raw_writel(r | USBCFG_ECE | USBCFG_PPE, base + AU1200_USBCFG);
+		wmb();
+		udelay(1000);
+	} else {
+		if (!(r & USBCFG_UCE))		/* UDC also off? */
+			r &= ~USBCFG_PPE;	/* yes: disable HS PHY PLL */
+		__raw_writel(r & ~USBCFG_ECE, base + AU1200_USBCFG);
+		wmb();
+		udelay(1000);
+	}
+}
+
+static inline void __au1200_udc_control(void __iomem *base, int enable)
+{
+	unsigned long r = __raw_readl(base + AU1200_USBCFG);
+	if (enable) {
+		__raw_writel(r | USBCFG_UCE | USBCFG_PPE, base + AU1200_USBCFG);
+		wmb();
+	} else {
+		if (!(r & USBCFG_ECE))		/* EHCI also off? */
+			r &= ~USBCFG_PPE;	/* yes: disable HS PHY PLL */
+		__raw_writel(r & ~USBCFG_UCE, base + AU1200_USBCFG);
+		wmb();
+	}
+}
+
+static inline int au1200_coherency_bug(void)
+{
+#if defined(CONFIG_DMA_COHERENT)
+	/* Au1200 AB USB does not support coherent memory */
+	if (!(read_c0_prid() & 0xff)) {
+		printk(KERN_INFO "Au1200 USB: this is chip revision AB !!\n");
+		printk(KERN_INFO "Au1200 USB: update your board or re-configure"
+				 " the kernel\n");
+		return -ENODEV;
+	}
+#endif
+	return 0;
+}
+
+static inline int au1200_usb_control(int block, int enable)
+{
+	void __iomem *base =
+			(void __iomem *)KSEG1ADDR(AU1200_USB_CTL_PHYS_ADDR);
+	int ret = 0;
+
+	switch (block) {
+	case ALCHEMY_USB_OHCI0:
+		ret = au1200_coherency_bug();
+		if (ret && enable)
+			goto out;
+		__au1200_ohci_control(base, enable);
+		break;
+	case ALCHEMY_USB_UDC0:
+		__au1200_udc_control(base, enable);
+		break;
+	case ALCHEMY_USB_EHCI0:
+		ret = au1200_coherency_bug();
+		if (ret && enable)
+			goto out;
+		__au1200_ehci_control(base, enable);
+		break;
+	default:
+		ret = -ENODEV;
+	}
+out:
+	return ret;
+}
+
+
+/* initialize USB block(s) to a known working state */
+static inline void au1200_usb_init(void)
+{
+	void __iomem *base =
+			(void __iomem *)KSEG1ADDR(AU1200_USB_CTL_PHYS_ADDR);
+	__raw_writel(USBCFG_INIT_AU1200, base + AU1200_USBCFG);
+	wmb();
+	udelay(1000);
+}
+
+static inline void au1000_usb_init(unsigned long rb, int reg)
+{
+	void __iomem *base = (void __iomem *)KSEG1ADDR(rb + reg);
+	unsigned long r = __raw_readl(base);
+
+#if defined(__BIG_ENDIAN)
+	r |= USBHEN_BE;
+#endif
+	r |= USBHEN_C;
+
+	__raw_writel(r, base);
+	wmb();
+	udelay(1000);
+}
+
+
+static inline void __au1xx0_ohci_control(int enable, unsigned long rb, int creg)
+{
+	void __iomem *base = (void __iomem *)KSEG1ADDR(rb);
+	unsigned long r = __raw_readl(base + creg);
+
+	if (enable) {
+		__raw_writel(r | USBHEN_CE, base + creg);
+		wmb();
+		udelay(1000);
+		__raw_writel(r | USBHEN_CE | USBHEN_E, base + creg);
+		wmb();
+		udelay(1000);
+
+		/* wait for reset complete (read reg twice: au1500 erratum) */
+		while (__raw_readl(base + creg),
+			!(__raw_readl(base + creg) & USBHEN_RD))
+			udelay(1000);
+	} else {
+		__raw_writel(r & ~(USBHEN_CE | USBHEN_E), base + creg);
+		wmb();
+	}
+}
+
+static inline int au1000_usb_control(int block, int enable, unsigned long rb,
+				     int creg)
+{
+	int ret = 0;
+
+	switch (block) {
+	case ALCHEMY_USB_OHCI0:
+		__au1xx0_ohci_control(enable, rb, creg);
+		break;
+	default:
+		ret = -ENODEV;
+	}
+	return ret;
+}
+
+/*
+ * alchemy_usb_control - control Alchemy on-chip USB blocks
+ * @block:	USB block to target
+ * @enable:	set 1 to enable a block, 0 to disable
+ */
+int alchemy_usb_control(int block, int enable)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&alchemy_usb_lock, flags);
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1100:
+		ret = au1000_usb_control(block, enable,
+				AU1000_USB_OHCI_PHYS_ADDR, AU1000_OHCICFG);
+		break;
+	case ALCHEMY_CPU_AU1550:
+		ret = au1000_usb_control(block, enable,
+				AU1550_USB_OHCI_PHYS_ADDR, AU1550_OHCICFG);
+		break;
+	case ALCHEMY_CPU_AU1200:
+		ret = au1200_usb_control(block, enable);
+		break;
+	default:
+		ret = -ENODEV;
+	}
+	spin_unlock_irqrestore(&alchemy_usb_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(alchemy_usb_control);
+
+
+static unsigned long alchemy_usb_pmdata[2];
+
+static void au1000_usb_pm(unsigned long br, int creg, int susp)
+{
+	void __iomem *base = (void __iomem *)KSEG1ADDR(br);
+
+	if (susp) {
+		alchemy_usb_pmdata[0] = __raw_readl(base + creg);
+		/* There appears to be some undocumented reset register.... */
+		__raw_writel(0, base + 0x04);
+		wmb();
+		__raw_writel(0, base + creg);
+		wmb();
+	} else {
+		__raw_writel(alchemy_usb_pmdata[0], base + creg);
+		wmb();
+	}
+}
+
+static void au1200_usb_pm(int susp)
+{
+	void __iomem *base =
+			(void __iomem *)KSEG1ADDR(AU1200_USB_OTG_PHYS_ADDR);
+	if (susp) {
+		/* save OTG_CAP/MUX registers which indicate port routing */
+		/* FIXME: write an OTG driver to do that */
+		alchemy_usb_pmdata[0] = __raw_readl(base + 0x00);
+		alchemy_usb_pmdata[1] = __raw_readl(base + 0x04);
+	} else {
+		/* restore access to all MMIO areas */
+		au1200_usb_init();
+
+		/* restore OTG_CAP/MUX registers */
+		__raw_writel(alchemy_usb_pmdata[0], base + 0x00);
+		__raw_writel(alchemy_usb_pmdata[1], base + 0x04);
+		wmb();
+	}
+}
+
+static void alchemy_usb_pm(int susp)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1100:
+		au1000_usb_pm(AU1000_USB_OHCI_PHYS_ADDR, AU1000_OHCICFG, susp);
+		break;
+	case ALCHEMY_CPU_AU1550:
+		au1000_usb_pm(AU1550_USB_OHCI_PHYS_ADDR, AU1550_OHCICFG, susp);
+		break;
+	case ALCHEMY_CPU_AU1200:
+		au1200_usb_pm(susp);
+		break;
+	}
+}
+
+static int alchemy_usb_suspend(void)
+{
+	alchemy_usb_pm(1);
+	return 0;
+}
+
+static void alchemy_usb_resume(void)
+{
+	alchemy_usb_pm(0);
+}
+
+static struct syscore_ops alchemy_usb_pm_ops = {
+	.suspend	= alchemy_usb_suspend,
+	.resume		= alchemy_usb_resume,
+};
+
+static int __init alchemy_usb_init(void)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1100:
+		au1000_usb_init(AU1000_USB_OHCI_PHYS_ADDR, AU1000_OHCICFG);
+		break;
+	case ALCHEMY_CPU_AU1550:
+		au1000_usb_init(AU1550_USB_OHCI_PHYS_ADDR, AU1550_OHCICFG);
+		break;
+	case ALCHEMY_CPU_AU1200:
+		au1200_usb_init();
+		break;
+	}
+
+	register_syscore_ops(&alchemy_usb_pm_ops);
+
+	return 0;
+}
+arch_initcall(alchemy_usb_init);
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index f260ebe..73e0d79 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -245,6 +245,15 @@ void alchemy_sleep_au1000(void);
 void alchemy_sleep_au1550(void);
 void au_sleep(void);
 
+/* USB: arch/mips/alchemy/common/usb.c */
+enum alchemy_usb_block {
+	ALCHEMY_USB_OHCI0,
+	ALCHEMY_USB_UDC0,
+	ALCHEMY_USB_EHCI0,
+	ALCHEMY_USB_OTG0,
+};
+int alchemy_usb_control(int block, int enable);
+
 
 /* SOC Interrupt numbers */
 
@@ -687,7 +696,8 @@ enum soc_au1200_ints {
  */
 
 #define AU1000_AC97_PHYS_ADDR		0x10000000 /* 012 */
-#define AU1000_USBD_PHYS_ADDR		0x10200000 /* 0123 */
+#define AU1000_USB_OHCI_PHYS_ADDR	0x10100000 /* 012 */
+#define AU1000_USB_UDC_PHYS_ADDR	0x10200000 /* 0123 */
 #define AU1000_IC0_PHYS_ADDR		0x10400000 /* 01234 */
 #define AU1000_MAC0_PHYS_ADDR		0x10500000 /* 023 */
 #define AU1000_MAC1_PHYS_ADDR		0x10510000 /* 023 */
@@ -710,12 +720,17 @@ enum soc_au1200_ints {
 #define AU1550_DBDMA_CONF_PHYS_ADDR	0x14003000 /* 34 */
 #define AU1000_MACDMA0_PHYS_ADDR	0x14004000 /* 0123 */
 #define AU1000_MACDMA1_PHYS_ADDR	0x14004200 /* 0123 */
+#define AU1550_USB_OHCI_PHYS_ADDR	0x14020000 /* 3 */
+#define AU1200_USB_CTL_PHYS_ADDR	0x14020000 /* 4 */
+#define AU1200_USB_OTG_PHYS_ADDR	0x14020020 /* 4 */
+#define AU1200_USB_OHCI_PHYS_ADDR	0x14020100 /* 4 */
+#define AU1200_USB_EHCI_PHYS_ADDR	0x14020200 /* 4 */
+#define AU1200_USB_UDC_PHYS_ADDR	0x14022000 /* 4 */
 
 
 #ifdef CONFIG_SOC_AU1000
 #define	MEM_PHYS_ADDR		0x14000000
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define	USBH_PHYS_ADDR		0x10100000
 #define	IRDA_PHYS_ADDR		0x10300000
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
@@ -729,7 +744,6 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1500
 #define	MEM_PHYS_ADDR		0x14000000
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define	USBH_PHYS_ADDR		0x10100000
 #define PCI_PHYS_ADDR		0x14005000
 #define PCI_MEM_PHYS_ADDR	0x400000000ULL
 #define PCI_IO_PHYS_ADDR	0x500000000ULL
@@ -745,7 +759,6 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1100
 #define	MEM_PHYS_ADDR		0x14000000
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define	USBH_PHYS_ADDR		0x10100000
 #define	IRDA_PHYS_ADDR		0x10300000
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
@@ -760,7 +773,6 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1550
 #define	MEM_PHYS_ADDR		0x14000000
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
-#define	USBH_PHYS_ADDR		0x14020000
 #define PCI_PHYS_ADDR		0x14005000
 #define PE_PHYS_ADDR		0x14008000
 #define PSC0_PHYS_ADDR		0x11A00000
@@ -783,8 +795,6 @@ enum soc_au1200_ints {
 #define	STATIC_MEM_PHYS_ADDR	0x14001000
 #define AES_PHYS_ADDR		0x10300000
 #define CIM_PHYS_ADDR		0x14004000
-#define USBM_PHYS_ADDR		0x14020000
-#define	USBH_PHYS_ADDR		0x14020100
 #define PSC0_PHYS_ADDR	 	0x11A00000
 #define PSC1_PHYS_ADDR	 	0x11B00000
 #define LCD_PHYS_ADDR		0x15000000
@@ -868,21 +878,6 @@ enum soc_au1200_ints {
 #define USB_EHCI_LEN		0x100
 #define USB_UDC_BASE		0x14022000
 #define USB_UDC_LEN		0x2000
-#define USB_MSR_BASE		0xB4020000
-#define USB_MSR_MCFG		4
-#define USBMSRMCFG_OMEMEN	0
-#define USBMSRMCFG_OBMEN	1
-#define USBMSRMCFG_EMEMEN	2
-#define USBMSRMCFG_EBMEN	3
-#define USBMSRMCFG_DMEMEN	4
-#define USBMSRMCFG_DBMEN	5
-#define USBMSRMCFG_GMEMEN	6
-#define USBMSRMCFG_OHCCLKEN	16
-#define USBMSRMCFG_EHCCLKEN	17
-#define USBMSRMCFG_UDCCLKEN	18
-#define USBMSRMCFG_PHYPLLEN	19
-#define USBMSRMCFG_RDCOMB	30
-#define USBMSRMCFG_PFEN 	31
 
 #define FOR_PLATFORM_C_USB_HOST_INT AU1200_USB_INT
 
@@ -963,51 +958,6 @@ enum soc_au1200_ints {
 #define USB_OHCI_LEN		0x00100000
 #endif
 
-#ifndef CONFIG_SOC_AU1200
-
-/* USB Device Controller */
-#define USBD_EP0RD		0xB0200000
-#define USBD_EP0WR		0xB0200004
-#define USBD_EP2WR		0xB0200008
-#define USBD_EP3WR		0xB020000C
-#define USBD_EP4RD		0xB0200010
-#define USBD_EP5RD		0xB0200014
-#define USBD_INTEN		0xB0200018
-#define USBD_INTSTAT		0xB020001C
-#  define USBDEV_INT_SOF	(1 << 12)
-#  define USBDEV_INT_HF_BIT	6
-#  define USBDEV_INT_HF_MASK	(0x3f << USBDEV_INT_HF_BIT)
-#  define USBDEV_INT_CMPLT_BIT	0
-#  define USBDEV_INT_CMPLT_MASK (0x3f << USBDEV_INT_CMPLT_BIT)
-#define USBD_CONFIG		0xB0200020
-#define USBD_EP0CS		0xB0200024
-#define USBD_EP2CS		0xB0200028
-#define USBD_EP3CS		0xB020002C
-#define USBD_EP4CS		0xB0200030
-#define USBD_EP5CS		0xB0200034
-#  define USBDEV_CS_SU		(1 << 14)
-#  define USBDEV_CS_NAK 	(1 << 13)
-#  define USBDEV_CS_ACK 	(1 << 12)
-#  define USBDEV_CS_BUSY	(1 << 11)
-#  define USBDEV_CS_TSIZE_BIT	1
-#  define USBDEV_CS_TSIZE_MASK	(0x3ff << USBDEV_CS_TSIZE_BIT)
-#  define USBDEV_CS_STALL	(1 << 0)
-#define USBD_EP0RDSTAT		0xB0200040
-#define USBD_EP0WRSTAT		0xB0200044
-#define USBD_EP2WRSTAT		0xB0200048
-#define USBD_EP3WRSTAT		0xB020004C
-#define USBD_EP4RDSTAT		0xB0200050
-#define USBD_EP5RDSTAT		0xB0200054
-#  define USBDEV_FSTAT_FLUSH	(1 << 6)
-#  define USBDEV_FSTAT_UF	(1 << 5)
-#  define USBDEV_FSTAT_OF	(1 << 4)
-#  define USBDEV_FSTAT_FCNT_BIT 0
-#  define USBDEV_FSTAT_FCNT_MASK (0x0f << USBDEV_FSTAT_FCNT_BIT)
-#define USBD_ENABLE		0xB0200058
-#  define USBDEV_ENABLE 	(1 << 1)
-#  define USBDEV_CE		(1 << 0)
-
-#endif /* !CONFIG_SOC_AU1200 */
 
 /* Ethernet Controllers  */
 
diff --git a/drivers/usb/host/ehci-au1xxx.c b/drivers/usb/host/ehci-au1xxx.c
index 42ae574..e480dc1 100644
--- a/drivers/usb/host/ehci-au1xxx.c
+++ b/drivers/usb/host/ehci-au1xxx.c
@@ -14,61 +14,9 @@
 #include <linux/platform_device.h>
 #include <asm/mach-au1x00/au1000.h>
 
-#define USB_HOST_CONFIG   (USB_MSR_BASE + USB_MSR_MCFG)
-#define USB_MCFG_PFEN     (1<<31)
-#define USB_MCFG_RDCOMB   (1<<30)
-#define USB_MCFG_SSDEN    (1<<23)
-#define USB_MCFG_PHYPLLEN (1<<19)
-#define USB_MCFG_UCECLKEN (1<<18)
-#define USB_MCFG_EHCCLKEN (1<<17)
-#ifdef CONFIG_DMA_COHERENT
-#define USB_MCFG_UCAM     (1<<7)
-#else
-#define USB_MCFG_UCAM     (0)
-#endif
-#define USB_MCFG_EBMEN    (1<<3)
-#define USB_MCFG_EMEMEN   (1<<2)
-
-#define USBH_ENABLE_CE	(USB_MCFG_PHYPLLEN | USB_MCFG_EHCCLKEN)
-#define USBH_ENABLE_INIT (USB_MCFG_PFEN  | USB_MCFG_RDCOMB |	\
-			  USBH_ENABLE_CE | USB_MCFG_SSDEN  |	\
-			  USB_MCFG_UCAM  | USB_MCFG_EBMEN  |	\
-			  USB_MCFG_EMEMEN)
-
-#define USBH_DISABLE      (USB_MCFG_EBMEN | USB_MCFG_EMEMEN)
 
 extern int usb_disabled(void);
 
-static void au1xxx_start_ehc(void)
-{
-	/* enable clock to EHCI block and HS PHY PLL*/
-	au_writel(au_readl(USB_HOST_CONFIG) | USBH_ENABLE_CE, USB_HOST_CONFIG);
-	au_sync();
-	udelay(1000);
-
-	/* enable EHCI mmio */
-	au_writel(au_readl(USB_HOST_CONFIG) | USBH_ENABLE_INIT, USB_HOST_CONFIG);
-	au_sync();
-	udelay(1000);
-}
-
-static void au1xxx_stop_ehc(void)
-{
-	unsigned long c;
-
-	/* Disable mem */
-	au_writel(au_readl(USB_HOST_CONFIG) & ~USBH_DISABLE, USB_HOST_CONFIG);
-	au_sync();
-	udelay(1000);
-
-	/* Disable EHC clock. If the HS PHY is unused disable it too. */
-	c = au_readl(USB_HOST_CONFIG) & ~USB_MCFG_EHCCLKEN;
-	if (!(c & USB_MCFG_UCECLKEN))		/* UDC disabled? */
-		c &= ~USB_MCFG_PHYPLLEN;	/* yes: disable HS PHY PLL */
-	au_writel(c, USB_HOST_CONFIG);
-	au_sync();
-}
-
 static int au1xxx_ehci_setup(struct usb_hcd *hcd)
 {
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
@@ -136,16 +84,6 @@ static int ehci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 	if (usb_disabled())
 		return -ENODEV;
 
-#if defined(CONFIG_SOC_AU1200) && defined(CONFIG_DMA_COHERENT)
-	/* Au1200 AB USB does not support coherent memory */
-	if (!(read_c0_prid() & 0xff)) {
-		printk(KERN_INFO "%s: this is chip revision AB!\n", pdev->name);
-		printk(KERN_INFO "%s: update your board or re-configure"
-				 " the kernel\n", pdev->name);
-		return -ENODEV;
-	}
-#endif
-
 	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
 		pr_debug("resource[1] is not IORESOURCE_IRQ");
 		return -ENOMEM;
@@ -171,7 +109,11 @@ static int ehci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	au1xxx_start_ehc();
+	if (alchemy_usb_control(ALCHEMY_USB_EHCI0, 1)) {
+		printk(KERN_INFO "%s: controller init failed!\n", pdev->name);
+		ret = -ENODEV;
+		goto err3;
+	}
 
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = hcd->regs;
@@ -187,7 +129,8 @@ static int ehci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	au1xxx_stop_ehc();
+	alchemy_usb_control(ALCHEMY_USB_EHCI0, 0);
+err3:
 	iounmap(hcd->regs);
 err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
@@ -201,10 +144,10 @@ static int ehci_hcd_au1xxx_drv_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_remove_hcd(hcd);
+	alchemy_usb_control(ALCHEMY_USB_EHCI0, 0);
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
-	au1xxx_stop_ehc();
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
@@ -236,7 +179,7 @@ static int ehci_hcd_au1xxx_drv_suspend(struct device *dev)
 	// could save FLADJ in case of Vaux power loss
 	// ... we'd only use it to handle clock skew
 
-	au1xxx_stop_ehc();
+	alchemy_usb_control(ALCHEMY_USB_EHCI0, 0);
 
 	return rc;
 }
@@ -246,7 +189,7 @@ static int ehci_hcd_au1xxx_drv_resume(struct device *dev)
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
 
-	au1xxx_start_ehc();
+	alchemy_usb_control(ALCHEMY_USB_EHCI0, 1);
 
 	// maybe restore FLADJ
 
diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index 958d985..299d719 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -23,92 +23,9 @@
 
 #include <asm/mach-au1x00/au1000.h>
 
-#ifndef	CONFIG_SOC_AU1200
-
-#define USBH_ENABLE_BE (1<<0)
-#define USBH_ENABLE_C  (1<<1)
-#define USBH_ENABLE_E  (1<<2)
-#define USBH_ENABLE_CE (1<<3)
-#define USBH_ENABLE_RD (1<<4)
-
-#ifdef __LITTLE_ENDIAN
-#define USBH_ENABLE_INIT (USBH_ENABLE_CE | USBH_ENABLE_E | USBH_ENABLE_C)
-#elif defined(__BIG_ENDIAN)
-#define USBH_ENABLE_INIT (USBH_ENABLE_CE | USBH_ENABLE_E | USBH_ENABLE_C | \
-			  USBH_ENABLE_BE)
-#else
-#error not byte order defined
-#endif
-
-#else   /* Au1200 */
-
-#define USB_HOST_CONFIG    (USB_MSR_BASE + USB_MSR_MCFG)
-#define USB_MCFG_PFEN     (1<<31)
-#define USB_MCFG_RDCOMB   (1<<30)
-#define USB_MCFG_SSDEN    (1<<23)
-#define USB_MCFG_OHCCLKEN (1<<16)
-#ifdef CONFIG_DMA_COHERENT
-#define USB_MCFG_UCAM     (1<<7)
-#else
-#define USB_MCFG_UCAM     (0)
-#endif
-#define USB_MCFG_OBMEN    (1<<1)
-#define USB_MCFG_OMEMEN   (1<<0)
-
-#define USBH_ENABLE_CE    USB_MCFG_OHCCLKEN
-
-#define USBH_ENABLE_INIT  (USB_MCFG_PFEN  | USB_MCFG_RDCOMB 	|	\
-			   USBH_ENABLE_CE | USB_MCFG_SSDEN	|	\
-			   USB_MCFG_UCAM  |				\
-			   USB_MCFG_OBMEN | USB_MCFG_OMEMEN)
-
-#define USBH_DISABLE      (USB_MCFG_OBMEN | USB_MCFG_OMEMEN)
-
-#endif  /* Au1200 */
 
 extern int usb_disabled(void);
 
-static void au1xxx_start_ohc(void)
-{
-	/* enable host controller */
-#ifndef CONFIG_SOC_AU1200
-	au_writel(USBH_ENABLE_CE, USB_HOST_CONFIG);
-	au_sync();
-	udelay(1000);
-
-	au_writel(au_readl(USB_HOST_CONFIG) | USBH_ENABLE_INIT, USB_HOST_CONFIG);
-	au_sync();
-	udelay(1000);
-
-	/* wait for reset complete (read register twice; see au1500 errata) */
-	while (au_readl(USB_HOST_CONFIG),
-		!(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
-		udelay(1000);
-
-#else   /* Au1200 */
-	au_writel(au_readl(USB_HOST_CONFIG) | USBH_ENABLE_CE, USB_HOST_CONFIG);
-	au_sync();
-	udelay(1000);
-
-	au_writel(au_readl(USB_HOST_CONFIG) | USBH_ENABLE_INIT, USB_HOST_CONFIG);
-	au_sync();
-	udelay(2000);
-#endif  /* Au1200 */
-}
-
-static void au1xxx_stop_ohc(void)
-{
-#ifdef CONFIG_SOC_AU1200
-	/* Disable mem */
-	au_writel(au_readl(USB_HOST_CONFIG) & ~USBH_DISABLE, USB_HOST_CONFIG);
-	au_sync();
-	udelay(1000);
-#endif
-	/* Disable clock */
-	au_writel(au_readl(USB_HOST_CONFIG) & ~USBH_ENABLE_CE, USB_HOST_CONFIG);
-	au_sync();
-}
-
 static int __devinit ohci_au1xxx_start(struct usb_hcd *hcd)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
@@ -178,17 +95,6 @@ static int ohci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 	if (usb_disabled())
 		return -ENODEV;
 
-#if defined(CONFIG_SOC_AU1200) && defined(CONFIG_DMA_COHERENT)
-	/* Au1200 AB USB does not support coherent memory */
-	if (!(read_c0_prid() & 0xff)) {
-		printk(KERN_INFO "%s: this is chip revision AB !!\n",
-			pdev->name);
-		printk(KERN_INFO "%s: update your board or re-configure "
-				 "the kernel\n", pdev->name);
-		return -ENODEV;
-	}
-#endif
-
 	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
 		pr_debug("resource[1] is not IORESOURCE_IRQ\n");
 		return -ENOMEM;
@@ -214,7 +120,12 @@ static int ohci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	au1xxx_start_ohc();
+	if (alchemy_usb_control(ALCHEMY_USB_OHCI0, 1)) {
+		printk(KERN_INFO "%s: controller init failed!\n", pdev->name);
+		ret = -ENODEV;
+		goto err3;
+	}
+
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
 	ret = usb_add_hcd(hcd, pdev->resource[1].start,
@@ -224,7 +135,8 @@ static int ohci_hcd_au1xxx_drv_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	au1xxx_stop_ohc();
+	alchemy_usb_control(ALCHEMY_USB_OHCI0, 0);
+err3:
 	iounmap(hcd->regs);
 err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
@@ -238,7 +150,7 @@ static int ohci_hcd_au1xxx_drv_remove(struct platform_device *pdev)
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
 	usb_remove_hcd(hcd);
-	au1xxx_stop_ohc();
+	alchemy_usb_control(ALCHEMY_USB_OHCI0, 0);
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
@@ -275,7 +187,7 @@ static int ohci_hcd_au1xxx_drv_suspend(struct device *dev)
 
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 
-	au1xxx_stop_ohc();
+	alchemy_usb_control(ALCHEMY_USB_OHCI0, 0);
 bail:
 	spin_unlock_irqrestore(&ohci->lock, flags);
 
@@ -286,7 +198,7 @@ static int ohci_hcd_au1xxx_drv_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 
-	au1xxx_start_ohc();
+	alchemy_usb_control(ALCHEMY_USB_OHCI0, 1);
 
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	ohci_finish_controller_resume(hcd);
-- 
1.7.6
