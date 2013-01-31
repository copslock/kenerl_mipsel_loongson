Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 14:23:58 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:44765 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825723Ab3AaNXahF610 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jan 2013 14:23:30 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/3] Document: devicetree: add OF documents for MIPS interrupt controller
Date:   Thu, 31 Jan 2013 14:20:42 +0100
Message-Id: <1359638444-8891-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35661
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 Documentation/devicetree/bindings/mips/cpu_irq.txt |   47 ++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/cpu_irq.txt

diff --git a/Documentation/devicetree/bindings/mips/cpu_irq.txt b/Documentation/devicetree/bindings/mips/cpu_irq.txt
new file mode 100644
index 0000000..13aa4b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/cpu_irq.txt
@@ -0,0 +1,47 @@
+MIPS CPU interrupt controller
+
+On MIPS the mips_cpu_intc_init() helper can be used to initialize the 8 CPU
+IRQs from a devicetree file and create a irq_domain for IRQ controller.
+
+With the irq_domain in place we can describe how the 8 IRQs are wired to the
+platforms internal interrupt controller cascade.
+
+Below is an example of a platform describing the cascade inside the devicetree
+and the code used to load it inside arch_init_irq().
+
+Required properties:
+- compatible : Should be "mti,cpu-interrupt-controller"
+
+Example devicetree:
+	cpu-irq: cpu-irq@0 {
+		#address-cells = <0>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		compatible = "mti,cpu-interrupt-controller";
+	};
+
+	intc: intc@200 {
+		compatible = "ralink,rt2880-intc";
+		reg = <0x200 0x100>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpu-irq>;
+		interrupts = <2>;
+	};
+
+
+Example platform irq.c:
+static struct of_device_id __initdata of_irq_ids[] = {
+	{ .compatible = "mti,cpu-interrupt-controller", .data = mips_cpu_intc_init },
+	{ .compatible = "ralink,rt2880-intc", .data = intc_of_init },
+	{},
+};
+
+void __init arch_init_irq(void)
+{
+	of_irq_init(of_irq_ids);
+}
-- 
1.7.10.4
