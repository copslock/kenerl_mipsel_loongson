Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 00:30:26 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:60058 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994673AbeCQX3kGMwVh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 00:29:40 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 4/8] dt-bindings: Add doc for the Ingenic TCU drivers
Date:   Sun, 18 Mar 2018 00:28:57 +0100
Message-Id: <20180317232901.14129-5-paul@crapouillou.net>
In-Reply-To: <20180317232901.14129-1-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1521329379; bh=dP9gDM2vxCgS9n46a6rWIX5G2IF6HAt+lcdogYXk9VY=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hj/5OUnY4/jGoI+Fd1q9Y4EtyGhr3a8k5PWG98sh32niIwm3V50pYcJQzikPehgAj9EEwiYUy07SLfOR6KDzQs2R7JwS9Fxa8zpa7rF7H59QSQdih2jbeBZ14j8vtwOjJU3KrU/Juq6CrlyEUnuJyOmqYlztNurDQVaQ7Sh+r14=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Add documentation about how to properly use the Ingenic TCU
(Timer/Counter Unit) drivers from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/clock/ingenic,tcu-clocks.txt          | 42 ++++++++++++++++
 .../bindings/interrupt-controller/ingenic,tcu.txt  | 39 +++++++++++++++
 .../devicetree/bindings/mfd/ingenic,tcu.txt        | 56 ++++++++++++++++++++++
 .../devicetree/bindings/timer/ingenic,tcu.txt      | 41 ++++++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,tcu-clocks.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,tcu.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ingenic,tcu.txt
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt

 v4: New patch in this series. Corresponds to V2 patches 3-4-5 with
 added content.

