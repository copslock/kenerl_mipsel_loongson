Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2003 22:37:30 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:61181 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225222AbTAUWh3>;
	Tue, 21 Jan 2003 22:37:29 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h0LMbQC17344;
	Tue, 21 Jan 2003 14:37:26 -0800
Date: Tue, 21 Jan 2003 14:37:26 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [RFC & PATCH]  fixing tlb flush race problem on smp
Message-ID: <20030121143726.C16939@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Many of us are aware of a hole in current TLB flushing code that
could cause processes using the same ASID for a SMP machine.

Actually there are several problems:

1) get_new_mmu_context() and following set_entryhi, etc are
not called automically in switch_mm() and active_mm().  If
an IPI happens and request to flush local tlb, bad things happen.

2) if local_flush_tlb_range() and local_flush_tlb_mm() are 
called from an IPI, they may call get_new_mmu_context() which
can bump up the ASID generation number with current active_mm
totally not aware of it.  Bad things will happen later.

3) during the time window after schedule() calling switch_mm()
before switch_to(), current->active_mm may be valid but does
really mean "current->active_mm" anymore.  This is because
the "current" process will soon become "prev".  The real active_mm
is actually "next->active_mm".  Because of this, it is not
enough for those two IPI'ed flushing routines to just check
again current->active_mm.  Long story made short - bad
things will happen.

It turns out that other arches have similar problems and solved
it in various ways.  Unfortunely I like none of them.

Here is one I am pretty happy with.  It is very small and efficient.
And conceptually it is clean too.  We basically keep the semantics
of ->mm and ->active_mm unchanged and only introduce a new bit
to mark which mm is the true owner of mmu hardware on a cpu.

The only downside is that cpu_vm_mask variable does not really
mean "mask for blocking IPI" in this approach.  It actually 
indicates whether current->active_mm is really active or not.  

Tested and passed the notorious fork/malloc test.

Let me know what you think.

Jun


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

diff -Nru link/arch/mips/mm/tlb-sb1.c.orig link/arch/mips/mm/tlb-sb1.c
--- link/arch/mips/mm/tlb-sb1.c.orig	Tue Jan 21 13:54:59 2003
+++ link/arch/mips/mm/tlb-sb1.c	Tue Jan 21 13:58:50 2003
@@ -172,9 +172,13 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, cpu);
-			if (mm == current->active_mm)
+			if (mm == current->active_mm) {
+				get_new_mmu_context(mm, cpu);
 				write_c0_entryhi(cpu_asid(cpu, mm));
+			} else {
+				/* drop the current context completely */
+				CPU_CONTEXT(cpu, mm) = 0;
+			}
 		}
 	}
 	__restore_flags(flags);
@@ -258,9 +262,12 @@
 	__save_and_cli(flags);
 	cpu = smp_processor_id();
 	if (cpu_context(cpu, mm) != 0) {
-		get_new_mmu_context(mm, smp_processor_id());
 		if (mm == current->active_mm) {
+			get_new_mmu_context(mm, smp_processor_id());
 			write_c0_entryhi(cpu_asid(cpu, mm));
+		} else {
+			/* drop the current context completely */
+			CPU_CONTEXT(cpu, mm) = 0;
 		}
 	}
 	__restore_flags(flags);
diff -Nru link/include/asm-mips/mmu_context.h.orig link/include/asm-mips/mmu_context.h
--- link/include/asm-mips/mmu_context.h.orig	Tue Jan 21 13:55:43 2003
+++ link/include/asm-mips/mmu_context.h	Tue Jan 21 14:01:19 2003
@@ -89,12 +89,25 @@
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
                              struct task_struct *tsk, unsigned cpu)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
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
+	__restore_flags(flags);
 }
 
 /*
@@ -112,11 +125,17 @@
 static inline void
 activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
+
 	/* Unconditionally get a new ASID.  */
 	get_new_mmu_context(next, smp_processor_id());
 
 	write_c0_entryhi(cpu_context(smp_processor_id(), next));
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+	
+	__restore_flags(flags);
 }
 
 #endif /* _ASM_MMU_CONTEXT_H */

--AqsLC8rIMeq19msA--
