Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TJQJnC026720
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 12:26:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TJQJcj026719
	for linux-mips-outgoing; Wed, 29 May 2002 12:26:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TJP1nC026696;
	Wed, 29 May 2002 12:25:02 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Wed, 29 May 2002 12:26:27 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from ldt-sj3-022.sj.broadcom.com (ldt-sj3-022 [10.21.64.22])
 by mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g4TJQT1S002193; Wed, 29 May 2002 12:26:29 -0700 (PDT)
Received: (from carlson@localhost) by ldt-sj3-022.sj.broadcom.com (
 8.11.6/8.9.3) id g4TJQTN08360; Wed, 29 May 2002 12:26:29 -0700
X-Authentication-Warning: ldt-sj3-022.sj.broadcom.com: carlson set
 sender to justinca@cs.cmu.edu using -f
Subject: Re: __flush_cache_all() miscellany
From: "Justin Carlson" <justinca@cs.cmu.edu>
To: linux-mips@oss.sgi.com
cc: ralf@oss.sgi.com
In-Reply-To: <1022691053.7644.16.camel@ldt-sj3-022.sj.broadcom.com>
References: <1022691053.7644.16.camel@ldt-sj3-022.sj.broadcom.com>
X-Mailer: Ximian Evolution 1.0.5
Date: 29 May 2002 12:26:29 -0700
Message-ID: <1022700389.7644.155.camel@ldt-sj3-022.sj.broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 10EBF4E8908394-01-01
Content-Type: multipart/mixed; 
 boundary="=-Xa1GCNyIzk6j4NZOBlXP"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-Xa1GCNyIzk6j4NZOBlXP
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit

Here's a patch against cvs that does the rename.  Unless anyone has
objections, Ralf, could  you apply this?

While doing this, I've noticed that the whole mips tree is horribly
inconsistent in terms of the cache flushing syscalls (sys_cacheflush and
sys_sysmips->CACHE_FLUSH).  

Here's what the different ports appear to flush given one of these
syscall:

andes:  l1 and l2
lexra:  l1 icache
mips32: l1 icache/dcache
r3k:    l1 icache
r4k:    l1 icache/dcache
r5432:  l1 icache/dcache
r5900:  l1 icache/dcache
rm7k:   l1 icache/dcache
sb1:    l1 icache/dcache
sr7100: l1 and l2
tx39:   l1 icache
tx49:   li icache/dcache

Some of these are blatantly wrong with respect to the cacheflush
syscall; it defines flags for flushing the icache, dcache, or both.  In
the latter two cases, the lexra, r3k, and tx39 are not doing what was
requested.  I doubt this matters for any significant userspace app, but
it would be nice to at least be consistent.

As for the sysmips system call, I've  not been able to dig up the
semantics.  (Actually, I don't really see why we have both ways of
flushing the cache at all...some historical cruft?).  Anyone have a
helpful pointer to docs on the subject?

Thanks,
  Justin


--=-Xa1GCNyIzk6j4NZOBlXP
Content-Disposition: attachment; 
 filename=rename___flush_cache_all.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; 
 charset=iso-8859-1; 
 name=rename___flush_cache_all.patch

? rename___flush_cache_all.patch
Index: arch/mips/kernel/gdb-stub.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/kernel/gdb-stub.c,v
retrieving revision 1.7
diff -u -r1.7 gdb-stub.c
--- arch/mips/kernel/gdb-stub.c	9 May 2002 17:22:34 -0000	1.7
+++ arch/mips/kernel/gdb-stub.c	29 May 2002 19:00:41 -0000
@@ -578,7 +578,7 @@
 	async_bp.addr =3D epc;
 	async_bp.val  =3D *(unsigned *)epc;
 	*(unsigned *)epc =3D BP;
-	__flush_cache_all();
+	force_flush_cache_all();
 }
=20
=20
@@ -805,7 +805,7 @@
 			 * NB: We flush both caches, just to be sure...
 			 */
=20
-			__flush_cache_all();
+			force_flush_cache_all();
 			return;
 			/* NOTREACHED */
 			break;