diff --git a/Documentation/devicetree/bindings/clock/ingenic,tcu-clocks.txt b/Documentation/devicetree/bindings/clock/ingenic,tcu-clocks.txt
new file mode 100644
index 000000000000..471d27078599
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ingenic,tcu-clocks.txt
@@ -0,0 +1,42 @@
+Ingenic SoC TCU binding
+
+The TCU is the Timer/Counter Unit present in all Ingenic SoCs. It features 8
+channels, each one having its own clock, that can be started and stopped,
+reparented, and reclocked.
+
+Required properties:
+- compatible : One of:
+  * ingenic,jz4740-tcu-clocks,
+  * ingenic,jz4770-tcu-clocks,
+  * ingenic,jz4780-tcu-clocks.
+- clocks : List of phandle & clock specifiers for clocks external to the TCU.
+  The "pclk", "rtc" and "ext" clocks should be provided.
+- clock-names : List of name strings for the external clocks.
+- #clock-cells: Should be 1.
+  Clock consumers specify this argument to identify a clock. The valid values
+  may be found in <dt-bindings/clock/ingenic,tcu.h>.
+
+Example:
+
+/ {
+	tcu: mfd@10002000 {
+		compatible = "ingenic,tcu", "simple-mfd", "syscon";
+		reg = <0x10002000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10002000 0x1000>;
+
+		tcu_clk: clocks@10 {
+			compatible = "ingenic,jz4740-tcu-clocks";
+			reg = <0x10 0xff0>;
+
+			clocks = <&ext>, <&rtc>, <&pclk>;
+			clock-names = "ext", "rtc", "pclk";
+
+			#clock-cells = <1>;
+		};
+	};
+};
+
+For information about the top-level "ingenic,tcu" compatible node and other
+children nodes, see Documentation/devicetree/bindings/mfd/ingenic,tcu.txt.
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,tcu.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,tcu.txt
new file mode 100644
index 000000000000..7f3af2da77cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,tcu.txt
@@ -0,0 +1,39 @@
+Ingenic SoCs Timer/Counter Unit Interrupt Controller
+
+Required properties:
+
+- compatible : should be "ingenic,<socname>-tcu-intc". Valid strings are:
+  * ingenic,jz4740-tcu-intc
+  * ingenic,jz4770-tcu-intc
+  * ingenic,jz4780-tcu-intc
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+- interrupt-parent : phandle of the interrupt controller.
+- interrupts : Specifies the interrupt the controller is connected to.
+
+Example:
+
+/ {
+	tcu: mfd@10002000 {
+		compatible = "ingenic,tcu", "simple-mfd", "syscon";
+		reg = <0x10002000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10002000 0x1000>;
+
+		tcu_irq: interrupt-controller@20 {
+			compatible = "ingenic,jz4740-tcu-intc";
+			reg = <0x20 0x20>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&intc>;
+			interrupts = <15>;
+		};
+	};
+};
+
+For information about the top-level "ingenic,tcu" compatible node and other
+children nodes, see Documentation/devicetree/bindings/mfd/ingenic,tcu.txt.
diff --git a/Documentation/devicetree/bindings/mfd/ingenic,tcu.txt b/Documentation/devicetree/bindings/mfd/ingenic,tcu.txt
new file mode 100644
index 000000000000..5742c3f21550
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ingenic,tcu.txt
@@ -0,0 +1,56 @@
+Ingenic JZ47xx SoCs Timer/Counter Unit devicetree bindings
+----------------------------------------------------------
+
+For a description of the TCU hardware and drivers, have a look at
+Documentation/mips/ingenic-tcu.txt.
+
+The TCU is implemented as a parent node, whose role is to create the
+regmap, and child nodes for the various drivers listed in the aforementioned
+document.
+
+Required properties:
+
+- compatible: must be "ingenic,tcu", "simple-mfd", "syscon";
+- reg: Should be the offset/length value corresponding to the TCU registers
+- #address-cells: Should be <1>;
+- #size-cells: Should be <1>;
+- ranges: Should be one range for the full TCU registers area
+
+Accepted children nodes:
+- Documentation/devicetree/bindings/interrupt-controller/ingenic,tcu.txt
+- Documentation/devicetree/bindings/clock/ingenic,tcu-clocks.txt
+- Documentation/devicetree/bindings/timer/ingenic,tcu.txt
+
+
+Example:
+
+/ {
+	tcu: mfd@10002000 {
+		compatible = "ingenic,tcu", "simple-mfd", "syscon";
+		reg = <0x10002000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10002000 0x1000>;
+
+		tcu_irq: interrupt-controller@20 {
+			compatible = "ingenic,jz4740-tcu-intc";
+			reg = <0x20 0x20>;
+			...
+		};
+
+		tcu_clk: clocks@10 {
+			compatible = "ingenic,jz4740-tcu-clocks";
+			reg = <0x10 0xff0>;
+			...
+		};
+
+		tcu_timer: timer@10 {
+			compatible = "ingenic,jz4740-tcu";
+			reg = <0x10 0xff0>;
+			...
+		};
+	};
+};
+
+For more information about the children node, refer to the documents listed
+above in the "Accepted children nodes" section.
diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
new file mode 100644
index 000000000000..f910b7e96783
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
@@ -0,0 +1,41 @@
+Ingenic JZ47xx SoCs Timer/Counter Unit driver
+---------------------------------------------
+
+Required properties:
+
+- compatible : should be "ingenic,<socname>-tcu". Valid strings are:
+  * ingenic,jz4740-tcu
+  * ingenic,jz4770-tcu
+  * ingenic,jz4780-tcu
+- interrupt-parent : phandle of the TCU interrupt controller.
+- interrupts : Specifies the interrupts the controller is connected to.
+- clocks : List of phandle & clock specifiers for the TCU clocks.
+- clock-names : List of name strings for the TCU clocks.
+
+Example:
+
+/ {
+	tcu: mfd@10002000 {
+		compatible = "ingenic,tcu", "simple-mfd", "syscon";
+		reg = <0x10002000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10002000 0x1000>;
+
+		tcu_timer: timer@10 {
+			compatible = "ingenic,jz4740-tcu";
+			reg = <0x10 0xff0>;
+
+			clocks = <&tcu_clk 0>, <&tcu_clk 1>, <&tcu_clk 2>, <&tcu_clk 3>,
+					 <&tcu_clk 4>, <&tcu_clk 5>, <&tcu_clk 6>, <&tcu_clk 7>;
+			clock-names = "timer0", "timer1", "timer2", "timer3",
+						  "timer4", "timer5", "timer6", "timer7";
+
+			interrupt-parent = <&tcu_irq>;
+			interrupts = <0 1 2 3 4 5 6 7>;
+		};
+	};
+};
+
+For information about the top-level "ingenic,tcu" compatible node and other
+children nodes, see Documentation/devicetree/bindings/mfd/ingenic,tcu.txt.
-- 
2.11.0
