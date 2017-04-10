Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 15:00:07 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:54533 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992178AbdDJM77BVA6C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Apr 2017 14:59:59 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70756AD17;
        Mon, 10 Apr 2017 12:59:58 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to 3.12-stable] MIPS: Lantiq: Fix cascaded IRQ setup
Date:   Mon, 10 Apr 2017 14:59:24 +0200
Message-Id: <20170410125930.26495-47-jslaby@suse.cz>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170410125930.26495-1-jslaby@suse.cz>
References: <20170410125930.26495-1-jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Felix Fietkau <nbd@nbd.name>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/lantiq/irq.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index eb3e18659630..1637f165deab 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -268,6 +268,11 @@ static void ltq_hw5_irqdispatch(void)
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
@@ -312,23 +317,19 @@ static struct irqaction irq_call = {
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned int pending = read_c0_status() & read_c0_cause() & ST0_IM;
-	unsigned int i;
-
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
+	int irq;
+
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
@@ -353,11 +354,6 @@ static const struct irq_domain_ops irq_domain_ops = {
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
@@ -413,7 +409,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	mips_cpu_irq_init();
 
 	for (i = 0; i < MAX_IM; i++)
-		setup_irq(i + 2, &cascade);
+		irq_set_chained_handler(i + 2, ltq_hw_irq_handler);
 
 	if (cpu_has_vint) {
 		pr_info("Setting up vectored interrupts\n");
-- 
2.12.2