@@ -834,7 +834,7 @@
 			 * use breakpoints and continue, instead.
 			 */
 			single_step(regs);
-			__flush_cache_all();
+			force_flush_cache_all();
 			return;
 			/* NOTREACHED */
=20
Index: arch/mips/kernel/sysmips.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/kernel/sysmips.c,v
retrieving revision 1.10
diff -u -r1.10 sysmips.c
--- arch/mips/kernel/sysmips.c	26 Nov 2001 19:18:13 -0000	1.10
+++ arch/mips/kernel/sysmips.c	29 May 2002 19:00:41 -0000
@@ -84,7 +84,7 @@
 		goto out;
=20
 	case FLUSH_CACHE:
-		__flush_cache_all();
+		force_flush_cache_all();
 		retval =3D 0;
 		goto out;
=20
Index: arch/mips/mm/c-andes.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-andes.c,v
retrieving revision 1.4
diff -u -r1.4 c-andes.c
--- arch/mips/mm/c-andes.c	19 Feb 2002 17:43:02 -0000	1.4
+++ arch/mips/mm/c-andes.c	29 May 2002 19:00:41 -0000
@@ -70,7 +70,7 @@
 	}
 }
=20
-static void andes___flush_cache_all(void)
+static void andes_force_flush_cache_all(void)
 {
 	andes_flush_cache_l1();
 	andes_flush_cache_l2();
@@ -105,7 +105,7 @@
 	_copy_page =3D andes_copy_page;
=20
 	_flush_cache_all =3D andes_flush_cache_all;
-	___flush_cache_all =3D andes___flush_cache_all;
+	_force_flush_cache_all =3D andes_force_flush_cache_all;
 	_flush_cache_mm =3D andes_flush_cache_mm;
 	_flush_cache_page =3D andes_flush_cache_page;
 	_flush_page_to_ram =3D andes_flush_page_to_ram;
Index: arch/mips/mm/c-lexra.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-lexra.c,v
retrieving revision 1.1
diff -u -r1.1 c-lexra.c
--- arch/mips/mm/c-lexra.c	9 May 2002 17:22:35 -0000	1.1
+++ arch/mips/mm/c-lexra.c	29 May 2002 19:00:42 -0000
@@ -282,7 +282,7 @@
 	dcache_size =3D 1024 * 2;
=20
 	_flush_cache_all =3D lx_flush_cache_all;
-	___flush_cache_all =3D lx_flush_cache_all;=20
+	_force_flush_cache_all =3D lx_flush_cache_all;=20
 	_flush_cache_mm =3D lx_flush_cache_mm;
 	_flush_cache_range =3D lx_flush_cache_range;
 	_flush_cache_page =3D lx_flush_cache_page;
Index: arch/mips/mm/c-mips32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-mips32.c,v
retrieving revision 1.4
diff -u -r1.4 c-mips32.c
--- arch/mips/mm/c-mips32.c	28 Jan 2002 23:15:25 -0000	1.4
+++ arch/mips/mm/c-mips32.c	29 May 2002 19:00:42 -0000
@@ -590,7 +590,7 @@
 	_clear_page =3D (void *)mips32_clear_page_dc;
 	_copy_page =3D (void *)mips32_copy_page_dc;
 	_flush_cache_all =3D mips32_flush_cache_all_pc;
-	___flush_cache_all =3D mips32_flush_cache_all_pc;
+	_force_flush_cache_all =3D mips32_flush_cache_all_pc;
 	_flush_cache_mm =3D mips32_flush_cache_mm_pc;
 	_flush_cache_range =3D mips32_flush_cache_range_pc;
 	_flush_cache_page =3D mips32_flush_cache_page_pc;
@@ -606,7 +606,7 @@
 static void __init setup_scache_funcs(void)
 {
         _flush_cache_all =3D mips32_flush_cache_all_sc;
-        ___flush_cache_all =3D mips32_flush_cache_all_sc;
+        _force_flush_cache_all =3D mips32_flush_cache_all_sc;
 	_flush_cache_mm =3D mips32_flush_cache_mm_sc;
 	_flush_cache_range =3D mips32_flush_cache_range_sc;
 	_flush_cache_page =3D mips32_flush_cache_page_sc;
@@ -666,5 +666,5 @@
 	_flush_cache_sigtramp =3D mips32_flush_cache_sigtramp;
 	_flush_icache_range =3D mips32_flush_icache_range;	/* Ouch */
=20
-	__flush_cache_all();
+	force_flush_cache_all();
 }
Index: arch/mips/mm/c-r3k.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-r3k.c,v
retrieving revision 1.6
diff -u -r1.6 c-r3k.c
--- arch/mips/mm/c-r3k.c	19 Feb 2002 17:37:17 -0000	1.6
+++ arch/mips/mm/c-r3k.c	29 May 2002 19:00:42 -0000
@@ -240,7 +240,7 @@
 {
 }
 =20
-static inline void r3k___flush_cache_all(void)
+static inline void r3k_force_flush_cache_all(void)
 {
 	r3k_flush_icache_range(KSEG0, KSEG0 + icache_size);
 }
@@ -328,7 +328,7 @@
 	r3k_probe_cache();
=20
 	_flush_cache_all =3D r3k_flush_cache_all;
-	___flush_cache_all =3D r3k___flush_cache_all;
+	_force_flush_cache_all =3D r3k_force_flush_cache_all;
 	_flush_cache_mm =3D r3k_flush_cache_mm;
 	_flush_cache_range =3D r3k_flush_cache_range;
 	_flush_cache_page =3D r3k_flush_cache_page;
Index: arch/mips/mm/c-r4k.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.9
diff -u -r1.9 c-r4k.c
--- arch/mips/mm/c-r4k.c	28 May 2002 21:03:31 -0000	1.9
+++ arch/mips/mm/c-r4k.c	29 May 2002 19:00:42 -0000
@@ -1362,7 +1362,7 @@
 		_flush_cache_page =3D r4k_flush_cache_page_d32i32;
 		break;
 	}
