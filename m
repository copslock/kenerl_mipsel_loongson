Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Oct 2009 14:56:31 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:56394 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492520AbZJDMzm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Oct 2009 14:55:42 +0200
Received: by ewy10 with SMTP id 10so1846499ewy.33
        for <multiple recipients>; Sun, 04 Oct 2009 05:55:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7xC9w/aAgGCPR6VM7NOWxsIOoAGs+zMHApqop76glMs=;
        b=SNYUCd9y+tuEEEWDPbgcoyb6kqK94PQCqBcGei964SuxBsZ7sYuKntOcQshG/TSnzK
         BANfNeMKcdDN1kOlqroFV3okbSV4h9cMnhZijlfCVh1a3LYk/fTDkcblPMIfcA1aHHNd
         n1VmwzL7KksWJSb8uzIrEIlR3rxqIKRxiJNQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=upLUgM8q9gKOY/tXxhL4/JK4WvojmQjmCRth5UhynOi4/pnB6X4EvIOoDs6fMA68MD
         G8JQwjPyon1sLLaQX7x69dm+xtdoA2BGwaNSPWosfxoek84fl0XvkeedUpBEuPjB9H8z
         Uz5V4cuvfVtecSG6Ugqnm7ChN9iTc/JDE6Sik=
Received: by 10.211.155.16 with SMTP id h16mr5733380ebo.55.1254660933446;
        Sun, 04 Oct 2009 05:55:33 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 28sm1555483eyg.4.2009.10.04.05.55.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 05:55:32 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/6] Alchemy: devboards: factor out PB1200 IRQ cascade code.
Date:	Sun,  4 Oct 2009 14:55:25 +0200
Message-Id: <1254660929-15453-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1254660929-15453-2-git-send-email-manuel.lauss@gmail.com>
References: <1254660929-15453-1-git-send-email-manuel.lauss@gmail.com>
 <1254660929-15453-2-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Move the PB1200 IRQ cascade code out to the BCSR support code:
upcoming DB1300 support can use it too.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/bcsr.c          |   72 +++++++++++++++++++++++++++
 arch/mips/alchemy/devboards/pb1200/irqmap.c |   71 +--------------------------
 arch/mips/include/asm/mach-db1x00/bcsr.h    |    3 +
 3 files changed, 76 insertions(+), 70 deletions(-)

diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
index 85b7715..3bc4fd2 100644
--- a/arch/mips/alchemy/devboards/bcsr.c
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -7,6 +7,7 @@
  * All registers are 16bits wide with 32bit spacing.
  */
 
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <asm/addrspace.h>
@@ -18,6 +19,9 @@ static struct bcsr_reg {
 	spinlock_t lock;
 } bcsr_regs[BCSR_CNT];
 
+static void __iomem *bcsr_virt;	/* KSEG1 addr of BCSR base */
+static int bcsr_csc_base;	/* linux-irq of first cascaded irq */
+
 void __init bcsr_init(unsigned long bcsr1_phys, unsigned long bcsr2_phys)
 {
 	int i;
@@ -25,6 +29,8 @@ void __init bcsr_init(unsigned long bcsr1_phys, unsigned long bcsr2_phys)
 	bcsr1_phys = KSEG1ADDR(CPHYSADDR(bcsr1_phys));
 	bcsr2_phys = KSEG1ADDR(CPHYSADDR(bcsr2_phys));
 
+	bcsr_virt = (void __iomem *)bcsr1_phys;
+
 	for (i = 0; i < BCSR_CNT; i++) {
 		if (i >= BCSR_HEXLEDS)
 			bcsr_regs[i].raddr = (void __iomem *)bcsr2_phys +
@@ -74,3 +80,69 @@ void bcsr_mod(enum bcsr_id reg, unsigned short clr, unsigned short set)
 	spin_unlock_irqrestore(&bcsr_regs[reg].lock, flags);
 }
 EXPORT_SYMBOL_GPL(bcsr_mod);
+
+/*
+ * DB1200/PB1200 CPLD IRQ muxer
+ */
+static void bcsr_csc_handler(unsigned int irq, struct irq_desc *d)
+{
+	unsigned short bisr = __raw_readw(bcsr_virt + BCSR_REG_INTSTAT);
+
+	for ( ; bisr; bisr &= bisr - 1)
+		generic_handle_irq(bcsr_csc_base + __ffs(bisr));
+}
+
+/* NOTE: both the enable and mask bits must be cleared, otherwise the
+ * CPLD generates tons of spurious interrupts (at least on my DB1200).
+ *	-- mlau
+ */
+static void bcsr_irq_mask(unsigned int irq_nr)
+{
+	unsigned short v = 1 << (irq_nr - bcsr_csc_base);
+	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
+	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
+	wmb();
+}
+
+static void bcsr_irq_maskack(unsigned int irq_nr)
+{
+	unsigned short v = 1 << (irq_nr - bcsr_csc_base);
+	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
+	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
+	__raw_writew(v, bcsr_virt + BCSR_REG_INTSTAT);	/* ack */
+	wmb();
+}
+
+static void bcsr_irq_unmask(unsigned int irq_nr)
+{
+	unsigned short v = 1 << (irq_nr - bcsr_csc_base);
+	__raw_writew(v, bcsr_virt + BCSR_REG_INTSET);
+	__raw_writew(v, bcsr_virt + BCSR_REG_MASKSET);
+	wmb();
+}
+
+static struct irq_chip bcsr_irq_type = {
+	.name		= "CPLD",
+	.mask		= bcsr_irq_mask,
+	.mask_ack	= bcsr_irq_maskack,
+	.unmask		= bcsr_irq_unmask,
+};
+
+void __init bcsr_init_irq(int csc_start, int csc_end, int hook_irq)
+{
+	unsigned int irq;
+
+	/* mask & disable & ack all */
+	__raw_writew(0xffff, bcsr_virt + BCSR_REG_INTCLR);
+	__raw_writew(0xffff, bcsr_virt + BCSR_REG_MASKCLR);
+	__raw_writew(0xffff, bcsr_virt + BCSR_REG_INTSTAT);
+	wmb();
+
+	bcsr_csc_base = csc_start;
+
+	for (irq = csc_start; irq <= csc_end; irq++)
+		set_irq_chip_and_handler_name(irq, &bcsr_irq_type,
+			handle_level_irq, "level");
+
+	set_irq_chained_handler(hook_irq, bcsr_csc_handler);
+}
diff --git a/arch/mips/alchemy/devboards/pb1200/irqmap.c b/arch/mips/alchemy/devboards/pb1200/irqmap.c
index f379b02..3beb804 100644
--- a/arch/mips/alchemy/devboards/pb1200/irqmap.c
+++ b/arch/mips/alchemy/devboards/pb1200/irqmap.c
@@ -45,69 +45,11 @@ struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 	{ AU1000_GPIO_7, IRQF_TRIGGER_LOW, 0 },
 };
 
