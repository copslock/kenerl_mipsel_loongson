Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 17:10:04 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:39747 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27041200AbcFIPKB3xuqQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jun 2016 17:10:01 +0200
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 1/2] arch: mips: lantiq: fix eiu interrupt loading code
Date:   Thu,  9 Jun 2016 17:09:51 +0200
Message-Id: <1465484992-40808-1-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Using of_irq_count to load the irq index from the devicetree is incorrect.
This will cause the kernel to map them regardless, even if they dont
actually get used. Change the code to use of_property_count_u32_elems()
instead which is the correct API to use in this case.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/lantiq/irq.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 2b8e9cf..6746d7f 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -66,7 +66,7 @@ int gic_present;
 #endif
 
 static int exin_avail;
-static struct resource ltq_eiu_irq[MAX_EIU];
+static u32 ltq_eiu_irq[MAX_EIU];
 static void __iomem *ltq_icu_membase[MAX_IM];
 static void __iomem *ltq_eiu_membase;
 static struct irq_domain *ltq_domain;
@@ -75,7 +75,7 @@ static int ltq_perfcount_irq;
 int ltq_eiu_get_irq(int exin)
 {
 	if (exin < exin_avail)
-		return ltq_eiu_irq[exin].start;
+		return ltq_eiu_irq[exin];
 	return -1;
 }
 
@@ -126,7 +126,7 @@ static int ltq_eiu_settype(struct irq_data *d, unsigned int type)
 	int i;
 
 	for (i = 0; i < MAX_EIU; i++) {
-		if (d->hwirq == ltq_eiu_irq[i].start) {
+		if (d->hwirq == ltq_eiu_irq[i]) {
 			int val = 0;
 			int edge = 0;
 
@@ -174,7 +174,7 @@ static unsigned int ltq_startup_eiu_irq(struct irq_data *d)
 
 	ltq_enable_irq(d);
 	for (i = 0; i < MAX_EIU; i++) {
-		if (d->hwirq == ltq_eiu_irq[i].start) {
+		if (d->hwirq == ltq_eiu_irq[i]) {
 			/* by default we are low level triggered */
 			ltq_eiu_settype(d, IRQF_TRIGGER_LOW);
 			/* clear all pending */
@@ -196,7 +196,7 @@ static void ltq_shutdown_eiu_irq(struct irq_data *d)
 
 	ltq_disable_irq(d);
 	for (i = 0; i < MAX_EIU; i++) {
-		if (d->hwirq == ltq_eiu_irq[i].start) {
+		if (d->hwirq == ltq_eiu_irq[i]) {
 			/* disable */
 			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) & ~BIT(i),
 				LTQ_EIU_EXIN_INEN);
@@ -341,7 +341,7 @@ static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 		return 0;
 
 	for (i = 0; i < exin_avail; i++)
-		if (hw == ltq_eiu_irq[i].start)
+		if (hw == ltq_eiu_irq[i])
 			chip = &ltq_eiu_type;
 
 	irq_set_chip_and_handler(irq, chip, handle_level_irq);
@@ -439,14 +439,15 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	eiu_node = of_find_compatible_node(NULL, NULL, "lantiq,eiu-xway");
 	if (eiu_node && !of_address_to_resource(eiu_node, 0, &res)) {
 		/* find out how many external irq sources we have */
-		exin_avail = of_irq_count(eiu_node);
+		exin_avail = of_property_count_u32_elems(eiu_node,
+							 "lantiq,eiu-irqs");
 
 		if (exin_avail > MAX_EIU)
 			exin_avail = MAX_EIU;
 
-		ret = of_irq_to_resource_table(eiu_node,
+		ret = of_property_read_u32_array(eiu_node, "lantiq,eiu-irqs",
 						ltq_eiu_irq, exin_avail);
-		if (ret != exin_avail)
+		if (ret)
 			panic("failed to load external irq resources");
 
 		if (!request_mem_region(res.start, resource_size(&res),
-- 
1.7.10.4
