Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 17:52:59 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17383 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493189AbZJMPwx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 17:52:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad4a23e0000>; Tue, 13 Oct 2009 08:52:31 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Oct 2009 08:52:32 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Oct 2009 08:52:32 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n9DFqUdY022080;
	Tue, 13 Oct 2009 08:52:30 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n9DFqTBI022078;
	Tue, 13 Oct 2009 08:52:29 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Octeon: Use write_lock_irqsave/write_unlock_irqrestore when setting irq affinity.
Date:	Tue, 13 Oct 2009 08:52:28 -0700
Message-Id: <1255449149-22054-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4AD4A1E9.1080309@caviumnetworks.com>
References: <4AD4A1E9.1080309@caviumnetworks.com>
X-OriginalArrivalTime: 13 Oct 2009 15:52:32.0472 (UTC) FILETIME=[2CE92580:01CA4C1D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Since the locks are used from interrupt context we need the
irqsave/irqrestore versions of the locking functions.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-irq.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 384f184..0bda5c5 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -182,9 +182,10 @@ static void octeon_irq_ciu0_disable(unsigned int irq)
 static int octeon_irq_ciu0_set_affinity(unsigned int irq, const struct cpumask *dest)
 {
 	int cpu;
+	unsigned long flags;
 	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
 
-	write_lock(&octeon_irq_ciu0_rwlock);
+	write_lock_irqsave(&octeon_irq_ciu0_rwlock, flags);
 	for_each_online_cpu(cpu) {
 		int coreid = cpu_logical_map(cpu);
 		uint64_t en0 =
@@ -200,7 +201,7 @@ static int octeon_irq_ciu0_set_affinity(unsigned int irq, const struct cpumask *
 	 * of them are done.
 	 */
 	cvmx_read_csr(CVMX_CIU_INTX_EN0(cvmx_get_core_num() * 2));
-	write_unlock(&octeon_irq_ciu0_rwlock);
+	write_unlock_irqrestore(&octeon_irq_ciu0_rwlock, flags);
 
 	return 0;
 }
@@ -299,9 +300,10 @@ static void octeon_irq_ciu1_disable(unsigned int irq)
 static int octeon_irq_ciu1_set_affinity(unsigned int irq, const struct cpumask *dest)
 {
 	int cpu;
+	unsigned long flags;
 	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
 
-	write_lock(&octeon_irq_ciu1_rwlock);
+	write_lock_irqsave(&octeon_irq_ciu1_rwlock, flags);
 	for_each_online_cpu(cpu) {
 		int coreid = cpu_logical_map(cpu);
 		uint64_t en1 =
@@ -318,7 +320,7 @@ static int octeon_irq_ciu1_set_affinity(unsigned int irq, const struct cpumask *
 	 * of them are done.
 	 */
 	cvmx_read_csr(CVMX_CIU_INTX_EN1(cvmx_get_core_num() * 2 + 1));
-	write_unlock(&octeon_irq_ciu1_rwlock);
+	write_unlock_irqrestore(&octeon_irq_ciu1_rwlock, flags);
 
 	return 0;
 }
-- 
1.6.0.6
