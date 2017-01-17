Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 00:15:01 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:56790 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993889AbdAQXOyZ9uGA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 00:14:54 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 01/13] Documentation: dt/bindings: Document pinctrl-ingenic
Date:   Wed, 18 Jan 2017 00:14:09 +0100
Message-Id: <20170117231421.16310-2-paul@crapouillou.net>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1484694893; bh=8Dq1BFEuPqk2Emy9COS1sdF8JwTEafQtpKxYrblOxws=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QsFNx4D0ofUEzYeP/i1UOeDITeN4ssHT1jq4YT0ZsAKEx3RJjM8xVu/TJ+rjs1LsPZa2I6WpWYzMT7Z86bnZ7dQ795HDnJxmF60DZGbLrqXRjbEObv9m3PYDJdjd5gPSd+1lhcxznJ3y4zd5ckLZhBOWU07b83ualTieF5JZt4Q=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56370
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

From: Paul Burton <paul.burton@imgtec.com>

This commit adds documentation for the devicetree bidings of the
pinctrl-ingenic driver, which handles pin configuration, pin muxing
and GPIOs of the Ingenic SoCs currently supported by the Linux kernel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/pinctrl/ingenic,pinctrl.txt           | 173 +++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
new file mode 100644
index 000000000000..e59f7e7b6a49
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
@@ -0,0 +1,173 @@
+Ingenic jz47xx pin controller
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+For the jz47xx SoCs, pin control is tightly bound with GPIO ports. All pins may
+be used as GPIOs, multiplexed device functions are configured within the
+GPIO port configuration registers and it is typical to refer to pins using the
+naming scheme "PxN" where x is a character identifying the GPIO port with
+which the pin is associated and N is an integer from 0 to 31 identifying the
+pin within that GPIO port. For example PA0 is the first pin in GPIO port A, and
+PB31 is the last pin in GPIO port B. The jz4740 contains 4 GPIO ports, PA to
+PD, for a total of 128 pins. The jz4780 contains 6 GPIO ports, PA to PF, for a
+total of 192 pins.
+
+
+##### Pin controller node #####
+
+Required properties:
+- compatible: One of:
+  - "ingenic,jz4740-pinctrl"
+  - "ingenic,jz4780-pinctrl"
+- #address-cells: Should contain the integer 1.
+- #size-cells: Should contain the integer 1.
+- ranges: Should be empty.
+
+Required sub-nodes:
+  - gpio-chips (see below)
+  - functions (see below)
+
+The pin controller node must have two sub-nodes, 'gpio-chips' and 'functions'.
+
+
+##### 'gpio-chips' sub-node #####
+
+The gpio-chips node will contain sub-nodes that correspond to GPIO controllers
+(one sub-node per GPIO controller).
+
+Required properties:
+- #address-cells: Should contain the integer 1.
+- #size-cells: Should contain the integer 1.
+- ranges: Should be empty.
+
+
+##### 'functions' sub-node #####
+
+The "functions" node will contain sub-nodes that correspond to pin function
+nodes.
+
+Required properties:
+- None.
+
+
+##### GPIO controller node #####
+
+Each subnode of the 'gpio-chips' node is a GPIO controller node.
+
+Required properties:
+- gpio-controller: Identifies this node as a GPIO controller.
+- #gpio-cells: Should contain the integer 2.
+- reg: Should contain the physical address and length of the GPIO controller's
+  configuration registers.
+
+Optional properties:
+- interrupt-controller: The GPIO controllers can optionally configure the
+  GPIOs as interrupt sources. In this case, the 'interrupt-controller'
+  standalone property should be supplied.
+- #interrupt-cells: Required if 'interrupt-controller' is also specified.
+  In that case, it should contain the integer 2.
+- interrupts: Required if 'interrupt-controller' is also specified.
+  In that case, it should contain the IRQ number of this GPIO controller.
+- ingenic,pull-ups: A bit mask identifying the pins associated with this GPIO
+  port which feature a pull-up resistor. The default mask is 0x0.
+- ingenic,pull-downs: A bit mask identifying the pins associated with this GPIO
+  port which feature a pull-down resistor. The default mask is 0x0.
+  Each pin of the jz47xx SoCs may feature a single bias resistor, thus there
+  should be no bits which are set in both ingenic,pull-ups & ingenic,pull-downs.
+
+
+##### Pin function node #####
+
+Each subnode of the 'functions' node is a pin function node.
+
+These subnodes represent a functionality of the SoC which may be exposed
+through one or more groups of pins, represented as subnodes of the pin
+function node. For example a function may be uart0, which may be exposed
+through the group of pins PF0 to PF3.
+
+Required pin function node properties:
+- None.
+
+
+##### Pin group node #####
+
+Each subnode of a pin function node is a pin group node.
+
+Required pin group node properties:
+- ingenic,pins: A set of values representing the pins within this pin group and
+  their configuration. Four values should be provided for each pin:
+  - The phandle of the GPIO controller node for the GPIO port within which the
+    pin is found.
+  - The index of the pin within its GPIO port (an integer in the range 0 to 31
+    inclusive).
+  - The index of the shared function port to be programmed in the GPIO port
+    registers for this pin.
+    Tables of these may be found in the jz4740 and jz4780 programming
+    manuals within the "General-Purpose I/O Ports" -> "Overview" section.
+    The value can either be supplied directly (0 for function 0, 1 for
+    function 1, etc.) or using the macros present in
+    <dt-bindings/pinctrl/ingenic.h>.
+    The special macro JZ_PIN_MODE_GPIO can be used to specify that the pin is
+    to be used as a GPIO. This is useful, for instance, when you just want to
+    set the electrical configuration of a pin used as GPIO.
+  - The phandle of a pin configuration node specifying the electrical
+    configuration that should be applied to the pin.
+
+For example the function 'msc0' may be exposed through 2 different pin groups,
+one in GPIO port A and one in GPIO port E:
+
+  bias-configs {
+    nobias: nobias {
+      bias-disable;
+    };
+  };
+
+  functions {
+    pinfunc_msc0: msc0 {
+      pins_msc0_pa: msc0-pa {
+        ingenic,pins = <&gpa  4 1 &nobias   /* d4 */
+                        &gpa  5 1 &nobias   /* d5 */
+                        &gpa  6 1 &nobias   /* d6 */
+                        &gpa  7 1 &nobias   /* d7 */
+                        &gpa 18 1 &nobias   /* clk */
+                        &gpa 19 1 &nobias   /* cmd */
+                        &gpa 20 1 &nobias   /* d0 */
+                        &gpa 21 1 &nobias   /* d1 */
+                        &gpa 22 1 &nobias   /* d2 */
+                        &gpa 23 1 &nobias   /* d3 */
+                        &gpa 24 1 &nobias>; /* rst */
+      };
+
+      pins_msc0_pe: msc0-pe {
+        ingenic,pins = <&gpe 20 0 &nobias   /* d0 */
+                        &gpe 21 0 &nobias   /* d1 */
+                        &gpe 22 0 &nobias   /* d2 */
+                        &gpe 23 0 &nobias   /* d3 */
+                        &gpe 28 0 &nobias   /* clk */
+                        &gpe 29 0 &nobias>; /* cmd */
+      };
+    };
+  };
+
+
+##### Pin configuration node #####
+
+The pin configuration nodes are referenced by phandle, and can be placed
+anywhere in the device tree (including in the pin controller node, or in a
+sub-node that is not 'gpio-chips' or 'functions').
+
+Pin configuration nodes use generic pinconf properties to specify an electrical
+configuration of a pin. The only configurable property for a pin of the jz47xx
+SoCs is whether to enable its bias resistor. Thus the only supported pinconf
+properties are:
+
+- bias-disable
+- bias-pull-up
+- bias-pull-down
+
+No arguments are supported for any of these properties.
+
+For more information about generic pinconfig properties, see
+Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-- 
2.11.0
