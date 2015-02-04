Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 16:28:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15274 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012494AbbBDPWnfaxm2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 16:22:43 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5D5CFAC29E98E;
        Wed,  4 Feb 2015 15:22:40 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 4 Feb 2015 15:22:43 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 4 Feb 2015 15:22:42 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>,
        <gregkh@linuxfoundation.org>, <mturquette@linaro.org>,
        <sboyd@codeaurora.org>, <ralf@linux-mips.org>, <jslaby@suse.cz>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <lars@metafoo.de>,
        <paul.burton@imgtec.com>
Subject: [PATCH_V2 24/34] dt: serial: Add ingenic,jz4740-uart binding
Date:   Wed, 4 Feb 2015 15:21:53 +0000
Message-ID: <1423063323-19419-25-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

Add binding documentation for Ingenic jz4740 UARTs.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org
---
 .../bindings/serial/ingenic,jz4740-uart.txt        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ingenic,jz4740-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/ingenic,jz4740-uart.txt b/Documentation/devicetree/bindings/serial/ingenic,jz4740-uart.txt
new file mode 100644
index 0000000..9e12de6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ingenic,jz4740-uart.txt
@@ -0,0 +1,22 @@
+* Ingenic jz4740 UART
+
+Required properties:
+- compatible : "ingenic,jz4740-uart" or "ingenic,jz4780-uart"
+- reg : offset and length of the register set for the device.
+- interrupts : should contain uart interrupt.
+- clocks : phandles to the module & baud clocks.
+- clock-names: tuple listing input clock names.
+	Required elements: "baud", "module"
+
+Example:
+
+uart0: serial@10030000 {
+	compatible = "ingenic,jz4740-uart";
+	reg = <0x10030000 0x100>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <9>;
+
+	clocks = <&ext>, <&cgu JZ4740_CLK_UART0>;
+	clock-names = "baud", "module";
+};
-- 
1.9.1
