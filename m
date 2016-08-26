Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:20:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42943 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992472AbcHZOUAd70pn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:20:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6E5FEC8A3FAD9;
        Fri, 26 Aug 2016 15:19:40 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:19:43 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 05/19] MIPS: SEAD3: Probe ethernet controller using DT
Date:   Fri, 26 Aug 2016 15:17:37 +0100
Message-ID: <20160826141751.13121-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826141751.13121-1-paul.burton@imgtec.com>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54768
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

Probe the smsc911x ethernet controller using device tree rather than
platform code, reducing the amount of the latter.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/boot/dts/mti/sead3.dts             | 12 ++++++++++
 arch/mips/include/asm/mips-boards/sead3int.h |  2 --
 arch/mips/mti-sead3/sead3-dtshim.c           | 15 ++++++++++++-
 arch/mips/mti-sead3/sead3-platform.c         | 33 ----------------------------
 4 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index 3f681c5..29ed194 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -87,4 +87,16 @@
 
 		no-loopback-test;
 	};
+
+	eth@1f010000 {
+		compatible = "smsc,lan9115";
+		reg = <0x1f010000 0x10000>;
+		reg-io-width = <4>;
+
+		interrupts = <0>; /* GIC 0 or CPU 6 */
+
+		phy-mode = "mii";
+		smsc,irq-push-pull;
+		smsc,save-mac-address;
+	};
 };
diff --git a/arch/mips/include/asm/mips-boards/sead3int.h b/arch/mips/include/asm/mips-boards/sead3int.h
index 3a5e079..7fdb9d4 100644
--- a/arch/mips/include/asm/mips-boards/sead3int.h
+++ b/arch/mips/include/asm/mips-boards/sead3int.h
@@ -14,10 +14,8 @@
 
 /* CPU interrupt offsets */
 #define CPU_INT_EHCI		2
-#define CPU_INT_NET		6
 
 /* GIC interrupt offsets */
-#define GIC_INT_NET		GIC_SHARED_TO_HWIRQ(0)
 #define GIC_INT_EHCI		GIC_SHARED_TO_HWIRQ(5)
 
 #endif /* !(_MIPS_SEAD3INT_H) */
diff --git a/arch/mips/mti-sead3/sead3-dtshim.c b/arch/mips/mti-sead3/sead3-dtshim.c
index b462f65..279d8d4 100644
--- a/arch/mips/mti-sead3/sead3-dtshim.c
+++ b/arch/mips/mti-sead3/sead3-dtshim.c
@@ -25,7 +25,8 @@ static unsigned char fdt_buf[16 << 10] __initdata;
 static int remove_gic(void *fdt)
 {
 	const unsigned int cpu_uart_int = 4;
-	int gic_off, cpu_off, uart_off, err;
+	const unsigned int cpu_eth_int = 6;
+	int gic_off, cpu_off, uart_off, eth_off, err;
 	uint32_t cfg, cpu_phandle;
 
 	/* leave the GIC node intact if a GIC is present */
@@ -82,6 +83,18 @@ static int remove_gic(void *fdt)
 		return uart_off;
 	}
 
+	eth_off = fdt_node_offset_by_compatible(fdt, -1, "smsc,lan9115");
+	if (eth_off < 0) {
+		pr_err("unable to find ethernet DT node: %d\n", eth_off);
+		return eth_off;
+	}
+
+	err = fdt_setprop_u32(fdt, eth_off, "interrupts", cpu_eth_int);
+	if (err) {
+		pr_err("unable to set ethernet interrupts property: %d\n", err);
+		return err;
+	}
+
 	return 0;
 }
 
diff --git a/arch/mips/mti-sead3/sead3-platform.c b/arch/mips/mti-sead3/sead3-platform.c
index 538a6f8..9f9e914 100644
--- a/arch/mips/mti-sead3/sead3-platform.c
+++ b/arch/mips/mti-sead3/sead3-platform.c
@@ -14,37 +14,9 @@
 #include <linux/mtd/physmap.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/smsc911x.h>
 
 #include <asm/mips-boards/sead3int.h>
 
-static struct smsc911x_platform_config sead3_smsc911x_data = {
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
-	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-};
-
-static struct resource sead3_net_resources[] = {
-	{
-		.start			= 0x1f010000,
-		.end			= 0x1f01ffff,
-		.flags			= IORESOURCE_MEM
-	}, {
-		.flags			= IORESOURCE_IRQ
-	}
-};
-
-static struct platform_device sead3_net_device = {
-	.name			= "smsc911x",
-	.id			= 0,
-	.dev			= {
-		.platform_data	= &sead3_smsc911x_data,
-	},
-	.num_resources		= ARRAY_SIZE(sead3_net_resources),
-	.resource		= sead3_net_resources
-};
-
 static struct mtd_partition sead3_mtd_partitions[] = {
 	{
 		.name =		"User FS",
@@ -175,7 +147,6 @@ static struct platform_device *sead3_platform_devices[] __initdata = {
 	&fled_device,
 	&sead3_led_device,
 	&ehci_device,
-	&sead3_net_device,
 };
 
 static int __init sead3_platforms_device_init(void)
@@ -204,13 +175,9 @@ static int __init sead3_platforms_device_init(void)
 	if (gic_present) {
 		ehci_resources[1].start =
 			irq_create_mapping(irqd, GIC_INT_EHCI);
-		sead3_net_resources[1].start =
-			irq_create_mapping(irqd, GIC_INT_NET);
 	} else {
 		ehci_resources[1].start =
 			irq_create_mapping(irqd, CPU_INT_EHCI);
-		sead3_net_resources[1].start =
-			irq_create_mapping(irqd, CPU_INT_NET);
 	}
 
 	return platform_add_devices(sead3_platform_devices,
-- 
2.9.3
