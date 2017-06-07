Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2017 22:11:38 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:60130 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993950AbdFGUFX5pJOq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2017 22:05:23 +0200
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
Subject: [PATCH 06/15] serial: 8250_ingenic: Parse earlycon options
Date:   Wed,  7 Jun 2017 22:04:30 +0200
Message-Id: <20170607200439.24450-7-paul@crapouillou.net>
In-Reply-To: <20170607200439.24450-1-paul@crapouillou.net>
References: <20170607200439.24450-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58288
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

In the devicetree, it is possible to specify the baudrate, parity,
bits, flow of the early console, by passing a configuration string like
this:

aliases {
	serial0 = &uart0;
};

chosen {
	stdout-path = "serial0:57600n8";
};

This, for instance, will configure the early console for a baudrate of
57600 bps, no parity, and 8 bits per baud.

This patches implements parsing of this configuration string in the
8250_ingenic driver, which previously just ignored it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/tty/serial/8250/8250_ingenic.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index b31b2ca552d1..59f3e632df49 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -99,14 +99,24 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
 					      const char *opt)
 {
 	struct uart_port *port = &dev->port;
-	unsigned int baud, divisor;
+	unsigned int divisor;
+	int baud = 115200;
 
 	if (!dev->port.membase)
 		return -ENODEV;
 
+	if (opt) {
+		char options[256];
+		unsigned int parity, bits, flow; /* unused for now */
+
+		strlcpy(options, opt, sizeof(options));
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	}
+
 	ingenic_early_console_setup_clock(dev);
 
-	baud = dev->baud ?: 115200;
+	if (dev->baud)
+		baud = dev->baud;
 	divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
 
 	early_out(port, UART_IER, 0);
-- 
2.11.0
