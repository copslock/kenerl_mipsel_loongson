Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7I0R8Rw030439
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 17 Aug 2002 17:27:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7I0R8Tn030438
	for linux-mips-outgoing; Sat, 17 Aug 2002 17:27:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7I0PnRw030419
	for <linux-mips@oss.sgi.com>; Sat, 17 Aug 2002 17:25:50 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id AEEC7133F0; Sun, 18 Aug 2002 02:28:34 +0200 (CEST)
Date: Sun, 18 Aug 2002 02:28:34 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: SGI MIPS list <linux-mips@oss.sgi.com>
Subject: [PATCH] Bring back R4600 V1.7 support
Message-ID: <20020818002834.GQ10730@lug-owl.de>
Mail-Followup-To: SGI MIPS list <linux-mips@oss.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xSu31lw3TgkWXnjh"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--xSu31lw3TgkWXnjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Here's my current patch to bring back R4600 V1.7 support.

MfG, JBG



Index: include/asm-mips/war.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /usr/src/packages/foreign_CVS_reps/oss.sgi.com/linux/include/asm-=
mips/war.h,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 war.h
--- include/asm-mips/war.h	5 Aug 2002 23:53:38 -0000	1.1.2.3
+++ include/asm-mips/war.h	17 Aug 2002 23:53:01 -0000
@@ -65,6 +65,24 @@
  */
 #define	R5432_CP0_INTERRUPT_WAR
=20
-#endif
+#endif /* CONFIG_CPU_R5432 */
+
+#ifdef R4600_V1_HIT_DCACHE_WAR
+#define r4600_v1_7_cache_war_disable_irq(CACHE_FLAGS)	\
+	do {						\
+		__save_and_cli(CACHE_FLAGS);		\
+	} while (0)
+#define r4600_v1_7_cache_war_enable_irq(CACHE_FLAGS)	\
+	do {						\
+		__restore_flags(CACHE_FLAGS);		\
+	} while (0)
+#else
+#define r4600_v1_7_cache_war_disable_irq(CACHE_FLAGS)	\
+	do {} while (0)
+#define r4600_v1_7_cache_war_enable_irq(CACHE_FLAGS)	\
+	do {} while (0)
+#endif /* R4600_V1_HIT_DCACHE_WAR */
+		=09
+=09
=20
 #endif /* _ASM_WAR_H */
