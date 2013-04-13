Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 11:38:19 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56333 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835058Ab3DMJhl18GAG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 13 Apr 2013 11:37:41 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/3] tty: serial: add iosize field to struct uart_port
Date:   Sat, 13 Apr 2013 11:33:37 +0200
Message-Id: <1365845618-16040-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
References: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36144
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

From: Gabor Juhos <juhosg@openwrt.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/tty/serial/8250/8250_core.c |    3 +++
 include/linux/serial_core.h         |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 35f9c96..25b917a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2498,6 +2498,8 @@ serial8250_pm(struct uart_port *port, unsigned int state,
 
 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
+	if (pt->port.iosize)
+		return pt->port.iosize;
 	if (pt->port.iotype == UPIO_AU)
 		return 0x1000;
 	if (is_omap1_8250(pt))
@@ -3233,6 +3235,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 		uart->port.iobase       = up->port.iobase;
 		uart->port.membase      = up->port.membase;
+		uart->port.iosize       = up->port.iosize;
 		uart->port.irq          = up->port.irq;
 		uart->port.irqflags     = up->port.irqflags;
 		uart->port.uartclk      = up->port.uartclk;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 87d4bbc..d3aa18b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -194,6 +194,7 @@ struct uart_port {
 	unsigned char		irq_wake;
 	unsigned char		unused[2];
 	void			*private_data;		/* generic platform data pointer */
+	unsigned int		iosize;			/* for ioremap */
 };
 
 static inline int serial_port_in(struct uart_port *up, int offset)
-- 
1.7.10.4
