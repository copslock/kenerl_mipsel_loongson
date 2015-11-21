Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 01:17:10 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:13164 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013044AbbKUAQjwa08x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 01:16:39 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Fri, 20 Nov 2015
 17:16:32 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Fri, 20 Nov 2015
 17:22:59 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 09/14] DEVICETREE: Add bindings for PIC32 usart driver
Date:   Fri, 20 Nov 2015 17:17:21 -0700
Message-ID: <1448065205-15762-10-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

From: Andrei Pistirica <andrei.pistirica@microchip.com>

Document the devicetree bindings for the USART peripheral found on
Microchip PIC32 class devices.

Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 .../bindings/serial/microchip,pic32-usart.txt      |   29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt

diff --git a/Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt b/Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt
new file mode 100644
index 0000000..c87321c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/microchip,pic32-usart.txt
@@ -0,0 +1,29 @@
+* Microchip Universal Synchronous Asynchronous Receiver/Transmitter (USART)
+
+Required properties:
+- compatible: Should be "microchip,pic32-usart"
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt
+- pinctrl: Should contain pinctrl for TX/RX/RTS/CTS
+
+Optional properties:
+- microchip,uart-has-rtscts : Indicate the uart has hardware flow control
+- rts-gpios: RTS pin for USP-based UART if microchip,uart-has-rtscts
+- cts-gpios: CTS pin for USP-based UART if microchip,uart-has-rtscts
+
+Example:
+	usart0: serial@1f822000 {
+		compatible = "microchip,pic32-usart";
+		reg = <0x1f822000 0x50>;
+		interrupts = <UART1_FAULT DEFAULT_INT_PRI IRQ_TYPE_NONE>,
+			     <UART1_RECEIVE_DONE DEFAULT_INT_PRI IRQ_TYPE_NONE>,
+			     <UART1_TRANSFER_DONE DEFAULT_INT_PRI IRQ_TYPE_NONE>;
+		pinctrl-names = "default";
+		pinctrl-0 = <
+			&pinctrl_uart1
+			&pinctrl_uart1_cts
+			&pinctrl_uart1_rts>;
+		microchip,uart-has-rtscts;
+		cts-gpios = <&pioB 15 0>;
+		rts-gpios = <&pioD 1 0>;
+	};
-- 
1.7.9.5
