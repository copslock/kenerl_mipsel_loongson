Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7F66TRw025218
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 14 Aug 2002 23:06:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7F66Tsg025217
	for linux-mips-outgoing; Wed, 14 Aug 2002 23:06:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rail.cita.utoronto.ca (rail.cita.utoronto.ca [128.100.76.4])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7F64ARw025170
	for <linux-mips@oss.sgi.com>; Wed, 14 Aug 2002 23:04:11 -0700
Received: from [128.100.76.25] (marmot.cita.utoronto.ca) by rail.cita.utoronto.ca id 28191; Thu, 15 Aug 2002 02:06:43
Date: Thu, 15 Aug 2002 02:06:42 -0400
From: Robin Humble <rjh@cita.utoronto.ca>
To: linux-mips@oss.sgi.com
Subject: Re: R4600SC Indy
Message-ID: <20020815020642.A23230@marmot.cita.utoronto.ca>
References: <20020806111959.C15670@marmot.cita.utoronto.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020806111959.C15670@marmot.cita.utoronto.ca>; from rjh@marmot.cita.utoronto.ca on Tue, Aug 06, 2002 at 11:19:59AM -0400
X-Spam-Status: No, hits=-9.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2002 at 11:19:59AM -0400, Robin Humble wrote:
>I have an R4600SC Indy and an R5000 Indy and the R4600SC hasn't worked
>with a kernel since around 2.4.17 13feb2002. 

I apologise for the vagueness of my previous post.

To be precise, the changes that were checked in on 6-mar-2002 broke
R4600SC support. These changes were to arch/mips/mm/c-r4k.c (and its mips64
counterpart). The patch below (to 13-aug-02 linux_2_4 CVS) is simply a
reversal of the changes made on 6-mar-02 and makes my R4600SC Indy work
just fine.

I presume that these changes were made for a reason though, so reversing
them is presumably not a fix, just a dodgy workaround?? :-/

If there's anything I can do to help narrow the problem down further
and find a real fix then please let me know. eg. just applying these
saves/restore's to some of the function in c-r4k.c? Unfortunately I
have little mips architecture or assembly knowledge (and not heaps of
time) so can't really help except to try out things...  

My R5000SC Indy works fine with unpatched current cvs.
Hope this is of some assistance.

cheers,
robin

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.addSavesForR4600"

