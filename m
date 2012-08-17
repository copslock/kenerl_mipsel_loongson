Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2012 01:56:48 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56724 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903608Ab2HQXzu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Aug 2012 01:55:50 +0200
Received: by dajq27 with SMTP id q27so1114717daj.36
        for <multiple recipients>; Fri, 17 Aug 2012 16:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cZ2YkU7iDnmvRm7XrN6Pgma/PDVci5/F7Oy5WKhq1Oo=;
        b=1Iw7XkvEmxr3aid2ubiVVIxN1JQ3GHJZsl/6Tuw8/BGjx4mbVbu8jpl4n6YvkwtcIA
         c/D4iBCB9rSJqP7PEs9PL7CzRmzISngOg0X3EteZVOKG9I6rhR94v74o1qoZghhgyAV0
         7Sm+CWxYLalZvA/sW9H1nKr7e3Qefml8qbRW3g/lnCD+q89IAItebxnnQ0b9Mq/lptVN
         qaqJi5HgXM6iHmdPAEUt0gRGbHqjbOuyhMSNHS7e6k9HUluhvuJqClIYsvE2w1dUf9zB
         2KpuSv5467M9PLSBZlrEYgep1QEZfHWKW+yvnOfesa54WJDOwAymI94VuBMEqCD7Zh5M
         OPnQ==
Received: by 10.66.87.138 with SMTP id ay10mr13005572pab.38.1345247743377;
        Fri, 17 Aug 2012 16:55:43 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ns7sm5848712pbc.40.2012.08.17.16.55.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 16:55:42 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7HNseur025126;
        Fri, 17 Aug 2012 16:54:40 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7HNseHF025125;
        Fri, 17 Aug 2012 16:54:40 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     ralf@linux-mips.org, linux-ide@vger.kernel.org,
        Jeff Garzik <jgarzik@pobox.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS/OCTEON/ata: Convert pata_octeon_cf.c to use device tree.
Date:   Fri, 17 Aug 2012 16:54:32 -0700
Message-Id: <1345247673-25086-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1345247673-25086-1-git-send-email-ddaney.cavm@gmail.com>
References: <1345247673-25086-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The patch needs to eliminate the definition of OCTEON_IRQ_BOOTDMA so
that the device tree code can map the interrupt, so in order to not
temporarily break things, we do a single patch to both the interrupt
registration code and the pata_octeon_cf driver.

Also rolled in is a conversion to use hrtimers and corrections to the
timing calculations.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c           |   1 -
 arch/mips/cavium-octeon/octeon-platform.c      | 102 ------
 arch/mips/include/asm/mach-cavium-octeon/irq.h |   1 -
 arch/mips/include/asm/octeon/octeon.h          |   7 -
 drivers/ata/pata_octeon_cf.c                   | 419 +++++++++++++++++--------
 5 files changed, 284 insertions(+), 246 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 274cd4f..5dcb88c 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1213,7 +1213,6 @@ static void __init octeon_irq_init_ciu(void)
 		octeon_irq_force_ciu_mapping(ciu_domain, i + OCTEON_IRQ_TIMER0, 0, i + 52);
 
 	octeon_irq_force_ciu_mapping(ciu_domain, OCTEON_IRQ_USB0, 0, 56);
-	octeon_irq_force_ciu_mapping(ciu_domain, OCTEON_IRQ_BOOTDMA, 0, 63);
 
 	/* CIU_1 */
 	for (i = 0; i < 16; i++)
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 0938df1..3c1b625 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -24,108 +24,6 @@
 #include <asm/octeon/cvmx-helper.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
