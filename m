Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:50:59 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:35486 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826573Ab2KKMulHi7-K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:50:41 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053444bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fvXGJVcr32m5dIdKNvwgbIeKYAF4834Jkik01CT/D5Y=;
        b=r0rk9hKO1bEbBttLDiwVYHyjH3vrzzi5Xqw3SMQYjvUH2/SNuAggHCYk37qDldaeOn
         disCVQiPBgHuVuNHJnhkBZQiGQmNWSLHckizara+VvCwWqmw2P0DSd4aUOQg36wqnkag
         SIH0OzQj3gTBREKBesWMzsJeRPSyzQqI6amiomCwDpLHZq1829ImqgUhR6fqMRyBkU3U
         aEycfd/vOXf09LfRyGBjQNA8gXpDE5VVDMR+Lnf1uz8Oe28JJQEl78OnsgLW4sayhG0Y
         j9BuATdt3Jpa8so9jw2eQVBXR2u6wLXDdrBJKrz7fcQoMZP5xDSSS8r/Ad4w+a2lTNWO
         Iuiw==
Received: by 10.204.12.215 with SMTP id y23mr5808396bky.13.1352638240893;
        Sun, 11 Nov 2012 04:50:40 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.39
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:40 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] MIPS: BCM63XX: add Device Tree glue code for IRQ handling
Date:   Sun, 11 Nov 2012 13:50:38 +0100
Message-Id: <1352638249-29298-5-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Register IRQ domains through Device Tree for the internal and external
interrupt controllers. Register the same IRQ ranges as previously to
provide backward compatibility for non-DT drivers.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 .../devicetree/bindings/mips/bcm63xx/epic.txt      |   20 ++++++++++++
 .../devicetree/bindings/mips/bcm63xx/ipic.txt      |   18 +++++++++++
 arch/mips/bcm63xx/dts/bcm6328.dtsi                 |   16 ++++++++++
 arch/mips/bcm63xx/dts/bcm6338.dtsi                 |   16 ++++++++++
 arch/mips/bcm63xx/dts/bcm6345.dtsi                 |   16 ++++++++++
 arch/mips/bcm63xx/dts/bcm6348.dtsi                 |   16 ++++++++++
 arch/mips/bcm63xx/dts/bcm6358.dtsi                 |   16 ++++++++++
 arch/mips/bcm63xx/dts/bcm6368.dtsi                 |   16 ++++++++++
 arch/mips/bcm63xx/irq.c                            |   32 ++++++++++++++++++++
 9 files changed, 166 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/bcm63xx/epic.txt
 create mode 100644 Documentation/devicetree/bindings/mips/bcm63xx/ipic.txt

