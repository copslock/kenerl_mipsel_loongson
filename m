Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61Fr4nC009182
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 08:53:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61Fr4iG009181
	for linux-mips-outgoing; Mon, 1 Jul 2002 08:53:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61Fq2nC009148
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 08:52:03 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 3461513373; Mon,  1 Jul 2002 17:55:52 +0200 (CEST)
Date: Mon, 1 Jul 2002 17:55:52 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Buggy R4600 support (was: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1)
Message-ID: <20020701155552.GT17216@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020701094359.GP17216@lug-owl.de> <Pine.GSO.3.96.1020701161009.7601E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HL+2C3YiDdBCOf2R"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020701161009.7601E-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-9.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--HL+2C3YiDdBCOf2R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-07-01 16:28:13 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
wrote in message <Pine.GSO.3.96.1020701161009.7601E-100000@delta.ds2.pg.gda=
.pl>:
> On Mon, 1 Jul 2002, Jan-Benedict Glaw wrote:
> > Okay, stupid idea. All these flush functions seem to be never called in
> > parallel or recursive, so if might be possible to have a global flags
> > variable and instead of always calling __save..() and __restore..(),
> > we bulid a pair of inline functions doing this. This wouldn't give
> > any penalty for !CONFIG_CPU_R4X00 and doesn't obscure the code so much
> > as all those #ifdef and #endif's would do... I'll test my suggestion
> > as fast as I reach my Indy again (is powered down at home...).
>=20
>  Feel free to use the change privately.  Otherwise please code a real fix,
> i.e. a set of buggy-R4600-specific functions, as CONFIG_CPU_R4X00 means
> other processors as well, e.g. R4000 or R4400 which are fine here.=20

