Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 00:03:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:15863 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225240AbTBEADA>;
	Wed, 5 Feb 2003 00:03:00 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1502oT10577;
	Tue, 4 Feb 2003 16:02:50 -0800
Date: Tue, 4 Feb 2003 16:02:50 -0800
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
	linux-mips@linux-mips.org, jsun@mvista.com,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC & PATCH]  fixing tlb flush race problem on smp
Message-ID: <20030204160250.F5149@mvista.com>
References: <20030121143726.C16939@mvista.com> <86bs297hpd.fsf@trasno.mitica> <20030127170346.S11633@mvista.com> <20030129090627.D7741@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030129090627.D7741@linux-mips.org>; from ralf@linux-mips.org on Wed, Jan 29, 2003 at 09:06:27AM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Here is a complete patch for both mips/mips64, 2.4 and 
2.5.  Of course only 2.4/mips combo is tested.

The clear_bit/set_bit actually need to be protected.
The flag setting needs to be in sync with the actual
hardware setting (set_entry_hi/set current pgd).  Otherwise
an tlb flushing IPI may does the wrong thing.

Jun

On Wed, Jan 29, 2003 at 09:06:27AM +0100, Ralf Baechle wrote:
> On Mon, Jan 27, 2003 at 05:03:46PM -0800, Jun Sun wrote:
> 
> > I also find a stupid typo and a subtle hole in my original patch.
> > Here is an updated version, for 2.4/mips only.  If it looks ok, I 
> > will extend to other sub-arches/trees.
> > 
> > This new one is pretty nice in that all mmu related operations
> > are put into one file and it is much easier to ensure correctness
> > later.
> 
> I like this one.
> 
> > +
> > +	/*
> > +	 * Mark current->active_mm as not "active" anymore.
> > +	 * We don't want to mislead possible IPI tlb flush routines.
> > +	 */
> > +	clear_bit(cpu, &prev->cpu_vm_mask);
> > +	set_bit(cpu, &next->cpu_vm_mask);
> > +
> > +	local_irq_restore(flags);
> 
> I don't think it's necessary to protect the clear_bit and set_bit operations
> with local_irq_save ... local_irq_restore.
> 
> In addition because switch_mm is always called with interrupts enabled you
> can simplify that to local_irq_disable ... local_irq_enable.
> 
>   Ralf
> 

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030204-2.4-smp-tlb-flush.patch"

diff -Nru linux/arch/mips/mm/tlb-sb1.c.orig linux/arch/mips/mm/tlb-sb1.c
--- linux/arch/mips/mm/tlb-sb1.c.orig	Tue Feb  4 13:50:55 2003
+++ linux/arch/mips/mm/tlb-sb1.c	Tue Feb  4 14:01:24 2003
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
 	local_irq_restore(flags);
@@ -253,17 +251,10 @@
    these entries, we just bump the asid. */
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
-	unsigned long flags;
-	int cpu;
-	local_irq_save(flags);
-	cpu = smp_processor_id();
+	int cpu = smp_processor_id();
 	if (cpu_context(cpu, mm) != 0) {
-		get_new_mmu_context(mm, smp_processor_id());
-		if (mm == current->active_mm) {
-			write_c0_entryhi(cpu_asid(cpu, mm));
-		}
+		drop_mmu_context(mm, cpu);
 	}
-	local_irq_restore(flags);
 }
 
 /* Stolen from mips32 routines */
diff -Nru linux/arch/mips/mm/tlb-r4k.c.orig linux/arch/mips/mm/tlb-r4k.c
--- linux/arch/mips/mm/tlb-r4k.c.orig	Mon Jan 27 17:13:31 2003
+++ linux/arch/mips/mm/tlb-r4k.c	Tue Feb  4 14:15:04 2003
@@ -76,16 +76,10 @@
 	int cpu = smp_processor_id();
 
 	if (cpu_context(cpu, mm) != 0) {
-		unsigned long flags;
-
 #ifdef DEBUG_TLB
 		printk("[tlbmm<%d>]", cpu_context(cpu, mm));
 #endif
-		local_irq_save(flags);
-		get_new_mmu_context(mm, smp_processor_id());
-		if (mm == current->active_mm)
-			write_c0_entryhi(cpu_asid(cpu, mm));
-		local_irq_restore(flags);
+		drop_mmu_context(mm,cpu);
 	}
 }
 
@@ -133,9 +127,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, smp_processor_id());
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_asid(cpu, mm));
+			drop_mmu_context(mm, cpu);
 		}
 		local_irq_restore(flags);
 	}
