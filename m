Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 01:54:43 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:61684 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225213AbTB0Bym>;
	Thu, 27 Feb 2003 01:54:42 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1R1set12480;
	Wed, 26 Feb 2003 17:54:40 -0800
Date: Wed, 26 Feb 2003 17:54:40 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] missing mmu ownership change
Message-ID: <20030226175440.E24501@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


In my previous patch that fixes a bunch of TLB issues,
a new bug was introduced.  Since we now rely on mm->cpu_vm_mask
to indicate the true MMU owner, we need to update this flag
whenever there is ownership change.  

It turns out that activate_mm() does the ownership as well.
Here is the patch that fixes this problem.

A big thank to Clausen for spotting this and tracing it to
a great depth.

Jun




--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

diff -Nru link/include/asm-mips/mmu_context.h.orig link/include/asm-mips/mmu_context.h
--- link/include/asm-mips/mmu_context.h.orig	Thu Feb 20 10:22:57 2003
+++ link/include/asm-mips/mmu_context.h	Wed Feb 26 17:43:43 2003
@@ -126,6 +126,7 @@
 activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	unsigned long flags;
+	int cpu = smp_processor_id();
 
 	local_irq_save(flags);
 
@@ -134,7 +135,11 @@
 
 	write_c0_entryhi(cpu_context(smp_processor_id(), next));
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
-	
+
+	/* mark mmu ownership change */	
+	clear_bit(cpu, &prev->cpu_vm_mask);
+	set_bit(cpu, &next->cpu_vm_mask);
+
 	local_irq_restore(flags);
 }
 
diff -Nru link/include/asm-mips64/mmu_context.h.orig link/include/asm-mips64/mmu_context.h
--- link/include/asm-mips64/mmu_context.h.orig	Thu Feb 20 10:23:10 2003
+++ link/include/asm-mips64/mmu_context.h	Wed Feb 26 17:44:03 2003
@@ -117,6 +117,7 @@
 activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	unsigned long flags;
+	int cpu = smp_processor_id();
 
 	local_irq_save(flags);
 
@@ -125,7 +126,11 @@
 
 	write_c0_entryhi(cpu_context(smp_processor_id(), next));
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
-	
+
+	/* mark mmu ownership change */ 
+	clear_bit(cpu, &prev->cpu_vm_mask);
+	set_bit(cpu, &next->cpu_vm_mask);
+
 	local_irq_restore(flags);
 }
 

--a8Wt8u1KmwUX3Y2C--
