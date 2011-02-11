Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2011 09:47:58 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:45137 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491001Ab1BKIrz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Feb 2011 09:47:55 +0100
Received: by bwz5 with SMTP id 5so2803118bwz.36
        for <multiple recipients>; Fri, 11 Feb 2011 00:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=2o+EeHl3eo/R7IbB0zi+FPCDM55+v/NdBtMel1WlCRU=;
        b=BaLkHWJQH5+aaSi7/A2IcGYUmizBYuq1e9pH83fLQlJYXHNLdyVWKW9dr4flY7Us3o
         pY++5bHtqcijJH8gBg5jzINTgI2ooNSMSXXNotpNnkZrct6xL65bmJ4kCkYSFNcAx4Id
         Ofzln5BvXCslferEenOAfG/nn9nL2wCKFkRrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HqtvFSGVUMRXEZfwoxroV+Hf2/wJD7Ci4CsXzmxvE+KU0bPQXwo2erofOJp5u4AmG9
         RkYCqPZ98sRNiFByt3nhhVfiVfSyAuXLwEwEqHFmHWslvSnJ9s7pjTtY7Pnk7Mgw075g
         EDpuob/NSPMQkACBk1lUZqTYm0UhClEmebS9E=
Received: by 10.204.70.136 with SMTP id d8mr2417117bkj.96.1297414069393;
        Fri, 11 Feb 2011 00:47:49 -0800 (PST)
Received: from localhost.localdomain (188-22-147-70.adsl.highway.telekom.at [188.22.147.70])
        by mx.google.com with ESMTPS id v25sm290909bkt.18.2011.02.11.00.47.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 00:47:49 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RESEND 1/2] MIPS: Convert to new irq methods.
Date:   Fri, 11 Feb 2011 09:47:43 +0100
Message-Id: <1297414064-3446-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297414064-3446-1-git-send-email-manuel.lauss@googlemail.com>
References: <1297414064-3446-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Convert the core MIPS irq code to use the new .irq_xxx methods.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Tested on DB1200 with C0 timer.  The MIPS-MT bits are untested since
I don't have capable hardware.

 arch/mips/kernel/irq.c     |   12 ++++++++++--
 arch/mips/kernel/irq_cpu.c |   42 +++++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 4f93db5..b8112cf 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -89,6 +89,9 @@ int show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, j;
 	struct irqaction * action;
+	struct irq_desc *desc;
+	struct irq_data *data;
+	struct irq_chip *chip;
 	unsigned long flags;
 
 	if (i == 0) {
@@ -100,9 +103,14 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	if (i < NR_IRQS) {
 		raw_spin_lock_irqsave(&irq_desc[i].lock, flags);
-		action = irq_desc[i].action;
+		desc = irq_to_desc(i);
+		if (!desc)
+			goto skip;
+		action = desc->action;
 		if (!action)
 			goto skip;
+		data = irq_get_irq_data(i);
+		chip = irq_data_get_irq_chip(data);
 		seq_printf(p, "%3d: ", i);
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
@@ -110,7 +118,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", kstat_irqs_cpu(i, j));
 #endif
-		seq_printf(p, " %14s", irq_desc[i].chip->name);
+		seq_printf(p, " %14s", chip->name);
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 0262abe..91a8689 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -37,25 +37,25 @@
 #include <asm/mipsmtregs.h>
 #include <asm/system.h>
 
-static inline void unmask_mips_irq(unsigned int irq)
+static inline void unmask_mips_irq(struct irq_data *d)
 {
-	set_c0_status(0x100 << (irq - MIPS_CPU_IRQ_BASE));
+	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
 	irq_enable_hazard();
 }
 
-static inline void mask_mips_irq(unsigned int irq)
+static inline void mask_mips_irq(struct irq_data *d)
 {
-	clear_c0_status(0x100 << (irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
 	irq_disable_hazard();
 }
 
 static struct irq_chip mips_cpu_irq_controller = {
 	.name		= "MIPS",
-	.ack		= mask_mips_irq,
-	.mask		= mask_mips_irq,
-	.mask_ack	= mask_mips_irq,
-	.unmask		= unmask_mips_irq,
-	.eoi		= unmask_mips_irq,
+	.irq_ack	= mask_mips_irq,
+	.irq_mask	= mask_mips_irq,
+	.irq_mask_ack	= mask_mips_irq,
+	.irq_unmask	= unmask_mips_irq,
+	.irq_eoi	= unmask_mips_irq,
 };
 
 /*
@@ -65,13 +65,13 @@ static struct irq_chip mips_cpu_irq_controller = {
 #define unmask_mips_mt_irq	unmask_mips_irq
 #define mask_mips_mt_irq	mask_mips_irq
 
-static unsigned int mips_mt_cpu_irq_startup(unsigned int irq)
+static unsigned int mips_mt_cpu_irq_startup(struct irq_data *d)
 {
 	unsigned int vpflags = dvpe();
 
-	clear_c0_cause(0x100 << (irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_cause(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
 	evpe(vpflags);
-	unmask_mips_mt_irq(irq);
+	unmask_mips_mt_irq(d);
 
 	return 0;
 }
@@ -80,22 +80,22 @@ static unsigned int mips_mt_cpu_irq_startup(unsigned int irq)
  * While we ack the interrupt interrupts are disabled and thus we don't need
  * to deal with concurrency issues.  Same for mips_cpu_irq_end.
  */
-static void mips_mt_cpu_irq_ack(unsigned int irq)
+static void mips_mt_cpu_irq_ack(struct irq_data *d)
 {
 	unsigned int vpflags = dvpe();
-	clear_c0_cause(0x100 << (irq - MIPS_CPU_IRQ_BASE));
+	clear_c0_cause(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
 	evpe(vpflags);
-	mask_mips_mt_irq(irq);
+	mask_mips_mt_irq(d);
 }
 
 static struct irq_chip mips_mt_cpu_irq_controller = {
 	.name		= "MIPS",
-	.startup	= mips_mt_cpu_irq_startup,
-	.ack		= mips_mt_cpu_irq_ack,
-	.mask		= mask_mips_mt_irq,
-	.mask_ack	= mips_mt_cpu_irq_ack,
-	.unmask		= unmask_mips_mt_irq,
-	.eoi		= unmask_mips_mt_irq,
+	.irq_startup	= mips_mt_cpu_irq_startup,
+	.irq_ack	= mips_mt_cpu_irq_ack,
+	.irq_mask	= mask_mips_mt_irq,
+	.irq_mask_ack	= mips_mt_cpu_irq_ack,
+	.irq_unmask	= unmask_mips_mt_irq,
+	.irq_eoi	= unmask_mips_mt_irq,
 };
 
 void __init mips_cpu_irq_init(void)
-- 
1.7.4
