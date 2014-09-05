Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:35:12 +0200 (CEST)
Received: from mail-ob0-f202.google.com ([209.85.214.202]:44381 "EHLO
        mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025911AbaIERarbGm0S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:47 +0200
Received: by mail-ob0-f202.google.com with SMTP id wp18so2082603obc.3
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rpl2JdSPo8tnSjBfmdT9NhKu3hDb7rLTwd34KbVFjMw=;
        b=V614iSfw/f/CYFpphgQTrW5RRW0PNvcvw2ERFza+fqoaRp+YFoWunGMZu19tp3PjCg
         U3734ceWOoDN+lMpUWBwZyZCCjTSb2nD65xb9JwSpCBoUzibMh7+Gip7D7fa461cPCNJ
         m6agSGYOF1vDOptqq0TMhanVwYhVIUSArwhg35gCAAfxNCxXVvktE8r49H8iuqBYLtZe
         G+92SWpxZdNHHn2wVCIbQgYfzTRT+k4lGSCFVubBl0Vc5tC/3gXSO5imyEJHSyi6lCFq
         WIm+JcTSrxTXEAAdErkRH98TE4Uy86DBWphPQQY7TC/aLSF61jzWHamB/1m9r5rfFVlT
         ASIg==
X-Gm-Message-State: ALoCoQmDpnERH23akKw5u3mcilZP2FBYmpDAz0jHT31fVnIpKFhWzAjtkw0dSo18yZ85zgvW+wU0
X-Received: by 10.182.81.161 with SMTP id b1mr7175431oby.1.1409938241774;
        Fri, 05 Sep 2014 10:30:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c77si506623yha.5.2014.09.05.10.30.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:41 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 828245A427D;
        Fri,  5 Sep 2014 10:30:41 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 4707E2209EA; Fri,  5 Sep 2014 10:30:41 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/16] MIPS: Malta: Map GIC local interrupts
Date:   Fri,  5 Sep 2014 10:30:18 -0700
Message-Id: <1409938218-9026-17-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Now that the GIC driver properly supports local interrupts, extend
the static interrupt mapping to include the GIC timer and watchdog
and fix up the GIC interrupt setup and handling so that the local
interrupts are properly handled.  Note that ipi_map is also renamed
to gic_irq_map since it is now also used to track mapping of non-IPI
interrupts to CPUs.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
No changes from v1.
---
 arch/mips/mti-malta/malta-int.c | 44 +++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index e4f43ba..16b1473 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -38,7 +38,7 @@
 #include <asm/rtlx.h>
 
 static unsigned long _msc01_biu_base;
-static unsigned int ipi_map[NR_CPUS];
+static unsigned int gic_irq_map[NR_CPUS];
 
 static DEFINE_RAW_SPINLOCK(mips_irq_lock);
 
@@ -129,8 +129,8 @@ static void malta_hw0_irqdispatch(void)
 
 static void malta_ipi_irqdispatch(void)
 {
-#ifdef CONFIG_MIPS_GIC_IPI
 	unsigned long irq;
+#ifdef CONFIG_MIPS_GIC_IPI
 	DECLARE_BITMAP(pending, GIC_NUM_INTRS);
 
 	gic_get_int_mask(pending, ipi_ints);
@@ -143,8 +143,12 @@ static void malta_ipi_irqdispatch(void)
 		irq = find_next_bit(pending, GIC_NUM_INTRS, irq + 1);
 	}
 #endif
-	if (gic_compare_int())
-		do_IRQ(MIPS_GIC_IRQ_BASE);
+	irq = gic_get_local_int();
+	while (irq < GIC_NUM_LOCAL_INTRS) {
+		do_IRQ(MIPS_GIC_LOCAL_IRQ_BASE + irq);
+
+		irq = gic_get_local_int();
+	}
 }
 
 static void corehi_irqdispatch(void)
@@ -288,7 +292,7 @@ asmlinkage void plat_irq_dispatch(void)
 
 	if (irq == MIPSCPU_INT_I8259A)
 		malta_hw0_irqdispatch();
