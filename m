Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2004 16:49:30 +0100 (BST)
Received: from hydra.gt.owl.de ([IPv6:::ffff:195.71.99.218]:12494 "EHLO
	hydra.gt.owl.de") by linux-mips.org with ESMTP id <S8224931AbUIWPt0>;
	Thu, 23 Sep 2004 16:49:26 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 104)
	id 91ED21994E0; Thu, 23 Sep 2004 17:49:24 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8C522138065; Thu, 23 Sep 2004 17:48:55 +0200 (CEST)
Date: Thu, 23 Sep 2004 17:48:55 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20040923154855.GA2550@paradigm.rfc822.org>
References: <4152D58B.608@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <4152D58B.608@longlandclan.hopto.org>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--Sr1nOIr3CvdE5hEN
Content-Type: multipart/mixed; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 23, 2004 at 11:54:19PM +1000, Stuart Longland wrote:
> 	Using a MIPS64 config (built using gas-abi=3Do32 as suggested by Kumba),
> it doesn't even get that far:

There is still a lot left broken - The attached patch fixes some obvious
stuff with address space and mibs abi.

Missing is a fix for ip22zilog.c which seems to be broken.=20

With this fix the machines goes userspace (reverse engineered by sound
of hard disk) but seems to die somewhere. Probably the same bug as seen
on other archs - die on first fork.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cvs-20040923-ip22-64-2.6.diff"
Content-Transfer-Encoding: quoted-printable

Index: arch/mips/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/flo/linux-mips-cvs/linux/arch/mips/Makefile,v
retrieving revision 1.176
diff -u -r1.176 Makefile
--- arch/mips/Makefile	19 Sep 2004 00:15:05 -0000	1.176
+++ arch/mips/Makefile	22 Sep 2004 23:54:24 -0000
@@ -35,7 +35,7 @@
 endif
 ifdef CONFIG_MIPS64
 gcc-abi			=3D 64
-gas-abi			=3D 32
+gas-abi			=3D o64
 tool-prefix		=3D $(64bit-tool-prefix)
 UTS_MACHINE		:=3D mips64
 endif
@@ -107,7 +107,7 @@
 	break; \
 done; \
 if test "$(gcc-abi)" !=3D "$(gas-abi)"; then \
-	gas_abi=3D"-Wa,-$(gas-abi) -Wa,-mgp$(gcc-abi)"; \
+	gas_abi=3D"-Wa,-mabi=3D$(gas-abi) -Wa,-mgp$(gcc-abi)"; \
 fi; \
 if test "$$gcc_opt" =3D -march=3D && test -n "$$gcc_abi"; then \
 	$(CC) $$gcc_abi $$gcc_opt$$gcc_cpu -S -o /dev/null \
Index: arch/mips/lib-64/dump_tlb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/flo/linux-mips-cvs/linux/arch/mips/lib-64/dump_tlb.c,v
retrieving revision 1.2
diff -u -r1.2 dump_tlb.c
--- arch/mips/lib-64/dump_tlb.c	11 Feb 2004 15:05:44 -0000	1.2
+++ arch/mips/lib-64/dump_tlb.c	23 Sep 2004 01:19:10 -0000
@@ -190,7 +190,7 @@
 	pgd =3D pgd_offset(current->mm, addr);
 	pmd =3D pmd_offset(pgd, addr);
 	pte =3D pte_offset(pmd, addr);
-	paddr =3D (KSEG1 | (unsigned int) pte_val(*pte)) & PAGE_MASK;
+	paddr =3D (CKSEG1 | (unsigned int) pte_val(*pte)) & PAGE_MASK;
 	paddr |=3D (addr & ~PAGE_MASK);
=20
 	return paddr;
Index: arch/mips/mm/c-r4k.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/flo/linux-mips-cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.89
diff -u -r1.89 c-r4k.c
--- arch/mips/mm/c-r4k.c	24 Aug 2004 16:02:25 -0000	1.89
+++ arch/mips/mm/c-r4k.c	23 Sep 2004 01:11:27 -0000
@@ -49,7 +49,7 @@
 #define R4600_HIT_CACHEOP_WAR_IMPL					\
 do {									\
 	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())		\
