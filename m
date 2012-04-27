Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 20:35:59 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:60880 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903685Ab2D0Scz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2012 20:32:55 +0200
Received: by pbbrq13 with SMTP id rq13so1412693pbb.36
        for <multiple recipients>; Fri, 27 Apr 2012 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UPA/x/3/dcF93oYo5YvCD9LdOjsPuWVoS/A91N+3f7k=;
        b=zoflk0no2mKvYVpYPWNDmVXFCiu5uvA+PPjDWH79GC9FPDoH0iyohAOifTGrujxU56
         BPSJygBmEdOir4Rh0WgeT0s2SAB6fRhqhL36LwdLuumeCQhgy51CZm7H99eAYDDlg5ma
         FzwkLuaJrPN2DAK0zYxr+Ls7PUdXmVgB+On7wPnmmWYS0cF8w2hV9/23f520/bmI1HbQ
         D06gJiHZOx3yTIeF7ZGP5irN4EuD5WsXX5xF1C1k4FZQ5LxPHL77PC2kh1aWy1nOusRf
         k17Ao3vjHPZOaGS88hIPEJ0fwoTLFwsTCtpzDvHFfIX4jRloOKP94jQ2ZhyJxx3VtPpL
         KNrQ==
Received: by 10.68.220.161 with SMTP id px1mr25371789pbc.12.1335551569031;
        Fri, 27 Apr 2012 11:32:49 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id vs10sm6409335pbc.53.2012.04.27.11.32.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 11:32:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3RIWjTM019650;
        Fri, 27 Apr 2012 11:32:45 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3RIWjP7019649;
        Fri, 27 Apr 2012 11:32:45 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 7/8] MIPS: Octeon: Make interrupt controller work with threaded handlers.
Date:   Fri, 27 Apr 2012 11:32:39 -0700
Message-Id: <1335551560-19581-8-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335551560-19581-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

For CIUv1 controllers, we were relying on all calls to the irq_chip
functions to be done from the CPU that received the irq, and that they
would all be done from interrupt contest.  These assumptions do not
hold for threaded handlers.

We make all the masking actually mask the irq source, and use real
raw_spin_locks instead of manually twiddling the Status[IE] bit.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |  280 +++++++++++++++++-----------------
 1 files changed, 137 insertions(+), 143 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index c616947..1eb4461 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -18,11 +18,9 @@
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-ciu2-defs.h>
 
-static DEFINE_RAW_SPINLOCK(octeon_irq_ciu0_lock);
-static DEFINE_RAW_SPINLOCK(octeon_irq_ciu1_lock);
-
 static DEFINE_PER_CPU(unsigned long, octeon_irq_ciu0_en_mirror);
 static DEFINE_PER_CPU(unsigned long, octeon_irq_ciu1_en_mirror);
+static DEFINE_PER_CPU(raw_spinlock_t, octeon_irq_ciu_spinlock);
 
 static __read_mostly u8 octeon_irq_ciu_to_irq[8][64];
 
@@ -238,22 +236,31 @@ static void octeon_irq_ciu_enable(struct irq_data *data)
 	unsigned long *pen;
 	unsigned long flags;
 	union octeon_ciu_chip_data cd;
+	raw_spinlock_t *lock = &per_cpu(octeon_irq_ciu_spinlock, cpu);
 
 	cd.p = irq_data_get_irq_chip_data(data);
 
+	raw_spin_lock_irqsave(lock, flags);
 	if (cd.s.line == 0) {
-		raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
 		pen = &per_cpu(octeon_irq_ciu0_en_mirror, cpu);
-		set_bit(cd.s.bit, pen);
+		__set_bit(cd.s.bit, pen);
+		/*
+		 * Must be visible to octeon_irq_ip{2,3}_ciu() before
+		 * enabling the irq.
+		 */
+		wmb();
 		cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), *pen);
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
 	} else {
-		raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
 		pen = &per_cpu(octeon_irq_ciu1_en_mirror, cpu);
-		set_bit(cd.s.bit, pen);
+		__set_bit(cd.s.bit, pen);
+		/*
+		 * Must be visible to octeon_irq_ip{2,3}_ciu() before
+		 * enabling the irq.
+		 */
+		wmb();
 		cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), *pen);
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
 	}
+	raw_spin_unlock_irqrestore(lock, flags);
 }
 
 static void octeon_irq_ciu_enable_local(struct irq_data *data)
@@ -261,22 +268,31 @@ static void octeon_irq_ciu_enable_local(struct irq_data *data)
 	unsigned long *pen;
 	unsigned long flags;
 	union octeon_ciu_chip_data cd;
