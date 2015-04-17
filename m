Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 16:26:03 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:50765 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025747AbbDQOZw6T1mH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Apr 2015 16:25:52 +0200
Received: from localhost.localdomain (unknown [85.177.206.240])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id 67B534B0218;
        Fri, 17 Apr 2015 16:22:58 +0200 (CEST)
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
Subject: [PATCH 04/14] devicetree: Add bindings for the ATH79 interrupt controllers
Date:   Fri, 17 Apr 2015 16:24:19 +0200
Message-Id: <1429280669-2986-5-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429280669-2986-1-git-send-email-albeu@free.fr>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46889
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
 .../interrupt-controller/qca,ath79-cpu-intc.txt    | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qca,ath79-cpu-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qca,ath79-cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/qca,ath79-cpu-intc.txt
new file mode 100644
index 0000000..1548512
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/qca,ath79-cpu-intc.txt
@@ -0,0 +1,45 @@
+Binding for Qualcomm Atheros AR7xxx/AR9XXX CPU interrupt controller
+
+On most SoC the IRQ controller need to flush the DDR FIFO before running
+the interrupt handler of some devices. This is configured using the
+qca,ddr-wb-channels and qca,ddr-wb-channel-interrupts properties.
+
+Required Properties:
+
+- compatible: has to be "qca,<soctype>-cpu-intc", "qca,ar7100-cpu-intc"
+  as fallback
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode interrupt
+		     source, should be 1 for intc
+
+Please refer to interrupts.txt in this directory for details of the common
+Interrupt Controllers bindings used by client devices.
+
+Optional Properties:
+
+- qca,ddr-wb-channel-interrupts: List of the interrupts needing a write
+  buffer flush
+- qca,ddr-wb-channels: List of phandles to the write buffer channels for
+  each interrupt. If qca,ddr-wb-channel-interrupts is not present the interrupt
+  default to the entry's index.
+
+Example:
+
+	cpuintc@0 {
+		compatible = "qca,ar9132-cpu-intc", "qca,ar7100-cpu-intc";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		qca,ddr-wb-channel-interrupts = <2>, <3>, <4>, <5>;
+		qca,ddr-wb-channels = <&ddr_ctrl 3>, <&ddr_ctrl 2>,
+					<&ddr_ctrl 0>, <&ddr_ctrl 1>;
+	};
+
+	...
+
+	ddr_ctrl: ddr-controller@18000000 {
+		...
+		#qca,ddr-wb-channel-cells = <1>;
+	};
+
-- 
2.0.0