-static struct octeon_cf_data octeon_cf_data;
-
-static int __init octeon_cf_device_init(void)
-{
-	union cvmx_mio_boot_reg_cfgx mio_boot_reg_cfg;
-	unsigned long base_ptr, region_base, region_size;
-	struct platform_device *pd;
-	struct resource cf_resources[3];
-	unsigned int num_resources;
-	int i;
-	int ret = 0;
-
-	/* Setup octeon-cf platform device if present. */
-	base_ptr = 0;
-	if (octeon_bootinfo->major_version == 1
-		&& octeon_bootinfo->minor_version >= 1) {
-		if (octeon_bootinfo->compact_flash_common_base_addr)
-			base_ptr =
-				octeon_bootinfo->compact_flash_common_base_addr;
-	} else {
-		base_ptr = 0x1d000800;
-	}
-
-	if (!base_ptr)
-		return ret;
-
-	/* Find CS0 region. */
-	for (i = 0; i < 8; i++) {
-		mio_boot_reg_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(i));
-		region_base = mio_boot_reg_cfg.s.base << 16;
-		region_size = (mio_boot_reg_cfg.s.size + 1) << 16;
-		if (mio_boot_reg_cfg.s.en && base_ptr >= region_base
-		    && base_ptr < region_base + region_size)
-			break;
-	}
-	if (i >= 7) {
-		/* i and i + 1 are CS0 and CS1, both must be less than 8. */
-		goto out;
-	}
-	octeon_cf_data.base_region = i;
-	octeon_cf_data.is16bit = mio_boot_reg_cfg.s.width;
-	octeon_cf_data.base_region_bias = base_ptr - region_base;
-	memset(cf_resources, 0, sizeof(cf_resources));
-	num_resources = 0;
-	cf_resources[num_resources].flags	= IORESOURCE_MEM;
-	cf_resources[num_resources].start	= region_base;
-	cf_resources[num_resources].end	= region_base + region_size - 1;
-	num_resources++;
-
-
-	if (!(base_ptr & 0xfffful)) {
-		/*
-		 * Boot loader signals availability of DMA (true_ide
-		 * mode) by setting low order bits of base_ptr to
-		 * zero.
-		 */
-
-		/* Assume that CS1 immediately follows. */
-		mio_boot_reg_cfg.u64 =
-			cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(i + 1));
-		region_base = mio_boot_reg_cfg.s.base << 16;
-		region_size = (mio_boot_reg_cfg.s.size + 1) << 16;
-		if (!mio_boot_reg_cfg.s.en)
-			goto out;
-
-		cf_resources[num_resources].flags	= IORESOURCE_MEM;
-		cf_resources[num_resources].start	= region_base;
-		cf_resources[num_resources].end	= region_base + region_size - 1;
-		num_resources++;
-
-		octeon_cf_data.dma_engine = 0;
-		cf_resources[num_resources].flags	= IORESOURCE_IRQ;
-		cf_resources[num_resources].start	= OCTEON_IRQ_BOOTDMA;
-		cf_resources[num_resources].end	= OCTEON_IRQ_BOOTDMA;
-		num_resources++;
-	} else {
-		octeon_cf_data.dma_engine = -1;
-	}
-
-	pd = platform_device_alloc("pata_octeon_cf", -1);
-	if (!pd) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	pd->dev.platform_data = &octeon_cf_data;
-
-	ret = platform_device_add_resources(pd, cf_resources, num_resources);
-	if (ret)
-		goto fail;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		goto fail;
-
-	return ret;
-fail:
-	platform_device_put(pd);
-out:
-	return ret;
-}
-device_initcall(octeon_cf_device_init);
-
 /* Octeon Random Number Generator.  */
 static int __init octeon_rng_device_init(void)
 {
diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
index c22a307..4eda022 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -41,7 +41,6 @@ enum octeon_irq {
 	OCTEON_IRQ_TIMER3,
 	OCTEON_IRQ_USB0,
 	OCTEON_IRQ_USB1,
-	OCTEON_IRQ_BOOTDMA,
 #ifndef CONFIG_PCI_MSI
 	OCTEON_IRQ_LAST = 127
 #endif
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 712f6b7..96e58a5 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -209,13 +209,6 @@ union octeon_cvmemctl {
 	} s;
 };
 
-struct octeon_cf_data {
-	unsigned long	base_region_bias;
-	unsigned int	base_region;	/* The chip select region used by CF */
-	int		is16bit;	/* 0 - 8bit, !0 - 16bit */
-	int		dma_engine;	/* -1 for no DMA */
-};
-
 extern void octeon_write_lcd(const char *s);
 extern void octeon_check_cpu_bist(void);
 extern int octeon_get_boot_debug_flag(void);
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 1d61d5d..652d035 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -5,17 +5,19 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005 - 2009 Cavium Networks
+ * Copyright (C) 2005 - 2012 Cavium Inc.
  * Copyright (C) 2008 Wind River Systems
  */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/libata.h>
-#include <linux/irq.h>
+#include <linux/hrtimer.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
 
 #include <asm/octeon/octeon.h>
@@ -34,20 +36,36 @@
  */
 
 #define DRV_NAME	"pata_octeon_cf"
-#define DRV_VERSION	"2.1"
+#define DRV_VERSION	"2.2"
+
+/* Poll interval in nS. */
+#define OCTEON_CF_BUSY_POLL_INTERVAL 500000
 
+#define DMA_CFG 0
+#define DMA_TIM 0x20
+#define DMA_INT 0x38
+#define DMA_INT_EN 0x50
 
 struct octeon_cf_port {
-	struct workqueue_struct *wq;
-	struct delayed_work delayed_finish;
+	struct hrtimer delayed_finish;
 	struct ata_port *ap;
 	int dma_finished;
+	void		*c0;
+	unsigned int cs0;
+	unsigned int cs1;
+	bool is_true_ide;
+	u64 dma_base;
 };
 
 static struct scsi_host_template octeon_cf_sht = {
 	ATA_PIO_SHT(DRV_NAME),
 };
 
+static int enable_dma;
+module_param(enable_dma, int, 0444);
+MODULE_PARM_DESC(enable_dma,
+		 "Enable use of DMA on interfaces that support it (0=no dma [default], 1=use dma)");
+
 /**
  * Convert nanosecond based time to setting used in the
  * boot bus timing register, based on timing multiple
@@ -66,12 +84,29 @@ static unsigned int ns_to_tim_reg(unsigned int tim_mult, unsigned int nsecs)
 	return val;
 }
 
-static void octeon_cf_set_boot_reg_cfg(int cs)
+static void octeon_cf_set_boot_reg_cfg(int cs, unsigned int multiplier)
 {
 	union cvmx_mio_boot_reg_cfgx reg_cfg;
+	unsigned int tim_mult;
+
+	switch (multiplier) {
+	case 8:
+		tim_mult = 3;
+		break;
+	case 4:
+		tim_mult = 0;
+		break;
+	case 2:
+		tim_mult = 2;
+		break;
+	default:
+		tim_mult = 1;
+		break;
+	}
+
 	reg_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(cs));
 	reg_cfg.s.dmack = 0;	/* Don't assert DMACK on access */
-	reg_cfg.s.tim_mult = 2;	/* Timing mutiplier 2x */
+	reg_cfg.s.tim_mult = tim_mult;	/* Timing mutiplier */
 	reg_cfg.s.rd_dly = 0;	/* Sample on falling edge of BOOT_OE */
 	reg_cfg.s.sam = 0;	/* Don't combine write and output enable */
 	reg_cfg.s.we_ext = 0;	/* No write enable extension */
@@ -92,12 +127,12 @@ static void octeon_cf_set_boot_reg_cfg(int cs)
  */
 static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
 {
-	struct octeon_cf_data *ocd = ap->dev->platform_data;
+	struct octeon_cf_port *cf_port = ap->private_data;
 	union cvmx_mio_boot_reg_timx reg_tim;
-	int cs = ocd->base_region;
 	int T;
 	struct ata_timing timing;
 
+	unsigned int div;
 	int use_iordy;
 	int trh;
 	int pause;
@@ -106,7 +141,15 @@ static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
 	int t2;
 	int t2i;
 
-	T = (int)(2000000000000LL / octeon_get_clock_rate());
+	/*
+	 * A divisor value of four will overflow the timing fields at
+	 * clock rates greater than 800MHz
+	 */
+	if (octeon_get_io_clock_rate() <= 800000000)
+		div = 4;
+	else
+		div = 8;
+	T = (int)((1000000000000LL * div) / octeon_get_io_clock_rate());
 
 	if (ata_timing_compute(dev, dev->pio_mode, &timing, T, T))
 		BUG();
@@ -121,23 +164,26 @@ static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
 	if (t2i)
 		t2i--;
 
-	trh = ns_to_tim_reg(2, 20);
+	trh = ns_to_tim_reg(div, 20);
 	if (trh)
 		trh--;
 
-	pause = timing.cycle - timing.active - timing.setup - trh;
+	pause = (int)timing.cycle - (int)timing.active -
+		(int)timing.setup - trh;
+	if (pause < 0)
+		pause = 0;
 	if (pause)
 		pause--;
 
-	octeon_cf_set_boot_reg_cfg(cs);
-	if (ocd->dma_engine >= 0)
+	octeon_cf_set_boot_reg_cfg(cf_port->cs0, div);
+	if (cf_port->is_true_ide)
 		/* True IDE mode, program both chip selects.  */
-		octeon_cf_set_boot_reg_cfg(cs + 1);
+		octeon_cf_set_boot_reg_cfg(cf_port->cs1, div);
 
 
 	use_iordy = ata_pio_need_iordy(dev);
 
-	reg_tim.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_TIMX(cs));
+	reg_tim.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_TIMX(cf_port->cs0));
 	/* Disable page mode */
 	reg_tim.s.pagem = 0;
 	/* Enable dynamic timing */