+	raw_spinlock_t *lock = &__get_cpu_var(octeon_irq_ciu_spinlock);
 
 	cd.p = irq_data_get_irq_chip_data(data);
 
+	raw_spin_lock_irqsave(lock, flags);
 	if (cd.s.line == 0) {
-		raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
 		pen = &__get_cpu_var(octeon_irq_ciu0_en_mirror);
-		set_bit(cd.s.bit, pen);
+		__set_bit(cd.s.bit, pen);
+		/*
+		 * Must be visible to octeon_irq_ip{2,3}_ciu() before
+		 * enabling the irq.
+		 */
+		wmb();
 		cvmx_write_csr(CVMX_CIU_INTX_EN0(cvmx_get_core_num() * 2), *pen);
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
 	} else {
-		raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
 		pen = &__get_cpu_var(octeon_irq_ciu1_en_mirror);
-		set_bit(cd.s.bit, pen);
+		__set_bit(cd.s.bit, pen);
+		/*
+		 * Must be visible to octeon_irq_ip{2,3}_ciu() before
+		 * enabling the irq.
+		 */
+		wmb();
 		cvmx_write_csr(CVMX_CIU_INTX_EN1(cvmx_get_core_num() * 2 + 1), *pen);
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
 	}
+	raw_spin_unlock_irqrestore(lock, flags);
 }
 
 static void octeon_irq_ciu_disable_local(struct irq_data *data)
@@ -284,22 +300,31 @@ static void octeon_irq_ciu_disable_local(struct irq_data *data)
 	unsigned long *pen;
 	unsigned long flags;
 	union octeon_ciu_chip_data cd;
+	raw_spinlock_t *lock = &__get_cpu_var(octeon_irq_ciu_spinlock);
 
 	cd.p = irq_data_get_irq_chip_data(data);
 
+	raw_spin_lock_irqsave(lock, flags);
 	if (cd.s.line == 0) {
-		raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
 		pen = &__get_cpu_var(octeon_irq_ciu0_en_mirror);
-		clear_bit(cd.s.bit, pen);
+		__clear_bit(cd.s.bit, pen);
+		/*
+		 * Must be visible to octeon_irq_ip{2,3}_ciu() before
+		 * enabling the irq.
+		 */
+		wmb();
 		cvmx_write_csr(CVMX_CIU_INTX_EN0(cvmx_get_core_num() * 2), *pen);
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
 	} else {
-		raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
 		pen = &__get_cpu_var(octeon_irq_ciu1_en_mirror);
-		clear_bit(cd.s.bit, pen);
+		__clear_bit(cd.s.bit, pen);
+		/*
+		 * Must be visible to octeon_irq_ip{2,3}_ciu() before
+		 * enabling the irq.
+		 */
+		wmb();
 		cvmx_write_csr(CVMX_CIU_INTX_EN1(cvmx_get_core_num() * 2 + 1), *pen);
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
 	}
+	raw_spin_unlock_irqrestore(lock, flags);
 }
 
 static void octeon_irq_ciu_disable_all(struct irq_data *data)
@@ -308,29 +333,30 @@ static void octeon_irq_ciu_disable_all(struct irq_data *data)
 	unsigned long *pen;
 	int cpu;
 	union octeon_ciu_chip_data cd;
-
-	wmb(); /* Make sure flag changes arrive before register updates. */
+	raw_spinlock_t *lock;
 
 	cd.p = irq_data_get_irq_chip_data(data);
 
-	if (cd.s.line == 0) {
-		raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
-		for_each_online_cpu(cpu) {
-			int coreid = octeon_coreid_for_cpu(cpu);
+	for_each_online_cpu(cpu) {
+		int coreid = octeon_coreid_for_cpu(cpu);
+		lock = &per_cpu(octeon_irq_ciu_spinlock, cpu);
+		if (cd.s.line == 0)
 			pen = &per_cpu(octeon_irq_ciu0_en_mirror, cpu);
-			clear_bit(cd.s.bit, pen);
-			cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), *pen);
-		}
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
-	} else {
-		raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
-		for_each_online_cpu(cpu) {
-			int coreid = octeon_coreid_for_cpu(cpu);
+		else
 			pen = &per_cpu(octeon_irq_ciu1_en_mirror, cpu);
-			clear_bit(cd.s.bit, pen);
+
+		raw_spin_lock_irqsave(lock, flags);
+		__clear_bit(cd.s.bit, pen);
+		/*
+		 * Must be visible to octeon_irq_ip{2,3}_ciu() before
+		 * enabling the irq.
+		 */
+		wmb();
+		if (cd.s.line == 0)
+			cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), *pen);
+		else
 			cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), *pen);