Index: arch/mips/mm/c-r4k.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /usr/src/packages/foreign_CVS_reps/oss.sgi.com/linux/arch/mips/mm=
/c-r4k.c,v
retrieving revision 1.3.2.6
diff -u -r1.3.2.6 c-r4k.c
--- arch/mips/mm/c-r4k.c	9 Aug 2002 06:04:48 -0000	1.3.2.6
+++ arch/mips/mm/c-r4k.c	17 Aug 2002 23:55:53 -0000
@@ -77,47 +77,83 @@
=20
 static inline void r4k_flush_cache_all_s16d16i16(void)
 {
+	unsigned long flags;
+
+	r4600_v1_7_cache_war_disable_irq(flags);
 	blast_dcache16(); blast_icache16(); blast_scache16();
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static inline void r4k_flush_cache_all_s32d16i16(void)
 {
+	unsigned long flags;
+
+	r4600_v1_7_cache_war_disable_irq(flags);
 	blast_dcache16(); blast_icache16(); blast_scache32();
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static inline void r4k_flush_cache_all_s64d16i16(void)
 {
+	unsigned long flags;
+
+	r4600_v1_7_cache_war_disable_irq(flags);
 	blast_dcache16(); blast_icache16(); blast_scache64();
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static inline void r4k_flush_cache_all_s128d16i16(void)
 {
+	unsigned long flags;
+
+	r4600_v1_7_cache_war_disable_irq(flags);
 	blast_dcache16(); blast_icache16(); blast_scache128();
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static inline void r4k_flush_cache_all_s32d32i32(void)
 {
+	unsigned long flags;
+
+	r4600_v1_7_cache_war_disable_irq(flags);
 	blast_dcache32(); blast_icache32(); blast_scache32();
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static inline void r4k_flush_cache_all_s64d32i32(void)
 {
+	unsigned long flags;
+
+	r4600_v1_7_cache_war_disable_irq(flags);
 	blast_dcache32(); blast_icache32(); blast_scache64();
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static inline void r4k_flush_cache_all_s128d32i32(void)
 {
+	unsigned long flags;
+
+	r4600_v1_7_cache_war_disable_irq(flags);
 	blast_dcache32(); blast_icache32(); blast_scache128();
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static inline void r4k_flush_cache_all_d16i16(void)
 {
+	unsigned long flags;
+
+	r4600_v1_7_cache_war_disable_irq(flags);
 	blast_dcache16(); blast_icache16();
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static inline void r4k_flush_cache_all_d32i32(void)
 {
+	unsigned long flags;
+
+	r4600_v1_7_cache_war_disable_irq(flags);
 	blast_dcache32(); blast_icache32();
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static void
@@ -126,6 +162,7 @@
                                 unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
=20
 	if (mm->context =3D=3D 0)
 		return;
@@ -143,6 +180,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_v1_7_cache_war_disable_irq(flags);
 			while (start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -152,6 +190,7 @@
 					blast_scache16_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_v1_7_cache_war_enable_irq(flags);
 		}
 	}
 }
@@ -162,6 +201,7 @@
                                 unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
=20
 	if (mm->context =3D=3D 0)
 		return;
@@ -179,6 +219,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_v1_7_cache_war_disable_irq(flags);
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -188,6 +229,7 @@
 					blast_scache32_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_v1_7_cache_war_enable_irq(flags);
 		}
 	}
 }
@@ -197,6 +239,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
=20
 	if (mm->context =3D=3D 0)
 		return;
@@ -214,6 +257,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_v1_7_cache_war_disable_irq(flags);
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -223,6 +267,7 @@
 					blast_scache64_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_v1_7_cache_war_enable_irq(flags);
 		}
 	}
 }
@@ -232,6 +277,7 @@
 					     unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
=20
 	if (mm->context =3D=3D 0)
 		return;
@@ -249,6 +295,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_v1_7_cache_war_disable_irq(flags);
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -258,6 +305,7 @@
 					blast_scache128_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_v1_7_cache_war_enable_irq(flags);
 		}
 	}
 }
@@ -267,6 +315,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
=20
 	if (mm->context =3D=3D 0)
 		return;
@@ -284,6 +333,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_v1_7_cache_war_disable_irq(flags);
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -293,6 +343,7 @@
 					blast_scache32_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_v1_7_cache_war_enable_irq(flags);
 		}
 	}
 }
@@ -302,6 +353,7 @@
 					    unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
=20
 	if (mm->context =3D=3D 0)
 		return;
@@ -319,6 +371,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_v1_7_cache_war_disable_irq(flags);
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -328,6 +381,7 @@
 					blast_scache64_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_v1_7_cache_war_enable_irq(flags);
 		}
 	}
 }
@@ -337,6 +391,7 @@
 					     unsigned long end)
 {
 	struct vm_area_struct *vma;
+	unsigned long flags;
=20
 	if (mm->context =3D=3D 0)
 		return;
@@ -354,6 +409,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_v1_7_cache_war_disable_irq(flags);
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -363,6 +419,7 @@
 					blast_scache128_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_v1_7_cache_war_enable_irq(flags);
 		}
 	}
 }
@@ -371,11 +428,15 @@
 					 unsigned long start,
 					 unsigned long end)
 {
+	unsigned long flags;
+
 	if (mm->context !=3D 0) {
 #ifdef DEBUG_CACHE
 		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
 #endif
+		r4600_v1_7_cache_war_disable_irq(flags);
 		blast_dcache16(); blast_icache16();
+		r4600_v1_7_cache_war_enable_irq(flags);
 	}
 }