diff -ruN linux-2.4.19-rc1-13aug02/arch/mips/mm/c-r4k.c linux-2.4.19-rc1-13aug02-rjh/arch/mips/mm/c-r4k.c
--- linux-2.4.19-rc1-13aug02/arch/mips/mm/c-r4k.c	Tue Aug 13 21:12:38 2002
+++ linux-2.4.19-rc1-13aug02-rjh/arch/mips/mm/c-r4k.c	Tue Aug 13 22:05:59 2002
@@ -77,47 +77,83 @@
 
 static inline void r4k_flush_cache_all_s16d16i16(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16(); blast_icache16(); blast_scache16();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s32d16i16(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16(); blast_icache16(); blast_scache32();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s64d16i16(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16(); blast_icache16(); blast_scache64();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s128d16i16(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16(); blast_icache16(); blast_scache128();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s32d32i32(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache32(); blast_icache32(); blast_scache32();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s64d32i32(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache32(); blast_icache32(); blast_scache64();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s128d32i32(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache32(); blast_icache32(); blast_scache128();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_d16i16(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16(); blast_icache16();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_d32i32(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache32(); blast_icache32();
+	__restore_flags(flags);
 }
 
 static void
@@ -126,6 +162,7 @@
                                 unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (mm->context == 0)
 		return;
@@ -143,6 +180,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while (start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -152,6 +190,7 @@
 					blast_scache16_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -162,6 +201,7 @@
                                 unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (mm->context == 0)
 		return;
@@ -179,6 +219,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -188,6 +229,7 @@
 					blast_scache32_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -197,6 +239,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (mm->context == 0)
 		return;
@@ -214,6 +257,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -223,6 +267,7 @@
 					blast_scache64_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -232,6 +277,7 @@
 					     unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (mm->context == 0)
 		return;
@@ -249,6 +295,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -258,6 +305,7 @@
 					blast_scache128_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -267,6 +315,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (mm->context == 0)
 		return;
@@ -284,6 +333,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -293,6 +343,7 @@
 					blast_scache32_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -302,6 +353,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (mm->context == 0)
 		return;
@@ -319,6 +371,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -328,6 +381,7 @@
 					blast_scache64_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -337,6 +391,7 @@
 					     unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (mm->context == 0)
 		return;
@@ -354,6 +409,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -363,6 +419,7 @@
 					blast_scache128_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -372,10 +429,14 @@
 					 unsigned long end)
 {
 	if (mm->context != 0) {
+		unsigned long flags;
+
 #ifdef DEBUG_CACHE
 		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
 #endif
+		__save_and_cli(flags);
 		blast_dcache16(); blast_icache16();
+		__restore_flags(flags);
 	}
 }
 
@@ -384,10 +445,14 @@
 					 unsigned long end)
 {
 	if (mm->context != 0) {
+		unsigned long flags;
+
 #ifdef DEBUG_CACHE
 		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
 #endif
+		__save_and_cli(flags);
 		blast_dcache32(); blast_icache32();
+		__restore_flags(flags);
 	}
 }
 
@@ -490,6 +555,7 @@
 					   unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -504,6 +570,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -533,12 +600,14 @@
 	} else
 		blast_scache16_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s32d16i16(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -553,6 +622,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -581,12 +651,14 @@
 	} else
 		blast_scache32_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s64d16i16(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -601,6 +673,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -629,12 +702,14 @@
 	} else
 		blast_scache64_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s128d16i16(struct vm_area_struct *vma,
 					    unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -649,6 +724,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -678,12 +754,14 @@
 	} else
 		blast_scache128_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s32d32i32(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -698,6 +776,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -727,12 +806,14 @@
 	} else
 		blast_scache32_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s64d32i32(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -747,6 +828,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -776,12 +858,14 @@
 	} else
 		blast_scache64_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s128d32i32(struct vm_area_struct *vma,
 					    unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -796,6 +880,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -824,12 +909,14 @@
 	} else
 		blast_scache128_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_d16i16(struct vm_area_struct *vma,
 					unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -844,6 +931,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -872,12 +960,14 @@
 		blast_dcache16_page_indexed(page);
 	}
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_d32i32(struct vm_area_struct *vma,
 					unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -892,6 +982,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -921,12 +1012,14 @@
 		blast_dcache32_page_indexed(page);
 	}
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_d32i32_r4600(struct vm_area_struct *vma,
 					      unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -941,6 +1034,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -970,6 +1064,7 @@
 		blast_dcache32_page_indexed(page ^ dcache_waybit);
 	}
 out:
+	__restore_flags(flags);
 }
 
 /* If the addresses passed to these routines are valid, they are
diff -ruN linux-2.4.19-rc1-13aug02/arch/mips64/mm/r4xx0.c linux-2.4.19-rc1-13aug02-rjh/arch/mips64/mm/r4xx0.c
--- linux-2.4.19-rc1-13aug02/arch/mips64/mm/r4xx0.c	Tue Aug 13 21:12:43 2002
+++ linux-2.4.19-rc1-13aug02-rjh/arch/mips64/mm/r4xx0.c	Tue Aug 13 22:05:59 2002
@@ -693,47 +693,83 @@
 
 static inline void r4k_flush_cache_all_s16d16i16(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16(); blast_icache16(); blast_scache16();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s32d16i16(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16(); blast_icache16(); blast_scache32();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s64d16i16(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16(); blast_icache16(); blast_scache64();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s128d16i16(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16(); blast_icache16(); blast_scache128();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s32d32i32(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache32(); blast_icache32(); blast_scache32();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s64d32i32(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache32(); blast_icache32(); blast_scache64();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_s128d32i32(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache32(); blast_icache32(); blast_scache128();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_d16i16(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16(); blast_icache16();
+	__restore_flags(flags);
 }
 
 static inline void r4k_flush_cache_all_d32i32(void)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache32(); blast_icache32();
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_range_s16d16i16(struct mm_struct *mm,
@@ -741,6 +777,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (CPU_CONTEXT(smp_processor_id(), mm) == 0)
 		return;
@@ -759,6 +796,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -768,6 +806,7 @@
 					blast_scache16_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -777,6 +816,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (CPU_CONTEXT(smp_processor_id(), mm) == 0)
 		return;
@@ -795,6 +835,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -804,6 +845,7 @@
 					blast_scache32_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -813,6 +855,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (CPU_CONTEXT(smp_processor_id(), mm) == 0)
 		return;
@@ -831,6 +874,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -840,6 +884,7 @@
 					blast_scache64_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -849,6 +894,7 @@
 					     unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (CPU_CONTEXT(smp_processor_id(), mm) == 0)
 		return;
@@ -867,6 +913,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -876,6 +923,7 @@
 					blast_scache128_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -885,6 +933,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (CPU_CONTEXT(smp_processor_id(), mm) == 0)
 		return;
@@ -903,6 +952,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -912,6 +962,7 @@
 					blast_scache32_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -921,6 +972,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (CPU_CONTEXT(smp_processor_id(), mm) == 0)
 		return;
@@ -939,6 +991,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -948,6 +1001,7 @@
 					blast_scache64_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -957,6 +1011,7 @@
 					     unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
 
 	if (CPU_CONTEXT(smp_processor_id(), mm) != 0)
 		return;
@@ -975,6 +1030,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
 
+			__save_and_cli(flags);
 			while(start < end) {
 				pgd = pgd_offset(mm, start);
 				pmd = pmd_offset(pgd, start);
@@ -984,6 +1040,7 @@
 					blast_scache128_page(start);
 				start += PAGE_SIZE;
 			}
+			__restore_flags(flags);
 		}
 	}
 }
@@ -993,10 +1050,14 @@
 					 unsigned long end)
 {
 	if (CPU_CONTEXT(smp_processor_id(), mm) != 0) {
+		unsigned long flags;
+
 #ifdef DEBUG_CACHE
 		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
 #endif
+		__save_and_cli(flags);
 		blast_dcache16(); blast_icache16();
+		__restore_flags(flags);
 	}
 }
 
@@ -1005,10 +1066,14 @@
 					 unsigned long end)
 {
 	if (CPU_CONTEXT(smp_processor_id(), mm) != 0) {
+		unsigned long flags;
+
 #ifdef DEBUG_CACHE
 		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
 #endif
+		__save_and_cli(flags);
 		blast_dcache32(); blast_icache32();
+		__restore_flags(flags);
 	}
 }
 
@@ -1111,6 +1176,7 @@
 					   unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1125,6 +1191,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -1153,12 +1220,14 @@
 	} else
 		blast_scache16_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s32d16i16(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1173,6 +1242,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -1200,12 +1270,14 @@
 	} else
 		blast_scache32_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s64d16i16(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1220,6 +1292,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -1248,12 +1321,14 @@
 	} else
 		blast_scache64_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s128d16i16(struct vm_area_struct *vma,
 					    unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1268,6 +1343,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -1297,12 +1373,14 @@
 	} else
 		blast_scache128_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s32d32i32(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1317,6 +1395,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -1347,12 +1426,14 @@
 	} else
 		blast_scache32_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s64d32i32(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1367,6 +1448,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -1397,12 +1479,14 @@
 	} else
 		blast_scache64_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_s128d32i32(struct vm_area_struct *vma,
 					    unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1417,6 +1501,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -1445,12 +1530,14 @@
 	} else
 		blast_scache128_page(page);
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_d16i16(struct vm_area_struct *vma,
 					unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1465,6 +1552,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -1492,12 +1580,14 @@
 		blast_dcache16_page_indexed(page);
 	}
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_d32i32(struct vm_area_struct *vma,
 					unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1512,6 +1602,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -1541,12 +1632,14 @@
 		blast_dcache32_page_indexed(page);
 	}
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_cache_page_d32i32_r4600(struct vm_area_struct *vma,
 					      unsigned long page)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -1561,6 +1654,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	__save_and_cli(flags);
 	page &= PAGE_MASK;
 	pgdp = pgd_offset(mm, page);
 	pmdp = pmd_offset(pgdp, page);
@@ -1590,6 +1684,7 @@
 		blast_dcache32_page_indexed(page ^ dcache_waybit);
 	}
 out:
+	__restore_flags(flags);
 }
 
 static void r4k_flush_page_to_ram_s16(struct page *page)
@@ -1614,12 +1709,20 @@
 
 static void r4k_flush_page_to_ram_d16(struct page *page)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache16_page((unsigned long)page_address(page));
+	__restore_flags(flags);
 }
 
 static void r4k_flush_page_to_ram_d32(struct page *page)
 {
+	unsigned long flags;
+
+	__save_and_cli(flags);
 	blast_dcache32_page((unsigned long)page_address(page));
+	__restore_flags(flags);
 }
 
 static void

--liOOAslEiF7prFVr--
