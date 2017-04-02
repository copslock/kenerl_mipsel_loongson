Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2017 22:43:50 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:44076 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdDBUnXO2lQj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2017 22:43:23 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 02/14] dt/bindings: Document gpio-ingenic
Date:   Sun,  2 Apr 2017 22:42:32 +0200
Message-Id: <20170402204244.14216-3-paul@crapouillou.net>
In-Reply-To: <20170402204244.14216-1-paul@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57533
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

This commit adds documentation for the devicetree bindings of the
gpio-ingenic driver, which handles GPIOs of the Ingenic SoCs
currently supported by the Linux kernel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/gpio/ingenic,gpio.txt      | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt

 v2: New patch
 v3: No changes
 v4: Update for the v4 version of the gpio-ingenic driver

diff --git a/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
new file mode 100644
index 000000000000..f54af444f7c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
@@ -0,0 +1,48 @@
+Ingenic jz47xx GPIO controller
+
+That the Ingenic GPIO driver node must be a sub-node of the Ingenic pinctrl
+driver node.
+
+Required properties:
+--------------------
+
+ - compatible: Must contain one of:
+    - "ingenic,jz4740-gpio"
+    - "ingenic,jz4770-gpio"
+    - "ingenic,jz4780-gpio"
+	And one of:
+	- "ingenic,gpio-bank-a"
+	- "ingenic,gpio-bank-b"
+	- "ingenic,gpio-bank-c"
+	- "ingenic,gpio-bank-d"
+	- "ingenic,gpio-bank-e" (for SoC version > jz4740)
+	- "ingenic,gpio-bank-f" (for SoC version > jz4740)
+ - interrupt-controller: Marks the device node as an interrupt controller.
+ - interrupts: Interrupt specifier for the controllers interrupt.
+ - #interrupt-cells: Should be 2. Refer to
+   ../interrupt-controller/interrupts.txt for more details.
+ - gpio-controller: Marks the device node as a GPIO controller.
+ - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
+    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
+    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
+ - gpio-ranges: Range of pins managed by the GPIO controller. Refer to
+   'gpio.txt' in this directory for more details.
+
+Example:
+--------
+
+&pinctrl {
+	gpa: gpio-controller@0 {
+		compatible = "ingenic,gpio-bank-a", "ingenic,jz4740-gpio";
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <28>;
+	};
+};
-- 
2.11.0
