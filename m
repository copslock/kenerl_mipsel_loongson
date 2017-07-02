Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jul 2017 18:36:50 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:46474 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994632AbdGBQbHleuRq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jul 2017 18:31:07 +0200
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
Subject: [PATCH v3 07/18] serial: core: Make uart_parse_options take const char* argument
Date:   Sun,  2 Jul 2017 18:30:05 +0200
Message-Id: <20170702163016.6714-8-paul@crapouillou.net>
In-Reply-To: <20170702163016.6714-1-paul@crapouillou.net>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170702163016.6714-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1499013029; bh=uD3VT4wt/m1fHhLXZQONis7lQvX/4kx+mWOurhCs4o8=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oFABpAiEdWkOF7bUaCMbe5iZX+hS5Cc88G9TThm6oyC2pU5v1+n6KiOoUQPGdLscLLjLHs1vGEklnoDhTjuu1GJwzVVP8MG4gRdNFYYfCjFNkA2mI28mTgDRO1SkvcSXoI4CMFEN28W9hVMdBSew4w9qBjIjldqywrWw2veKBzM=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58959
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

The pointed string is never modified from within uart_parse_options, so
it should be marked as const in the function prototype.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/tty/serial/serial_core.c | 5 +++--
 include/linux/serial_core.h      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

 v2: New patch in this series
 v3: No change

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 13bfd5dcffce..95d3770bdb37 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1954,9 +1954,10 @@ EXPORT_SYMBOL_GPL(uart_parse_earlycon);
  *	eg: 115200n8r
  */
 void
-uart_parse_options(char *options, int *baud, int *parity, int *bits, int *flow)
+uart_parse_options(const char *options, int *baud, int *parity,
+		   int *bits, int *flow)
 {
-	char *s = options;
+	const char *s = options;
 
 	*baud = simple_strtoul(s, NULL, 10);
 	while (*s >= '0' && *s <= '9')
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 64d892f1e5cd..67f88fb53195 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -386,7 +386,7 @@ struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
 int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
 			char **options);
-void uart_parse_options(char *options, int *baud, int *parity, int *bits,
+void uart_parse_options(const char *options, int *baud, int *parity, int *bits,
 			int *flow);
 int uart_set_options(struct uart_port *port, struct console *co, int baud,
 		     int parity, int bits, int flow);
-- 
2.11.0