diff -Nru linux/arch/mips/mm/tlb-r3k.c.orig linux/arch/mips/mm/tlb-r3k.c
--- linux/arch/mips/mm/tlb-r3k.c.orig	Mon Jan 27 17:13:31 2003
+++ linux/arch/mips/mm/tlb-r3k.c	Tue Feb  4 14:09:04 2003
@@ -69,16 +69,10 @@
 	int cpu = smp_processor_id();
 
 	if (cpu_context(cpu, mm) != 0) {
-		unsigned long flags;
-
 #ifdef DEBUG_TLB
 		printk("[tlbmm<%lu>]", (unsigned long)cpu_context(cpu, mm));
 #endif
-		local_irq_save(flags);
-		get_new_mmu_context(mm, smp_processor_id());
-		if (mm == current->active_mm)
-			write_c0_entryhi(cpu_asid(cpu, mm));
-		local_irq_restore(flags);
+		drop_mmu_context(mm, cpu);
 	}
 }
 
@@ -119,9 +113,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, smp_processor_id());
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_asid(cpu, mm));
+			drop_mmu_context(mm, cpu);
 		}
 		local_irq_restore(flags);
 	}
diff -Nru linux/arch/mips64/mm/tlb-sb1.c.orig linux/arch/mips64/mm/tlb-sb1.c
--- linux/arch/mips64/mm/tlb-sb1.c.orig	Mon Jan 27 17:13:34 2003
+++ linux/arch/mips64/mm/tlb-sb1.c	Tue Feb  4 14:45:58 2003
@@ -180,9 +180,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, cpu);
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_asid(cpu, mm));
+			drop_mmu_context(mm, cpu);
 		}
 	}
 	local_irq_restore(flags);
@@ -231,17 +229,10 @@
    these entries, we just bump the asid. */
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
-	unsigned long flags;
-	int cpu;
-	local_irq_save(flags);
-	cpu = smp_processor_id();
+	int cpu = smp_processor_id();
 	if (cpu_context(cpu, mm) != 0) {
-		get_new_mmu_context(mm, smp_processor_id());
-		if (mm == current->active_mm) {
-			write_c0_entryhi(cpu_asid(cpu, mm));
-		}
+		drop_mmu_context(mm, cpu);
 	}
-	local_irq_restore(flags);
 }
 
 /* Stolen from mips32 routines */
diff -Nru linux/arch/mips64/mm/tlb-r4k.c.orig linux/arch/mips64/mm/tlb-r4k.c
--- linux/arch/mips64/mm/tlb-r4k.c.orig	Mon Jan 27 17:13:34 2003
+++ linux/arch/mips64/mm/tlb-r4k.c	Tue Feb  4 14:47:52 2003
@@ -80,16 +80,10 @@
 	int cpu = smp_processor_id();
 
 	if (cpu_context(cpu, mm) != 0) {
-		unsigned long flags;
-
 #ifdef DEBUG_TLB
 		printk("[tlbmm<%d>]", mm->context);
 #endif
-		local_irq_save(flags);
-		get_new_mmu_context(mm, cpu);
-		if (mm == current->active_mm)
-			write_c0_entryhi(cpu_asid(cpu, mm));
-		local_irq_restore(flags);
+		drop_mmu_context(mm,cpu);
 	}
 }
 
@@ -137,9 +131,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, cpu);
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_asid(cpu, mm));
+			drop_mmu_context(mm, cpu);
 		}
 		local_irq_restore(flags);
 	}
diff -Nru linux/arch/mips64/mm/tlb-andes.c.orig linux/arch/mips64/mm/tlb-andes.c
--- linux/arch/mips64/mm/tlb-andes.c.orig	Tue Feb  4 13:13:43 2003
+++ linux/arch/mips64/mm/tlb-andes.c	Tue Feb  4 14:49:59 2003
@@ -53,18 +53,12 @@
 
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
-	if (cpu_context(smp_processor_id(), mm) != 0) {
-		unsigned long flags;
-
+	int cpu = smp_processor_id();
+	if (cpu_context(cpu, mm) != 0) {
 #ifdef DEBUG_TLB
 		printk("[tlbmm<%d>]", mm->context);
 #endif
-		local_irq_save(flags);
-		get_new_mmu_context(mm, smp_processor_id());
-		if (mm == current->active_mm)
-			write_c0_entryhi(cpu_context(smp_processor_id(), mm)
-				    & ASID_MASK);
-		local_irq_restore(flags);
+		drop_mmu_context(mm,cpu);
 	}
 }
 
@@ -106,10 +100,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, smp_processor_id());
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_context(smp_processor_id(), mm)
-					    & ASID_MASK);
+			drop_mmu_context(mm, cpu);
 		}
 		local_irq_restore(flags);
 	}
