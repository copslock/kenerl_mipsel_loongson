Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2005 18:41:00 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:216.31.210.18]:46094 "EHLO
	MMS2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225421AbVHXRko>; Wed, 24 Aug 2005 18:40:44 +0100
Received: from 10.10.64.121 by MMS2.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Wed, 24 Aug 2005 10:45:52 -0700
X-Server-Uuid: 1F20ACF3-9CAF-44F7-AB47-F294E2D5B4EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 24 Aug 2005 10:45:50 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BQQ54061; Wed, 24 Aug 2005 10:45:18 -0700 (PDT)
Received: from nt-sjca-0740.brcm.ad.broadcom.com (
 nt-sjca-0740.sj.broadcom.com [10.16.192.49]) by
 mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP id KAA16998 for
 <linux-mips@linux-mips.org>; Wed, 24 Aug 2005 10:45:17 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com ([10.16.192.220]) by
 nt-sjca-0740.brcm.ad.broadcom.com with Microsoft SMTPSVC(6.0.3790.211);
 Wed, 24 Aug 2005 10:45:17 -0700
Received: from [127.0.0.1] ([10.27.253.8]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft SMTPSVC(6.0.3790.211);
 Wed, 24 Aug 2005 10:45:16 -0700
Message-ID: <430CB229.1000405@broadcom.com>
Date:	Wed, 24 Aug 2005 10:45:13 -0700
From:	"Mark Mason" <mason@broadcom.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Patch to arch/mips/sibyte/sb1250/irq.c
X-OriginalArrivalTime: 24 Aug 2005 17:45:17.0210 (UTC)
 FILETIME=[96D5FFA0:01C5A8D3]
X-WSS-ID: 6F126DDA1NK1432906-01-01
Content-Type: multipart/mixed;
 boundary=------------090000050301070100020606
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090000050301070100020606
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

Attached is a patch to the sb1250 version of irq.c to fix compilation 
warnings (and make the code more correct).

Change sb1250_set_affinity() to use the proper datatype and access 
macros for the cpu mask.

Thanks,
Mark



--------------090000050301070100020606
Content-Type: text/plain;
 name=irq-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=irq-patch

Index: arch/mips/sibyte/sb1250/irq.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sibyte/sb1250/irq.c,v
retrieving revision 1.34
diff -u -p -r1.34 irq.c
--- arch/mips/sibyte/sb1250/irq.c	11 Jul 2005 10:03:30 -0000	1.34
+++ arch/mips/sibyte/sb1250/irq.c	24 Aug 2005 17:33:33 -0000
@@ -53,7 +53,7 @@ static void disable_sb1250_irq(unsigned 
 static unsigned int startup_sb1250_irq(unsigned int irq);
 static void ack_sb1250_irq(unsigned int irq);
 #ifdef CONFIG_SMP
-static void sb1250_set_affinity(unsigned int irq, unsigned long mask);
+static void sb1250_set_affinity(unsigned int irq, cpumask_t mask);
 #endif
 
 #ifdef CONFIG_SIBYTE_HAS_LDT
@@ -117,26 +117,19 @@ void sb1250_unmask_irq(int cpu, int irq)
 }
 
 #ifdef CONFIG_SMP
-static void sb1250_set_affinity(unsigned int irq, unsigned long mask)
+static void sb1250_set_affinity(unsigned int irq, cpumask_t mask)
 {
-	int i = 0, old_cpu, cpu, int_on;
+	int i = 0, old_cpu, cpu, int_on, weight;
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
-
-	if (mask) {
+	weight = cpus_weight(mask);
+	if (weight > 1) {
 		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
 		return;
-	}
+	} else if (weight != 0)
+		i = first_cpu(mask);
 
 	/* Convert logical CPU to physical CPU */
 	cpu = cpu_logical_map(i);

--------------090000050301070100020606--
