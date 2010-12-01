Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 17:21:14 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:40416 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493023Ab0LAQVL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 17:21:11 +0100
Received: by fxm19 with SMTP id 19so2320233fxm.36
        for <multiple recipients>; Wed, 01 Dec 2010 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=D3VUvLR6tzVGksmzTyHH6iG84QN6UEbKXIIcOx8QC7Q=;
        b=xctiYQ5CjfLzIAYwOm/AqB+hEqXvSanrtEz+Cc1o4j5anUnCnP2sT8glEkfkUypRTP
         Bp8ll4hF4tD5Vt3r/+Cyjs5WLHenfEHC8PKtl/DvEgeimYmddnIjL7Dunz4ve6lNZA1t
         AQfq1K4EHubvBpyFzm64a3e2A09jSk3rhux5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=t44mJnjXU9nFZhGaRQczCuLi4IoCEOwWL7JxRz2aoJOYAl7kiLMsmfM+q0b/6utckh
         78CLqBfL4mtWd6RfZZuXTyaD1EVU52P0PiZn257gUwFWKiHTF8MH4c0T6tV1DIad14UR
         T67EqxHMwX0ZdaQXUSWUA0tYQXxHRMK6JU8HA=
Received: by 10.223.116.11 with SMTP id k11mr7412764faq.15.1291220465701;
        Wed, 01 Dec 2010 08:21:05 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id f24sm72281fak.0.2010.12.01.08.21.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:21:05 -0800 (PST)
Subject: [RFC 3/3] VSMP support for MSP71xx family
From:   Anoop P A <anoop.pa@gmail.com>
To:     kevink@paralogos.com, linux-mips@linux-mips.org,
        David Howells <dhowells@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 01 Dec 2010 21:53:57 +0530
Message-ID: <1291220637.31413.20.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

>From 5bfd3ba210e521df2b493862446b4535bcdb0cdf Mon Sep 17 00:00:00 2001
Message-Id:
<5bfd3ba210e521df2b493862446b4535bcdb0cdf.1291219118.git.anoop.pa@gmail.com>
In-Reply-To: <cover.1291219118.git.anoop.pa@gmail.com>
References: <cover.1291219118.git.anoop.pa@gmail.com>
From: Anoop P A <anoop.pa@gmail.com>
Date: Wed, 1 Dec 2010 21:08:37 +0530
Subject: [RFC 3/3] VSMP support for MSP71xx family.
Cc: anoop.pa@gmail.com

followig patches setup vectored interrupt in msp_irq.c and
register vsmp_ops from msp_setup.c.
It also changes get_c0_compare_int to return corresponding vpe timer
interrupt.

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_irq.c   |   49
+++++++++++++++++++++++++-----
 arch/mips/pmc-sierra/msp71xx/msp_setup.c |    3 ++
 arch/mips/pmc-sierra/msp71xx/msp_time.c  |    2 +-
 3 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq.c
b/arch/mips/pmc-sierra/msp71xx/msp_irq.c
index 734d598..e9144c8 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_irq.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_irq.c
@@ -19,8 +19,6 @@
 
 #include <msp_int.h>
 
-extern void msp_int_handle(void);
-
 /* SLP bases systems */
 extern void msp_slp_irq_init(void);
 extern void msp_slp_irq_dispatch(void);
@@ -29,6 +27,19 @@ extern void msp_slp_irq_dispatch(void);
 extern void msp_cic_irq_init(void);
 extern void msp_cic_irq_dispatch(void);
 