-	___flush_cache_all =3D _flush_cache_all;
+	_force_flush_cache_all =3D _flush_cache_all;
=20
 	_flush_icache_page =3D r4k_flush_icache_page_p;
 #ifdef CONFIG_NONCOHERENT_IO
@@ -1448,7 +1448,7 @@
 		_copy_page =3D r4k_copy_page_s128;
 		break;
 	}
-	___flush_cache_all =3D _flush_cache_all;
+	_force_flush_cache_all =3D _flush_cache_all;
 	_flush_icache_page =3D r4k_flush_icache_page_s;
 #ifdef CONFIG_NONCOHERENT_IO
 	_dma_cache_wback_inv =3D r4k_dma_cache_wback_inv_sc;
@@ -1504,5 +1504,5 @@
 		_flush_cache_sigtramp =3D r4600v20k_flush_cache_sigtramp;
 	}
=20
-	__flush_cache_all();
+	force_flush_cache_all();
 }
Index: arch/mips/mm/c-r5432.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-r5432.c,v
retrieving revision 1.6
diff -u -r1.6 c-r5432.c
--- arch/mips/mm/c-r5432.c	30 Nov 2001 18:34:09 -0000	1.6
+++ arch/mips/mm/c-r5432.c	29 May 2002 19:00:42 -0000
@@ -463,7 +463,7 @@
 	_clear_page =3D r5432_clear_page_d32;
 	_copy_page =3D r5432_copy_page_d32;
 	_flush_cache_all =3D r5432_flush_cache_all_d32i32;
-	___flush_cache_all =3D r5432_flush_cache_all_d32i32;
+	_force_flush_cache_all =3D r5432_flush_cache_all_d32i32;
 	_flush_page_to_ram =3D r5432_flush_page_to_ram_d32;
 	_flush_cache_mm =3D r5432_flush_cache_mm_d32i32;
 	_flush_cache_range =3D r5432_flush_cache_range_d32i32;
