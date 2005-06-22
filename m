Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 00:03:28 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:216.31.210.19]:8717 "EHLO
	MMS3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225407AbVFVXCx>; Thu, 23 Jun 2005 00:02:53 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Wed, 22 Jun 2005 16:01:45 -0700
X-Server-Uuid: 35E76369-CF33-4172-911A-D1698BD5E887
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 16:01:34 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BFO30719; Wed, 22 Jun 2005 16:01:30 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id QAA02351 for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 16:01:29
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j5MN1Aov008171 for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005
 16:01:28 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j5MN19S17950 for linux-mips@linux-mips.org; Wed, 22 Jun 2005
 16:01:09 -0700
Date:	Wed, 22 Jun 2005 16:01:09 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [patch 2/5] SiByte fixes for 2.6.12
Message-ID: <20050622230109.GA17938@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20050622230003.GA17725@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6EA732532EO417636-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Update sb1250_set_affinity to use cpumask_t rather than hand-rolled
bitmask code.

Signed-Off-By: Andrew Isaacson <adi@broadcom.com>

Index: linux-2.6-work/arch/mips/sibyte/sb1250/irq.c
===================================================================
--- linux-2.6-work.orig/arch/mips/sibyte/sb1250/irq.c	2005-06-22 11:17:21.000000000 -0700
+++ linux-2.6-work/arch/mips/sibyte/sb1250/irq.c	2005-06-22 11:17:30.000000000 -0700
@@ -53,7 +53,7 @@
 static unsigned int startup_sb1250_irq(unsigned int irq);
 static void ack_sb1250_irq(unsigned int irq);
 #ifdef CONFIG_SMP
-static void sb1250_set_affinity(unsigned int irq, unsigned long mask);
+static void sb1250_set_affinity(unsigned int irq, cpumask_t mask);
 #endif
 
 #ifdef CONFIG_SIBYTE_HAS_LDT
@@ -117,23 +117,16 @@
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
+	if (cpus_weight(mask) > 1) {
 		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
 		return;
 	}

--
