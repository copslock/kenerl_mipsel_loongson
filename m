Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 02:04:53 +0100 (CET)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:38153 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012435AbaKBBEwM0CiW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 02:04:52 +0100
Received: by mail-pd0-f182.google.com with SMTP id fp1so9487550pdb.13
        for <multiple recipients>; Sat, 01 Nov 2014 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4yXHLKKnC7swTgpYBEOSP4qSw+X0tJNBChso4h7IDhU=;
        b=V2gcA8yakH99B1t4rD3cZS2+8sOf4eOcb53v2Xp7ZvgnVqLzr/7YYCfWa/vdFkeNEY
         v9p17rxPo7mMwbYcOhQL6PUTWnjxEIFLPvyiQNEUSjodsOU+AsfH58UsVWRdTjaUQQxv
         eGpEQsapJXfuV/Havdsxov2cnLLvkfgf2V8HJwrwrD2gfqnkoq8Tq6IY2WAlOQMWCSa2
         bz+84iw4qqYD9IAzPhf8xd02ZAVYgKsv7VPUwoNeQgR1/VxyiF6ThV03oF/yi1Z8zvbs
         aNrPCSuitzRImMKoG2LKLSpjpelKZ4jkFLij7yr2JqaphTnBJEz4Ij8AYW+DeZ3FTMKO
         Fmxw==
X-Received: by 10.66.157.101 with SMTP id wl5mr8589924pab.37.1414890285259;
        Sat, 01 Nov 2014 18:04:45 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id f7sm13488343pdj.15.2014.11.01.18.04.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Nov 2014 18:04:44 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
Cc:     linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V3 00/14] genirq endian fixes; bcm7120/brcmstb IRQ updates
Date:   Sat,  1 Nov 2014 18:03:47 -0700
Message-Id: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

V2->V3:

 - Move updated irq_reg_{readl,writel} functions back into <linux/irq.h>
   so they can be called by irqchip drivers

 - Add gc->reg_{readl,writel} function pointers so that irqchip
   drivers like arch/sh/boards/mach-se/{7343,7722}/irq.c can override them

 - CC: linux-sh list in lieu of Paul's defunct linux-sh.org email address

 - Fix handling of zero L2 status in bcm7120-l2.c

 - Rebase on Linus' head of tree

 - Drop GENERIC_CHIP / GENERIC_CHIP_BE compile-time optimizations

For the latter item, I ran a quick benchmark to see if the extra
indirection in irq_reg_{readl,write} had any perceptible effect on
register access times.  The MIPS BE case did show a small performance
hit from using the read wrapper, but on ARM LE the only differences
were attributed to the presence/absence of a barrier:


BCM3384 (UBUS architecture, MIPS BE, IRQ_GC_BE_IO):

irq_reg_readl       : 207 ns
readl               : 186 ns
__raw_readl         : 186 ns
ioread32be          : 195 ns

irq_reg_writel      : 177 ns
writel              : 177 ns
__raw_writel        : 177 ns
iowrite32be         : 177 ns


BCM7445 (GISB architecture, ARM LE, standard LE readl):

irq_reg_readl       : 519 ns
readl               : 519 ns
__raw_readl         : 482 ns
ioread32be          : 519 ns

irq_reg_writel      : 500 ns
writel              : 500 ns
__raw_writel        : 482 ns
iowrite32be         : 500 ns


Test code (do not merge):

-- 8< --

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index e7c6155..fcbe8e8 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -14,6 +14,8 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/kconfig.h>
+#include <linux/ktime.h>
+#include <linux/math64.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -21,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqflags.h>
 #include <linux/io.h>
 #include <linux/irqdomain.h>
 #include <linux/reboot.h>
@@ -120,6 +123,8 @@ static int bcm7120_l2_intc_init_one(struct device_node *dn,
 	return 0;
 }
 