=20
@@ -383,11 +444,15 @@
 					 unsigned long start,
 					 unsigned long end)
 {
+	unsigned long flags;
+
 	if (mm->context !=3D 0) {
 #ifdef DEBUG_CACHE
 		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
 #endif
+		r4600_v1_7_cache_war_disable_irq(flags);
 		blast_dcache32(); blast_icache32();
+		r4600_v1_7_cache_war_enable_irq(flags);
 	}
 }
=20
@@ -490,6 +555,7 @@
 					   unsigned long page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -504,6 +570,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_v1_7_cache_war_disable_irq(flags);
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -533,12 +600,14 @@
 	} else
 		blast_scache16_page(page);
 out:
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static void r4k_flush_cache_page_s32d16i16(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -553,6 +622,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_v1_7_cache_war_disable_irq(flags);
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -581,12 +651,14 @@
 	} else
 		blast_scache32_page(page);
 out:
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static void r4k_flush_cache_page_s64d16i16(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -601,6 +673,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_v1_7_cache_war_disable_irq(flags);
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -629,12 +702,14 @@
 	} else
 		blast_scache64_page(page);
 out:
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static void r4k_flush_cache_page_s128d16i16(struct vm_area_struct *vma,
 					    unsigned long page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -649,6 +724,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_v1_7_cache_war_disable_irq(flags);
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -678,12 +754,14 @@
 	} else
 		blast_scache128_page(page);
 out:
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static void r4k_flush_cache_page_s32d32i32(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -698,6 +776,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_v1_7_cache_war_disable_irq(flags);
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -727,12 +806,14 @@
 	} else
 		blast_scache32_page(page);
 out:
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static void r4k_flush_cache_page_s64d32i32(struct vm_area_struct *vma,
 					   unsigned long page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -747,6 +828,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_v1_7_cache_war_disable_irq(flags);
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -776,12 +858,14 @@
 	} else
 		blast_scache64_page(page);
 out:
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static void r4k_flush_cache_page_s128d32i32(struct vm_area_struct *vma,
 					    unsigned long page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -796,6 +880,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_v1_7_cache_war_disable_irq(flags);
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -824,12 +909,14 @@
 	} else
 		blast_scache128_page(page);
 out:
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static void r4k_flush_cache_page_d16i16(struct vm_area_struct *vma,
 					unsigned long page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -844,6 +931,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_v1_7_cache_war_disable_irq(flags);
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -872,12 +960,14 @@
 		blast_dcache16_page_indexed(page);
 	}
 out:
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static void r4k_flush_cache_page_d32i32(struct vm_area_struct *vma,
 					unsigned long page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -892,6 +982,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_v1_7_cache_war_disable_irq(flags);
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -921,12 +1012,14 @@
 		blast_dcache32_page_indexed(page);
 	}
 out:
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 static void r4k_flush_cache_page_d32i32_r4600(struct vm_area_struct *vma,
 					      unsigned long page)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pmd_t *pmdp;
 	pte_t *ptep;
@@ -941,6 +1034,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_v1_7_cache_war_disable_irq(flags);
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -970,6 +1064,7 @@
 		blast_dcache32_page_indexed(page ^ dcache_waybit);
 	}
 out:
+	r4600_v1_7_cache_war_enable_irq(flags);
 }
=20
 /* If the addresses passed to these routines are valid, they are
@@ -1063,7 +1158,7 @@
 		flush_cache_all();
 	} else {
 #ifdef R4600_V2_HIT_CACHEOP_WAR
-		/* Workaround for R4600 bug.  See comment in <asm/war>. */
+		/* Workaround for R4600 bug.  See comment in <asm/war.h>. */
 		__save_and_cli(flags);
 		*(volatile unsigned long *)KSEG1;
 #endif


--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--xSu31lw3TgkWXnjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9XuoyHb1edYOZ4bsRApQmAJwNSQ7xxs3JSa5+x5RMW/BtPqFd5wCfVjXw
KJVf2g4ttoE/w9YXfse9Pns=
=tVj5
-----END PGP SIGNATURE-----

--xSu31lw3TgkWXnjh--
