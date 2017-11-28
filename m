Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 16:29:37 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:39345 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991935AbdK1P1z2NRDY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 16:27:55 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 6916E206F9; Tue, 28 Nov 2017 16:27:49 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 3E44D20741;
        Tue, 28 Nov 2017 16:27:39 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 04/13] dt-bindings: pinctrl: Add bindings for Microsemi Ocelot
Date:   Tue, 28 Nov 2017 16:26:34 +0100
Message-Id: <20171128152643.20463-5-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Add the documentation for the Microsemi Ocelot pinmuxing and gpio
controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org

 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt       | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
new file mode 100644
index 000000000000..24a210e0c59a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
@@ -0,0 +1,39 @@
+Microsemi Ocelot pin controller Device Tree Bindings
+----------------------------------------------------
+
+Required properties:
+ - compatible		: Should be "mscc,ocelot-pinctrl"
+ - reg			: Address and length of the register set for the device
+ - gpio-controller	: Indicates this device is a GPIO controller
+ - #gpio-cells		: Must be 2.
+			  The first cell is the pin number and the
+			  second cell specifies GPIO flags, as defined in
+			  <dt-bindings/gpio/gpio.h>.
+ - gpio-ranges		: Range of pins managed by the GPIO controller.
+
+
+The ocelot-pinctrl driver uses the generic pin multiplexing and generic pin
+configuration documented in pinctrl-bindings.txt.
+
+The following generic properties are supported:
+ - function
+ - pins
+
+Example:
+	gpio: pinctrl@71070034 {
+		compatible = "mscc,ocelot-pinctrl";
+		reg = <0x71070034 0x28>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&gpio 0 0 22>;
+
+		uart_pins: uart-pins {
+				pins = "GPIO_6", "GPIO_7";
+				function = "uart";
+		};
+
+		uart2_pins: uart2-pins {
+				pins = "GPIO_12", "GPIO_13";
+				function = "uart2";
+		};
+	};
-- 
2.15.0