@@ -161,20 +207,22 @@ static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
 	/* How long read enable is asserted */
 	reg_tim.s.oe = t2;
 	/* Time after CE that read/write starts */
-	reg_tim.s.ce = ns_to_tim_reg(2, 5);
+	reg_tim.s.ce = ns_to_tim_reg(div, 5);
 	/* Time before CE that address is valid */
 	reg_tim.s.adr = 0;
 
 	/* Program the bootbus region timing for the data port chip select. */
-	cvmx_write_csr(CVMX_MIO_BOOT_REG_TIMX(cs), reg_tim.u64);
-	if (ocd->dma_engine >= 0)
+	cvmx_write_csr(CVMX_MIO_BOOT_REG_TIMX(cf_port->cs0), reg_tim.u64);
+	if (cf_port->is_true_ide)
 		/* True IDE mode, program both chip selects.  */
-		cvmx_write_csr(CVMX_MIO_BOOT_REG_TIMX(cs + 1), reg_tim.u64);
+		cvmx_write_csr(CVMX_MIO_BOOT_REG_TIMX(cf_port->cs1),
+			       reg_tim.u64);
 }
 
 static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
 {
-	struct octeon_cf_data *ocd = dev->link->ap->dev->platform_data;
+	struct octeon_cf_port *cf_port = ap->private_data;
+	union cvmx_mio_boot_pin_defs pin_defs;
 	union cvmx_mio_boot_dma_timx dma_tim;
 	unsigned int oe_a;
 	unsigned int oe_n;
@@ -183,6 +231,7 @@ static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
 	unsigned int pause;
 	unsigned int T0, Tkr, Td;
 	unsigned int tim_mult;
+	int c;
 
 	const struct ata_timing *timing;
 
@@ -199,13 +248,19 @@ static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
 	/* not spec'ed, value in eclocks, not affected by tim_mult */
 	dma_arq = 8;
 	pause = 25 - dma_arq * 1000 /
-		(octeon_get_clock_rate() / 1000000); /* Tz */
+		(octeon_get_io_clock_rate() / 1000000); /* Tz */
 
 	oe_a = Td;
 	/* Tkr from cf spec, lengthened to meet T0 */
 	oe_n = max(T0 - oe_a, Tkr);
 
-	dma_tim.s.dmack_pi = 1;
+	pin_defs.u64 = cvmx_read_csr(CVMX_MIO_BOOT_PIN_DEFS);
+
+	/* DMA channel number. */
+	c = (cf_port->dma_base & 8) >> 3;
+
+	/* Invert the polarity if the default is 0*/
+	dma_tim.s.dmack_pi = (pin_defs.u64 & (1ull << (11 + c))) ? 0 : 1;
 
 	dma_tim.s.oe_n = ns_to_tim_reg(tim_mult, oe_n);
 	dma_tim.s.oe_a = ns_to_tim_reg(tim_mult, oe_a);
@@ -228,14 +283,11 @@ static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
 
 	pr_debug("ns to ticks (mult %d) of %d is: %d\n", tim_mult, 60,
 		 ns_to_tim_reg(tim_mult, 60));
-	pr_debug("oe_n: %d, oe_a: %d, dmack_s: %d, dmack_h: "
-		 "%d, dmarq: %d, pause: %d\n",
+	pr_debug("oe_n: %d, oe_a: %d, dmack_s: %d, dmack_h: %d, dmarq: %d, pause: %d\n",
 		 dma_tim.s.oe_n, dma_tim.s.oe_a, dma_tim.s.dmack_s,
 		 dma_tim.s.dmack_h, dma_tim.s.dmarq, dma_tim.s.pause);
 
-	cvmx_write_csr(CVMX_MIO_BOOT_DMA_TIMX(ocd->dma_engine),
-		       dma_tim.u64);
-
+	cvmx_write_csr(cf_port->dma_base + DMA_TIM, dma_tim.u64);
 }
 
 /**
@@ -489,15 +541,10 @@ static void octeon_cf_exec_command16(struct ata_port *ap,
 	ata_wait_idle(ap);
 }
 
-static void octeon_cf_irq_on(struct ata_port *ap)
+static void octeon_cf_ata_port_noaction(struct ata_port *ap)
 {
 }
 
-static void octeon_cf_irq_clear(struct ata_port *ap)
-{
-	return;
-}
-
 static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -519,7 +566,7 @@ static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
  */
 static void octeon_cf_dma_start(struct ata_queued_cmd *qc)
 {
-	struct octeon_cf_data *ocd = qc->ap->dev->platform_data;
+	struct octeon_cf_port *cf_port = qc->ap->private_data;
 	union cvmx_mio_boot_dma_cfgx mio_boot_dma_cfg;
 	union cvmx_mio_boot_dma_intx mio_boot_dma_int;
 	struct scatterlist *sg;
@@ -535,12 +582,10 @@ static void octeon_cf_dma_start(struct ata_queued_cmd *qc)
 	 */
 	mio_boot_dma_int.u64 = 0;
 	mio_boot_dma_int.s.done = 1;
-	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine),
-		       mio_boot_dma_int.u64);
+	cvmx_write_csr(cf_port->dma_base + DMA_INT, mio_boot_dma_int.u64);
 
 	/* Enable the interrupt.  */
