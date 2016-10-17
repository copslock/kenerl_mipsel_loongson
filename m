Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 18:58:29 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:23885 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992996AbcJQQxRD6Ncz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 18:53:17 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTP id 02E01BBA0A611;
        Mon, 17 Oct 2016 17:53:02 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 17:53:05 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 17 Oct 2016 17:53:05 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <alistair@popple.id.au>, <mporter@kernel.crashing.org>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <paulus@samba.org>, <benh@kernel.crashing.org>
Subject: [Patch v5 04/12] irqchip: xilinx: Add support for parent intc
Date:   Mon, 17 Oct 2016 17:52:48 +0100
Message-ID: <1476723176-39891-5-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55478
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
V4 -> V5
Rebased to v4.9-rc1
Missing curly braces

V3 -> V4
Clean up if/else when a parent is found
Pass irqchip structure to handler as data

V2 -> V3
Reused existing parent node instead of finding again.
Cleanup up handler based on review

V1 -> V2

No change
---
 drivers/irqchip/irq-xilinx-intc.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 45e5154..dbf8b0c 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/io.h>
 #include <linux/bug.h>
+#include <linux/of_irq.h>
 
 /* No one else should require these constants, so define them locally here. */
 #define ISR 0x00			/* Interrupt Status Register */
@@ -154,11 +155,23 @@ static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 	.map = xintc_map,
 };
 
+static void xil_intc_irq_handler(struct irq_desc *desc)
+{
+	u32 pending;
+
+	do {
+		pending = xintc_get_irq();
+		if (pending == -1U)
+			break;
+		generic_handle_irq(pending);
+	} while (true);
+}
+
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
 	u32 nr_irq;
-	int ret;
+	int ret, irq;
 	struct xintc_irq_chip *irqc;
 
 	if (xintc_irqc) {
@@ -221,7 +234,16 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		goto err_alloc;
 	}
 
-	irq_set_default_host(root_domain);
+	if (parent) {
+		irq = irq_of_parse_and_map(intc, 0);
+		if (irq)
+			irq_set_chained_handler_and_data(irq,
+							 xil_intc_irq_handler,
+							 irqc);
+
+	} else {
+		irq_set_default_host(root_domain);
+	}
 
 	return 0;
 
-- 
1.9.1
