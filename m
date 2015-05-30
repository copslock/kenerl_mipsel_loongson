Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2015 02:02:18 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:23258 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006760AbbEaACQ23ey4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 May 2015 02:02:16 +0200
Received: from localhost.localdomain (unknown [78.54.178.112])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id 07B874B0026;
        Sun, 31 May 2015 02:00:11 +0200 (CEST)
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
Subject: [PATCH v4 07/12] devicetree: Add bindings for the ATH79 PLL controllers
Date:   Sun, 31 May 2015 01:52:30 +0200
Message-Id: <1433029955-7346-8-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1433029955-7346-1-git-send-email-albeu@free.fr>
References: <1433029955-7346-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47743
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

Signed-off-by: Alban Bedel <albeu@free.fr>
---
v2: * Fixed the node names to respect ePAPR
    * Fixed the missing 's' in 'fallbacks' and the 'clocks' property
v3: * Fix the compatible string for qca9550
---
 .../devicetree/bindings/clock/qca,ath79-pll.txt    | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qca,ath79-pll.txt

diff --git a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
new file mode 100644
index 0000000..e0fc2c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
@@ -0,0 +1,33 @@
+Binding for Qualcomm Atheros AR7xxx/AR9XXX PLL controller
+
+The PPL controller provides the 3 main clocks of the SoC: CPU, DDR and AHB.
+
+Required Properties:
+- compatible: has to be "qca,<soctype>-cpu-intc" and one of the following
+  fallbacks:
+  - "qca,ar7100-pll"
+  - "qca,ar7240-pll"
+  - "qca,ar9130-pll"
+  - "qca,ar9330-pll"
+  - "qca,ar9340-pll"
+  - "qca,qca9550-pll"
+- reg: Base address and size of the controllers memory area
+- clock-names: Name of the input clock, has to be "ref"
+- clocks: phandle of the external reference clock
+- #clock-cells: has to be one
+
+Optional properties:
+- clock-output-names: should be "cpu", "ddr", "ahb"
+
+Example:
+
+	memory-controller@18050000 {
+		compatible = "qca,ar9132-ppl", "qca,ar9130-pll";
+		reg = <0x18050000 0x20>;
+
+		clock-names = "ref";
+		clocks = <&extosc>;
+
+		#clock-cells = <1>;
+		clock-output-names = "cpu", "ddr", "ahb";
+	};
-- 
2.0.0