-		}
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 }
 
@@ -340,27 +366,30 @@ static void octeon_irq_ciu_enable_all(struct irq_data *data)
 	unsigned long *pen;
 	int cpu;
 	union octeon_ciu_chip_data cd;
+	raw_spinlock_t *lock;
 
 	cd.p = irq_data_get_irq_chip_data(data);
 
-	if (cd.s.line == 0) {
-		raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
-		for_each_online_cpu(cpu) {
-			int coreid = octeon_coreid_for_cpu(cpu);
+	for_each_online_cpu(cpu) {
+		int coreid = octeon_coreid_for_cpu(cpu);
+		lock = &per_cpu(octeon_irq_ciu_spinlock, cpu);
+		if (cd.s.line == 0)
 			pen = &per_cpu(octeon_irq_ciu0_en_mirror, cpu);
-			set_bit(cd.s.bit, pen);
-			cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), *pen);
-		}
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
-	} else {
-		raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
-		for_each_online_cpu(cpu) {
-			int coreid = octeon_coreid_for_cpu(cpu);
+		else
 			pen = &per_cpu(octeon_irq_ciu1_en_mirror, cpu);
-			set_bit(cd.s.bit, pen);
+
+		raw_spin_lock_irqsave(lock, flags);
+		__set_bit(cd.s.bit, pen);
+		/*
+		 * Must be visible to octeon_irq_ip{2,3}_ciu() before
+		 * enabling the irq.
+		 */
+		wmb();
+		if (cd.s.line == 0)
+			cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), *pen);
+		else
 			cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), *pen);
-		}
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 }
 
@@ -463,8 +492,6 @@ static void octeon_irq_ciu_disable_all_v2(struct irq_data *data)
 	u64 mask;
 	union octeon_ciu_chip_data cd;
 
-	wmb(); /* Make sure flag changes arrive before register updates. */
-
 	cd.p = irq_data_get_irq_chip_data(data);
 	mask = 1ull << (cd.s.bit);
 
@@ -622,6 +649,8 @@ static int octeon_irq_ciu_set_affinity(struct irq_data *data,
 	bool enable_one = !irqd_irq_disabled(data) && !irqd_irq_masked(data);
 	unsigned long flags;
 	union octeon_ciu_chip_data cd;
+	unsigned long *pen;
+	raw_spinlock_t *lock;
 
 	cd.p = irq_data_get_irq_chip_data(data);
 
@@ -636,36 +665,36 @@ static int octeon_irq_ciu_set_affinity(struct irq_data *data,
 	if (!enable_one)
 		return 0;
 
-	if (cd.s.line == 0) {
-		raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
-		for_each_online_cpu(cpu) {
-			int coreid = octeon_coreid_for_cpu(cpu);
-			unsigned long *pen = &per_cpu(octeon_irq_ciu0_en_mirror, cpu);
 
-			if (cpumask_test_cpu(cpu, dest) && enable_one) {
-				enable_one = false;
-				set_bit(cd.s.bit, pen);
-			} else {
-				clear_bit(cd.s.bit, pen);
-			}
-			cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), *pen);
+	for_each_online_cpu(cpu) {
+		int coreid = octeon_coreid_for_cpu(cpu);
+
+		lock = &per_cpu(octeon_irq_ciu_spinlock, cpu);
+		raw_spin_lock_irqsave(lock, flags);
+
+		if (cd.s.line == 0)
+			pen = &per_cpu(octeon_irq_ciu0_en_mirror, cpu);
+		else
+			pen = &per_cpu(octeon_irq_ciu1_en_mirror, cpu);
+
+		if (cpumask_test_cpu(cpu, dest) && enable_one) {
+			enable_one = 0;
+			__set_bit(cd.s.bit, pen);
+		} else {
+			__clear_bit(cd.s.bit, pen);
 		}
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
-	} else {
-		raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
-		for_each_online_cpu(cpu) {
-			int coreid = octeon_coreid_for_cpu(cpu);
-			unsigned long *pen = &per_cpu(octeon_irq_ciu1_en_mirror, cpu);
+		/*
+		 * Must be visible to octeon_irq_ip{2,3}_ciu() before
+		 * enabling the irq.
+		 */
+		wmb();
 
-			if (cpumask_test_cpu(cpu, dest) && enable_one) {
-				enable_one = false;
-				set_bit(cd.s.bit, pen);
-			} else {
-				clear_bit(cd.s.bit, pen);
-			}
+		if (cd.s.line == 0)
+			cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), *pen);
+		else
 			cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), *pen);