-	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INT_ENX(ocd->dma_engine),
-		       mio_boot_dma_int.u64);
+	cvmx_write_csr(cf_port->dma_base + DMA_INT_EN, mio_boot_dma_int.u64);
 
 	/* Set the direction of the DMA */
 	mio_boot_dma_cfg.u64 = 0;
@@ -569,8 +614,7 @@ static void octeon_cf_dma_start(struct ata_queued_cmd *qc)
 		(mio_boot_dma_cfg.s.rw) ? "write" : "read", sg->length,
 		(void *)(unsigned long)mio_boot_dma_cfg.s.adr);
 
-	cvmx_write_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine),
-		       mio_boot_dma_cfg.u64);
+	cvmx_write_csr(cf_port->dma_base + DMA_CFG, mio_boot_dma_cfg.u64);
 }
 
 /**
@@ -583,10 +627,9 @@ static unsigned int octeon_cf_dma_finished(struct ata_port *ap,
 					struct ata_queued_cmd *qc)
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
-	struct octeon_cf_data *ocd = ap->dev->platform_data;
+	struct octeon_cf_port *cf_port = ap->private_data;
 	union cvmx_mio_boot_dma_cfgx dma_cfg;
 	union cvmx_mio_boot_dma_intx dma_int;
-	struct octeon_cf_port *cf_port;
 	u8 status;
 
 	VPRINTK("ata%u: protocol %d task_state %d\n",
@@ -596,9 +639,7 @@ static unsigned int octeon_cf_dma_finished(struct ata_port *ap,
 	if (ap->hsm_task_state != HSM_ST_LAST)
 		return 0;
 
-	cf_port = ap->private_data;
-
-	dma_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine));
+	dma_cfg.u64 = cvmx_read_csr(cf_port->dma_base + DMA_CFG);
 	if (dma_cfg.s.size != 0xfffff) {
 		/* Error, the transfer was not complete.  */
 		qc->err_mask |= AC_ERR_HOST_BUS;
