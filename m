Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 01:03:51 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:1777 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225223AbTA1BDv>;
	Tue, 28 Jan 2003 01:03:51 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h0S13k125346;
	Mon, 27 Jan 2003 17:03:46 -0800
Date: Mon, 27 Jan 2003 17:03:46 -0800
From: Jun Sun <jsun@mvista.com>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [RFC & PATCH]  fixing tlb flush race problem on smp
Message-ID: <20030127170346.S11633@mvista.com>
References: <20030121143726.C16939@mvista.com> <86bs297hpd.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86bs297hpd.fsf@trasno.mitica>; from quintela@mandrakesoft.com on Wed, Jan 22, 2003 at 08:43:26AM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Thanks, Juan.

I also find a stupid typo and a subtle hole in my original patch.
Here is an updated version, for 2.4/mips only.  If it looks ok, I 
will extend to other sub-arches/trees.

This new one is pretty nice in that all mmu related operations
are put into one file and it is much easier to ensure correctness
later.

Jun

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030127-fix-smp-tlb-flush-holes.patch"

diff -Nru link/arch/mips/mm/tlb-sb1.c.orig link/arch/mips/mm/tlb-sb1.c
--- link/arch/mips/mm/tlb-sb1.c.orig	Tue Jan 21 13:54:59 2003
+++ link/arch/mips/mm/tlb-sb1.c	Mon Jan 27 16:58:54 2003
@@ -172,9 +172,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, cpu);
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_asid(cpu, mm));
+			drop_mmu_context(mm, cpu);
 		}
 	}
 	__restore_flags(flags);
@@ -258,10 +256,7 @@
 	__save_and_cli(flags);
 	cpu = smp_processor_id();
 	if (cpu_context(cpu, mm) != 0) {
-		get_new_mmu_context(mm, smp_processor_id());
-		if (mm == current->active_mm) {
-			write_c0_entryhi(cpu_asid(cpu, mm));
-		}
+		drop_mmu_context(mm, cpu);
 	}
 	__restore_flags(flags);
 }
diff -Nru link/include/asm-mips/mmu_context.h.orig link/include/asm-mips/mmu_context.h
--- link/include/asm-mips/mmu_context.h.orig	Tue Jan 21 13:55:43 2003
+++ link/include/asm-mips/mmu_context.h	Mon Jan 27 16:56:44 2003
@@ -89,12 +89,25 @@
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
                              struct task_struct *tsk, unsigned cpu)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
+
 	/* Check if our ASID is of an older version and thus invalid */
 	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & ASID_VERSION_MASK)
 		get_new_mmu_context(next, cpu);
 
 	write_c0_entryhi(cpu_context(cpu, next));
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+
+	/*
+	 * Mark current->active_mm as not "active" anymore.
+	 * We don't want to mislead possible IPI tlb flush routines.
+	 */
+	clear_bit(cpu, &prev->cpu_vm_mask);
+	set_bit(cpu, &next->cpu_vm_mask);
+
+	local_irq_restore(flags);
 }
 
 /*
@@ -112,11 +125,39 @@
 static inline void
 activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
+
 	/* Unconditionally get a new ASID.  */
 	get_new_mmu_context(next, smp_processor_id());
 
 	write_c0_entryhi(cpu_context(smp_processor_id(), next));
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+	
+	local_irq_restore(flags);
+}
+
+/*
+ * If mm is currently active_mm, we can't really drop it.  Instead,
+ * we will get a new one for it.
+ */
+static inline void
+drop_mmu_context(struct mm_struct *mm, unsigned cpu)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	if (test_bit(cpu, &mm->cpu_vm_mask))  {
+		get_new_mmu_context(mm, cpu);
+		set_entryhi(CPU_CONTEXT(cpu, mm) & 0xff);
+	} else {
+		/* will get a new context next time */
+		CPU_CONTEXT(cpu, mm) = 0;
+	}
+
+	local_irq_restore(flags);
 }
 
 #endif /* _ASM_MMU_CONTEXT_H */

--PmA2V3Z32TCmWXqI--