-		*(volatile unsigned long *)KSEG1;			\
+		*(volatile unsigned long *)CKSEG1;			\
 	if (R4600_V1_HIT_CACHEOP_WAR)					\
 		__asm__ __volatile__("nop;nop;nop;nop");		\
 } while (0)
@@ -983,7 +983,7 @@
 	case CPU_R4000MC:
 	case CPU_R4400SC:
 	case CPU_R4400MC:
-		probe_scache_kseg1 =3D (probe_func_t) (KSEG1ADDR(&probe_scache));
+		probe_scache_kseg1 =3D (probe_func_t) (CKSEG1ADDR(&probe_scache));
 		sc_present =3D probe_scache_kseg1(config);
 		if (sc_present)
 			c->options |=3D MIPS_CPU_CACHE_CDEX_S;
Index: arch/mips/sgi-ip22/ip22-setup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/flo/linux-mips-cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
retrieving revision 1.39
diff -u -r1.39 ip22-setup.c
--- arch/mips/sgi-ip22/ip22-setup.c	20 Aug 2004 10:03:22 -0000	1.39
+++ arch/mips/sgi-ip22/ip22-setup.c	23 Sep 2004 00:56:44 -0000
@@ -76,7 +76,7 @@
 #endif
=20
 	/* Set EISA IO port base for Indigo2 */
-	set_io_port_base(KSEG1ADDR(0x00080000));
+	set_io_port_base(CKSEG1ADDR(0x00080000));
=20
 	/* ARCS console environment variable is set to "g?" for
 	 * graphics console, it is set to "d" for the first serial
Index: drivers/net/sgiseeq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/flo/linux-mips-cvs/linux/drivers/net/sgiseeq.c,v
retrieving revision 1.61
diff -u -r1.61 sgiseeq.c
--- drivers/net/sgiseeq.c	31 Jul 2004 01:47:50 -0000	1.61
+++ drivers/net/sgiseeq.c	23 Sep 2004 01:02:06 -0000
@@ -169,7 +169,7 @@
 			buffer =3D (unsigned long) kmalloc(PKT_BUF_SZ, GFP_KERNEL);
 			if (!buffer)
 				return -ENOMEM;
-			sp->tx_desc[i].buf_vaddr =3D KSEG1ADDR(buffer);
+			sp->tx_desc[i].buf_vaddr =3D CKSEG1ADDR(buffer);
 			sp->tx_desc[i].tdma.pbuf =3D CPHYSADDR(buffer);
 		}
 		sp->tx_desc[i].tdma.cntinfo =3D TCNTINFO_INIT;
@@ -183,7 +183,7 @@
 			buffer =3D (unsigned long) kmalloc(PKT_BUF_SZ, GFP_KERNEL);
 			if (!buffer)
 				return -ENOMEM;
-			sp->rx_desc[i].buf_vaddr =3D KSEG1ADDR(buffer);
+			sp->rx_desc[i].buf_vaddr =3D CKSEG1ADDR(buffer);
 			sp->rx_desc[i].rdma.pbuf =3D CPHYSADDR(buffer);
 		}
 		sp->rx_desc[i].rdma.cntinfo =3D RCNTINFO_INIT;
@@ -374,7 +374,7 @@
 	 */
 	while ((td->tdma.cntinfo & (HPCDMA_XIU | HPCDMA_ETXD)) =3D=3D
 	      (HPCDMA_XIU | HPCDMA_ETXD))