@@ -476,5 +476,5 @@
 	_flush_cache_sigtramp =3D r5432_flush_cache_sigtramp;
 	_flush_icache_range =3D r5432_flush_icache_range;	/* Ouch */
=20
-	__flush_cache_all();
+	force_flush_cache_all();
 }
Index: arch/mips/mm/c-r5900.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-r5900.c,v
retrieving revision 1.2
diff -u -r1.2 c-r5900.c
--- arch/mips/mm/c-r5900.c	27 Nov 2001 17:53:47 -0000	1.2
+++ arch/mips/mm/c-r5900.c	29 May 2002 19:00:42 -0000
@@ -307,7 +307,7 @@
 	_flush_cache_range =3D r5900_flush_cache_range_d64i64;
 	_flush_cache_page =3D r5900_flush_cache_page_d64i64;
=20
-	___flush_cache_all =3D _flush_cache_all;
+	_force_flush_cache_all =3D _flush_cache_all;
 	_flush_icache_range =3D r5900_flush_icache_range_i64;
 	_flush_icache_page =3D r5900_flush_icache_page_i64; /* FIXME */
=20
Index: arch/mips/mm/c-rm7k.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-rm7k.c,v
retrieving revision 1.5
diff -u -r1.5 c-rm7k.c
--- arch/mips/mm/c-rm7k.c	21 Apr 2002 20:01:13 -0000	1.5
+++ arch/mips/mm/c-rm7k.c	29 May 2002 19:00:42 -0000
@@ -66,7 +66,7 @@
 		  "i" (Page_Invalidate_T));
 }
=20
-static void __flush_cache_all_d32i32(void)
+static void force_flush_cache_all_d32i32(void)
 {
 	blast_dcache32();
 	blast_icache32();
@@ -105,7 +105,7 @@
 	/*
 	 * FIXME: This is overdoing things and harms performance.
 	 */
-	__flush_cache_all_d32i32();
+	force_flush_cache_all_d32i32();
 }
=20
 static void rm7k_flush_icache_page(struct vm_area_struct *vma,
@@ -116,7 +116,7 @@
 	 * temporary mapping and use hit_invalidate operation to flush out
 	 * the line from the cache.
 	 */
-	__flush_cache_all_d32i32();
+	force_flush_cache_all_d32i32();
 }
=20
=20
@@ -331,7 +331,7 @@
 	_copy_page =3D rm7k_copy_page;
=20
 	_flush_cache_all =3D rm7k_flush_cache_all_d32i32;
-	___flush_cache_all =3D __flush_cache_all_d32i32;
+	_force_flush_cache_all =3D force_flush_cache_all_d32i32;
 	_flush_cache_mm =3D rm7k_flush_cache_mm_d32i32;
 	_flush_cache_range =3D rm7k_flush_cache_range_d32i32;
 	_flush_cache_page =3D rm7k_flush_cache_page_d32i32;
@@ -344,5 +344,5 @@
 	_dma_cache_wback =3D rm7k_dma_cache_wback;
 	_dma_cache_inv =3D rm7k_dma_cache_inv;
=20
-	__flush_cache_all_d32i32();
+	force_flush_cache_all_d32i32();
 }
Index: arch/mips/mm/c-sb1.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-sb1.c,v
retrieving revision 1.14
diff -u -r1.14 c-sb1.c
--- arch/mips/mm/c-sb1.c	21 Apr 2002 20:01:13 -0000	1.14
+++ arch/mips/mm/c-sb1.c	29 May 2002 19:00:42 -0000
@@ -74,7 +74,7 @@
 {
 }