+static struct irq_chip_generic *some_gc;
+
 int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 					struct device_node *parent)
 {
@@ -213,6 +218,7 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 	for (idx = 0; idx < data->n_words; idx++) {
 		irq = idx * IRQS_PER_WORD;
 		gc = irq_get_domain_generic_chip(data->domain, irq);
+		some_gc = gc;
 
 		gc->unused = 0xffffffff & ~data->irq_map_mask[idx];
 		gc->reg_base = data->base[idx];
@@ -253,3 +259,58 @@ out_unmap:
 }
 IRQCHIP_DECLARE(bcm7120_l2_intc, "brcm,bcm7120-l2-intc",
 		bcm7120_l2_intc_of_init);
+
+static const int iterations = 10000000;
+
+static void print_elapsed(const char *tag, ktime_t start)
+{
+	printk("%-20s: %lld ns\n", tag,
+		div64_u64(ktime_to_ns(ktime_sub(ktime_get(), start)),
+			  iterations));
+}
+
+static int __init reg_timetest(void)
+{
+	int i;
+	ktime_t start;
+	struct irq_chip_generic *gc = some_gc;
+
+	local_irq_disable();
+	for (start = ktime_get(), i = 0; i < iterations; i++)
+		irq_reg_readl(gc, IRQSTAT);
+	print_elapsed("irq_reg_readl", start);
+
+	for (start = ktime_get(), i = 0; i < iterations; i++)
+		readl(gc->reg_base + IRQSTAT);
+	print_elapsed("readl", start);
+
+	for (start = ktime_get(), i = 0; i < iterations; i++)
+		__raw_readl(gc->reg_base + IRQSTAT);
+	print_elapsed("__raw_readl", start);
+
+	for (start = ktime_get(), i = 0; i < iterations; i++)
+		ioread32be(gc->reg_base + IRQSTAT);
+	print_elapsed("ioread32be", start);
+
+	printk("\n");
+
+	for (start = ktime_get(), i = 0; i < iterations; i++)
+		irq_reg_writel(gc, 0, IRQSTAT);
+	print_elapsed("irq_reg_writel", start);
+
+	for (start = ktime_get(), i = 0; i < iterations; i++)
+		writel(0, gc->reg_base + IRQSTAT);
+	print_elapsed("writel", start);
+
+	for (start = ktime_get(), i = 0; i < iterations; i++)
+		__raw_writel(0, gc->reg_base + IRQSTAT);
+	print_elapsed("__raw_writel", start);
+
+	for (start = ktime_get(), i = 0; i < iterations; i++)
+		iowrite32be(0, gc->reg_base + IRQSTAT);
+	print_elapsed("iowrite32be", start);
+	local_irq_enable();
+
+	return 0;
+}
+device_initcall(reg_timetest);

-- 8< --

Kevin Cernekee (14):
  sh: Eliminate unused irq_reg_{readl,writel} accessors
  genirq: Generic chip: Change irq_reg_{readl,writel} arguments
  genirq: Generic chip: Allow irqchip drivers to override
    irq_reg_{readl,writel}
  genirq: Generic chip: Add big endian I/O accessors
  irqchip: brcmstb-l2: Eliminate dependency on ARM code
  irqchip: bcm7120-l2: Eliminate bad IRQ check
  irqchip: bcm7120-l2, brcmstb-l2: Remove ARM Kconfig dependency
  irqchip: bcm7120-l2: Make sure all register accesses use base+offset
  irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
  irqchip: bcm7120-l2: Use gc->mask_cache to simplify suspend/resume
    functions
  irqchip: bcm7120-l2: Extend driver to support 64+ bit controllers
  irqchip: bcm7120-l2: Decouple driver from brcmstb-l2
  irqchip: bcm7120-l2: Convert driver to use irq_reg_{readl,writel}
  irqchip: brcmstb-l2: Convert driver to use irq_reg_{readl,writel}

 .../interrupt-controller/brcm,bcm7120-l2-intc.txt  |  26 ++-
 arch/arm/mach-bcm/Kconfig                          |   1 +
 arch/sh/boards/mach-se/7343/irq.c                  |   3 -
 arch/sh/boards/mach-se/7722/irq.c                  |   3 -
 drivers/irqchip/Kconfig                            |   6 +-
 drivers/irqchip/Makefile                           |   4 +-
 drivers/irqchip/irq-atmel-aic.c                    |  40 ++---
 drivers/irqchip/irq-atmel-aic5.c                   |  65 ++++----
 drivers/irqchip/irq-bcm7120-l2.c                   | 174 +++++++++++++--------
 drivers/irqchip/irq-brcmstb-l2.c                   |  41 +++--
 drivers/irqchip/irq-sunxi-nmi.c                    |   4 +-
 drivers/irqchip/irq-tb10x.c                        |   4 +-
 include/linux/irq.h                                |  29 +++-
 kernel/irq/generic-chip.c                          |  36 +++--
 14 files changed, 260 insertions(+), 176 deletions(-)

-- 
2.1.1
