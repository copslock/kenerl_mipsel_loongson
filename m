Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2017 15:50:52 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:46124 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992029AbdAVOuULfrWb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Jan 2017 15:50:20 +0100
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
Subject: [PATCH v2 01/14] Documentation: dt/bindings: Document pinctrl-ingenic
Date:   Sun, 22 Jan 2017 15:49:34 +0100
Message-Id: <20170122144947.16158-2-paul@crapouillou.net>
In-Reply-To: <20170122144947.16158-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170122144947.16158-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1485096619; bh=YnaLAM//LPT0v60qQIHlFuQSepX92O3hTHPx1OOwNTk=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tlCiXtsfb5VffHaYxy2wv1kpgXzzz1udUgRXkGrgO363GedZ7q+mappsQqUIsPt0tF0FDgK5N33JCl8AyWvZBZN0LpxntNUmnMdOn4aoP2cE4UUo1PzsqPVkeXIauUG17c4LVV8g9Cv/XTclcdvRFriNPptUxGHimIJRGckxvxU=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56442
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
pinctrl-ingenic driver, which handles pin configuration and pin
muxing of the Ingenic SoCs currently supported by the Linux kernel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/pinctrl/ingenic,pinctrl.txt           | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt

v2: Rewrote the documentation for the new pinctrl-ingenic driver

diff --git a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
new file mode 100644
index 000000000000..ead5b01ad471
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
@@ -0,0 +1,77 @@
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
+Pin controller node
+===================
+
+Required properties:
+- compatible: One of:
+  - "ingenic,jz4740-pinctrl"
+  - "ingenic,jz4780-pinctrl"
+
+Optional properties:
+- ingenic,pull-ups: A list of 32-bit bit fields, where each bit set tells the
+  driver that a pull-up resistor is available for this pin.
+  By default, the driver considers that all pins feature a pull-up resistor.
+- ingenic,pull-downs: A list of 32-bit bit fields, where each bit set tells
+  the driver that a pull-down resistor is available for this pin.
+  By default, the driver considers that all pins feature a pull-down
+  resistor.
+
+
+'functions' sub-node
+====================
+
+The 'functions' node will contain sub-nodes that correspond to pin function
+nodes, and no properties. Pin function nodes will contain sub-nodes that
+correspond to pin groups, and no properties.
+
+The names of the pin function nodes will end up being the available functions
+provided by the pinctrl driver.
+The names of the pin group nodes will end up being the available groups
+provided by the pinctrl driver.
+
+Required properties for pin groups:
+- ingenic,pins: <pin mode [pin mode ...]>;
+  where 'pin' is the number of the pin, and 'mode' is the function mode of the
+  pin that should be enabled for this group.
+
+
+Example:
+=======
+
+pinctrl: ingenic-pinctrl@10010000 {
+	compatible = "ingenic,jz4740-pinctrl";
+	reg = <0x10010000 0x400>;
+
+	ingenic,pull-ups   = <0xffffffff 0xffffffff 0xffffffff 0xdfffffff>;
+	ingenic,pull-downs = <0x00000000 0x00000000 0x00000000 0x00000000>;
+
+	functions {
+		mmc {
+			mmc-1bit {
+				/* CLK, CMD, D0 */
+				ingenic,pins = <0x69 0 0x68 0 0x6a 0>;
+			};
+
+			mmc-4bit {
+				/* D1, D2, D3 */
+				ingenic,pins = <0x6b 0 0x6c 0 0x6d 0>;
+			};
+		};
+	};
+};
-- 
2.11.0
