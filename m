Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 10:43:23 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990519AbdDFInP7JPjK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 10:43:15 +0200
Received: from localhost (unknown [46.44.180.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A78DC958;
        Thu,  6 Apr 2017 08:43:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 66/72] MIPS: Lantiq: Fix cascaded IRQ setup
Date:   Thu,  6 Apr 2017 10:38:53 +0200
Message-Id: <20170406083622.858979592@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170406083619.775985942@linuxfoundation.org>
References: <20170406083619.775985942@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

commit 6c356eda225e3ee134ed4176b9ae3a76f793f4dd upstream.

With the IRQ stack changes integrated, the XRX200 devices started
emitting a constant stream of kernel messages like this:

[  565.415310] Spurious IRQ: CAUSE=0x1100c300

This is caused by IP0 getting handled by plat_irq_dispatch() rather than
its vectored interrupt handler, which is fixed by commit de856416e714
("MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch").

Fix plat_irq_dispatch() to handle non-vectored IPI interrupts correctly
by setting up IP2-6 as proper chained IRQ handlers and calling do_IRQ
for all MIPS CPU interrupts.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Acked-by: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15077/
[james.hogan@imgtec.com: tweaked commit message]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/irq.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -269,6 +269,11 @@ static void ltq_hw5_irqdispatch(void)
 DEFINE_HWx_IRQDISPATCH(5)
 #endif
 
+static void ltq_hw_irq_handler(struct irq_desc *desc)
+{
+	ltq_hw_irqdispatch(irq_desc_get_irq(desc) - 2);
+}
+
 #ifdef CONFIG_MIPS_MT_SMP
 void __init arch_init_ipiirq(int irq, struct irqaction *action)
 {
@@ -313,23 +318,19 @@ static struct irqaction irq_call = {
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-	unsigned int i;
+	int irq;
 
-	if ((MIPS_CPU_TIMER_IRQ == 7) && (pending & CAUSEF_IP7)) {
-		do_IRQ(MIPS_CPU_TIMER_IRQ);
-		goto out;
-	} else {
-		for (i = 0; i < MAX_IM; i++) {
-			if (pending & (CAUSEF_IP2 << i)) {
-				ltq_hw_irqdispatch(i);
-				goto out;
-			}
-		}
+	if (!pending) {
+		spurious_interrupt();
+		return;
 	}
-	pr_alert("Spurious IRQ: CAUSE=0x%08x\n", read_c0_status());
 
-out:
-	return;
+	pending >>= CAUSEB_IP;
+	while (pending) {
+		irq = fls(pending) - 1;
+		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
+		pending &= ~BIT(irq);
+	}
 }
 
 static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
@@ -354,11 +355,6 @@ static const struct irq_domain_ops irq_d
 	.map = icu_map,
 };
 
-static struct irqaction cascade = {
-	.handler = no_action,
-	.name = "cascade",
-};
-
 int __init icu_of_init(struct device_node *node, struct device_node *parent)
 {
 	struct device_node *eiu_node;
@@ -390,7 +386,7 @@ int __init icu_of_init(struct device_nod
 	mips_cpu_irq_init();
 
 	for (i = 0; i < MAX_IM; i++)
-		setup_irq(i + 2, &cascade);
+		irq_set_chained_handler(i + 2, ltq_hw_irq_handler);
 
 	if (cpu_has_vint) {
 		pr_info("Setting up vectored interrupts\n");
