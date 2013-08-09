Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 21:01:45 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50275 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865311Ab3HITBlp58G8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Aug 2013 21:01:41 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 2/2] serial: MIPS: lantiq: fix clock error check
Date:   Fri,  9 Aug 2013 20:54:31 +0200
Message-Id: <1376074471-29404-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1376074471-29404-1-git-send-email-blogic@openwrt.org>
References: <1376074471-29404-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

The clock should be checked with the proper IS_ERR() api before using it.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/lantiq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 93ac046..88d01e0 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -318,7 +318,7 @@ lqasc_startup(struct uart_port *port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 	int retval;
 
-	if (ltq_port->clk)
+	if (!IS_ERR(ltq_port->clk))
 		clk_enable(ltq_port->clk);
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
@@ -386,7 +386,7 @@ lqasc_shutdown(struct uart_port *port)
 		port->membase + LTQ_ASC_RXFCON);
 	ltq_w32_mask(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
-	if (ltq_port->clk)
+	if (!IS_ERR(ltq_port->clk))
 		clk_disable(ltq_port->clk);
 }
 
-- 
1.7.10.4
