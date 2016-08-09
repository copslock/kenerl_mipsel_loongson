Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 14:39:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27673 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992696AbcHIMiDXZRp4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 14:38:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4BCDFFE03CE73;
        Tue,  9 Aug 2016 13:37:41 +0100 (IST)
Received: from localhost (10.100.200.230) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 9 Aug
 2016 13:37:43 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 07/20] MIPS: SEAD3: Probe EHCI controller using DT
Date:   Tue, 9 Aug 2016 13:35:32 +0100
Message-ID: <20160809123546.10190-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160809123546.10190-1-paul.burton@imgtec.com>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.230]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Probe the SEAD3 EHCI controller using device tree rather than platform
code, in order to reduce the amount of the latter.

Now that no devices probed from platform code require interrupts, remove
the retrieval of the IRQ domain & sead3int.h.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/boot/dts/mti/sead3.dts             |  7 ++++
 arch/mips/include/asm/mips-boards/sead3int.h | 21 ----------
 arch/mips/mti-sead3/sead3-dtshim.c           | 15 ++++++-
 arch/mips/mti-sead3/sead3-platform.c         | 59 ----------------------------
 4 files changed, 21 insertions(+), 81 deletions(-)
 delete mode 100644 arch/mips/include/asm/mips-boards/sead3int.h

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index 29ed194..66f7947 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -60,6 +60,13 @@
 		};
 	};
 
+	ehci@1b200000 {
+		compatible = "mti,sead3-ehci";
+		reg = <0x1b200000 0x1000>;
+
+		interrupts = <0>; /* GIC 0 or CPU 6 */
+	};
+
 	/* UART connected to FTDI & miniUSB socket */
 	uart0: uart@1f000900 {
 		compatible = "ns16550a";
diff --git a/arch/mips/include/asm/mips-boards/sead3int.h b/arch/mips/include/asm/mips-boards/sead3int.h
deleted file mode 100644
index 7fdb9d4..0000000
--- a/arch/mips/include/asm/mips-boards/sead3int.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2000,2012 MIPS Technologies, Inc.  All rights reserved.
- *	Douglas Leung <douglas@mips.com>
- *	Steven J. Hill <sjhill@mips.com>
- */
-#ifndef _MIPS_SEAD3INT_H
-#define _MIPS_SEAD3INT_H
-
-#include <linux/irqchip/mips-gic.h>
-
-/* CPU interrupt offsets */
-#define CPU_INT_EHCI		2
-
-/* GIC interrupt offsets */
-#define GIC_INT_EHCI		GIC_SHARED_TO_HWIRQ(5)
-
-#endif /* !(_MIPS_SEAD3INT_H) */
diff --git a/arch/mips/mti-sead3/sead3-dtshim.c b/arch/mips/mti-sead3/sead3-dtshim.c
index 50f3236..40f8e03 100644
--- a/arch/mips/mti-sead3/sead3-dtshim.c
+++ b/arch/mips/mti-sead3/sead3-dtshim.c
@@ -22,9 +22,10 @@ static unsigned char fdt_buf[16 << 10] __initdata;
 
 static int remove_gic(void *fdt)
 {
+	const unsigned int cpu_ehci_int = 2;
 	const unsigned int cpu_uart_int = 4;
 	const unsigned int cpu_eth_int = 6;
-	int gic_off, cpu_off, uart_off, eth_off, err;
+	int gic_off, cpu_off, uart_off, eth_off, ehci_off, err;
 	uint32_t cfg, cpu_phandle;
 
 	/* leave the GIC node intact if a GIC is present */
@@ -93,6 +94,18 @@ static int remove_gic(void *fdt)
 		return err;
 	}
 
+	ehci_off = fdt_node_offset_by_compatible(fdt, -1, "mti,sead3-ehci");
+	if (ehci_off < 0) {
+		pr_err("unable to find EHCI DT node: %d\n", ehci_off);
+		return ehci_off;
+	}
+
+	err = fdt_setprop_u32(fdt, ehci_off, "interrupts", cpu_ehci_int);
+	if (err) {
+		pr_err("unable to set EHCI interrupts property: %d\n", err);
+		return err;
+	}
+
 	return 0;
 }
 
diff --git a/arch/mips/mti-sead3/sead3-platform.c b/arch/mips/mti-sead3/sead3-platform.c
index f79a890..21047b5 100644
--- a/arch/mips/mti-sead3/sead3-platform.c
+++ b/arch/mips/mti-sead3/sead3-platform.c
@@ -7,16 +7,10 @@
  */
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/irqchip/mips-gic.h>
-#include <linux/irqdomain.h>
 #include <linux/leds.h>
 #include <linux/mtd/physmap.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 
-#include <asm/mips-boards/sead3int.h>
-
 static struct mtd_partition sead3_mtd_partitions[] = {
 	{
 		.name =		"User FS",
@@ -118,68 +112,15 @@ static struct platform_device sead3_led_device = {
         .id     = -1,
 };
 
-static struct resource ehci_resources[] = {
-	{
-		.start			= 0x1b200000,
-		.end			= 0x1b200fff,
-		.flags			= IORESOURCE_MEM
-	}, {
-		.flags			= IORESOURCE_IRQ
-	}
-};
-
-static u64 sead3_usbdev_dma_mask = DMA_BIT_MASK(32);
-
-static struct platform_device ehci_device = {
-	.name		= "sead3-ehci",
-	.id		= 0,
-	.dev		= {
-		.dma_mask		= &sead3_usbdev_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32)
-	},
-	.num_resources	= ARRAY_SIZE(ehci_resources),
-	.resource	= ehci_resources
-};
-
 static struct platform_device *sead3_platform_devices[] __initdata = {
 	&sead3_flash,
 	&pled_device,
 	&fled_device,
 	&sead3_led_device,
-	&ehci_device,
 };
 
 static int __init sead3_platforms_device_init(void)
 {
-	const char *intc_compat;
-	struct device_node *node;
-	struct irq_domain *irqd;
-
-	if (gic_present)
-		intc_compat = "mti,gic"
-	else
-		intc_compat = "mti,cpu-interrupt-controller";
-
-	node = of_find_compatible_node(NULL, NULL, intc_compat);
-	if (!node) {
-		pr_err("unable to find interrupt controller DT node\n");
-		return -ENODEV;
-	}
-
-	irqd = irq_find_host(node);
-	if (!irqd) {
-		pr_err("unable to find interrupt controller IRQ domain\n");
-		return -ENODEV;
-	}
-
-	if (gic_present) {
-		ehci_resources[1].start =
-			irq_create_mapping(irqd, GIC_INT_EHCI);
-	} else {
-		ehci_resources[1].start =
-			irq_create_mapping(irqd, CPU_INT_EHCI);
-	}
-
 	return platform_add_devices(sead3_platform_devices,
 				    ARRAY_SIZE(sead3_platform_devices));
 }
-- 
2.9.2
