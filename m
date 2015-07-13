Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:49:13 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:57010 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011078AbbGMUqRA6zQV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:46:17 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEkc9-0006Wd-Vu; Mon, 13 Jul 2015 22:46:14 +0200
Message-Id: <20150713200715.290025879@linutronix.de>
User-Agent: quilt/0.63-1
Date:   Mon, 13 Jul 2015 20:46:07 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: [patch 10/12] MIPS/cavium/octeon: Replace the homebrewn flow handler
References: <20150713200602.799079101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=MIPS-cavium-octeon--Replace-the-homebrewn-flow-handler.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48242
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

The gpio interrupt handling of octeon contains a homebrewn flow
handler which calls either handle_level_irq or handle_edge_irq
depending on the trigger type. Thats an extra conditional and call in
the interrupt handling path. The proper way to handle different types
and therefor different flows is to update the handler in the
irq_set_type() callback.

Remove the extra indirection and add the handler update to
octeon_irq_ciu_gpio_set_type(). At mapping time it defaults to
handle_level_irq which gets updated if the device tree contains a
different trigger type.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/cavium-octeon/octeon-irq.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

Index: tip/arch/mips/cavium-octeon/octeon-irq.c
===================================================================
--- tip.orig/arch/mips/cavium-octeon/octeon-irq.c
+++ tip/arch/mips/cavium-octeon/octeon-irq.c
@@ -663,6 +663,11 @@ static int octeon_irq_ciu_gpio_set_type(
 	irqd_set_trigger_type(data, t);
 	octeon_irq_gpio_setup(data);
 
+	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
+		irq_set_handler_locked(data, handle_edge_irq);
+	else
+		irq_set_handler_locked(data, handle_level_irq);
+
 	return IRQ_SET_MASK_OK;
 }
 
@@ -697,16 +702,6 @@ static void octeon_irq_ciu_gpio_ack(stru
 	cvmx_write_csr(CVMX_GPIO_INT_CLR, mask);
 }
 
-static void octeon_irq_handle_trigger(unsigned int irq, struct irq_desc *desc)
-{
-	struct irq_data *data = irq_desc_get_irq_data(desc);
-
-	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
-		handle_edge_irq(irq, desc);
-	else
-		handle_level_irq(irq, desc);
-}
-
 #ifdef CONFIG_SMP
 
 static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
@@ -1229,8 +1224,13 @@ static int octeon_irq_gpio_map(struct ir
 		octeon_irq_ciu_to_irq[line][bit] != 0)
 		return -EINVAL;
 
+	/*
+	 * Default to handle_level_irq. If the DT contains a different
+	 * trigger type, it will call the irq_set_type callback and
+	 * the handler gets updated.
+	 */
 	r = octeon_irq_set_ciu_mapping(virq, line, bit, hw,
-		octeon_irq_gpio_chip, octeon_irq_handle_trigger);
+				       octeon_irq_gpio_chip, handle_level_irq);
 	return r;
 }
 
