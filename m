Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2011 22:07:35 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:57517 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491106Ab1GRUH3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jul 2011 22:07:29 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH V2 1/3] MIPS: lantiq: fixes external interrupt sources
Date:   Mon, 18 Jul 2011 22:08:40 +0200
Message-Id: <1311019720-22234-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 30648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12696

The irq base offset needs to be ignored when matching irqs to external
interrupt pins. Taking the offset into account resulted in the EIU not
being brought up properly.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org

---
Changes in V2
* fix typo in patch title
---
 arch/mips/lantiq/irq.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index fc89795..f9737bb 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -123,11 +123,10 @@ void ltq_enable_irq(struct irq_data *d)
 static unsigned int ltq_startup_eiu_irq(struct irq_data *d)
 {
 	int i;
-	int irq_nr = d->irq - INT_NUM_IRQ0;
 
 	ltq_enable_irq(d);
 	for (i = 0; i < MAX_EIU; i++) {
-		if (irq_nr == ltq_eiu_irq[i]) {
+		if (d->irq == ltq_eiu_irq[i]) {
 			/* low level - we should really handle set_type */
 			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_C) |
 				(0x6 << (i * 4)), LTQ_EIU_EXIN_C);
@@ -147,11 +146,10 @@ static unsigned int ltq_startup_eiu_irq(struct irq_data *d)
 static void ltq_shutdown_eiu_irq(struct irq_data *d)
 {
 	int i;
-	int irq_nr = d->irq - INT_NUM_IRQ0;
 
 	ltq_disable_irq(d);
 	for (i = 0; i < MAX_EIU; i++) {
-		if (irq_nr == ltq_eiu_irq[i]) {
+		if (d->irq == ltq_eiu_irq[i]) {
 			/* disable */
 			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) & ~(1 << i),
 				LTQ_EIU_EXIN_INEN);
-- 
1.7.2.3
