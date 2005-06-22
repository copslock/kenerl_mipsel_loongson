Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2005 16:08:30 +0100 (BST)
Received: from pasta.sw.starentnetworks.com ([IPv6:::ffff:12.33.234.10]:38845
	"EHLO pasta.sw.starentnetworks.com") by linux-mips.org with ESMTP
	id <S8225216AbVFVPIK>; Wed, 22 Jun 2005 16:08:10 +0100
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP id B131414B6D7
	for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 11:06:57 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17081.32401.574987.337795@cortez.sw.starentnetworks.com>
Date:	Wed, 22 Jun 2005 11:06:57 -0400
From:	djohnson+linuxmips@sw.starentnetworks.com
To:	linux-mips@linux-mips.org
Subject: [PATCH] various sibyte 2.6.x bugfixes
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


Below patch is against 2.6.11 CVS tag and changes these items not
already in later CVS releases:

* update sb1250_set_affinity() to use cpumask_t

* fix printk format warning in swarm_be_handler()

* fix fatal alignment problem in sb1250-mac.c if CONFIG_DEBUG_SLAB
  enabled. (SBMAC corrupts descriptor table)

-- 
Dave Johnson
Starent Networks



===== arch/mips/sibyte/sb1250/irq.c 1.7 vs edited =====
--- 1.7/arch/mips/sibyte/sb1250/irq.c	Mon Jun 20 13:01:09 2005
+++ edited/arch/mips/sibyte/sb1250/irq.c	Mon Jun 20 14:27:08 2005
@@ -53,7 +53,7 @@
 static unsigned int startup_sb1250_irq(unsigned int irq);
 static void ack_sb1250_irq(unsigned int irq);
 #ifdef CONFIG_SMP
-static void sb1250_set_affinity(unsigned int irq, unsigned long mask);
+static void sb1250_set_affinity(unsigned int irq, cpumask_t mask);
 #endif
 
 #ifdef CONFIG_SIBYTE_HAS_LDT
@@ -117,24 +117,17 @@
 }
 
 #ifdef CONFIG_SMP
-static void sb1250_set_affinity(unsigned int irq, unsigned long mask)
+static void sb1250_set_affinity(unsigned int irq, cpumask_t mask)
 {
 	int i = 0, old_cpu, cpu, int_on;
 	u64 cur_ints;
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 
-	while (mask) {
-		if (mask & 1) {
-			mask >>= 1;
-			break;
-		}
-		mask >>= 1;
-		i++;
-	}
+	i = first_cpu(mask);
 
-	if (mask) {
-		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
+	if ((i == NR_CPUS) || (next_cpu(i, mask) != NR_CPUS)) {
+		printk("attempted to set irq affinity for irq %d to zero/multiple CPUs\n", irq);
 		return;
 	}
 
===== arch/mips/sibyte/swarm/setup.c 1.7 vs edited =====
--- 1.7/arch/mips/sibyte/swarm/setup.c	Tue Jan  4 21:48:16 2005
+++ edited/arch/mips/sibyte/swarm/setup.c	Mon Jun 20 17:19:25 2005
@@ -74,7 +74,7 @@
 	if (!is_fixup && (regs->cp0_cause & 4)) {
 		/* Data bus error - print PA */
 #ifdef CONFIG_MIPS64
-		printk("DBE physical address: %010lx\n",
+		printk("DBE physical address: %010llx\n",
 		       __read_64bit_c0_register($26, 1));
 #else
 		printk("DBE physical address: %010llx\n",
===== drivers/net/sb1250-mac.c 1.16 vs edited =====
--- 1.16/drivers/net/sb1250-mac.c	Mon Jun 20 13:01:12 2005
+++ edited/drivers/net/sb1250-mac.c	Wed Jun 22 10:10:35 2005
@@ -750,8 +750,16 @@
 	d->sbdma_maxdescr = maxdescr;
 	
 	d->sbdma_dscrtable = (sbdmadscr_t *) 
-		kmalloc(d->sbdma_maxdescr*sizeof(sbdmadscr_t), GFP_KERNEL);
+		kmalloc(d->sbdma_maxdescr*sizeof(sbdmadscr_t)+SMP_CACHE_BYTES, GFP_KERNEL);
 	
+	/*
+	 * The descriptor table must be aligned to at least 16 bytes or the
+	 * MAC will corrupt it. Align it to 32 bytes.
+	 */
+	if ((unsigned long)d->sbdma_dscrtable & (SMP_CACHE_BYTES-1)) {
+		(unsigned long)d->sbdma_dscrtable += SMP_CACHE_BYTES - ((unsigned long)d->sbdma_dscrtable & (SMP_CACHE_BYTES-1));
+	}
+
 	memset(d->sbdma_dscrtable,0,d->sbdma_maxdescr*sizeof(sbdmadscr_t));
 	
 	d->sbdma_dscrtable_end = d->sbdma_dscrtable + d->sbdma_maxdescr;
