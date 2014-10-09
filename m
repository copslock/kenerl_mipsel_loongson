Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 20:57:25 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:58470
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010993AbaJIS43BIpg0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 20:56:29 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 3/4] pinctrl: ralink: add binding documentation
Date:   Thu,  9 Oct 2014 04:55:26 +0200
Message-Id: <1412823327-10296-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412823327-10296-1-git-send-email-blogic@openwrt.org>
References: <1412823327-10296-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43157
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 .../bindings/pinctrl/ralink,rt2880-pinmux.txt      |   74 ++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.txt
new file mode 100644
index 0000000..20e6cc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.txt
@@ -0,0 +1,74 @@
+Ralink rt2880 pinmux controller
+
+Required properties:
+- compatible: "lantiq,rt2880-pinmux"
+- reg: Should contain the physical address and length of the gpio/pinmux
+  register range
+
+The rt2880 pinmux can only set the muxing of pin groups. muxing indiviual pins
+is not supported. There is no pinconf support.
+
+Definition of mux function groups:
+
+Required subnode-properties:
+- ralink,group : An array of strings. Each string contains the name of a group.
+  Valid values for these names are listed below.
+- ralink,function: A string containing the name of the function to mux to the
+  group. Valid values for function names are listed below.
+
+Valid values for group and function names:
+   mux groups (rt2880):
+    i2c, spi, uartlite, jtag, mdio, sdram, pci
+
+   mux functions (rt2880):
+    gpio, i2c, spi, uartlite, jtag, mdio, sdram, pci
+
+   mux groups (rt3050):
+    i2c, spi, uartf, uartlite, jtag, mdio, rgmii, sdram
+
+   mux functions (rt3050):
+    gpio, i2c, spi, uartf, pcm uartf, pcm i2s, i2s uartf, pcm gpio, gpio uartf,
+    gpio i2s, uartlite, jtag, mdio, sdram
+
+   mux groups (rt3352):
+    i2c, spi, uartf, uartlite, jtag, mdio, rgmii, lna, pna, led
+
+   mux functions (rt3050):
+    gpio, i2c, spi, uartf, pcm uartf, pcm i2s, i2s uartf, pcm gpio, gpio uartf,
+    gpio i2s, uartlite, jtag, mdio, lna, pna, led
+
+   mux groups (rt5350):
+    i2c, spi, uartf, uartlite, jtag, pna, led, spi cs1
+
+   mux functions (rt5350):
+    gpio, i2c, spi, uartf, pcm uartf, pcm i2s, i2s uartf, pcm gpio, gpio uartf,
+    gpio i2s, uartlite, jtag, spi_cs1, wdg
+
+
+Example:
+	pinctrl {
+		compatible = "ralink,rt2880-pinmux";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&state_default>;
+
+		state_default: pinctrl0 {
+			sdram {
+				ralink,group = "sdram";
+				ralink,function = "sdram";
+			};
+		};
+
+		spi_pins: spi {
+			spi {
+				ralink,group = "spi";
+				ralink,function = "spi";
+			};
+		};
+		uartlite_pins: uartlite {
+			uart {
+				ralink,group = "uartlite";
+				ralink,function = "uartlite";
+			};
+		};
+	};
-- 
1.7.10.4