@@ -608,15 +649,15 @@ static unsigned int octeon_cf_dma_finished(struct ata_port *ap,
 	/* Stop and clear the dma engine.  */
 	dma_cfg.u64 = 0;
 	dma_cfg.s.size = -1;
-	cvmx_write_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine), dma_cfg.u64);
+	cvmx_write_csr(cf_port->dma_base + DMA_CFG, dma_cfg.u64);
 
 	/* Disable the interrupt.  */
 	dma_int.u64 = 0;
-	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INT_ENX(ocd->dma_engine), dma_int.u64);
+	cvmx_write_csr(cf_port->dma_base + DMA_INT_EN, dma_int.u64);
 
 	/* Clear the DMA complete status */
 	dma_int.s.done = 1;
-	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine), dma_int.u64);
+	cvmx_write_csr(cf_port->dma_base + DMA_INT, dma_int.u64);
 
 	status = ap->ops->sff_check_status(ap);
 
@@ -649,69 +690,68 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
 		struct ata_queued_cmd *qc;
 		union cvmx_mio_boot_dma_intx dma_int;
 		union cvmx_mio_boot_dma_cfgx dma_cfg;
-		struct octeon_cf_data *ocd;
 
 		ap = host->ports[i];
-		ocd = ap->dev->platform_data;
 		cf_port = ap->private_data;
-		dma_int.u64 =
-			cvmx_read_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine));
-		dma_cfg.u64 =
-			cvmx_read_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine));
+
+		dma_int.u64 = cvmx_read_csr(cf_port->dma_base + DMA_INT);
+		dma_cfg.u64 = cvmx_read_csr(cf_port->dma_base + DMA_CFG);
 
 		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 
-		if (qc && !(qc->tf.flags & ATA_TFLAG_POLLING)) {
-			if (dma_int.s.done && !dma_cfg.s.en) {
-				if (!sg_is_last(qc->cursg)) {
-					qc->cursg = sg_next(qc->cursg);
-					handled = 1;
-					octeon_cf_dma_start(qc);
-					continue;
-				} else {
-					cf_port->dma_finished = 1;
-				}
-			}
-			if (!cf_port->dma_finished)
-				continue;
-			status = ioread8(ap->ioaddr.altstatus_addr);
-			if (status & (ATA_BUSY | ATA_DRQ)) {
-				/*
-				 * We are busy, try to handle it
-				 * later.  This is the DMA finished
-				 * interrupt, and it could take a
-				 * little while for the card to be
-				 * ready for more commands.
-				 */
-				/* Clear DMA irq. */
-				dma_int.u64 = 0;
-				dma_int.s.done = 1;
-				cvmx_write_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine),
-					       dma_int.u64);
-
-				queue_delayed_work(cf_port->wq,
-						   &cf_port->delayed_finish, 1);
+		if (!qc || (qc->tf.flags & ATA_TFLAG_POLLING))
+			continue;
+
+		if (dma_int.s.done && !dma_cfg.s.en) {
+			if (!sg_is_last(qc->cursg)) {
+				qc->cursg = sg_next(qc->cursg);
 				handled = 1;
+				octeon_cf_dma_start(qc);
+				continue;
 			} else {
-				handled |= octeon_cf_dma_finished(ap, qc);
+				cf_port->dma_finished = 1;
 			}
 		}
