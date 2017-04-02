Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2017 22:47:53 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:44344 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993875AbdDBUnu4tFGj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2017 22:43:50 +0200
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
Subject: [PATCH v4 01/14] dt/bindings: Document pinctrl-ingenic
Date:   Sun,  2 Apr 2017 22:42:31 +0200
Message-Id: <20170402204244.14216-2-paul@crapouillou.net>
In-Reply-To: <20170402204244.14216-1-paul@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57543
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
pinctrl-ingenic driver, which handles pin configuration and pin
muxing of the Ingenic SoCs currently supported by the Linux kernel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/pinctrl/ingenic,pinctrl.txt           | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt

 v2: Rewrote the documentation for the new pinctrl-ingenic driver
 v3: No changes
 v4: Update for the v4 version of the pinctrl-ingenic driver

diff --git a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
new file mode 100644
index 000000000000..0e43b527b681
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
@@ -0,0 +1,41 @@
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
+Required properties:
+--------------------
+
+ - compatible: One of:
+    - "ingenic,jz4740-pinctrl"
+    - "ingenic,jz4770-pinctrl"
+    - "ingenic,jz4780-pinctrl"
+ - reg: Address range of the pinctrl registers.
+
+
+GPIO sub-nodes
+--------------
+
+The pinctrl node can have optional sub-nodes for the Ingenic GPIO driver;
+please refer to ../gpio/ingenic,gpio.txt.
+
+
+Example:
+--------
+
+pinctrl: ingenic-pinctrl@10010000 {
+	compatible = "ingenic,jz4740-pinctrl";
+	reg = <0x10010000 0x400>;
+};
-- 
2.11.0