=20
-static void local_sb1___flush_cache_all(void)
+static void local_sb1_force_flush_cache_all(void)
 {
 	/*
 	 * Haven't worried too much about speed here; given that we're flushing
@@ -126,17 +126,17 @@
 }
=20
 #ifdef CONFIG_SMP
-extern void sb1___flush_cache_all_ipi(void *ignored);
-asm("sb1___flush_cache_all_ipi =3D local_sb1___flush_cache_all");
+extern void sb1_force_flush_cache_all_ipi(void *ignored);
+asm("sb1_force_flush_cache_all_ipi =3D local_sb1_force_flush_cache_all");
=20
-static void sb1___flush_cache_all(void)
+static void sb1_force_flush_cache_all(void)
 {
-	smp_call_function(sb1___flush_cache_all_ipi, 0, 1, 1);
-	local_sb1___flush_cache_all();
+	smp_call_function(sb1_force_flush_cache_all_ipi, 0, 1, 1);
+	local_sb1_force_flush_cache_all();
 }
 #else
-extern void sb1___flush_cache_all(void);
-asm("sb1___flush_cache_all =3D local_sb1___flush_cache_all");
+extern void sb1_force_flush_cache_all(void);
+asm("sb1_force_flush_cache_all =3D local_sb1_force_flush_cache_all");
 #endif
=20
=20
@@ -257,7 +257,7 @@
 	 * conservatively flush the entire caches on all processors
 	 * (ouch).
 	 */
-	sb1___flush_cache_all();
+	sb1_force_flush_cache_all();
 }
=20
 static inline void protected_flush_icache_line(unsigned long addr)
@@ -506,7 +506,7 @@
 	_copy_page =3D sb1_copy_page;
=20
 	_flush_cache_all =3D sb1_flush_cache_all;
-	___flush_cache_all =3D sb1___flush_cache_all;
+	_force_flush_cache_all =3D sb1_force_flush_cache_all;
 	_flush_cache_mm =3D (void (*)(struct mm_struct *))sb1_nop;
 	_flush_cache_range =3D (void *) sb1_nop;
 	_flush_page_to_ram =3D sb1_flush_page_to_ram;
Index: arch/mips/mm/c-sr7100.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-sr7100.c,v
retrieving revision 1.1
diff -u -r1.1 c-sr7100.c
--- arch/mips/mm/c-sr7100.c	19 Jan 2002 21:17:35 -0000	1.1
+++ arch/mips/mm/c-sr7100.c	29 May 2002 19:00:42 -0000
@@ -419,7 +419,7 @@
 static void __init setup_scache_funcs(void)
 {
         _flush_cache_all =3D sr7100_flush_cache_all_pc;
-        ___flush_cache_all =3D sr7100_nuke_caches;
+        _force_flush_cache_all =3D sr7100_nuke_caches;
 	_flush_cache_mm =3D sr7100_flush_cache_mm_pc;
 	_flush_cache_range =3D sr7100_flush_cache_range_pc;
 	_flush_cache_page =3D sr7100_flush_cache_page_pc;
Index: arch/mips/mm/c-tx39.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-tx39.c,v
retrieving revision 1.5
diff -u -r1.5 c-tx39.c
--- arch/mips/mm/c-tx39.c	30 Nov 2001 18:34:09 -0000	1.5
+++ arch/mips/mm/c-tx39.c	29 May 2002 19:00:43 -0000
@@ -286,7 +286,7 @@
 	case CPU_TX3912:
 		/* TX39/H core (writethru direct-map cache) */
 		_flush_cache_all	=3D tx39h_flush_icache_all;
-		___flush_cache_all	=3D tx39h_flush_icache_all;
+		_force_flush_cache_all	=3D tx39h_flush_icache_all;
 		_flush_cache_mm		=3D (void *) tx39h_flush_icache_all;
 		_flush_cache_range	=3D (void *) tx39h_flush_icache_all;
 		_flush_cache_page	=3D (void *) tx39h_flush_icache_all;
@@ -308,7 +308,7 @@
 		/* board-dependent init code may set WBON */
=20
 		_flush_cache_all =3D tx39_flush_cache_all;
-		___flush_cache_all =3D tx39_flush_cache_all;
+		_force_flush_cache_all =3D tx39_flush_cache_all;
 		_flush_cache_mm =3D tx39_flush_cache_mm;
 		_flush_cache_range =3D tx39_flush_cache_range;
 		_flush_cache_page =3D tx39_flush_cache_page;
Index: arch/mips/mm/c-tx49.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/c-tx49.c,v
retrieving revision 1.3
diff -u -r1.3 c-tx49.c
--- arch/mips/mm/c-tx49.c	30 Nov 2001 18:34:09 -0000	1.3
+++ arch/mips/mm/c-tx49.c	29 May 2002 19:00:43 -0000
@@ -423,7 +423,7 @@
 		_flush_cache_page =3D r49_flush_cache_page_d32i32;
 		break;
 	}