diff -Nru linux/include/asm-mips/mmu_context.h.orig linux/include/asm-mips/mmu_context.h
--- linux/include/asm-mips/mmu_context.h.orig	Tue Feb  4 13:50:55 2003
+++ linux/include/asm-mips/mmu_context.h	Tue Feb  4 13:51:03 2003
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
diff -Nru linux/include/asm-mips64/mmu_context.h.orig linux/include/asm-mips64/mmu_context.h
--- linux/include/asm-mips64/mmu_context.h.orig	Tue Jan 21 13:55:43 2003
+++ linux/include/asm-mips64/mmu_context.h	Tue Feb  4 14:46:00 2003
@@ -80,12 +80,25 @@
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
@@ -103,11 +116,39 @@
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

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030204-2.5-smp-tlb-flush.patch"

diff -Nru linux/arch/mips/mm/tlb-sb1.c.orig linux/arch/mips/mm/tlb-sb1.c
--- linux/arch/mips/mm/tlb-sb1.c.orig	Wed Dec 11 17:04:17 2002
+++ linux/arch/mips/mm/tlb-sb1.c	Tue Feb  4 15:00:53 2003
@@ -172,15 +172,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, cpu);
-			if (mm == current->active_mm) {
-				write_c0_entryhi(cpu_asid(cpu, mm));
-			} else if (!(cpu_asid(cpu, mm)) &&
-				   cpu_context(cpu, current->active_mm)) {
-				/* Just wrapped ASIDs, bump the active one */
-				get_new_mmu_context(current->active_mm, cpu);
-				write_c0_entryhi(cpu_context(cpu, current->active_mm)& 0xff);
-			}
+			drop_mmu_context(mm, cpu);
 		}
 	}
 	local_irq_restore(flags);
@@ -325,17 +317,10 @@
    these entries, we just bump the asid. */
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
-	unsigned long flags;
-	int cpu;
-	local_irq_save(flags);
-	cpu = smp_processor_id();
+	int cpu = smp_processor_id();
 	if (cpu_context(cpu, mm) != 0) {
-		get_new_mmu_context(mm, smp_processor_id());
-		if (mm == current->active_mm) {
-			write_c0_entryhi(cpu_context(cpu, mm) & 0xff);
-		}
+		drop_mmu_context(mm, cpu);
 	}
-	local_irq_restore(flags);
 }
 
 /* Stolen from mips32 routines */
diff -Nru linux/arch/mips/mm/tlb-r4k.c.orig linux/arch/mips/mm/tlb-r4k.c
--- linux/arch/mips/mm/tlb-r4k.c.orig	Mon Jan 27 18:03:21 2003
+++ linux/arch/mips/mm/tlb-r4k.c	Tue Feb  4 15:04:29 2003
@@ -76,16 +76,10 @@
 	int cpu = smp_processor_id();
 
 	if (cpu_context(cpu, mm) != 0) {
-		unsigned long flags;
-
 #ifdef DEBUG_TLB
 		printk("[tlbmm<%d>]", cpu_context(cpu, mm));
 #endif
-		local_irq_save(flags);
-		get_new_mmu_context(mm, smp_processor_id());
-		if (mm == current->active_mm)
-			write_c0_entryhi(cpu_context(cpu, mm) & ASID_MASK);
-		local_irq_restore(flags);
+		drop_mmu_context(mm,cpu);
 	}
 }
 
@@ -134,9 +128,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, smp_processor_id());
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_context(cpu, mm) & ASID_MASK);
+			drop_mmu_context(mm, cpu);
 		}
 		local_irq_restore(flags);
 	}
diff -Nru linux/arch/mips/mm/tlb-r3k.c.orig linux/arch/mips/mm/tlb-r3k.c
--- linux/arch/mips/mm/tlb-r3k.c.orig	Mon Jan 27 18:03:21 2003
+++ linux/arch/mips/mm/tlb-r3k.c	Tue Feb  4 15:05:22 2003
@@ -69,16 +69,10 @@
 	int cpu = smp_processor_id();
 
 	if (cpu_context(cpu, mm) != 0) {
-		unsigned long flags;
-
 #ifdef DEBUG_TLB
 		printk("[tlbmm<%lu>]", (unsigned long)cpu_context(cpu, mm));
 #endif
-		local_irq_save(flags);
-		get_new_mmu_context(mm, cpu);
-		if (mm == current->active_mm)
-			write_c0_entryhi(cpu_context(cpu, mm) & ASID_MASK);
-		local_irq_restore(flags);
+		drop_mmu_context(mm, cpu);
 	}
 }
 
@@ -120,9 +114,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, smp_processor_id());
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_context(cpu, mm) & ASID_MASK);
+			drop_mmu_context(mm, cpu);
 		}
 		local_irq_restore(flags);
 	}
