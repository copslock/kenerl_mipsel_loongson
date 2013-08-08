Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 11:46:12 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:51509 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816642Ab3HHJqGeO9pU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 11:46:06 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Grant Likely <grant.likely@linaro.org>
Cc:     Rob Herring <rob.herring@calxeda.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 1/2] DT: Add documentation for gpio-ralink
Date:   Thu,  8 Aug 2013 11:38:52 +0200
Message-Id: <1375954733-30675-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37450
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

Describe gpio-ralink binding.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
---
 .../devicetree/bindings/gpio/gpio-ralink.txt       |   40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-ralink.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-ralink.txt b/Documentation/devicetree/bindings/gpio/gpio-ralink.txt
new file mode 100644
index 0000000..b4acf02
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-ralink.txt
@@ -0,0 +1,40 @@
+Ralink SoC GPIO controller bindings
+
+Required properties:
+- compatible:
+  - "ralink,rt2880-gpio" for Ralink controllers
+- #gpio-cells : Should be two.
+  - first cell is the pin number
+  - second cell is used to specify optional parameters (unused)
+- gpio-controller : Marks the device node as a GPIO controller
+- reg : Physical base address and length of the controller's registers
+- interrupt-parent: phandle to the INTC device node
+- interrupts : Specify the INTC interrupt number
+- ralink,num-gpios : Specify the number of GPIOs
+- ralink,register-map : The register layout depends on the GPIO bank and actual
+		SoC type. Register offsets need to be in this order.
+		[ INT, EDGE, RENA, FENA, DATA, DIR, POL, SET, RESET, TOGGLE ]
+
+Optional properties:
+- ralink,gpio-base : Specify the GPIO chips base number
+
+Example:
+
+	gpio0: gpio@600 {
+		compatible = "ralink,rt5350-gpio", "ralink,rt2880-gpio";
+
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		reg = <0x600 0x34>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <6>;
+
+		ralink,gpio-base = <0>;
+		ralink,num-gpios = <24>;
+		ralink,register-map = [ 00 04 08 0c
+				20 24 28 2c
+				30 34 ];
+
+	};
-- 
1.7.10.4