-	___flush_cache_all =3D _flush_cache_all;
+	_force_flush_cache_all =3D _flush_cache_all;
=20
 	_flush_icache_page =3D r4k_flush_icache_page;
=20
@@ -434,5 +434,5 @@
 	_flush_cache_sigtramp =3D r4k_flush_cache_sigtramp;
 	_flush_icache_range =3D r4k_flush_icache_range;	/* Ouch */
=20
-	__flush_cache_all();
+	force_flush_cache_all();
 }
Index: arch/mips/mm/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/init.c,v
retrieving revision 1.6
diff -u -r1.6 init.c
--- arch/mips/mm/init.c	18 Mar 2002 22:48:17 -0000	1.6
+++ arch/mips/mm/init.c	29 May 2002 19:00:43 -0000
@@ -49,7 +49,7 @@
 asmlinkage int sys_cacheflush(void *addr, int bytes, int cache)
 {
 	/* This should flush more selectivly ...  */
-	__flush_cache_all();
+	force_flush_cache_all();
=20
 	return 0;
 }
Index: arch/mips/mm/loadmmu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips/mm/loadmmu.c,v
retrieving revision 1.13
diff -u -r1.13 loadmmu.c
--- arch/mips/mm/loadmmu.c	9 May 2002 17:22:35 -0000	1.13
+++ arch/mips/mm/loadmmu.c	29 May 2002 19:00:43 -0000
@@ -24,7 +24,7 @@
=20
 /* Cache operations. */
 void (*_flush_cache_all)(void);
-void (*___flush_cache_all)(void);
+void (*_force_flush_cache_all)(void);
 void (*_flush_cache_mm)(struct mm_struct *mm);
 void (*_flush_cache_range)(struct mm_struct *mm, unsigned long start,
 			  unsigned long end);
Index: arch/mips64/mm/c-sb1.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips64/mm/c-sb1.c,v
retrieving revision 1.6
diff -u -r1.6 c-sb1.c
--- arch/mips64/mm/c-sb1.c	24 Apr 2002 17:30:19 -0000	1.6
+++ arch/mips64/mm/c-sb1.c	29 May 2002 19:00:43 -0000
@@ -111,24 +111,24 @@
 		  "r" (KSEG0), "i" (Index_Invalidate_I));
 }
=20
-static void local_sb1___flush_cache_all(void)
+static void local_sb1_force_flush_cache_all(void)
 {
 	local_sb1___flush_dcache_all();
 	local_sb1___flush_icache_all();
 }
=20
 #ifdef CONFIG_SMP
-extern void sb1___flush_cache_all_ipi(void *ignored);
-asm("sb1___flush_cache_all_ipi =3D local_sb1___flush_cache_all");
+extern void sb1_force_flush_cache_all_ipi(void *ignored);
+asm("sb1_force_flush_cache_all_ipi =3D local_sb1_force_flush_cache_all");
=20
-static void sb1___flush_cache_all(void)
+static void sb1_force_flush_cache_all(void)
 {
-	smp_call_function(sb1___flush_cache_all_ipi, 0, 1, 1);
-	local_sb1___flush_cache_all();
+	smp_call_function(sb1_force_flush_cache_all_ipi, 0, 1, 1);
+	local_sb1_force_flush_cache_all();
 }
 #else
-extern void sb1___flush_cache_all(void);
-asm("sb1___flush_cache_all =3D local_sb1___flush_cache_all");
+extern void sb1_force_flush_cache_all(void);
+asm("sb1_force_flush_cache_all =3D local_sb1_force_flush_cache_all");
 #endif