diff --git a/Documentation/devicetree/bindings/mips/bcm63xx/epic.txt b/Documentation/devicetree/bindings/mips/bcm63xx/epic.txt
new file mode 100644
index 0000000..4fc74e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/bcm63xx/epic.txt
@@ -0,0 +1,20 @@
+* Broadcom BCM63XX External Interrupt Controller
+
+Properties:
+- compatible: "brcm,bcm63xx-epic"
+  Compatible with all bcm63xx SoCs.
+
+- interrupt-controller: This is an interrupt controller.
+
+- #interrupt-cells: <2>
+  This controller supports level and edge triggered interrupts. The
+  first cell is the interrupt number, the second is a 1:1 mapping to
+  the linux interrupt flags.
+
+Example:
+
+	epic: interrupt-controller@18 {
+		compatible = "brcm,bcm63xx-epic";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	}
diff --git a/Documentation/devicetree/bindings/mips/bcm63xx/ipic.txt b/Documentation/devicetree/bindings/mips/bcm63xx/ipic.txt
new file mode 100644
index 0000000..1cbabf90
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/bcm63xx/ipic.txt
@@ -0,0 +1,18 @@
+* BCM63XX Internal Interrupt Controller
+
+Properties:
+- compatible: "brcm,bcm63xx-ipic"
+  Compatible with all bcm63xx SoCs.
+
+- interrupt-controller: This is an interrupt controller.
+
+- #interrupt-cells: <1>
+  This controller supports only level interrupts.
+
+Example:
+
+	ipic: interrupt-controller@20 {
+		compatible = "brcm,bcm63xx-ipic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	}
diff --git a/arch/mips/bcm63xx/dts/bcm6328.dtsi b/arch/mips/bcm63xx/dts/bcm6328.dtsi
index a0e1835..a41033a 100644
--- a/arch/mips/bcm63xx/dts/bcm6328.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6328.dtsi
@@ -26,5 +26,21 @@
 		#size-cells = <1>;
 		ranges = <0 0x10000000 0x20000>;
 		compatible = "simple-bus";
+
+		interrupt-parent = <&ipic>;
+
+		perf@0 {
+			epic: interrupt-controller@18 {
+				compatible = "brcm,bcm63xx-epic";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			ipic: interrupt-controller@20 {
+				compatible = "brcm,bcm63xx-ipic";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6338.dtsi b/arch/mips/bcm63xx/dts/bcm6338.dtsi
index 21772d9..8ecbc4f 100644
--- a/arch/mips/bcm63xx/dts/bcm6338.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6338.dtsi
@@ -26,5 +26,21 @@
 		#size-cells = <1>;
 		ranges = <0 0xfffe0000 0x20000>;
 		compatible = "simple-bus";
+
+		interrupt-parent = <&ipic>;
+
+		perf@0 {
+			ipic: interrupt-controller@c {
+				compatible = "brcm,bcm63xx-ipic";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			epic: interrupt-controller@14 {
+				compatible = "brcm,bcm63xx-epic";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6345.dtsi b/arch/mips/bcm63xx/dts/bcm6345.dtsi
index f1e7153..ed17c12 100644
--- a/arch/mips/bcm63xx/dts/bcm6345.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6345.dtsi
@@ -26,5 +26,21 @@
 		#size-cells = <1>;
 		ranges = <0 0xfffe0000 0x20000>;
 		compatible = "simple-bus";
+
+		interrupt-parent = <&ipic>;
+
+		perf@0 {
+			ipic: interrupt-controller@c {
+				compatible = "brcm,bcm63xx-ipic";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			epic: interrupt-controller@14 {
+				compatible = "brcm,bcm63xx-epic";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6348.dtsi b/arch/mips/bcm63xx/dts/bcm6348.dtsi
index 8a5a2dc..d54cf20 100644
--- a/arch/mips/bcm63xx/dts/bcm6348.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6348.dtsi
@@ -26,5 +26,21 @@
 		#size-cells = <1>;
 		ranges = <0 0xfffe0000 0x20000>;
 		compatible = "simple-bus";
+
+		interrupt-parent = <&ipic>;
+
+		perf@0 {
+			ipic: interrupt-controller@c {
+				compatible = "brcm,bcm63xx-ipic";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			epic: interrupt-controller@14 {
+				compatible = "brcm,bcm63xx-epic";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6358.dtsi b/arch/mips/bcm63xx/dts/bcm6358.dtsi
index 1d3f20f..6ef283f 100644
--- a/arch/mips/bcm63xx/dts/bcm6358.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6358.dtsi
@@ -29,5 +29,21 @@
 		#size-cells = <1>;
 		ranges = <0 0xfffe0000 0x20000>;
 		compatible = "simple-bus";
+
+		interrupt-parent = <&ipic>;
+
+		perf@0 {
+			epic: interrupt-controller@18 {
+				compatible = "brcm,bcm63xx-epic";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			ipic: interrupt-controller@20 {
+				compatible = "brcm,bcm63xx-ipic";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/bcm6368.dtsi b/arch/mips/bcm63xx/dts/bcm6368.dtsi
index a7624b9..ae1b584 100644
--- a/arch/mips/bcm63xx/dts/bcm6368.dtsi
+++ b/arch/mips/bcm63xx/dts/bcm6368.dtsi
@@ -29,5 +29,21 @@
 		#size-cells = <1>;
 		ranges = <0 0x10000000 0x20000>;
 		compatible = "simple-bus";
+
+		interrupt-parent = <&ipic>;
+
+		perf@0 {
+			epic: interrupt-controller@18 {
+				compatible = "brcm,bcm63xx-epic";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			ipic: interrupt-controller@20 {
+				compatible = "brcm,bcm63xx-ipic";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index da24c2b..3b64066 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -12,6 +12,8 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
 #include <asm/irq_cpu.h>
 #include <asm/mipsregs.h>
 #include <bcm63xx_cpu.h>
@@ -515,6 +517,34 @@ static struct irqaction cpu_ext_cascade_action = {
 	.flags		= IRQF_NO_THREAD,
 };
 
+static int __init bcm63xx_ipic_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	if (!irq_domain_add_simple(node,
+				   IRQ_EXTERNAL_BASE - IRQ_INTERNAL_BASE,
+				   IRQ_INTERNAL_BASE, &irq_domain_simple_ops,
+				   NULL))
+		panic("unable to add ipic domain!\n");
+
+	return 0;
+}
+
+static int __init bcm63xx_epic_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	if (!irq_domain_add_simple(node, ext_irq_count, IRQ_EXTERNAL_BASE,
+				   &irq_domain_simple_ops, NULL))
+		panic("unable to add epic domain!\n");
+
+	return 0;
+}
+
+static const struct of_device_id bcm63xx_pic_of_match[] __initconst = {
+	{ .compatible = "brcm,bcm63xx-ipic", .data = bcm63xx_ipic_of_init },
+	{ .compatible = "brcm,bcm63xx-epic", .data = bcm63xx_epic_of_init },
+	{ },
+};
+
 void __init arch_init_irq(void)
 {
 	int i;
@@ -535,4 +565,6 @@ void __init arch_init_irq(void)
 	}
 
 	setup_irq(MIPS_CPU_IRQ_BASE + 2, &cpu_ip2_cascade_action);
+
+	of_irq_init(bcm63xx_pic_of_match);
 }
-- 
1.7.2.5
