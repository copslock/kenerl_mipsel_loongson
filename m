Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 16:26:38 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:32877 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823002Ab3HHO0ff3qIe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 16:26:35 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Grant Likely <grant.likely@linaro.org>
Cc:     Rob Herring <rob.herring@calxeda.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 1/2] DT: Add documentation for gpio-falcon
Date:   Thu,  8 Aug 2013 16:19:14 +0200
Message-Id: <1375971555-24128-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37476
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

Describe gpio-falcon binding.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
---
 .../devicetree/bindings/gpio/gpio-falcon.txt       |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-falcon.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-falcon.txt b/Documentation/devicetree/bindings/gpio/gpio-falcon.txt
new file mode 100644
index 0000000..60bc6cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-falcon.txt
@@ -0,0 +1,25 @@
+Lantiq Falon SoC GPIO controller bindings
+
+Required properties:
+- compatible:
+  - "lantiq,falcon-gpio" for Falcon SoC controllers
+- #gpio-cells : Should be two.
+  - first cell is the pin number
+  - second cell is used to specify optional parameters (unused)
+- gpio-controller : Marks the device node as a GPIO controller
+- reg : Physical base address and length of the controller's registers
+- interrupt-parent: phandle to the IM device node that the irq is routed via
+- interrupts : Specify the IM interrupt number
+- lantiq,bank : The physical GPIO bank that this block is assiciated with
+
+Example:
+
+	gpio0: gpio@810000 {
+		compatible = "lantiq,falcon-gpio";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x810000 0x80>;
+		interrupt-parent = <&icu0>;
+		interrupts = <44>;
+		lantiq,bank = <0>;
+	};
-- 
1.7.10.4
