Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:48:56 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:57000 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011075AbbGMUqN48n2V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:46:13 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEkc8-0006WW-EE; Mon, 13 Jul 2015 22:46:12 +0200
Message-Id: <20150713200715.209383043@linutronix.de>
User-Agent: quilt/0.63-1
Date:   Mon, 13 Jul 2015 20:46:06 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org
Subject: [patch 09/12] MIPS/ath91: Remove pointless irqdisable/enable
References: <20150713200602.799079101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=MIPS-ath91--Remove-pointless-irqdisable-enable.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

The various interrupt flow handlers in ath79 are cascading interrupt
handlers. They all have a disable_irq_nosync()/enable_irq() pair
around the generic_handle_irq() call. The value of this disable/enable
is zero because its a complete noop:

disable_irq_nosync() merily increments the disable count without
actually masking the interrupt. enable_irq() soleley decrements the
disable count without touching the interrupt chip. The interrupt
cannot arrive again because the complete call chain runs with
interrupts disabled.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ath79/irq.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

Index: tip/arch/mips/ath79/irq.c
===================================================================
--- tip.orig/arch/mips/ath79/irq.c
+++ tip/arch/mips/ath79/irq.c
@@ -124,8 +124,6 @@ static void ar934x_ip2_irq_dispatch(unsi
 {
 	u32 status;
 
-	disable_irq_nosync(irq);
-
 	status = ath79_reset_rr(AR934X_RESET_REG_PCIE_WMAC_INT_STATUS);
 
 	if (status & AR934X_PCIE_WMAC_INT_PCIE_ALL) {
@@ -137,8 +135,6 @@ static void ar934x_ip2_irq_dispatch(unsi
 	} else {
 		spurious_interrupt();
 	}
-
-	enable_irq(irq);
 }
 
 static void ar934x_ip2_irq_init(void)
@@ -157,14 +153,12 @@ static void qca955x_ip2_irq_dispatch(uns
 {
 	u32 status;
 
-	disable_irq_nosync(irq);
-
 	status = ath79_reset_rr(QCA955X_RESET_REG_EXT_INT_STATUS);
 	status &= QCA955X_EXT_INT_PCIE_RC1_ALL | QCA955X_EXT_INT_WMAC_ALL;
 
 	if (status == 0) {
 		spurious_interrupt();
-		goto enable;
+		return;
 	}
 
 	if (status & QCA955X_EXT_INT_PCIE_RC1_ALL) {
@@ -176,17 +170,12 @@ static void qca955x_ip2_irq_dispatch(uns
 		/* TODO: flush DDR? */
 		generic_handle_irq(ATH79_IP2_IRQ(1));
 	}
-
-enable:
-	enable_irq(irq);
 }
 
 static void qca955x_ip3_irq_dispatch(unsigned int irq, struct irq_desc *desc)
 {
 	u32 status;
 
-	disable_irq_nosync(irq);
-
 	status = ath79_reset_rr(QCA955X_RESET_REG_EXT_INT_STATUS);
 	status &= QCA955X_EXT_INT_PCIE_RC2_ALL |
 		  QCA955X_EXT_INT_USB1 |
@@ -194,7 +183,7 @@ static void qca955x_ip3_irq_dispatch(uns
 
 	if (status == 0) {
 		spurious_interrupt();
-		goto enable;
+		return;
 	}
 
 	if (status & QCA955X_EXT_INT_USB1) {
@@ -211,9 +200,6 @@ static void qca955x_ip3_irq_dispatch(uns
 		/* TODO: flush DDR? */
 		generic_handle_irq(ATH79_IP3_IRQ(2));
 	}
-
-enable:
-	enable_irq(irq);
 }
 
 static void qca955x_irq_init(void)