-	else if (gic_present && ((1 << irq) & ipi_map[smp_processor_id()]))
+	else if (gic_present && ((1 << irq) & gic_irq_map[smp_processor_id()]))
 		malta_ipi_irqdispatch();
 	else
 		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
@@ -408,7 +412,7 @@ static int msc_nr_eicirqs __initdata = ARRAY_SIZE(msc_eicirqmap);
 #define GIC_CPU_NMI GIC_MAP_TO_NMI_MSK
 #define X GIC_UNUSED
 
-static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
+static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS + GIC_NUM_LOCAL_INTRS] = {
 	{ X, X,		   X,		X,		0 },
 	{ X, X,		   X,		X,		0 },
 	{ X, X,		   X,		X,		0 },
@@ -425,7 +429,10 @@ static struct gic_intr_map gic_intr_map[GIC_NUM_INTRS] = {
 	{ 0, GIC_CPU_NMI,  GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
 	{ 0, GIC_CPU_NMI,  GIC_POL_POS, GIC_TRIG_LEVEL, GIC_FLAG_TRANSPARENT },
 	{ X, X,		   X,		X,		0 },
-	/* The remainder of this table is initialised by fill_ipi_map */
+	/*
+	 * The remainder of this table is initialised by fill_ipi_map and
+	 * fill_local_irq_map
+	 */
 };
 #undef X
 
@@ -438,7 +445,7 @@ static void __init fill_ipi_map1(int baseintr, int cpu, int cpupin)
 	gic_intr_map[intr].polarity = GIC_POL_POS;
 	gic_intr_map[intr].trigtype = GIC_TRIG_EDGE;
 	gic_intr_map[intr].flags = 0;
-	ipi_map[cpu] |= (1 << (cpupin + 2));
+	gic_irq_map[cpu] |= (1 << (cpupin + 2));
 	bitmap_set(ipi_ints, intr, 1);
 }
 
@@ -453,6 +460,22 @@ static void __init fill_ipi_map(void)
 }
 #endif
 
+static void __init fill_local_irq_map(void)
+{
+	int i;
+
+	for (i = 0; i < GIC_NUM_LOCAL_INTRS; i++) {
+		int intr = i + GIC_NUM_INTRS;
+
+		gic_intr_map[intr].cpunum = 0;
+		gic_intr_map[intr].pin = GIC_CPU_INT2;
+		gic_intr_map[intr].flags = 0;
+	}
+
+	for (i = 0; i < NR_CPUS; i++)
+		gic_irq_map[i] |= 1 << (GIC_CPU_INT2 + 2);
+}
+
 void __init arch_init_ipiirq(int irq, struct irqaction *action)
 {
 	setup_irq(irq, action);
@@ -533,6 +556,7 @@ void __init arch_init_irq(void)
 		gic_resched_int_base = gic_call_int_base - nr_cpu_ids;
 		fill_ipi_map();
 #endif
+		fill_local_irq_map();
 		gic_init(GIC_BASE_ADDR, GIC_ADDRSPACE_SZ, gic_intr_map,
 				ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
 		if (!mips_cm_present()) {
@@ -542,8 +566,7 @@ void __init arch_init_irq(void)
 				(i | (0x1 << MSC01_SC_CFG_GICENA_SHF));
 			pr_debug("GIC Enabled\n");
 		}
-#if defined(CONFIG_MIPS_GIC_IPI)
-		/* set up ipi interrupts */
+		/* set up ipi and local interrupts */
 		if (cpu_has_vint) {
 			set_vi_handler(MIPSCPU_INT_IPI0, malta_ipi_irqdispatch);
 			set_vi_handler(MIPSCPU_INT_IPI1, malta_ipi_irqdispatch);
@@ -557,6 +580,7 @@ void __init arch_init_irq(void)
 		write_c0_status(0x1100dc00);
 		pr_info("CPU%d: status register frc %08x\n",
 			smp_processor_id(), read_c0_status());
+#if defined(CONFIG_MIPS_GIC_IPI)
 		for (i = 0; i < nr_cpu_ids; i++) {
 			arch_init_ipiirq(MIPS_GIC_IRQ_BASE +
 					 GIC_RESCHED_INT(i), &irq_resched);
-- 
2.1.0.rc2.206.gedb03e5
