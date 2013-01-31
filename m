Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 14:23:31 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:44761 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824803Ab3AaNXaFrXdr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jan 2013 14:23:30 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/3] MIPS: ralink: add CPU interrupt controller to of_irq_ids
Date:   Thu, 31 Jan 2013 14:20:44 +0100
Message-Id: <1359638444-8891-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359638444-8891-1-git-send-email-blogic@openwrt.org>
References: <1359638444-8891-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

From: Gabor Juhos <juhosg@openwrt.org>

Convert the ralink IRQ code to make use of the new MIPS IRQ controller OF
mappings.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/dts/rt305x.dts |   10 ++++++++++
 arch/mips/ralink/irq.c          |   10 +++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ralink/dts/rt305x.dts b/arch/mips/ralink/dts/rt305x.dts
index c7298f3..a9acdb2 100644
--- a/arch/mips/ralink/dts/rt305x.dts
+++ b/arch/mips/ralink/dts/rt305x.dts
@@ -11,6 +11,13 @@
 		};
 	};
 
+	cpuintc: cpuintc@0 {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
 	memory@0 {
 		reg = <0x0 0x2000000>;
 	};
@@ -47,6 +54,9 @@
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
+
+			interrupt-parent = <&cpuintc>;
+			interrupts = <2>;
 		};
 
 		memc@300 {
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index e62c975..6d054c5 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -128,8 +128,11 @@ static int __init intc_of_init(struct device_node *node,
 {
 	struct resource res;
 	struct irq_domain *domain;
+	int irq;
 
-	mips_cpu_irq_init();
+	irq = irq_of_parse_and_map(node, 0);
+	if (!irq)
+		panic("Failed to get INTC IRQ");
 
 	if (of_address_to_resource(node, 0, &res))
 		panic("Failed to get intc memory range");
@@ -156,8 +159,8 @@ static int __init intc_of_init(struct device_node *node,
 
 	rt_intc_w32(INTC_INT_GLOBAL, INTC_REG_ENABLE);
 
-	irq_set_chained_handler(RALINK_CPU_IRQ_INTC, ralink_intc_irq_handler);
-	irq_set_handler_data(RALINK_CPU_IRQ_INTC, domain);
+	irq_set_chained_handler(irq, ralink_intc_irq_handler);
+	irq_set_handler_data(irq, domain);
 
 	cp0_perfcount_irq = irq_create_mapping(domain, 9);
 
@@ -165,6 +168,7 @@ static int __init intc_of_init(struct device_node *node,
 }
 
 static struct of_device_id __initdata of_irq_ids[] = {
+	{ .compatible = "mti,cpu-interrupt-controller", .data = mips_cpu_intc_init },
 	{ .compatible = "ralink,rt2880-intc", .data = intc_of_init },
 	{},
 };
-- 
1.7.10.4
