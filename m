Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 22:23:25 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:47514 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491944Ab1CWVJY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 22:09:24 +0100
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q2VIs-0001xH-UL; Wed, 23 Mar 2011 22:09:19 +0100
Message-Id: <20110323210538.070462971@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Wed, 23 Mar 2011 21:09:18 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 37/38] mips: vr41xx: Cleanup the direct access to irq_desc[]
References: <20110323210437.398062704@linutronix.de>
Content-Disposition: inline; filename=mips-vr41xx-mess.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

Tons of unused code, but that's Ralfs problem.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/vr41xx/common/icu.c |   44 +++++++++++++++++++++---------------------
 arch/mips/vr41xx/common/irq.c |   19 +++++++++---------
 2 files changed, 32 insertions(+), 31 deletions(-)

Index: linux-mips-next/arch/mips/vr41xx/common/icu.c
===================================================================
--- linux-mips-next.orig/arch/mips/vr41xx/common/icu.c
+++ linux-mips-next/arch/mips/vr41xx/common/icu.c
@@ -154,7 +154,7 @@ static inline uint16_t icu2_clear(uint8_
 
 void vr41xx_enable_piuint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + PIU_IRQ;
+	struct irq_desc *desc = irq_to_desc(PIU_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4111 ||
@@ -169,7 +169,7 @@ EXPORT_SYMBOL(vr41xx_enable_piuint);
 
 void vr41xx_disable_piuint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + PIU_IRQ;
+	struct irq_desc *desc = irq_to_desc(PIU_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4111 ||
@@ -184,7 +184,7 @@ EXPORT_SYMBOL(vr41xx_disable_piuint);
 
 void vr41xx_enable_aiuint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + AIU_IRQ;
+	struct irq_desc *desc = irq_to_desc(AIU_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4111 ||
@@ -199,7 +199,7 @@ EXPORT_SYMBOL(vr41xx_enable_aiuint);
 
 void vr41xx_disable_aiuint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + AIU_IRQ;
+	struct irq_desc *desc = irq_to_desc(AIU_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4111 ||
@@ -214,7 +214,7 @@ EXPORT_SYMBOL(vr41xx_disable_aiuint);
 
 void vr41xx_enable_kiuint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + KIU_IRQ;
+	struct irq_desc *desc = irq_to_desc(KIU_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4111 ||
@@ -229,7 +229,7 @@ EXPORT_SYMBOL(vr41xx_enable_kiuint);
 
 void vr41xx_disable_kiuint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + KIU_IRQ;
+	struct irq_desc *desc = irq_to_desc(KIU_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4111 ||
@@ -244,7 +244,7 @@ EXPORT_SYMBOL(vr41xx_disable_kiuint);
 
 void vr41xx_enable_macint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + ETHERNET_IRQ;
+	struct irq_desc *desc = irq_to_desc(ETHERNET_IRQ);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -256,7 +256,7 @@ EXPORT_SYMBOL(vr41xx_enable_macint);
 
 void vr41xx_disable_macint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + ETHERNET_IRQ;
+	struct irq_desc *desc = irq_to_desc(ETHERNET_IRQ);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -268,7 +268,7 @@ EXPORT_SYMBOL(vr41xx_disable_macint);
 
 void vr41xx_enable_dsiuint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + DSIU_IRQ;
+	struct irq_desc *desc = irq_to_desc(DSIU_IRQ);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -280,7 +280,7 @@ EXPORT_SYMBOL(vr41xx_enable_dsiuint);
 
 void vr41xx_disable_dsiuint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + DSIU_IRQ;
+	struct irq_desc *desc = irq_to_desc(DSIU_IRQ);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -292,7 +292,7 @@ EXPORT_SYMBOL(vr41xx_disable_dsiuint);
 
 void vr41xx_enable_firint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + FIR_IRQ;
+	struct irq_desc *desc = irq_to_desc(FIR_IRQ);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -304,7 +304,7 @@ EXPORT_SYMBOL(vr41xx_enable_firint);
 
 void vr41xx_disable_firint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + FIR_IRQ;
+	struct irq_desc *desc = irq_to_desc(FIR_IRQ);
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
@@ -316,7 +316,7 @@ EXPORT_SYMBOL(vr41xx_disable_firint);
 
 void vr41xx_enable_pciint(void)
 {
-	struct irq_desc *desc = irq_desc + PCI_IRQ;
+	struct irq_desc *desc = irq_to_desc(PCI_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4122 ||
@@ -332,7 +332,7 @@ EXPORT_SYMBOL(vr41xx_enable_pciint);
 
 void vr41xx_disable_pciint(void)
 {
-	struct irq_desc *desc = irq_desc + PCI_IRQ;
+	struct irq_desc *desc = irq_to_desc(PCI_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4122 ||
@@ -348,7 +348,7 @@ EXPORT_SYMBOL(vr41xx_disable_pciint);
 
 void vr41xx_enable_scuint(void)
 {
-	struct irq_desc *desc = irq_desc + SCU_IRQ;
+	struct irq_desc *desc = irq_to_desc(SCU_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4122 ||
@@ -364,7 +364,7 @@ EXPORT_SYMBOL(vr41xx_enable_scuint);
 
 void vr41xx_disable_scuint(void)
 {
-	struct irq_desc *desc = irq_desc + SCU_IRQ;
+	struct irq_desc *desc = irq_to_desc(SCU_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4122 ||
@@ -380,7 +380,7 @@ EXPORT_SYMBOL(vr41xx_disable_scuint);
 
 void vr41xx_enable_csiint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + CSI_IRQ;
+	struct irq_desc *desc = irq_to_desc(CSI_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4122 ||
@@ -396,7 +396,7 @@ EXPORT_SYMBOL(vr41xx_enable_csiint);
 
 void vr41xx_disable_csiint(uint16_t mask)
 {
-	struct irq_desc *desc = irq_desc + CSI_IRQ;
+	struct irq_desc *desc = irq_to_desc(CSI_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4122 ||
@@ -412,7 +412,7 @@ EXPORT_SYMBOL(vr41xx_disable_csiint);
 
 void vr41xx_enable_bcuint(void)
 {
-	struct irq_desc *desc = irq_desc + BCU_IRQ;
+	struct irq_desc *desc = irq_to_desc(BCU_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4122 ||
@@ -428,7 +428,7 @@ EXPORT_SYMBOL(vr41xx_enable_bcuint);
 
 void vr41xx_disable_bcuint(void)
 {
-	struct irq_desc *desc = irq_desc + BCU_IRQ;
+	struct irq_desc *desc = irq_to_desc(BCU_IRQ);
 	unsigned long flags;
 
 	if (current_cpu_type() == CPU_VR4122 ||
@@ -476,7 +476,7 @@ static struct irq_chip sysint2_irq_type 
 
 static inline int set_sysint1_assign(unsigned int irq, unsigned char assign)
 {
-	struct irq_desc *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_to_desc(irq);
 	uint16_t intassign0, intassign1;
 	unsigned int pin;
 
@@ -536,7 +536,7 @@ static inline int set_sysint1_assign(uns
 
 static inline int set_sysint2_assign(unsigned int irq, unsigned char assign)
 {
-	struct irq_desc *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_to_desc(irq);
 	uint16_t intassign2, intassign3;
 	unsigned int pin;
 
Index: linux-mips-next/arch/mips/vr41xx/common/irq.c
===================================================================
--- linux-mips-next.orig/arch/mips/vr41xx/common/irq.c
+++ linux-mips-next/arch/mips/vr41xx/common/irq.c
@@ -62,7 +62,6 @@ EXPORT_SYMBOL_GPL(cascade_irq);
 static void irq_dispatch(unsigned int irq)
 {
 	irq_cascade_t *cascade;
-	struct irq_desc *desc;
 
 	if (irq >= NR_IRQS) {
 		atomic_inc(&irq_err_count);
@@ -71,14 +70,16 @@ static void irq_dispatch(unsigned int ir
 
 	cascade = irq_cascade + irq;
 	if (cascade->get_irq != NULL) {
-		unsigned int source_irq = irq;
+		struct irq_desc *desc = irq_to_desc(irq);
+		struct irq_data *idata = irq_desc_get_irq_data(desc);
+		struct irq_chip *chip = irq_desc_get_chip(desc);
 		int ret;
-		desc = irq_desc + source_irq;
-		if (desc->chip->mask_ack)
-			desc->chip->mask_ack(source_irq);
+
+		if (chip->irq_mask_ack)
+			chip->irq_mask_ack(idata);
 		else {
-			desc->chip->mask(source_irq);
-			desc->chip->ack(source_irq);
+			chip->irq_mask(idata);
+			chip->irq_ack(idata);
 		}
 		ret = cascade->get_irq(irq);
 		irq = ret;
@@ -86,8 +87,8 @@ static void irq_dispatch(unsigned int ir
 			atomic_inc(&irq_err_count);
 		else
 			irq_dispatch(irq);
-		if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-			desc->chip->unmask(source_irq);
+		if (!(desc->status & IRQ_DISABLED) && chip->irq_unmask)
+			chip->irq_unmask(idata);
 	} else
 		do_IRQ(irq);
 }
