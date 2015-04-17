Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 16:25:44 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:49894 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025746AbbDQOZhA2eUs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Apr 2015 16:25:37 +0200
Received: from localhost.localdomain (unknown [85.177.206.240])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id 9258B4B02B5;
        Fri, 17 Apr 2015 16:22:42 +0200 (CEST)
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] devicetree: Add bindings for the ATH79 DDR controllers
Date:   Fri, 17 Apr 2015 16:24:18 +0200
Message-Id: <1429280669-2986-4-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429280669-2986-1-git-send-email-albeu@free.fr>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46888
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

The DDR controller of the ARxxx and AR9xxx famillies provides an
interface to flush the FIFO between various devices and the DDR.
This is mainly used by the IRQ controller to flush the FIFO before
running the interrupt handler of such devices.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 .../memory-controllers/ath79-ddr-controller.txt    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt b/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
new file mode 100644
index 0000000..5541eed
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ath79-ddr-controller.txt
@@ -0,0 +1,35 @@
+Binding for Qualcomm  Atheros AR7xxx/AR9xxx DDR controller
+
+The DDR controller of the ARxxx and AR9xxx famillies provides an interface
+to flush the FIFO between various devices and the DDR. This is mainly used
+by the IRQ controller to flush the FIFO before running the interrupt handler
+of such devices.
+
+Required properties:
+
+- compatible: has to be "qca,<soc-type>-ddr-controller",
+  "qca,[ar7100|ar7240]-ddr-controller" as fallback.
+  On SoC with PCI support "qca,ar7100-ddr-controller" should be used as
+  fallback, otherwise "qca,ar7240-ddr-controller" should be used.
+- reg: Base address and size of the controllers memory area
+- #qca,ddr-wb-channel-cells: has to be 1, the index of the write buffer
+  channel
+
+Example:
+
+	ddr_ctrl: ddr-controller@18000000 {
+		compatible = "qca,ar9132-ddr-controller",
+				"qca,ar7240-ddr-controller";
+		reg = <0x18000000 0x100>;
+
+		#qca,ddr-wb-channel-cells = <1>;
+	};
+
+	...
+
+	cpuintc@0 {
+		...
+		qca,ddr-wb-channel-interrupts = <2>, <3>, <4>, <5>;
+		qca,ddr-wb-channels = <&ddr_ctrl 3>, <&ddr_ctrl 2>,
+					<&ddr_ctrl 0>, <&ddr_ctrl 1>;
+	};
-- 
2.0.0