+/* VSMP support init */
+extern void msp_vsmp_int_init(void);
+
+/* vectored interrupt implementation */
+
+/* SW0/1 interrupts are used for SMP/SMTC */
+static inline void mac0_int_dispatch(void) { do_IRQ(MSP_INT_MAC0); }
+static inline void mac1_int_dispatch(void) { do_IRQ(MSP_INT_MAC1); }
+static inline void mac2_int_dispatch(void) { do_IRQ(MSP_INT_SAR); }
+static inline void usb_int_dispatch(void)  { do_IRQ(MSP_INT_USB);  }
+static inline void sec_int_dispatch(void)  { do_IRQ(MSP_INT_SEC);  }
+
+
 /*
  * The PMC-Sierra MSP interrupts are arranged in a 3 level cascaded
  * hierarchical system.  The first level are the direct MIPS interrupts
@@ -96,29 +107,51 @@ asmlinkage void plat_irq_dispatch(struct pt_regs
*regs)
 		do_IRQ(MSP_INT_SW1);
 }
 
-static struct irqaction cascade_msp = {
+static struct irqaction cic_cascade_msp = {
 	.handler = no_action,
-	.name	 = "MSP cascade"
+	.name	 = "MSP CIC cascade"
 };
 
+static struct irqaction per_cascade_msp = {
+	.handler = no_action,
+	.name	 = "MSP PER cascade"
+};
 
 void __init arch_init_irq(void)
 {
+	/* assume we'll be using vectored interrupt mode except in UP mode*/
+#ifdef CONFIG_MIPS_MT
+	BUG_ON(!cpu_has_vint);
+#endif
+
 	/* initialize the 1st-level CPU based interrupt controller */
 	mips_cpu_irq_init();
 
 #ifdef CONFIG_IRQ_MSP_CIC
 	msp_cic_irq_init();
+#ifdef CONFIG_MIPS_MT
+	set_vi_handler(MSP_INT_CIC, msp_cic_irq_dispatch);
+	set_vi_handler(MSP_INT_MAC0, mac0_int_dispatch);
+	set_vi_handler(MSP_INT_MAC1, mac1_int_dispatch);
+	set_vi_handler(MSP_INT_SAR, mac2_int_dispatch);
+	set_vi_handler(MSP_INT_USB, usb_int_dispatch);
+	set_vi_handler(MSP_INT_SEC, sec_int_dispatch);
+#endif
+#ifdef CONFIG_MIPS_MT_SMP
+	msp_vsmp_int_init();
+#endif
 
 	/* setup the cascaded interrupts */
-	setup_irq(MSP_INT_CIC, &cascade_msp);
-	setup_irq(MSP_INT_PER, &cascade_msp);
+	setup_irq(MSP_INT_CIC, &cic_cascade_msp);
+	setup_irq(MSP_INT_PER, &per_cascade_msp);
+
 #else
 	/* setup the 2nd-level SLP register based interrupt controller */
+	/* VSMP /SMTC support support is not enabled for SLP */
 	msp_slp_irq_init();
 
 	/* setup the cascaded SLP/PER interrupts */
-	setup_irq(MSP_INT_SLP, &cascade_msp);
-	setup_irq(MSP_INT_PER, &cascade_msp);
+	setup_irq(MSP_INT_SLP, &cic_cascade_msp);
+	setup_irq(MSP_INT_PER, &per_cascade_msp);
 #endif
 }
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
index a54e85b..d7e06b8 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
@@ -225,6 +225,9 @@ void __init prom_init(void)
 	 * in separate specific files.
 	 */
 	msp_serial_setup();
+#ifdef CONFIG_MIPS_MT_SMP
+	register_smp_ops(&vsmp_smp_ops);
+#endif
 
 #ifdef CONFIG_PMCTWILED
 	/*
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c
b/arch/mips/pmc-sierra/msp71xx/msp_time.c
index 01df84c..67c0222 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -83,5 +83,5 @@ void __init plat_time_init(void)
 
 unsigned int __cpuinit get_c0_compare_int(void)
 {
-	return MSP_INT_VPE0_TIMER;
+	return smp_processor_id() ? MSP_INT_VPE1_TIMER : MSP_INT_VPE0_TIMER;
 }
-- 
1.7.0.4
