Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 22:56:08 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:34951
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011122AbaJJUzbnggIV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 22:55:31 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-gpio@vger.kernel.org
Subject: [PATCH 3/5] DT: Add documentation for gpio-mt7621
Date:   Fri, 10 Oct 2014 22:28:48 +0200
Message-Id: <1412972930-16777-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
References: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43222
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

Describe gpio-mt7621 binding.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
---
 .../devicetree/bindings/gpio/gpio-mt7621.txt       |   45 ++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mt7621.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mt7621.txt b/Documentation/devicetree/bindings/gpio/gpio-mt7621.txt
new file mode 100644
index 0000000..ade0efe
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-mt7621.txt
@@ -0,0 +1,45 @@
+Mediatek SoC GPIO controller bindings
+
+The IP core used inside these SoCs has 1-N banks of 32 GPIOs each. Unfortunately
+the registers of all the banks are interwoven inside one single IO range. We
+really want to load one GPIO controller instance per bank. to make this possible
+we support 2 types of nodes. The parent node defines the memory I/O range and
+has N children each describing a single bank.
+
+Required properties for the top level node:
+- compatible:
+  - "mediatek,mt7621-gpio" for Mediatek controllers
+- reg : Physical base address and length of the controller's registers
+
+Required properties for the GPIO bank node:
+- compatible:
+  - "mediatek,mt7621-gpio-bank" for Mediatek banks
+- #gpio-cells : Should be two.
+  - first cell is the pin number
+  - second cell is used to specify optional parameters (unused)
+- gpio-controller : Marks the device node as a GPIO controller
+- reg : The id of the bank that the node describes.
+
+
+Example:
+	gpio@600 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		compatible = "mediatek,mt7621-gpio";
+		reg = <0x600 0x100>;
+
+		gpio0: bank@0 {
+			reg = <0>;
+			compatible = "mediatek,mt7621-gpio-bank";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio1: bank@1 {
+			reg = <1>;
+			compatible = "mediatek,mt7621-gpio-bank";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
-- 
1.7.10.4