+		if (!cf_port->dma_finished)
+			continue;
+		status = ioread8(ap->ioaddr.altstatus_addr);
+		if (status & (ATA_BUSY | ATA_DRQ)) {
+			/*
+			 * We are busy, try to handle it later.  This
+			 * is the DMA finished interrupt, and it could
+			 * take a little while for the card to be
+			 * ready for more commands.
+			 */
+			/* Clear DMA irq. */
+			dma_int.u64 = 0;
+			dma_int.s.done = 1;
+			cvmx_write_csr(cf_port->dma_base + DMA_INT,
+				       dma_int.u64);
+			hrtimer_start_range_ns(&cf_port->delayed_finish,
+					       ns_to_ktime(OCTEON_CF_BUSY_POLL_INTERVAL),
+					       OCTEON_CF_BUSY_POLL_INTERVAL / 5,
+					       HRTIMER_MODE_REL);
+			handled = 1;
+		} else {
+			handled |= octeon_cf_dma_finished(ap, qc);
+		}
 	}
 	spin_unlock_irqrestore(&host->lock, flags);
 	DPRINTK("EXIT\n");
 	return IRQ_RETVAL(handled);
 }
 
-static void octeon_cf_delayed_finish(struct work_struct *work)
+static enum hrtimer_restart octeon_cf_delayed_finish(struct hrtimer *hrt)
 {
-	struct octeon_cf_port *cf_port = container_of(work,
+	struct octeon_cf_port *cf_port = container_of(hrt,
 						      struct octeon_cf_port,
-						      delayed_finish.work);
+						      delayed_finish);
 	struct ata_port *ap = cf_port->ap;
 	struct ata_host *host = ap->host;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	u8 status;
+	enum hrtimer_restart rv = HRTIMER_NORESTART;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -726,15 +766,17 @@ static void octeon_cf_delayed_finish(struct work_struct *work)
 	status = ioread8(ap->ioaddr.altstatus_addr);
 	if (status & (ATA_BUSY | ATA_DRQ)) {
 		/* Still busy, try again. */
-		queue_delayed_work(cf_port->wq,
-				   &cf_port->delayed_finish, 1);
+		hrtimer_forward_now(hrt,
+				    ns_to_ktime(OCTEON_CF_BUSY_POLL_INTERVAL));
+		rv = HRTIMER_RESTART;
 		goto out;
 	}
 	qc = ata_qc_from_tag(ap, ap->link.active_tag);
-	if (qc && !(qc->tf.flags & ATA_TFLAG_POLLING))
+	if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 		octeon_cf_dma_finished(ap, qc);
 out:
 	spin_unlock_irqrestore(&host->lock, flags);
+	return rv;
 }
 
 static void octeon_cf_dev_config(struct ata_device *dev)
