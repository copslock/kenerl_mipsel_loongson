Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 17:18:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29829 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006775AbbEXPSIHVjUw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 17:18:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0326C2C1761C5;
        Sun, 24 May 2015 16:18:02 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 24 May 2015 16:18:04 +0100
Received: from localhost (192.168.159.140) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 24 May
 2015 16:18:03 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        "Kumar Gala" <galak@codeaurora.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 10/37] devicetree: document Ingenic SoC interrupt controller binding
Date:   Sun, 24 May 2015 16:11:20 +0100
Message-ID: <1432480307-23789-11-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
References: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.140]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Add binding documentation for Ingenic SoC interrupt controllers.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: devicetree@vger.kernel.org
---

Changes in v5:
- List all supported compatible strings in the binding document.

Changes in v4:
  - s/intc/interrupt-controller/ in example.

Changes in v3:
- Merge documentation for various Ingenic SoCs, which only differ by
  their compatible strings.

Changes in v2: None

 .../bindings/interrupt-controller/ingenic,intc.txt | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
new file mode 100644
index 0000000..5f89fb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
@@ -0,0 +1,28 @@
+Ingenic SoC Interrupt Controller
+
+Required properties:
+
+- compatible : should be "ingenic,<socname>-intc". Valid strings are:
+    ingenic,jz4740-intc
+    ingenic,jz4770-intc
+    ingenic,jz4775-intc
+    ingenic,jz4780-intc
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+- interrupt-parent : phandle of the CPU interrupt controller.
+- interrupts : Specifies the CPU interrupt the controller is connected to.
+
+Example:
+
+intc: interrupt-controller@10001000 {
+	compatible = "ingenic,jz4740-intc";
+	reg = <0x10001000 0x14>;
+
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	interrupt-parent = <&cpuintc>;
+	interrupts = <2>;
+};
-- 
2.4.1
