Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g71FNIRw005213
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 1 Aug 2002 08:23:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g71FNIXE005212
	for linux-mips-outgoing; Thu, 1 Aug 2002 08:23:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g71FMcRw005199;
	Thu, 1 Aug 2002 08:22:40 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA08910;
	Thu, 1 Aug 2002 17:24:43 +0200 (MET DST)
Date: Thu, 1 Aug 2002 17:24:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
In-Reply-To: <20020731223158.A6394@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020801171104.8256E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-9.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 31 Jul 2002, Ralf Baechle wrote:

> I doublechecked the docs for the R4700 as well - just one cycle needed
> between a tlbw and eret.

 After looking at the generated assembly I discovered the handlers don't
fit in 128 bytes.  They didn't crash since I have modules disabled for
now, so the vmalloc path didn't get hit and the user path happened to fit,
but it was pure luck.  The path got hit before I fixed a bug in gas though
-- that's the explanation of the false cache error exceptions I used to
observe. 

 Here is a temporary corrected version I use now.  It works, but
ultimately the chosen handler should get copied somewhere above
KSEG0+0x200.  Also the "non_vmalloc" path looks bogus -- k0 gets loaded
with a random value from (k1) (if it doesn't happen to fault again), k1
retains the pointer and then both get loaded into the TLB -- intriguing... 

 I believe the patch should get applied for now to avoid surprises.  OK?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020726-mips64-tlbex-r4k-2
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips64/mm/tlbex-r4k.S linux-mips-2.4.19-rc1-20020726/arch/mips64/mm/tlbex-r4k.S
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips64/mm/tlbex-r4k.S	2002-07-25 02:57:02.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips64/mm/tlbex-r4k.S	2002-07-31 23:20:21.000000000 +0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2000 Silicon Graphics, Inc.
  * Written by Ulf Carlsson (ulfc@engr.sgi.com)
+ * Copyright (C) 2002  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -22,8 +23,7 @@
 	 * After this macro runs we have a pointer to the pte of the address
 	 * that caused the fault in in PTR.
 	 */
-
-	.macro	LOAD_PTE2, ptr, tmp
+	.macro	LOAD_PTE2, ptr, tmp, kaddr
 #ifdef CONFIG_SMP
 	dmfc0	\ptr, CP0_CONTEXT
 	dmfc0	\tmp, CP0_BADVADDR
@@ -32,8 +32,8 @@
 	dmfc0	\tmp, CP0_BADVADDR
 	dla	\ptr, pgd_current
 #endif
-	bltz	\tmp, kaddr
-	ld	\ptr, (\ptr)
+	bltz	\tmp, \kaddr
+	 ld	\ptr, (\ptr)
 	dsrl	\tmp, (PGDIR_SHIFT-3)		# get pgd offset in bytes
 	andi	\tmp, ((PTRS_PER_PGD - 1)<<3)
 	daddu	\ptr, \tmp			# add in pgd offset
@@ -48,6 +48,35 @@
 	daddu	\ptr, \tmp
 	.endm
 
+
+	/*
+	 * Ditto for the kernel table.
+	 */
+	.macro	LOAD_KPTE2, ptr, tmp, not_vmalloc
+	/*
+	 * First, determine that the address is in/above vmalloc range.
+	 */
+	dmfc0	\tmp, CP0_BADVADDR
+	dli	\ptr, VMALLOC_START
+
+	/*
+	 * Now find offset into kptbl.
+	 */
+	dsubu	\tmp, \tmp, \ptr
+	dla	\ptr, kptbl
+	dsrl	\tmp, (PAGE_SHIFT+1)		# get vpn2
+	dsll	\tmp, 4				# byte offset of pte
+	daddu	\ptr, \ptr, \tmp
+
+	/*
+	 * Determine that fault address is within vmalloc range.
+	 */
+	dla	\tmp, ekptbl
+	sltu	\tmp, \ptr, \tmp
+	beqz	\tmp, \not_vmalloc		# not vmalloc
+	.endm
+	
+
 	/*
 	 * This places the even/odd pte pair in the page table at the pte
 	 * entry pointed to by PTE into ENTRYLO0 and ENTRYLO1.
@@ -59,6 +88,7 @@
 	dmtc0	\pte1, CP0_ENTRYLO1		# load it
 	.endm
 
+
 	.text
 	.set	noreorder
 	.set	mips3
@@ -66,105 +96,93 @@
 	__INIT
 
 	.align	5
-FEXPORT(except_vec0)
+LEAF(except_vec0)
 	.set	noat
 	PANIC("Unused vector called")
 1:	b	1b
 	 nop
+END(except_vec0)
 
+
+	/*
+	 * TLB refill handler for the R4000.
+	 * Attention:  We may only use 32 instructions / 128 bytes.
+	 */
 	.align  5
 LEAF(except_vec1_r4k)
 	.set    noat
-	dla     k1, pgd_current
-	dmfc0   k0, CP0_BADVADDR
-	ld      k1, (k1)
-	bltz    k0, vmaddr
-	 dsrl   k0, (PGDIR_SHIFT-3)             # get pgd offset in bytes
-	andi    k0, ((PTRS_PER_PGD - 1)<<3)
-	daddu   k1, k0                          # add in pgd offset
-	dmfc0   k0, CP0_BADVADDR
-	ld      k1, (k1)                        # get pmd pointer
-	dsrl    k0, (PMD_SHIFT-3)               # get pmd offset in bytes
-	andi    k0, ((PTRS_PER_PMD - 1)<<3)
-	daddu   k1, k0                          # add in pmd offset
-	dmfc0   k0, CP0_XCONTEXT
-	andi    k0, 0xff0                       # get pte offset
-	ld      k1, (k1)                        # get pte pointer
-	daddu   k1, k0
-	ld      k0, 0(k1)                       # get even pte
-	ld      k1, 8(k1)                       # get odd pte
-	dsrl    k0, 6                           # convert to entrylo0
-	dmtc0   k0, CP0_ENTRYLO0                # load it
-	dsrl    k1, 6                           # convert to entrylo1
-	dmtc0   k1, CP0_ENTRYLO1                # load it
-	nop                                     # Need 2 cycles between mtc0
-	nop                                     #  and tlbwr (CP0 hazard).
-	tlbwr
-	nop
-	eret
-vmaddr:
-	dla     k0, handle_vmalloc_address
+	dla     k0, handle_vec1_r4k
 	jr      k0
 	 nop
 END(except_vec1_r4k)
-	
+
+	__FINIT
+
+	.align  5
+LEAF(handle_vec1_r4k)
+	.set    noat
+	LOAD_PTE2 k1 k0 9f
+	ld	k0, 0(k1)			# get even pte
+	ld	k1, 8(k1)			# get odd pte
+	PTE_RELOAD k0 k1
+	b	1f
+	 tlbwr
+1:	nop
+	eret
+
+9:						# handle the vmalloc range
+	LOAD_KPTE2 k1 k0 invalid_vmalloc_address
+	ld	k0, 0(k1)			# get even pte
+	ld	k1, 8(k1)			# get odd pte
+	PTE_RELOAD k0 k1
+	b	1f
+	 tlbwr
+1:	nop
+	eret
+END(handle_vec1_r4k)
+
+	__INIT
+
 	/*
 	 * TLB refill handler for the R10000.
 	 * Attention:  We may only use 32 instructions / 128 bytes.
 	 */
-
 	.align	5
 LEAF(except_vec1_r10k)
+	.set    noat
+	dla     k0, handle_vec1_r10k
+	jr      k0
+	 nop
+END(except_vec1_r10k)
+
+	__FINIT
+
+	.align	5
+LEAF(handle_vec1_r10k)
 	.set	noat
-	LOAD_PTE2 k1 k0
+	LOAD_PTE2 k1 k0 9f
 	ld	k0, 0(k1)			# get even pte
 	ld	k1, 8(k1)			# get odd pte
 	PTE_RELOAD k0 k1
 	nop
 	tlbwr
 	eret
-kaddr:
-	dla	k0, handle_vmalloc_address	# MAPPED kernel needs this
-	jr	k0
-	 nop
-	END(except_vec1_r10k)
-
-	__FINIT
 
-	.align	5
-LEAF(handle_vmalloc_address)
-	.set	noat
-	/*
-	 * First, determine that the address is in/above vmalloc range.
-	 */
-	dmfc0	k0, CP0_BADVADDR
-	dli	k1, VMALLOC_START
-
-	/*
-	 * Now find offset into kptbl.
-	 */
-	dsubu	k0, k0, k1
-	dla	k1, kptbl
-	dsrl	k0, (PAGE_SHIFT+1)		# get vpn2
-	dsll	k0, 4				# byte offset of pte
-	daddu	k1, k1, k0
-
-	/*
-	 * Determine that fault address is within vmalloc range.
-	 */
-	dla	k0, ekptbl
-	sltu	k0, k1, k0
-	beqz	k0, not_vmalloc
-
-	/*
-	 * Load cp0 registers.
-	 */
+9:						# handle the vmalloc range
+	LOAD_KPTE2 k1 k0 invalid_vmalloc_address
 	ld	k0, 0(k1)			# get even pte
 	ld	k1, 8(k1)			# get odd pte
-
-not_vmalloc:
 	PTE_RELOAD k0 k1
 	nop
 	tlbwr
 	eret
-	END(handle_vmalloc_address)
+END(handle_vec1_r10k)
+
+
+	.align	5
+LEAF(invalid_vmalloc_address)
+	.set	noat
+	PANIC("Invalid kernel address")
+1:	b	1b
+	 nop
+END(invalid_vmalloc_address)
