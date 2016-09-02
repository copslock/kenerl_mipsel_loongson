Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:50:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42140 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992100AbcIBPu05H6PA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:50:26 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 357872E780A0C;
        Fri,  2 Sep 2016 16:50:07 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:50:10 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 02/12] irqchip: i8259: Allow platforms to override poll function
Date:   Fri, 2 Sep 2016 16:48:48 +0100
Message-ID: <20160902154859.24269-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160902154859.24269-1-paul.burton@imgtec.com>
References: <20160902154859.24269-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The default i8259 polling function (i8259_irq) is nicely generic but is
fairly costly. Platforms often provide an alternative means of polling
for an i8259 interrupt, and when using the i8259 without device tree
have typically just chained its parent interrupt to their own handler
function. In order to allow for platform-specific polling functions to
be used in cases where the driver is probed via device tree, provide an
i8259_set_poll function that accepts a pointer to an alternative poll
function that will override the default.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/i8259.h | 11 +++++++++++
 drivers/irqchip/irq-i8259.c   |  8 +++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/i8259.h b/arch/mips/include/asm/i8259.h
index a7fbcd6..b27fcc4 100644
--- a/arch/mips/include/asm/i8259.h
+++ b/arch/mips/include/asm/i8259.h
@@ -43,6 +43,17 @@ extern void make_8259A_irq(unsigned int irq);
 extern void init_i8259_irqs(void);
 extern int i8259_of_init(struct device_node *node, struct device_node *parent);
 
+/**
+ * i8159_set_poll() - Override the i8259 polling function
+ * @poll: pointer to platform-specific polling function
+ *
+ * Call this to override the generic i8259 polling function, which directly
+ * accesses i8259 registers, with a platform specific one which may be faster
+ * in cases where hardware provides a more optimal means of polling for an
+ * interrupt.
+ */
+extern void i8259_set_poll(int (*poll)(void));
+
 /*
  * Do the traditional i8259 interrupt polling thing.  This is for the few
  * cases where no better interrupt acknowledge method is available and we
diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index 85897fd..1f4a344 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -38,6 +38,7 @@ static void disable_8259A_irq(struct irq_data *d);
 static void enable_8259A_irq(struct irq_data *d);
 static void mask_and_ack_8259A(struct irq_data *d);
 static void init_8259A(int auto_eoi);
+static int (*i8259_poll)(void) = i8259_irq;
 
 static struct irq_chip i8259A_chip = {
 	.name			= "XT-PIC",
@@ -51,6 +52,11 @@ static struct irq_chip i8259A_chip = {
  * 8259A PIC functions to handle ISA devices:
  */
 
+void i8259_set_poll(int (*poll)(void))
+{
+	i8259_poll = poll;
+}
+
 /*
  * This contains the irq mask for both 8259A irq controllers,
  */
@@ -355,7 +361,7 @@ void __init init_i8259_irqs(void)
 static void i8259_irq_dispatch(struct irq_desc *desc)
 {
 	struct irq_domain *domain = irq_desc_get_handler_data(desc);
-	int hwirq = i8259_irq();
+	int hwirq = i8259_poll();
 	unsigned int irq;
 
 	if (hwirq < 0)
-- 
2.9.3