-		}
-		raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
+
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 	return 0;
 }
@@ -721,14 +750,6 @@ static int octeon_irq_ciu_set_affinity_v2(struct irq_data *data,
 #endif
 
 /*
- * The v1 CIU code already masks things, so supply a dummy version to
- * the core chip code.
- */
-static void octeon_irq_dummy_mask(struct irq_data *data)
-{
-}
-
-/*
  * Newer octeon chips have support for lockless CIU operation.
  */
 static struct irq_chip octeon_irq_chip_ciu_v2 = {
@@ -749,7 +770,8 @@ static struct irq_chip octeon_irq_chip_ciu = {
 	.irq_enable = octeon_irq_ciu_enable,
 	.irq_disable = octeon_irq_ciu_disable_all,
 	.irq_ack = octeon_irq_ciu_ack,
-	.irq_mask = octeon_irq_dummy_mask,
+	.irq_mask = octeon_irq_ciu_disable_local,
+	.irq_unmask = octeon_irq_ciu_enable,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = octeon_irq_ciu_set_affinity,
 #endif
@@ -773,6 +795,8 @@ static struct irq_chip octeon_irq_chip_ciu_mbox = {
 	.name = "CIU-M",
 	.irq_enable = octeon_irq_ciu_enable_all,
 	.irq_disable = octeon_irq_ciu_disable_all,
+	.irq_ack = octeon_irq_ciu_disable_local,
+	.irq_eoi = octeon_irq_ciu_enable_local,
 
 	.irq_cpu_online = octeon_irq_ciu_enable_local,
 	.irq_cpu_offline = octeon_irq_ciu_disable_local,
@@ -797,7 +821,8 @@ static struct irq_chip octeon_irq_chip_ciu_gpio = {
 	.name = "CIU-GPIO",
 	.irq_enable = octeon_irq_ciu_enable_gpio,
 	.irq_disable = octeon_irq_ciu_disable_gpio,
-	.irq_mask = octeon_irq_dummy_mask,
+	.irq_mask = octeon_irq_ciu_disable_local,
+	.irq_unmask = octeon_irq_ciu_enable,
 	.irq_ack = octeon_irq_ciu_gpio_ack,
 	.irq_set_type = octeon_irq_ciu_gpio_set_type,
 #ifdef CONFIG_SMP
@@ -816,12 +841,18 @@ static void octeon_irq_ciu_wd_enable(struct irq_data *data)
 	unsigned long *pen;
 	int coreid = data->irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
 	int cpu = octeon_cpu_for_coreid(coreid);
+	raw_spinlock_t *lock = &per_cpu(octeon_irq_ciu_spinlock, cpu);
 
-	raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
+	raw_spin_lock_irqsave(lock, flags);
 	pen = &per_cpu(octeon_irq_ciu1_en_mirror, cpu);
-	set_bit(coreid, pen);
+	__set_bit(coreid, pen);
+	/*
+	 * Must be visible to octeon_irq_ip{2,3}_ciu() before enabling
+	 * the irq.
+	 */
+	wmb();
 	cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), *pen);
-	raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
+	raw_spin_unlock_irqrestore(lock, flags);
 }
 
 /*
@@ -850,7 +881,8 @@ static struct irq_chip octeon_irq_chip_ciu_wd = {
 	.name = "CIU-W",
 	.irq_enable = octeon_irq_ciu_wd_enable,
 	.irq_disable = octeon_irq_ciu_disable_all,
-	.irq_mask = octeon_irq_dummy_mask,
+	.irq_mask = octeon_irq_ciu_disable_local,
+	.irq_unmask = octeon_irq_ciu_enable_local,
 };
 
 static bool octeon_irq_ciu_is_edge(unsigned int line, unsigned int bit)
@@ -1032,27 +1064,7 @@ static struct irq_domain_ops octeon_irq_domain_gpio_ops = {
 	.xlate = octeon_irq_gpio_xlat,
 };
 
-static void octeon_irq_ip2_v1(void)
-{
-	const unsigned long core_id = cvmx_get_core_num();
-	u64 ciu_sum = cvmx_read_csr(CVMX_CIU_INTX_SUM0(core_id * 2));
-
-	ciu_sum &= __get_cpu_var(octeon_irq_ciu0_en_mirror);
-	clear_c0_status(STATUSF_IP2);
-	if (likely(ciu_sum)) {
-		int bit = fls64(ciu_sum) - 1;
-		int irq = octeon_irq_ciu_to_irq[0][bit];
-		if (likely(irq))
-			do_IRQ(irq);
-		else
-			spurious_interrupt();
-	} else {
-		spurious_interrupt();
-	}
-	set_c0_status(STATUSF_IP2);
-}
-
-static void octeon_irq_ip2_v2(void)
+static void octeon_irq_ip2_ciu(void)
 {
 	const unsigned long core_id = cvmx_get_core_num();
 	u64 ciu_sum = cvmx_read_csr(CVMX_CIU_INTX_SUM0(core_id * 2));
@@ -1069,26 +1081,8 @@ static void octeon_irq_ip2_v2(void)
 		spurious_interrupt();
 	}
 }
-static void octeon_irq_ip3_v1(void)
-{
-	u64 ciu_sum = cvmx_read_csr(CVMX_CIU_INT_SUM1);
 
-	ciu_sum &= __get_cpu_var(octeon_irq_ciu1_en_mirror);
-	clear_c0_status(STATUSF_IP3);
-	if (likely(ciu_sum)) {
-		int bit = fls64(ciu_sum) - 1;
-		int irq = octeon_irq_ciu_to_irq[1][bit];
-		if (likely(irq))
-			do_IRQ(irq);
-		else
-			spurious_interrupt();
-	} else {
-		spurious_interrupt();
-	}
-	set_c0_status(STATUSF_IP3);
-}
-
-static void octeon_irq_ip3_v2(void)
+static void octeon_irq_ip3_ciu(void)
 {
 	u64 ciu_sum = cvmx_read_csr(CVMX_CIU_INT_SUM1);
 
@@ -1139,6 +1133,12 @@ static void __cpuinit octeon_irq_percpu_enable(void)
 static void __cpuinit octeon_irq_init_ciu_percpu(void)
 {
 	int coreid = cvmx_get_core_num();
+
+
+	__get_cpu_var(octeon_irq_ciu0_en_mirror) = 0;
+	__get_cpu_var(octeon_irq_ciu1_en_mirror) = 0;
+	wmb();
+	raw_spin_lock_init(&__get_cpu_var(octeon_irq_ciu_spinlock));
 	/*
 	 * Disable All CIU Interrupts. The ones we need will be
 	 * enabled later.  Read the SUM register so we know the write
@@ -1175,10 +1175,6 @@ static void octeon_irq_init_ciu2_percpu(void)
 
 static void __cpuinit octeon_irq_setup_secondary_ciu(void)
 {
-
-	__get_cpu_var(octeon_irq_ciu0_en_mirror) = 0;
-	__get_cpu_var(octeon_irq_ciu1_en_mirror) = 0;
-
 	octeon_irq_init_ciu_percpu();
 	octeon_irq_percpu_enable();
 
@@ -1212,19 +1208,17 @@ static void __init octeon_irq_init_ciu(void)
 	octeon_irq_init_ciu_percpu();
 	octeon_irq_setup_secondary = octeon_irq_setup_secondary_ciu;
 
+	octeon_irq_ip2 = octeon_irq_ip2_ciu;
+	octeon_irq_ip3 = octeon_irq_ip3_ciu;
 	if (OCTEON_IS_MODEL(OCTEON_CN58XX_PASS2_X) ||
 	    OCTEON_IS_MODEL(OCTEON_CN56XX_PASS2_X) ||
 	    OCTEON_IS_MODEL(OCTEON_CN52XX_PASS2_X) ||
 	    OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
-		octeon_irq_ip2 = octeon_irq_ip2_v2;
-		octeon_irq_ip3 = octeon_irq_ip3_v2;
 		chip = &octeon_irq_chip_ciu_v2;
 		chip_mbox = &octeon_irq_chip_ciu_mbox_v2;
 		chip_wd = &octeon_irq_chip_ciu_wd_v2;
 		octeon_irq_gpio_chip = &octeon_irq_chip_ciu_gpio_v2;
 	} else {
-		octeon_irq_ip2 = octeon_irq_ip2_v1;
-		octeon_irq_ip3 = octeon_irq_ip3_v1;
 		chip = &octeon_irq_chip_ciu;
 		chip_mbox = &octeon_irq_chip_ciu_mbox;
 		chip_wd = &octeon_irq_chip_ciu_wd;
-- 
1.7.2.3