-static void __iomem *bcsr_virt;
-
-/*
- * Support for External interrupts on the Pb1200 Development platform.
- */
-
-static void pb1200_cascade_handler(unsigned int irq, struct irq_desc *d)
-{
-	unsigned short bisr = __raw_readw(bcsr_virt + BCSR_REG_INTSTAT);
-
-	for ( ; bisr; bisr &= bisr - 1)
-		generic_handle_irq(PB1200_INT_BEGIN + __ffs(bisr));
-}
-
-/* NOTE: both the enable and mask bits must be cleared, otherwise the
- * CPLD generates tons of spurious interrupts (at least on the DB1200).
- */
-static void pb1200_mask_irq(unsigned int irq_nr)
-{
-	unsigned short v = 1 << (irq_nr - PB1200_INT_BEGIN);
-	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
-	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
-	wmb();
-}
-
-static void pb1200_maskack_irq(unsigned int irq_nr)
-{
-	unsigned short v = 1 << (irq_nr - PB1200_INT_BEGIN);
-	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
-	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
-	__raw_writew(v, bcsr_virt + BCSR_REG_INTSTAT);	/* ack */
-	wmb();
-}
-
-static void pb1200_unmask_irq(unsigned int irq_nr)
-{
-	unsigned short v = 1 << (irq_nr - PB1200_INT_BEGIN);
-	__raw_writew(v, bcsr_virt + BCSR_REG_INTSET);
-	__raw_writew(v, bcsr_virt + BCSR_REG_MASKSET);
-	wmb();
-}
-
-static struct irq_chip pb1200_cpld_irq_type = {
-#ifdef CONFIG_MIPS_PB1200
-	.name = "Pb1200 Ext",
-#endif
-#ifdef CONFIG_MIPS_DB1200
-	.name = "Db1200 Ext",
-#endif
-	.mask		= pb1200_mask_irq,
-	.mask_ack	= pb1200_maskack_irq,
-	.unmask		= pb1200_unmask_irq,
-};
-
 void __init board_init_irq(void)
 {
-	unsigned int irq;
-
 	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
 
 #ifdef CONFIG_MIPS_PB1200
-	bcsr_virt = (void __iomem *)KSEG1ADDR(PB1200_BCSR_PHYS_ADDR);
-
 	/* We have a problem with CPLD rev 3. */
 	if (BCSR_WHOAMI_CPLD(bcsr_read(BCSR_WHOAMI)) <= 3) {
 		printk(KERN_ERR "WARNING!!!\n");
@@ -127,18 +69,7 @@ void __init board_init_irq(void)
 		printk(KERN_ERR "WARNING!!!\n");
 		panic("Game over.  Your score is 0.");
 	}
-#else
-	bcsr_virt = (void __iomem *)KSEG1ADDR(DB1200_BCSR_PHYS_ADDR);
 #endif
 
-	/* mask & disable & ack all */
-	bcsr_write(BCSR_INTCLR, 0xffff);
-	bcsr_write(BCSR_MASKCLR, 0xffff);
-	bcsr_write(BCSR_INTSTAT, 0xffff);
-
-	for (irq = PB1200_INT_BEGIN; irq <= PB1200_INT_END; irq++)
-		set_irq_chip_and_handler_name(irq, &pb1200_cpld_irq_type,
-					 handle_level_irq, "level");
-
-	set_irq_chained_handler(AU1000_GPIO_7, pb1200_cascade_handler);
+	bcsr_init_irq(PB1200_INT_BEGIN, PB1200_INT_END, AU1000_GPIO_7);
 }
diff --git a/arch/mips/include/asm/mach-db1x00/bcsr.h b/arch/mips/include/asm/mach-db1x00/bcsr.h
index ecbe19e..618d2de 100644
--- a/arch/mips/include/asm/mach-db1x00/bcsr.h
+++ b/arch/mips/include/asm/mach-db1x00/bcsr.h
@@ -232,4 +232,7 @@ void bcsr_write(enum bcsr_id reg, unsigned short val);
 /* modify a register. clear bits set in 'clr', set bits set in 'set' */
 void bcsr_mod(enum bcsr_id reg, unsigned short clr, unsigned short set);
 
+/* install CPLD IRQ demuxer (DB1200/PB1200) */
+void __init bcsr_init_irq(int csc_start, int csc_end, int hook_irq);
+
 #endif
-- 
1.6.5.rc2
