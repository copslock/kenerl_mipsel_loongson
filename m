Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:41:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39302 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011778AbbARWlWONh6I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:41:22 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7445B7FB9F3CB;
        Sun, 18 Jan 2015 22:41:12 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:41:16 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:41:12 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 25/36] devicetree: document ingenic,jz4780-uart binding
Date:   Sun, 18 Jan 2015 14:41:09 -0800
Message-ID: <1421620869-25063-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45274
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

Add binding documentation for Ingenic jz4780 UARTs.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org
---
 .../bindings/serial/ingenic,jz4780-uart.txt        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ingenic,jz4780-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/ingenic,jz4780-uart.txt b/Documentation/devicetree/bindings/serial/ingenic,jz4780-uart.txt
new file mode 100644
index 0000000..123b433
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ingenic,jz4780-uart.txt
@@ -0,0 +1,22 @@
+* Ingenic jz4780 UART
+
+Required properties:
+- compatible : "ingenic,jz4780-uart"
+- reg : offset and length of the register set for the device.
+- interrupts : should contain uart interrupt.
+- clocks : phandles to the module & baud clocks.
+- clock-names: tuple listing input clock names.
+	Required elements: "baud", "module"
+
+Example:
+
+uart0: serial@10030000 {
+	compatible = "ingenic,jz4780-uart";
+	reg = <0x10030000 0x100>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <51>;
+
+	clocks = <&ext>, <&cgu JZ4780_CLK_UART0>;
+	clock-names = "baud", "module";
+};
-- 
2.2.1
