Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 19:28:41 +0100 (BST)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:53262 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225246AbTDYS2k>; Fri, 25 Apr 2003 19:28:40 +0100
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.2)); Fri, 25 Apr 2003 11:28:24 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA00039; Fri, 25 Apr 2003 11:28:15 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.4/SSF) with ESMTP id
 h3PISWml020070; Fri, 25 Apr 2003 11:28:32 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id LAA05496; Fri,
 25 Apr 2003 11:28:31 -0700
Message-ID: <3EA97E4F.42C2441F@broadcom.com>
Date: Fri, 25 Apr 2003 11:28:31 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
cc: "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH]: load_mmu for SMP systems
References: <3EA97D54.6910D49E@broadcom.com>
X-WSS-ID: 12B7A1C22176111-01-01
Content-Type: multipart/mixed;
 boundary=------------E2894F85DC36FBB51CCC4951
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------E2894F85DC36FBB51CCC4951
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit


OK, I'll add some declarations make it tidier.

Kip

Kip Walker wrote:
> 
> In SMP systems, each CPU needs to set up "current_cpu_data.tlbsize".
> Some CPUs do this initialization in cpu_probe, which is called both by
> init_arch and start_secondary.  However, some CPUs do this in their TLB
> setup code, which is called via load_mmu.  The SMP boot code doesn't
> currently call load_mmu() for the secondary CPUs.  Here's a simple fix
> for the 2.4 tree.
> 
> TLB flush routines that have loops running up to tlbsize will lose if
> it's not set properly on all CPUs!
--------------E2894F85DC36FBB51CCC4951
Content-Type: text/plain;
 charset=us-ascii;
 name=loadmmu.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=loadmmu.diff

Index: arch/mips/kernel/smp.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/smp.c,v
retrieving revision 1.10.2.24
diff -u -r1.10.2.24 smp.c
--- arch/mips/kernel/smp.c	23 Apr 2003 20:10:49 -0000	1.10.2.24
+++ arch/mips/kernel/smp.c	25 Apr 2003 18:27:05 -0000
@@ -39,6 +39,9 @@
 #include <asm/mmu_context.h>
 #include <asm/smp.h>
 
+extern void load_mmu(void);
+extern void per_cpu_trap_init(void);
+
 /* The 'big kernel lock' */
 spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int smp_threads_ready;	/* Not used */
@@ -99,6 +102,7 @@
 	unsigned int cpu = smp_processor_id();
 
 	cpu_probe();
+	load_mmu();
 	prom_init_secondary();
 	per_cpu_trap_init();
 
Index: arch/mips64/kernel/smp.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/smp.c,v
retrieving revision 1.26.2.22
diff -u -r1.26.2.22 smp.c
--- arch/mips64/kernel/smp.c	23 Apr 2003 20:10:49 -0000	1.26.2.22
+++ arch/mips64/kernel/smp.c	25 Apr 2003 18:27:05 -0000
@@ -39,6 +39,9 @@
 #include <asm/mmu_context.h>
 #include <asm/smp.h>
 
+extern void load_mmu(void);
+extern void per_cpu_trap_init(void);      
+
 /* The 'big kernel lock' */
 spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 int smp_threads_ready;	/* Not used */
@@ -103,6 +106,7 @@
 	unsigned int cpu = smp_processor_id();
 
 	cpu_probe();
+	load_mmu();
 	prom_init_secondary();
 	per_cpu_trap_init();
 

--------------E2894F85DC36FBB51CCC4951--
