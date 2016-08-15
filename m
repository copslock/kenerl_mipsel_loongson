Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 15:56:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60917 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992486AbcHON4EOMUkj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 15:56:04 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 371B6490CB1E6;
        Mon, 15 Aug 2016 14:55:45 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 15 Aug 2016 14:55:48 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>
CC:     <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <Zubair.Kakakhel@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 2/9] irqchip: xilinx: Add support for parent intc
Date:   Mon, 15 Aug 2016 14:55:28 +0100
Message-ID: <1471269335-58747-3-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1471269335-58747-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1471269335-58747-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

The MIPS based xilfpga platform has the following IRQ structure

Peripherals --> xilinx_intcontroller -> mips_cpu_int controller

Add support for the driver to chain the irq handler

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 drivers/irqchip/irq-xilinx.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-xilinx.c b/drivers/irqchip/irq-xilinx.c
index 90bec7d..a0be6fa 100644
--- a/drivers/irqchip/irq-xilinx.c
+++ b/drivers/irqchip/irq-xilinx.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/io.h>
 #include <linux/bug.h>
+#include <linux/of_irq.h>
 
 static void __iomem *intc_baseaddr;
 
@@ -135,11 +136,26 @@ static const struct irq_domain_ops xintc_irq_domain_ops = {
 	.map = xintc_map,
 };
 
+static void xil_intc_irq_handler(struct irq_desc *desc)
+{
+	u32 pending = get_irq();
+
+	if (pending != -1U) {
+		while (true) {
+			pending = get_irq();
+			generic_handle_irq(pending);
+			if (pending == -1U)
+				break;
+		}
+	}
+}
+
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
 	u32 nr_irq, intr_mask;
-	int ret;
+	int ret, irq;
+	struct device_node *parent_node;
 
 	intc_baseaddr = of_iomap(intc, 0);
 	BUG_ON(!intc_baseaddr);
@@ -188,6 +204,16 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 	root_domain = irq_domain_add_linear(intc, nr_irq, &xintc_irq_domain_ops,
 							(void *)intr_mask);
 
+	parent_node = of_irq_find_parent(intc);
+	if (parent_node) {
+		irq = irq_of_parse_and_map(intc, 0);
+		if (irq)
+			irq_set_chained_handler_and_data(irq,
+							 xil_intc_irq_handler,
+							 root_domain);
+
+	}
+
 	irq_set_default_host(root_domain);
 
 	return 0;
-- 
1.9.1