diff -Nru linux/arch/mips64/mm/tlb-sb1.c.orig linux/arch/mips64/mm/tlb-sb1.c
--- linux/arch/mips64/mm/tlb-sb1.c.orig	Wed Dec 11 17:04:19 2002
+++ linux/arch/mips64/mm/tlb-sb1.c	Tue Feb  4 15:07:42 2003
@@ -180,9 +180,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, cpu);
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_context(cpu, mm) & 0xff);
+			drop_mmu_context(mm, cpu);
 		}
 	}
 	local_irq_restore(flags);
@@ -268,17 +266,10 @@
    these entries, we just bump the asid. */
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
-	unsigned long flags;
-	int cpu;
-	local_irq_save(flags);
-	cpu = smp_processor_id();
+	int cpu = smp_processor_id();
 	if (cpu_context(cpu, mm) != 0) {
-		get_new_mmu_context(mm, smp_processor_id());
-		if (mm == current->active_mm) {
-			write_c0_entryhi(cpu_context(cpu, mm) & 0xff);
-		}
+		drop_mmu_context(mm, cpu);
 	}
-	local_irq_restore(flags);
 }
 
 /* Stolen from mips32 routines */
diff -Nru linux/arch/mips64/mm/tlb-r4k.c.orig linux/arch/mips64/mm/tlb-r4k.c
--- linux/arch/mips64/mm/tlb-r4k.c.orig	Mon Jan 27 18:03:22 2003
+++ linux/arch/mips64/mm/tlb-r4k.c	Tue Feb  4 15:08:21 2003
@@ -80,16 +80,10 @@
 	int cpu = smp_processor_id();
 
 	if (cpu_context(cpu, mm) != 0) {
-		unsigned long flags;
-
 #ifdef DEBUG_TLB
 		printk("[tlbmm<%d>]", cpu_context(cpu, mm));
 #endif
-		local_irq_save(flags);
-		get_new_mmu_context(mm, cpu);
-		if (mm == current->active_mm)
-			write_c0_entryhi(cpu_asid(cpu, mm));
-		local_irq_restore(flags);
+		drop_mmu_context(mm,cpu);
 	}
 }
 
@@ -138,9 +132,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, cpu);
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_asid(cpu, mm));
+			drop_mmu_context(mm, cpu);
 		}
 		local_irq_restore(flags);
 	}
diff -Nru linux/arch/mips64/mm/tlb-andes.c.orig linux/arch/mips64/mm/tlb-andes.c
--- linux/arch/mips64/mm/tlb-andes.c.orig	Tue Feb  4 13:14:43 2003
+++ linux/arch/mips64/mm/tlb-andes.c	Tue Feb  4 14:53:28 2003
@@ -53,18 +53,12 @@
 
 void local_flush_tlb_mm(struct mm_struct *mm)
 {
-	if (cpu_context(smp_processor_id(), mm) != 0) {
-		unsigned long flags;
-
+	int cpu = smp_processor_id();
+	if (cpu_context(cpu, mm) != 0) {
 #ifdef DEBUG_TLB
 		printk("[tlbmm<%d>]", mm->context);
 #endif
-		local_irq_save(flags);
-		get_new_mmu_context(mm, smp_processor_id());
-		if (mm == current->active_mm)
-			write_c0_entryhi(cpu_context(smp_processor_id(), mm)
-				    & ASID_MASK);
-		local_irq_restore(flags);
+		drop_mmu_context(mm,cpu);
 	}
 }
 
@@ -108,10 +102,7 @@
 			}
 			write_c0_entryhi(oldpid);
 		} else {
-			get_new_mmu_context(mm, smp_processor_id());
-			if (mm == current->active_mm)
-				write_c0_entryhi(cpu_context(smp_processor_id(), mm)
-					    & ASID_MASK);
+			drop_mmu_context(mm, cpu);
 		}
 		local_irq_restore(flags);
 	}
diff -Nru linux/include/asm-mips/mmu_context.h.orig linux/include/asm-mips/mmu_context.h
--- linux/include/asm-mips/mmu_context.h.orig	Mon Jan 27 18:03:23 2003
+++ linux/include/asm-mips/mmu_context.h	Tue Feb  4 14:53:28 2003
@@ -92,12 +92,25 @@
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
@@ -115,11 +128,39 @@
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
diff -Nru linux/include/asm-mips64/mmu_context.h.orig linux/include/asm-mips64/mmu_context.h
--- linux/include/asm-mips64/mmu_context.h.orig	Mon Jan 27 18:03:23 2003
+++ linux/include/asm-mips64/mmu_context.h	Tue Feb  4 14:53:28 2003
@@ -83,12 +83,25 @@
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
@@ -106,11 +119,39 @@
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

--gBBFr7Ir9EOA20Yy--
