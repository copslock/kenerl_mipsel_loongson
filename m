Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2017 15:53:46 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:53124 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdAVOuwYBArb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Jan 2017 15:50:52 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 02/14] Documentation: dt/bindings: Document pinctrl-gpio
Date:   Sun, 22 Jan 2017 15:49:35 +0100
Message-Id: <20170122144947.16158-3-paul@crapouillou.net>
In-Reply-To: <20170122144947.16158-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485096621; bh=Bs3ZviHVAjxoe7ox+jPOvtsO+YO6b8FJk1ESZvmSMMw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=xGE7pMw4hpgFUO8uoDgPrD1IXafCZNg7sMKc54K2fIRNfHbuLUfck8qceLe857Yg3IL7S4xiz8Bg6DeMHs78/0l8Zf32WlxkBKKJD1SlJXMkHSe0FEhG4FAc2huuwon5tmbSrZg60eSgN1TmhGotqW336FPDAwstNORNcLm0fzc=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56449
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

This commit adds documentation for the devicetree bidings of the
pinctrl-gpio driver, which handles GPIOs of the Ingenic SoCs
currently supported by the Linux kernel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/gpio/ingenic,gpio.txt      | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt

v2: New patch

diff --git a/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
new file mode 100644
index 000000000000..b2eb20494365
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
@@ -0,0 +1,45 @@
+Ingenic jz47xx GPIO controller
+
+Required properties:
+  - compatible:
+    - "ingenic,jz4740-gpio" for the JZ4740 SoC
+    - "ingenic,jz4780-gpio" for the JZ4780 SoC
+
+  - reg: Base address and length of each memory resource used by the GPIO
+    controller hardware module.
+
+  - gpio-controller: Marks the device node as a GPIO controller.
+  - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
+    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
+    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
+  - gpio-ranges: Range of pins managed by the GPIO controller.
+
+Optional properties:
+  - base: The GPIO number to use as the base for this driver.
+  - interrupt-controller: Marks the device node as an interrupt controller.
+  - interrupts: Interrupt specifier for the controllers interrupt.
+    Required if 'interrupt-controller' is specified.
+
+Please refer to gpio.txt in this directory for details of gpio-ranges property
+and the common GPIO bindings used by client devices.
+
+The GPIO controller also acts as an interrupt controller. It uses the default
+two cells specifier as described in Documentation/devicetree/bindings/
+interrupt-controller/interrupts.txt.
+
+Example:
+
+gpa: gpio-controller@10010000 {
+	compatible = "ingenic,jz4740-gpio";
+	reg = <0x10010000 0x100>;
+
+	gpio-controller;
+	gpio-ranges = <&pinctrl 0 0 32>;
+	#gpio-cells = <2>;
+
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <28>;
+};
-- 
2.11.0