-		td =3D (struct sgiseeq_tx_desc *)(long) KSEG1ADDR(td->tdma.pnext);
+		td =3D (struct sgiseeq_tx_desc *)(long) CKSEG1ADDR(td->tdma.pnext);
 	if (td->tdma.cntinfo & HPCDMA_XIU) {
 		hregs->tx_ndptr =3D CPHYSADDR(td);
 		hregs->tx_ctrl =3D HPC3_ETXCTRL_ACTIVE;
@@ -671,11 +671,11 @@
 	sp->mode =3D SEEQ_RCMD_RBCAST;
=20
 	sp->rx_desc =3D (struct sgiseeq_rx_desc *)
-	              KSEG1ADDR(ALIGNED(&sp->srings->rxvector[0]));
+	              CKSEG1ADDR(ALIGNED(&sp->srings->rxvector[0]));
 	dma_cache_wback_inv((unsigned long)&sp->srings->rxvector,
 	                    sizeof(sp->srings->rxvector));
 	sp->tx_desc =3D (struct sgiseeq_tx_desc *)
-	              KSEG1ADDR(ALIGNED(&sp->srings->txvector[0]));
+	              CKSEG1ADDR(ALIGNED(&sp->srings->txvector[0]));
 	dma_cache_wback_inv((unsigned long)&sp->srings->txvector,
 	                    sizeof(sp->srings->txvector));
=20
Index: drivers/video/console/newport_con.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/flo/linux-mips-cvs/linux/drivers/video/console/newport_con.=
c,v
retrieving revision 1.9
diff -u -r1.9 newport_con.c
--- drivers/video/console/newport_con.c	6 Aug 2004 00:33:29 -0000	1.9
+++ drivers/video/console/newport_con.c	23 Sep 2004 01:21:54 -0000
@@ -290,7 +290,7 @@
=20
 	if (!sgi_gfxaddr)
 		return NULL;
-	npregs =3D (struct newport_regs *) (KSEG1 + sgi_gfxaddr);
+	npregs =3D (struct newport_regs *) (CKSEG1ADDR(sgi_gfxaddr));
 	npregs->cset.config =3D NPORT_CFG_GD0;
=20
 	if (newport_wait()) {
Index: include/asm-mips/addrspace.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/flo/linux-mips-cvs/linux/include/asm-mips/addrspace.h,v
retrieving revision 1.13
diff -u -r1.13 addrspace.h
--- include/asm-mips/addrspace.h	30 Nov 2003 01:52:25 -0000	1.13
+++ include/asm-mips/addrspace.h	23 Sep 2004 01:08:48 -0000
@@ -38,16 +38,6 @@
 #endif
=20
 /*
- * Memory segments (32bit kernel mode addresses)
- * These are the traditional names used in the 32-bit universe.
- */
-#define KUSEG			0x00000000
-#define KSEG0			0x80000000
-#define KSEG1			0xa0000000
-#define KSEG2			0xc0000000
-#define KSEG3			0xe0000000
-
-/*
  * Returns the kernel segment base of a given address
  */
 #define KSEGX(a)		((_ACAST32_ (a)) & 0xe0000000)
@@ -58,18 +48,7 @@
 #define CPHYSADDR(a)		((_ACAST32_ (a)) & 0x1fffffff)
 #define XPHYSADDR(a)            ((_ACAST64_ (a)) & 0x000000ffffffffff)
=20
-/*
- * Map an address to a certain kernel segment
- */
-#define KSEG0ADDR(a)		(CPHYSADDR(a) | KSEG0)
-#define KSEG1ADDR(a)		(CPHYSADDR(a) | KSEG1)
-#define KSEG2ADDR(a)		(CPHYSADDR(a) | KSEG2)
-#define KSEG3ADDR(a)		(CPHYSADDR(a) | KSEG3)
-
-#define CKSEG0ADDR(a)		(CPHYSADDR(a) | CKSEG0)
-#define CKSEG1ADDR(a)		(CPHYSADDR(a) | CKSEG1)
-#define CKSEG2ADDR(a)		(CPHYSADDR(a) | CKSEG2)
-#define CKSEG3ADDR(a)		(CPHYSADDR(a) | CKSEG3)
+#ifdef CONFIG_MIPS64
=20
 /*
  * Memory segments (64bit kernel mode addresses)
@@ -85,6 +64,44 @@
 #define CKSSEG			0xffffffffc0000000
 #define CKSEG3			0xffffffffe0000000
=20
+#define CKSEG0ADDR(a)		(CPHYSADDR(a) | CKSEG0)
+#define CKSEG1ADDR(a)		(CPHYSADDR(a) | CKSEG1)
+#define CKSEG2ADDR(a)		(CPHYSADDR(a) | CKSEG2)
+#define CKSEG3ADDR(a)		(CPHYSADDR(a) | CKSEG3)
+
+#else
+
+#define CKSEG0ADDR(a)		(CPHYSADDR(a) | KSEG0)
+#define CKSEG1ADDR(a)		(CPHYSADDR(a) | KSEG1)
+#define CKSEG2ADDR(a)		(CPHYSADDR(a) | KSEG2)
+#define CKSEG3ADDR(a)		(CPHYSADDR(a) | KSEG3)
+
+/*
+ * Map an address to a certain kernel segment
+ */
+#define KSEG0ADDR(a)		(CPHYSADDR(a) | KSEG0)
+#define KSEG1ADDR(a)		(CPHYSADDR(a) | KSEG1)
+#define KSEG2ADDR(a)		(CPHYSADDR(a) | KSEG2)
+#define KSEG3ADDR(a)		(CPHYSADDR(a) | KSEG3)
+
+/*
+ * Memory segments (32bit kernel mode addresses)
+ * These are the traditional names used in the 32-bit universe.
+ */
+#define KUSEG			0x00000000
+#define KSEG0			0x80000000
+#define KSEG1			0xa0000000
+#define KSEG2			0xc0000000
+#define KSEG3			0xe0000000
+
+#define CKUSEG			0x00000000
+#define CKSEG0			0x80000000
+#define CKSEG1			0xa0000000
+#define CKSEG2			0xc0000000
+#define CKSEG3			0xe0000000
+
+#endif
+
 /*
  * Cache modes for XKPHYS address conversion macros
  */
Index: include/asm-mips/r4kcache.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/flo/linux-mips-cvs/linux/include/asm-mips/r4kcache.h,v
retrieving revision 1.22
diff -u -r1.22 r4kcache.h
--- include/asm-mips/r4kcache.h	5 Jan 2004 01:56:01 -0000	1.22
+++ include/asm-mips/r4kcache.h	23 Sep 2004 01:09:47 -0000
@@ -26,7 +26,7 @@
  *  - We need a properly sign extended address for 64-bit code.  To get aw=
ay
  *    without ifdefs we let the compiler do it by a type cast.
  */
-#define INDEX_BASE	((int) KSEG0)
+#define INDEX_BASE	CKSEG0
=20
 #define cache_op(op,addr)						\
 	__asm__ __volatile__(						\
--- include/asm-mips/mach-ip22/spaces.h	2004-09-21 12:59:52.000000000 +0200
+++ include/asm-mips/mach-ip22/spaces.h	2004-09-23 01:52:01.000000000 +0200
@@ -0,0 +1,55 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
+ * Copyright (C) 2000, 2002  Maciej W. Rozycki
+ * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_MACH_SPACES_H
+#define _ASM_MACH_SPACES_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_MIPS32
+
+#define CAC_BASE		0x80000000
+#define IO_BASE			0xa0000000
+#define UNCAC_BASE		0xa0000000
+#define MAP_BASE		0xc0000000
+
+/*
+ * This handles the memory map.
+ * We handle pages at KSEG0 for kernels with 32 bit address space.
+ */
+#define PAGE_OFFSET		0x80000000UL
+
+/*
+ * Memory above this physical address will be considered highmem.
+ */
+#ifndef HIGHMEM_START
+#define HIGHMEM_START		0x20000000UL
+#endif
+
+#endif /* CONFIG_MIPS32 */
+
+#ifdef CONFIG_MIPS64
+#define PAGE_OFFSET	0xffffffff80000000UL
+
+#ifndef HIGHMEM_START
+#define HIGHMEM_START		(1UL << 59UL)
+#endif
+
+#define CAC_BASE		0xffffffff80000000
+#define IO_BASE			0xffffffffa0000000
+#define UNCAC_BASE		0xffffffffa0000000
+#define MAP_BASE		0xffffffffc0000000
+
+#define TO_PHYS(x)		(             ((x) & TO_PHYS_MASK))
+#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
+#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
+
+#endif /* CONFIG_MIPS64 */
+
+#endif /* __ASM_MACH_GENERIC_SPACES_H */

--aM3YZ0Iwxop3KEKx--

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUvBnUaz2rXW+gJcRAsbqAKCdSVO7+Xhu+YJAPtWDwRfpZG/xDQCgy1yA
aPA7HpAa1LEGmfWMrHPgh34=
=GkfN
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
