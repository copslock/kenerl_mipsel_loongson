Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2015 02:19:32 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:48623 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006760AbbEaAT3eTYk4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 May 2015 02:19:29 +0200
Received: from localhost.localdomain (unknown [78.54.107.71])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id E77E94B0026;
        Sun, 31 May 2015 02:17:24 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/12] devicetree: Add bindings for the ATH79 GPIO controllers
Date:   Sun, 31 May 2015 02:18:23 +0200
Message-Id: <1433031506-7984-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1433029955-7346-1-git-send-email-albeu@free.fr>
References: <1433029955-7346-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

These bindings support the GPIO controllers found on the Qualcomm
Atheros AR7xxx/AR9XXX SoC.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
v2: * Add the ngpios property to have fewer fallbacks and simpler code
v3: * Fix missing 's' typo
    * Fix the example to be valid with the binding
v4: * Fix the double space in the title
---
 .../devicetree/bindings/gpio/gpio-ath79.txt        | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-ath79.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-ath79.txt b/Documentation/devicetree/bindings/gpio/gpio-ath79.txt
new file mode 100644
index 0000000..c522851
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-ath79.txt
@@ -0,0 +1,38 @@
+Binding for Qualcomm Atheros AR7xxx/AR9xxx GPIO controller
+
+Required properties:
+- compatible: has to be "qca,<soctype>-gpio" and one of the following
+  fallbacks:
+  - "qca,ar7100-gpio"
+  - "qca,ar9340-gpio"
+- reg: Base address and size of the controllers memory area
+- gpio-controller : Marks the device node as a GPIO controller.
+- #gpio-cells : Should be two. The first cell is the pin number and the
+  second cell is used to specify optional parameters.
+- ngpios: Should be set to the number of GPIOs available on the SoC.
+
+Optional properties:
+- interrupt-parent: phandle of the parent interrupt controller.
+- interrupts: Interrupt specifier for the controllers interrupt.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode interrupt
+		     source, should be 2
+
+Please refer to interrupts.txt in this directory for details of the common
+Interrupt Controllers bindings used by client devices.
+
+Example:
+
+	gpio@18040000 {
+		compatible = "qca,ar9132-gpio", "qca,ar7100-gpio";
+		reg = <0x18040000 0x30>;
+		interrupts = <2>;
+
+		ngpios = <22>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
-- 
2.0.0