@@ -786,8 +828,8 @@ static struct ata_port_operations octeon_cf_ops = {
 	.qc_prep		= ata_noop_qc_prep,
 	.qc_issue		= octeon_cf_qc_issue,
 	.sff_dev_select		= octeon_cf_dev_select,
-	.sff_irq_on		= octeon_cf_irq_on,
-	.sff_irq_clear		= octeon_cf_irq_clear,
+	.sff_irq_on		= octeon_cf_ata_port_noaction,
+	.sff_irq_clear		= octeon_cf_ata_port_noaction,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= octeon_cf_set_piomode,
 	.set_dmamode		= octeon_cf_set_dmamode,
@@ -798,46 +840,113 @@ static int __devinit octeon_cf_probe(struct platform_device *pdev)
 {
 	struct resource *res_cs0, *res_cs1;
 
+	bool is_16bit;
+	const __be32 *cs_num;
+	struct property *reg_prop;
+	int n_addr, n_size, reg_len;
+	struct device_node *node;
+	const void *prop;
 	void __iomem *cs0;
 	void __iomem *cs1 = NULL;
 	struct ata_host *host;
 	struct ata_port *ap;
-	struct octeon_cf_data *ocd;
 	int irq = 0;
 	irq_handler_t irq_handler = NULL;
 	void __iomem *base;
 	struct octeon_cf_port *cf_port;
-	char version[32];
+	int rv = -ENOMEM;
 
-	res_cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	if (!res_cs0)
+	node = pdev->dev.of_node;
+	if (node == NULL)
 		return -EINVAL;
 
-	ocd = pdev->dev.platform_data;
+	cf_port = kzalloc(sizeof(*cf_port), GFP_KERNEL);
+	if (!cf_port)
+		return -ENOMEM;
 
-	cs0 = devm_ioremap_nocache(&pdev->dev, res_cs0->start,
-				   resource_size(res_cs0));
+	cf_port->is_true_ide = (of_find_property(node, "cavium,true-ide", NULL) != NULL);
 
-	if (!cs0)
-		return -ENOMEM;
+	prop = of_get_property(node, "cavium,bus-width", NULL);
+	if (prop)
+		is_16bit = (be32_to_cpup(prop) == 16);
+	else
+		is_16bit = false;
 
-	/* Determine from availability of DMA if True IDE mode or not */
-	if (ocd->dma_engine >= 0) {
-		res_cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		if (!res_cs1)
-			return -EINVAL;
+	n_addr = of_n_addr_cells(node);
+	n_size = of_n_size_cells(node);
 
+	reg_prop = of_find_property(node, "reg", &reg_len);
+	if (!reg_prop || reg_len < sizeof(__be32)) {
+		rv = -EINVAL;
+		goto free_cf_port;
+	}
+	cs_num = reg_prop->value;
+	cf_port->cs0 = be32_to_cpup(cs_num);
+
+	if (cf_port->is_true_ide) {
+		struct device_node *dma_node;
+		dma_node = of_parse_phandle(node,
+					    "cavium,dma-engine-handle", 0);
+		if (dma_node) {
+			struct platform_device *dma_dev;
+			dma_dev = of_find_device_by_node(dma_node);
+			if (dma_dev) {
+				struct resource *res_dma;
+				int i;
+				res_dma = platform_get_resource(dma_dev, IORESOURCE_MEM, 0);
+				if (!res_dma) {
+					of_node_put(dma_node);
+					rv = -EINVAL;
+					goto free_cf_port;
+				}
+				cf_port->dma_base = (u64)devm_ioremap_nocache(&pdev->dev, res_dma->start,
+									 resource_size(res_dma));
+
+				if (!cf_port->dma_base) {
+					of_node_put(dma_node);
+					rv = -EINVAL;
+					goto free_cf_port;
+				}
+
+				irq_handler = octeon_cf_interrupt;
+				i = platform_get_irq(dma_dev, 0);
+				if (i > 0)
+					irq = i;
+			}
+			of_node_put(dma_node);
+		}
+		res_cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res_cs1) {
+			rv = -EINVAL;
+			goto free_cf_port;
+		}
 		cs1 = devm_ioremap_nocache(&pdev->dev, res_cs1->start,
-					   resource_size(res_cs1));
+					   res_cs1->end - res_cs1->start + 1);
 
 		if (!cs1)
-			return -ENOMEM;
+			goto free_cf_port;
+
+		if (reg_len < (n_addr + n_size + 1) * sizeof(__be32)) {
+			rv = -EINVAL;
+			goto free_cf_port;
+		}
+		cs_num += n_addr + n_size;
+		cf_port->cs1 = be32_to_cpup(cs_num);
 	}
 
-	cf_port = kzalloc(sizeof(*cf_port), GFP_KERNEL);
-	if (!cf_port)
-		return -ENOMEM;
+	res_cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res_cs0) {
+		rv = -EINVAL;
+		goto free_cf_port;
+	}
+
+	cs0 = devm_ioremap_nocache(&pdev->dev, res_cs0->start,
+				   resource_size(res_cs0));
+
+	if (!cs0)
+		goto free_cf_port;
 
 	/* allocate host */
 	host = ata_host_alloc(&pdev->dev, 1);
@@ -846,21 +955,22 @@ static int __devinit octeon_cf_probe(struct platform_device *pdev)
 
 	ap = host->ports[0];
 	ap->private_data = cf_port;
+	pdev->dev.platform_data = cf_port;
 	cf_port->ap = ap;
 	ap->ops = &octeon_cf_ops;
 	ap->pio_mask = ATA_PIO6;
 	ap->flags |= ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING;
 