Well, here's step 1. I've created inline functions for save/restore
flags and dropped them in where (as of 2.4.16) the calls where. My Indy
already runs (fine) with this. Now, there are two possibilities: I could
double all the cache handling functions for old R4600 and set
appropriate pointers in all the __init functions at the end of c-r4k.c.
The other variant would be to work on the inline functions to only
save/restore if this is a buggy CPU. The next step could be to only mask
out some interrupts as suggested, but I'm currently not experienced
enough to do this. I've now also looked at www.mips.com, but I cannot
find the erratta for R4600:-( I'm too dumb...

However, here's what I currently have. Feel free to throw stones at me:

Ralf: There's a little spellinck ficks at patches end...

Index: c-r4k.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.3
diff -u -r1.3.2.3 c-r4k.c
--- c-r4k.c	2002/05/29 03:03:17	1.3.2.3
+++ c-r4k.c	2002/07/01 15:40:03
@@ -54,6 +54,10 @@
=20
 struct bcache_ops *bcops =3D &no_sc_ops;
=20
+#ifdef CONFIG_CPU_R4X00
+unsigned long	r4600_buggy_flags;
+#endif /* CONFIG_CPU_R4X00 */
+
 /*
  * On processors with QED R4600 style two set assosicative cache
  * this is the bit which selects the way in the cache for the
@@ -62,6 +66,26 @@
 #define icache_waybit (icache_size >> 1)
 #define dcache_waybit (dcache_size >> 1)
=20
+static inline void
+r4600_bug_start(void)
+{
+#ifdef CONFIG_CPU_R4X00
+	__save_and_cli(r4600_buggy_flags);
+	__asm__ __volatile__("nop;nop;nop;nop");
+#endif /* CONFIG_CPU_R4X00 */
+	return;
+}
+
+static inline void
+r4600_bug_finish(void)
+{
+#ifdef CONFIG_CPU_R4X00
+	__restore_flags(r4600_buggy_flags);
+#endif /* CONFIG_CPU_R4X00 */
+	return;
+}
+
+
 /*
  * If you think for one second that this stuff coming up is a lot
  * of bulky code eating too many kernel cache lines.  Think _again_.
@@ -77,47 +101,65 @@
=20
 static inline void r4k_flush_cache_all_s16d16i16(void)
 {
+	r4600_bug_start();
 	blast_dcache16(); blast_icache16(); blast_scache16();
+	r4600_bug_finish();
 }
=20
 static inline void r4k_flush_cache_all_s32d16i16(void)
 {
+	r4600_bug_start();
 	blast_dcache16(); blast_icache16(); blast_scache32();
+	r4600_bug_finish();
 }
=20
 static inline void r4k_flush_cache_all_s64d16i16(void)
 {
+	r4600_bug_start();
 	blast_dcache16(); blast_icache16(); blast_scache64();
+	r4600_bug_finish();
 }
=20
 static inline void r4k_flush_cache_all_s128d16i16(void)
 {
+	r4600_bug_start();
 	blast_dcache16(); blast_icache16(); blast_scache128();
+	r4600_bug_finish();
 }
=20
 static inline void r4k_flush_cache_all_s32d32i32(void)
 {
+	r4600_bug_start();
 	blast_dcache32(); blast_icache32(); blast_scache32();
+	r4600_bug_finish();
 }
=20
 static inline void r4k_flush_cache_all_s64d32i32(void)
 {
+	r4600_bug_start();
 	blast_dcache32(); blast_icache32(); blast_scache64();
+	r4600_bug_finish();
 }
=20
 static inline void r4k_flush_cache_all_s128d32i32(void)
 {
+	r4600_bug_start();
 	blast_dcache32(); blast_icache32(); blast_scache128();
+	r4600_bug_finish();
 }
=20
 static inline void r4k_flush_cache_all_d16i16(void)
 {
+	r4600_bug_start();
 	blast_dcache16(); blast_icache16();
+	r4600_bug_finish();
 }
=20
 static inline void r4k_flush_cache_all_d32i32(void)
 {
+	r4600_bug_start();
 	blast_dcache32(); blast_icache32();
+	r4600_bug_finish();
 }
=20
 static void
@@ -143,6 +185,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_bug_start();
 			while (start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -152,6 +195,7 @@
 					blast_scache16_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_bug_finish();
 		}
 	}
 }
@@ -179,6 +223,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_bug_start();
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -188,6 +233,7 @@
 					blast_scache32_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_bug_finish();
 		}
 	}
 }
@@ -214,6 +260,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_bug_start();
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -223,6 +270,7 @@
 					blast_scache64_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_bug_finish();
 		}
 	}
 }
@@ -249,6 +297,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_bug_start();
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -258,6 +307,7 @@
 					blast_scache128_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_bug_finish();
 		}
 	}
 }
@@ -284,6 +334,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_bug_start();
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -293,6 +344,7 @@
 					blast_scache32_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_bug_finish();
 		}
 	}
 }
@@ -319,6 +371,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_bug_start();
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -328,6 +381,7 @@
 					blast_scache64_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_bug_finish();
 		}
 	}
 }
@@ -354,6 +408,7 @@
 			pmd_t *pmd;
 			pte_t *pte;
=20
+			r4600_bug_start();
 			while(start < end) {
 				pgd =3D pgd_offset(mm, start);
 				pmd =3D pmd_offset(pgd, start);
@@ -363,6 +418,7 @@
 					blast_scache128_page(start);
 				start +=3D PAGE_SIZE;
 			}
+			r4600_bug_finish();
 		}
 	}
 }
@@ -375,7 +431,9 @@
 #ifdef DEBUG_CACHE
 		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
 #endif
+		r4600_bug_start();
 		blast_dcache16(); blast_icache16();
+		r4600_bug_finish();
 	}
 }
=20
@@ -387,7 +445,9 @@
 #ifdef DEBUG_CACHE
 		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
 #endif
+		r4600_bug_start();
 		blast_dcache32(); blast_icache32();
+		r4600_bug_finish();
 	}
 }
=20
@@ -504,6 +564,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_bug_start();
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -533,6 +594,7 @@
 	} else
 		blast_scache16_page(page);
 out:
+	r4600_bug_finish();
 }
=20
 static void r4k_flush_cache_page_s32d16i16(struct vm_area_struct *vma,
@@ -553,6 +615,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_bug_start();
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -581,6 +644,7 @@
 	} else
 		blast_scache32_page(page);
 out:
+	r4600_bug_finish();
 }
=20
 static void r4k_flush_cache_page_s64d16i16(struct vm_area_struct *vma,
@@ -601,6 +665,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_bug_start();
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -629,6 +694,7 @@
 	} else
 		blast_scache64_page(page);
 out:
+	r4600_bug_finish();
 }
=20
 static void r4k_flush_cache_page_s128d16i16(struct vm_area_struct *vma,
@@ -649,6 +715,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_bug_start();
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -678,6 +745,7 @@
 	} else
 		blast_scache128_page(page);
 out:
+	r4600_bug_finish();
 }
=20
 static void r4k_flush_cache_page_s32d32i32(struct vm_area_struct *vma,
@@ -698,6 +766,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_bug_start();
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -727,6 +796,7 @@
 	} else
 		blast_scache32_page(page);
 out:
+	r4600_bug_finish();
 }
=20
 static void r4k_flush_cache_page_s64d32i32(struct vm_area_struct *vma,
@@ -747,6 +817,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_bug_start();
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -776,6 +847,7 @@
 	} else
 		blast_scache64_page(page);
 out:
+	r4600_bug_finish();
 }
=20
 static void r4k_flush_cache_page_s128d32i32(struct vm_area_struct *vma,
@@ -796,6 +868,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_bug_start();
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -824,6 +897,7 @@
 	} else
 		blast_scache128_page(page);
 out:
+	r4600_bug_finish();
 }
=20
 static void r4k_flush_cache_page_d16i16(struct vm_area_struct *vma,
@@ -844,6 +918,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_bug_start();
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -872,6 +947,7 @@
 		blast_dcache16_page_indexed(page);
 	}
 out:
+	r4600_bug_finish();
 }
=20
 static void r4k_flush_cache_page_d32i32(struct vm_area_struct *vma,
@@ -892,6 +968,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_bug_start();
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -921,6 +998,7 @@
 		blast_dcache32_page_indexed(page);
 	}
 out:
+	r4600_bug_finish();
 }
=20
 static void r4k_flush_cache_page_d32i32_r4600(struct vm_area_struct *vma,
@@ -941,6 +1019,7 @@
 #ifdef DEBUG_CACHE
 	printk("cpage[%d,%08lx]", (int)mm->context, page);
 #endif
+	r4600_bug_start();
 	page &=3D PAGE_MASK;
 	pgdp =3D pgd_offset(mm, page);
 	pmdp =3D pmd_offset(pgdp, page);
@@ -970,6 +1049,7 @@
 		blast_dcache32_page_indexed(page ^ dcache_waybit);
 	}
 out:
+	r4600_bug_finish();
 }
=20
 /* If the addresses passed to these routines are valid, they are
@@ -1063,7 +1143,7 @@
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

--HL+2C3YiDdBCOf2R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9IHuHHb1edYOZ4bsRAneZAJ9+xZy/m8yDHgNfaKN9x/NQsElwIgCeIxop
q4rldnK6hGpUbRMX095cCBY=
=v5/7
-----END PGP SIGNATURE-----

--HL+2C3YiDdBCOf2R--
