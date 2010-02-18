Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2010 20:47:55 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:2685 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492443Ab0BRTrv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Feb 2010 20:47:51 +0100
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b7d97fc0000>; Thu, 18 Feb 2010 14:41:48 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 14:47:49 -0500
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 11:47:47 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1IJlgCA000898;
        Thu, 18 Feb 2010 11:47:42 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1IJlgKi000897;
        Thu, 18 Feb 2010 11:47:42 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Octeon: Replace rwlocks in irq_chip handlers with raw_spinlocks.
Date:   Thu, 18 Feb 2010 11:47:40 -0800
Message-Id: <1266522460-862-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6
X-OriginalArrivalTime: 18 Feb 2010 19:47:47.0173 (UTC) FILETIME=[3ECD9950:01CAB0D3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |   42 +++++++++++----------------------
 1 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 8f4a664..e0e5a59 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -13,8 +13,8 @@
 #include <asm/octeon/cvmx-pexp-defs.h>
 #include <asm/octeon/cvmx-npi-defs.h>
 
-DEFINE_RWLOCK(octeon_irq_ciu0_rwlock);
-DEFINE_RWLOCK(octeon_irq_ciu1_rwlock);
+static DEFINE_RAW_SPINLOCK(octeon_irq_ciu0_lock);
+static DEFINE_RAW_SPINLOCK(octeon_irq_ciu1_lock);
 static DEFINE_RAW_SPINLOCK(octeon_irq_msi_lock);
 
 static int octeon_coreid_for_cpu(int cpu)
@@ -138,19 +138,12 @@ static void octeon_irq_ciu0_enable(unsigned int irq)
 	uint64_t en0;
 	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
 
-	/*
-	 * A read lock is used here to make sure only one core is ever
-	 * updating the CIU enable bits at a time. During an enable
-	 * the cores don't interfere with each other. During a disable
-	 * the write lock stops any enables that might cause a
-	 * problem.
-	 */
-	read_lock_irqsave(&octeon_irq_ciu0_rwlock, flags);
+	raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
 	en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
 	en0 |= 1ull << bit;
 	cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
 	cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
-	read_unlock_irqrestore(&octeon_irq_ciu0_rwlock, flags);
+	raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
 }
 
 static void octeon_irq_ciu0_disable(unsigned int irq)
@@ -159,7 +152,7 @@ static void octeon_irq_ciu0_disable(unsigned int irq)
 	unsigned long flags;
 	uint64_t en0;
 	int cpu;
-	write_lock_irqsave(&octeon_irq_ciu0_rwlock, flags);
+	raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
 	for_each_online_cpu(cpu) {
 		int coreid = octeon_coreid_for_cpu(cpu);
 		en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
@@ -171,7 +164,7 @@ static void octeon_irq_ciu0_disable(unsigned int irq)
 	 * of them are done.
 	 */
 	cvmx_read_csr(CVMX_CIU_INTX_EN0(cvmx_get_core_num() * 2));
-	write_unlock_irqrestore(&octeon_irq_ciu0_rwlock, flags);
+	raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
 }
 
 /*
@@ -257,7 +250,7 @@ static int octeon_irq_ciu0_set_affinity(unsigned int irq, const struct cpumask *
 	unsigned long flags;
 	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
 
-	write_lock_irqsave(&octeon_irq_ciu0_rwlock, flags);
+	raw_spin_lock_irqsave(&octeon_irq_ciu0_lock, flags);
 	for_each_online_cpu(cpu) {
 		int coreid = octeon_coreid_for_cpu(cpu);
 		uint64_t en0 =
@@ -273,7 +266,7 @@ static int octeon_irq_ciu0_set_affinity(unsigned int irq, const struct cpumask *
 	 * of them are done.
 	 */
 	cvmx_read_csr(CVMX_CIU_INTX_EN0(cvmx_get_core_num() * 2));
-	write_unlock_irqrestore(&octeon_irq_ciu0_rwlock, flags);
+	raw_spin_unlock_irqrestore(&octeon_irq_ciu0_lock, flags);
 
 	return 0;
 }
@@ -378,19 +371,12 @@ static void octeon_irq_ciu1_enable(unsigned int irq)
 	uint64_t en1;
 	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
 
-	/*
-	 * A read lock is used here to make sure only one core is ever
-	 * updating the CIU enable bits at a time.  During an enable
-	 * the cores don't interfere with each other.  During a disable
-	 * the write lock stops any enables that might cause a
-	 * problem.
-	 */
-	read_lock_irqsave(&octeon_irq_ciu1_rwlock, flags);
+	raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
 	en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
 	en1 |= 1ull << bit;
 	cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
 	cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
-	read_unlock_irqrestore(&octeon_irq_ciu1_rwlock, flags);
+	raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
 }
 
 static void octeon_irq_ciu1_disable(unsigned int irq)
@@ -399,7 +385,7 @@ static void octeon_irq_ciu1_disable(unsigned int irq)
 	unsigned long flags;
 	uint64_t en1;
 	int cpu;
-	write_lock_irqsave(&octeon_irq_ciu1_rwlock, flags);
+	raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
 	for_each_online_cpu(cpu) {
 		int coreid = octeon_coreid_for_cpu(cpu);
 		en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
@@ -411,7 +397,7 @@ static void octeon_irq_ciu1_disable(unsigned int irq)
 	 * of them are done.
 	 */
 	cvmx_read_csr(CVMX_CIU_INTX_EN1(cvmx_get_core_num() * 2 + 1));
-	write_unlock_irqrestore(&octeon_irq_ciu1_rwlock, flags);
+	raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
 }
 
 /*
@@ -475,7 +461,7 @@ static int octeon_irq_ciu1_set_affinity(unsigned int irq,
 	unsigned long flags;
 	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
 
-	write_lock_irqsave(&octeon_irq_ciu1_rwlock, flags);
+	raw_spin_lock_irqsave(&octeon_irq_ciu1_lock, flags);
 	for_each_online_cpu(cpu) {
 		int coreid = octeon_coreid_for_cpu(cpu);
 		uint64_t en1 =
@@ -492,7 +478,7 @@ static int octeon_irq_ciu1_set_affinity(unsigned int irq,
 	 * of them are done.
 	 */
 	cvmx_read_csr(CVMX_CIU_INTX_EN1(cvmx_get_core_num() * 2 + 1));
-	write_unlock_irqrestore(&octeon_irq_ciu1_rwlock, flags);
+	raw_spin_unlock_irqrestore(&octeon_irq_ciu1_lock, flags);
 
 	return 0;
 }
-- 
1.6.6