-	base = cs0 + ocd->base_region_bias;
-	if (!ocd->is16bit) {
+	if (!is_16bit) {
+		base = cs0 + 0x800;
 		ap->ioaddr.cmd_addr	= base;
 		ata_sff_std_ports(&ap->ioaddr);
 
 		ap->ioaddr.altstatus_addr = base + 0xe;
 		ap->ioaddr.ctl_addr	= base + 0xe;
 		octeon_cf_ops.sff_data_xfer = octeon_cf_data_xfer8;
-	} else if (cs1) {
-		/* Presence of cs1 indicates True IDE mode.  */
+	} else if (cf_port->is_true_ide) {
+		base = cs0;
 		ap->ioaddr.cmd_addr	= base + (ATA_REG_CMD << 1) + 1;
 		ap->ioaddr.data_addr	= base + (ATA_REG_DATA << 1);
 		ap->ioaddr.error_addr	= base + (ATA_REG_ERR << 1) + 1;
@@ -876,19 +986,15 @@ static int __devinit octeon_cf_probe(struct platform_device *pdev)
 		ap->ioaddr.ctl_addr	= cs1 + (6 << 1) + 1;
 		octeon_cf_ops.sff_data_xfer = octeon_cf_data_xfer16;
 
-		ap->mwdma_mask	= ATA_MWDMA4;
-		irq = platform_get_irq(pdev, 0);
-		irq_handler = octeon_cf_interrupt;
-
-		/* True IDE mode needs delayed work to poll for not-busy.  */
-		cf_port->wq = create_singlethread_workqueue(DRV_NAME);
-		if (!cf_port->wq)
-			goto free_cf_port;
-		INIT_DELAYED_WORK(&cf_port->delayed_finish,
-				  octeon_cf_delayed_finish);
+		ap->mwdma_mask	= enable_dma ? ATA_MWDMA4 : 0;
 
+		/* True IDE mode needs a timer to poll for not-busy.  */
+		hrtimer_init(&cf_port->delayed_finish, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL);
+		cf_port->delayed_finish.function = octeon_cf_delayed_finish;
 	} else {
 		/* 16 bit but not True IDE */
+		base = cs0 + 0x800;
 		octeon_cf_ops.sff_data_xfer	= octeon_cf_data_xfer16;
 		octeon_cf_ops.softreset		= octeon_cf_softreset16;
 		octeon_cf_ops.sff_check_status	= octeon_cf_check_status16;
@@ -902,28 +1008,71 @@ static int __devinit octeon_cf_probe(struct platform_device *pdev)
 		ap->ioaddr.ctl_addr	= base + 0xe;
 		ap->ioaddr.altstatus_addr = base + 0xe;
 	}
+	cf_port->c0 = ap->ioaddr.ctl_addr;
+
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
+	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 
 	ata_port_desc(ap, "cmd %p ctl %p", base, ap->ioaddr.ctl_addr);
 
 
-	snprintf(version, sizeof(version), "%s %d bit%s",
-		 DRV_VERSION,
-		 (ocd->is16bit) ? 16 : 8,
-		 (cs1) ? ", True IDE" : "");
-	ata_print_version_once(&pdev->dev, version);
+	dev_info(&pdev->dev, "version " DRV_VERSION" %d bit%s.\n",
+		 is_16bit ? 16 : 8,
+		 cf_port->is_true_ide ? ", True IDE" : "");
 
-	return ata_host_activate(host, irq, irq_handler, 0, &octeon_cf_sht);
+	return ata_host_activate(host, irq, irq_handler,
+				 IRQF_SHARED, &octeon_cf_sht);
 
 free_cf_port:
 	kfree(cf_port);
-	return -ENOMEM;
+	return rv;
+}
+
+static void octeon_cf_shutdown(struct device *dev)
+{
+	union cvmx_mio_boot_dma_cfgx dma_cfg;
+	union cvmx_mio_boot_dma_intx dma_int;
+
+	struct octeon_cf_port *cf_port = dev->platform_data;
+
+	if (cf_port->dma_base) {
+		/* Stop and clear the dma engine.  */
+		dma_cfg.u64 = 0;
+		dma_cfg.s.size = -1;
+		cvmx_write_csr(cf_port->dma_base + DMA_CFG, dma_cfg.u64);
+
+		/* Disable the interrupt.  */
+		dma_int.u64 = 0;
+		cvmx_write_csr(cf_port->dma_base + DMA_INT_EN, dma_int.u64);
+
+		/* Clear the DMA complete status */
+		dma_int.s.done = 1;
+		cvmx_write_csr(cf_port->dma_base + DMA_INT, dma_int.u64);
+
+		__raw_writeb(0, cf_port->c0);
+		udelay(20);
+		__raw_writeb(ATA_SRST, cf_port->c0);
+		udelay(20);
+		__raw_writeb(0, cf_port->c0);
+		mdelay(100);
+	}
 }
 
+static struct of_device_id octeon_cf_match[] = {
+	{
+		.compatible = "cavium,ebt3000-compact-flash",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_i2c_match);
+
 static struct platform_driver octeon_cf_driver = {
 	.probe		= octeon_cf_probe,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = octeon_cf_match,
+		.shutdown = octeon_cf_shutdown
 	},
 };
 
-- 
1.7.11.2
