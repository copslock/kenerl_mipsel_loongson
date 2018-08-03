Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 05:05:16 +0200 (CEST)
Received: from mga07.intel.com ([134.134.136.100]:59388 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994553AbeHCDENA10zH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Aug 2018 05:04:13 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="62004955"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2018 20:04:07 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 09/18] serial: intel: Change ltq_w32_mask to asc_update_bits
Date:   Fri,  3 Aug 2018 11:02:28 +0800
Message-Id: <20180803030237.3366-10-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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

ltq prefix is platform specific function, asc prefix
is more generic.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2: None

 drivers/tty/serial/lantiq.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 836ca51460f2..e36e6a267e7a 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -114,6 +114,13 @@ struct ltq_uart_port {
 	unsigned int		err_irq;
 };
 
+static inline void asc_update_bits(u32 clear, u32 set, void __iomem *reg)
+{
+	u32 tmp = readl(reg);
+
+	writel((tmp & ~clear) | set, reg);
+}
+
 static inline struct
 ltq_uart_port *to_ltq_uart_port(struct uart_port *port)
 {
@@ -164,16 +171,16 @@ lqasc_rx_chars(struct uart_port *port)
 		if (rsr & ASCSTATE_ANY) {
 			if (rsr & ASCSTATE_PE) {
 				port->icount.parity++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRPE,
+				asc_update_bits(0, ASCWHBSTATE_CLRPE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			} else if (rsr & ASCSTATE_FE) {
 				port->icount.frame++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRFE,
+				asc_update_bits(0, ASCWHBSTATE_CLRFE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			}
 			if (rsr & ASCSTATE_ROE) {
 				port->icount.overrun++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRROE,
+				asc_update_bits(0, ASCWHBSTATE_CLRROE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			}
 
@@ -253,7 +260,7 @@ lqasc_err_int(int irq, void *_port)
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
 	/* clear any pending interrupts */
-	ltq_w32_mask(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
+	asc_update_bits(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	return IRQ_HANDLED;
@@ -305,7 +312,7 @@ lqasc_startup(struct uart_port *port)
 		clk_enable(ltq_port->clk);
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
-	ltq_w32_mask(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
+	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
 		port->membase + LTQ_ASC_CLC);
 
 	ltq_w32(0, port->membase + LTQ_ASC_PISEL);
@@ -321,7 +328,7 @@ lqasc_startup(struct uart_port *port)
 	 * setting enable bits
 	 */
 	wmb();
-	ltq_w32_mask(0, ASCCON_M_8ASYNC | ASCCON_FEN | ASCCON_TOEN |
+	asc_update_bits(0, ASCCON_M_8ASYNC | ASCCON_FEN | ASCCON_TOEN |
 		ASCCON_ROEN, port->membase + LTQ_ASC_CON);
 
 	retval = request_irq(ltq_port->tx_irq, lqasc_tx_int,
@@ -365,9 +372,9 @@ lqasc_shutdown(struct uart_port *port)
 	free_irq(ltq_port->err_irq, port);
 
 	ltq_w32(0, port->membase + LTQ_ASC_CON);
-	ltq_w32_mask(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
+	asc_update_bits(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
 		port->membase + LTQ_ASC_RXFCON);
-	ltq_w32_mask(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
+	asc_update_bits(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
 	if (!IS_ERR(ltq_port->clk))
 		clk_disable(ltq_port->clk);
@@ -439,7 +446,7 @@ lqasc_set_termios(struct uart_port *port,
 	spin_lock_irqsave(&ltq_asc_lock, flags);
 
 	/* set up CON */
-	ltq_w32_mask(0, con, port->membase + LTQ_ASC_CON);
+	asc_update_bits(0, con, port->membase + LTQ_ASC_CON);
 
 	/* Set baud rate - take a divider of 2 into account */
 	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
@@ -447,19 +454,19 @@ lqasc_set_termios(struct uart_port *port,
 	divisor = divisor / 2 - 1;
 
 	/* disable the baudrate generator */
-	ltq_w32_mask(ASCCON_R, 0, port->membase + LTQ_ASC_CON);
+	asc_update_bits(ASCCON_R, 0, port->membase + LTQ_ASC_CON);
 
 	/* make sure the fractional divider is off */
-	ltq_w32_mask(ASCCON_FDE, 0, port->membase + LTQ_ASC_CON);
+	asc_update_bits(ASCCON_FDE, 0, port->membase + LTQ_ASC_CON);
 
 	/* set up to use divisor of 2 */
-	ltq_w32_mask(ASCCON_BRS, 0, port->membase + LTQ_ASC_CON);
+	asc_update_bits(ASCCON_BRS, 0, port->membase + LTQ_ASC_CON);
 
 	/* now we can write the new baudrate into the register */
 	ltq_w32(divisor, port->membase + LTQ_ASC_BG);
 
 	/* turn the baudrate generator back on */
-	ltq_w32_mask(0, ASCCON_R, port->membase + LTQ_ASC_CON);
+	asc_update_bits(0, ASCCON_R, port->membase + LTQ_ASC_CON);
 
 	/* enable rx */
 	ltq_w32(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
-- 
2.11.0