=20
=20
@@ -256,7 +256,7 @@
 	 *
 	 * Bumping the ASID may well be cheaper, need to experiment ...
 	 */
-	sb1___flush_cache_all();
+	sb1_force_flush_cache_all();
 }
=20
 static inline void protected_flush_icache_line(unsigned long addr)
@@ -505,7 +505,7 @@
 	_copy_page =3D sb1_copy_page;
=20
 	_flush_cache_all =3D sb1_flush_cache_all;
-	___flush_cache_all =3D sb1___flush_cache_all;
+	_force_flush_cache_all =3D sb1_force_flush_cache_all;
 	_flush_cache_mm =3D (void (*)(struct mm_struct *))sb1_nop;
 	_flush_cache_range =3D (void *) sb1_nop;
 	_flush_page_to_ram =3D sb1_flush_page_to_ram;
Index: arch/mips64/mm/loadmmu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/arch/mips64/mm/loadmmu.c,v
retrieving revision 1.6
diff -u -r1.6 loadmmu.c
--- arch/mips64/mm/loadmmu.c	19 Feb 2002 17:43:02 -0000	1.6
+++ arch/mips64/mm/loadmmu.c	29 May 2002 19:00:43 -0000
@@ -25,7 +25,7 @@
=20
 /* Cache operations. */
 void (*_flush_cache_all)(void);
-void (*___flush_cache_all)(void);
+void (*_force_flush_cache_all)(void);
 void (*_flush_cache_mm)(struct mm_struct *mm);
 void (*_flush_cache_range)(struct mm_struct *mm, unsigned long start,
                            unsigned long end);
Index: include/asm-mips/pgtable.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/include/asm-mips/pgtable.h,v
retrieving revision 1.17
diff -u -r1.17 pgtable.h
--- include/asm-mips/pgtable.h	21 Apr 2002 20:34:31 -0000	1.17
+++ include/asm-mips/pgtable.h	29 May 2002 19:00:44 -0000
@@ -33,7 +33,7 @@
  *  - flush_icache_all() flush the entire instruction cache
  */
 extern void (*_flush_cache_all)(void);
-extern void (*___flush_cache_all)(void);
+extern void (*_force_flush_cache_all)(void);
 extern void (*_flush_cache_mm)(struct mm_struct *mm);
 extern void (*_flush_cache_range)(struct mm_struct *mm, unsigned long star=
t,
 	unsigned long end);
@@ -49,7 +49,7 @@
 #define flush_dcache_page(page)			do { } while (0)
=20
 #define flush_cache_all()		_flush_cache_all()
-#define __flush_cache_all()		___flush_cache_all()
+#define force_flush_cache_all()		_force_flush_cache_all()
 #define flush_cache_mm(mm)		_flush_cache_mm(mm)
 #define flush_cache_range(mm,start,end)	_flush_cache_range(mm,start,end)
 #define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
Index: include/asm-mips64/pgtable.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/linux-mips/linux/include/asm-mips64/pgtable.h,v
retrieving revision 1.14
diff -u -r1.14 pgtable.h
--- include/asm-mips64/pgtable.h	28 May 2002 20:25:38 -0000	1.14
+++ include/asm-mips64/pgtable.h	29 May 2002 19:00:44 -0000
@@ -28,7 +28,7 @@
  *  - flush_page_to_ram(page) write back kernel page to ram
  */
 extern void (*_flush_cache_all)(void);
-extern void (*___flush_cache_all)(void);
+extern void (*_force_flush_cache_all)(void);
 extern void (*_flush_cache_mm)(struct mm_struct *mm);
 extern void (*_flush_cache_range)(struct mm_struct *mm, unsigned long star=
t,
 	unsigned long end);
@@ -47,7 +47,7 @@
=20
=20
 #define flush_cache_all()		_flush_cache_all()
-#define __flush_cache_all()		___flush_cache_all()
+#define force_flush_cache_all()		_force_flush_cache_all()
 #define flush_dcache_page(page)		do { } while (0)
=20
 #ifdef CONFIG_CPU_R10000

--=-Xa1GCNyIzk6j4NZOBlXP--
