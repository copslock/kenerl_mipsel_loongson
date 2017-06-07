Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2017 22:07:04 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:59894 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993913AbdFGUEwRDdUq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2017 22:04:52 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 05/15] serial: 8250_ingenic: Add support for the JZ4770 SoC
Date:   Wed,  7 Jun 2017 22:04:29 +0200
Message-Id: <20170607200439.24450-6-paul@crapouillou.net>
In-Reply-To: <20170607200439.24450-1-paul@crapouillou.net>
References: <20170607200439.24450-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

The JZ4770 SoC's UART is no different from the other JZ SoCs, so this
commit simply adds the ingenic,jz4770-uart compatible string.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.txt | 3 ++-
 drivers/tty/serial/8250/8250_ingenic.c                    | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.txt b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
index 02cb7fe59cb7..75fd8b314af9 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
@@ -2,7 +2,8 @@
 
 Required properties:
 - compatible : "ingenic,jz4740-uart", "ingenic,jz4760-uart",
-	"ingenic,jz4775-uart" or "ingenic,jz4780-uart"
+	"ingenic,jz4770-uart", "ingenic,jz4775-uart" or
+	"ingenic,jz4780-uart"
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
 - clocks : phandles to the module & baud clocks.
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 4d9dc10e265c..b31b2ca552d1 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -133,6 +133,10 @@ EARLYCON_DECLARE(jz4740_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
 		    ingenic_early_console_setup);
 
+EARLYCON_DECLARE(jz4770_uart, ingenic_early_console_setup);
+OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
+		    ingenic_early_console_setup);
+
 EARLYCON_DECLARE(jz4775_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4775_uart, "ingenic,jz4775-uart",
 		    ingenic_early_console_setup);
@@ -327,6 +331,7 @@ static const struct ingenic_uart_config jz4780_uart_config = {
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
 	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
+	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4780-uart", .data = &jz4780_uart_config },
 	{ /* sentinel */ }
-- 
2.11.0
