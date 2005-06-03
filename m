Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2005 11:22:05 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:47255 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8226147AbVFCKVt>;
	Fri, 3 Jun 2005 11:21:49 +0100
Received: from port-195-158-167-89.dynamic.qsc.de ([195.158.167.89] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1De9J6-0000ck-00; Fri, 03 Jun 2005 12:21:40 +0200
Received: from ths by hattusa.textio with local (Exim 4.50)
	id 1De9J6-00024Y-L0; Fri, 03 Jun 2005 12:21:40 +0200
Date:	Fri, 3 Jun 2005 12:21:40 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050603102140.GA1610@hattusa.textio>
References: <20050603022113Z8226140-1340+8064@linux-mips.org> <20050603092205.GA4573@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603092205.GA4573@linux-mips.org>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Jun 03, 2005 at 03:21:13AM +0100, ths@linux-mips.org wrote:
> 
> > Log message:
> > 	Fix R4[04]00 hazards breakage.
> > 
> > diff -urN linux/arch/mips/mm/tlbex-r4k.S linux/arch/mips/mm/tlbex-r4k.S
> > --- linux/arch/mips/mm/Attic/tlbex-r4k.S	2004/11/25 22:18:38	1.2.2.19
> > +++ linux/arch/mips/mm/Attic/tlbex-r4k.S	2005/06/03 02:21:06	1.2.2.20
> > @@ -186,6 +186,7 @@
> >  	P_MTC0	k1, CP0_ENTRYLO1		# load it
> >  	mtc0_tlbw_hazard
> >  	tlbwr					# write random tlb entry
> > +	nop
> >  	tlbw_eret_hazard
> 
> I did previously object to a similar patch

I didn't know that, IIRC a similiar patch went in 2.6 before the synthesized
TLB handlers were done.

> - why not fix tlbw_eret_hazard instead.

Like this?


Thiemo


Index: arch/mips/mm/tlbex-r4k.S
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/Attic/tlbex-r4k.S,v
retrieving revision 1.2.2.20
diff -u -p -r1.2.2.20 tlbex-r4k.S
--- arch/mips/mm/tlbex-r4k.S	3 Jun 2005 02:21:06 -0000	1.2.2.20
+++ arch/mips/mm/tlbex-r4k.S	3 Jun 2005 10:16:28 -0000
@@ -186,7 +186,6 @@
 	P_MTC0	k1, CP0_ENTRYLO1		# load it
 	mtc0_tlbw_hazard
 	tlbwr					# write random tlb entry
-	nop
 	tlbw_eret_hazard
 	eret
 	END(except_vec0_r4000)
@@ -468,7 +467,6 @@ invalid_tlbl:
 	PTE_RELOAD(k1, k0)
 	mtc0_tlbw_hazard
 	tlbwi
-	nop
 	tlbw_eret_hazard
 	.set	mips3
 	eret
@@ -493,7 +491,6 @@ nopage_tlbl:
 	PTE_RELOAD(k1, k0)
 	mtc0_tlbw_hazard
 	tlbwi
-	nop
 	tlbw_eret_hazard
 	.set	mips3
 	eret
@@ -523,7 +520,6 @@ nopage_tlbs:
 	PTE_RELOAD(k1, k0)
 	mtc0_tlbw_hazard
 	tlbwi
-	nop
 	tlbw_eret_hazard
 	.set	mips3
 	eret
Index: arch/mips64/mm/tlbex-r4k.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/Attic/tlbex-r4k.S,v
retrieving revision 1.1.2.20
diff -u -p -r1.1.2.20 tlbex-r4k.S
--- arch/mips64/mm/tlbex-r4k.S	3 Jun 2005 02:21:07 -0000	1.1.2.20
+++ arch/mips64/mm/tlbex-r4k.S	3 Jun 2005 10:16:28 -0000
@@ -125,6 +125,33 @@ LEAF(except_vec1_r4k)
 	 nop
 END(except_vec1_r4k)
 
+	__FINIT
+
+	.align  5
+LEAF(handle_vec1_r4k)
+	.set    noat
+	LOAD_PTE2 k1 k0 9f
+	ld	k0, 0(k1)			# get even pte
+	ld	k1, 8(k1)			# get odd pte
+	PTE_RELOAD k0 k1
+	mtc0_tlbw_hazard
+	tlbwr
+	tlbw_eret_hazard
+	eret
+
+9:						# handle the vmalloc range
+	LOAD_KPTE2 k1 k0 invalid_vmalloc_address
+	ld	k0, 0(k1)			# get even pte
+	ld	k1, 8(k1)			# get odd pte
+	PTE_RELOAD k0 k1
+	mtc0_tlbw_hazard
+	tlbwr
+	tlbw_eret_hazard
+	eret
+END(handle_vec1_r4k)
+
+	__INIT
+
 LEAF(except_vec1_sb1)
 #if BCM1250_M3_WAR
 	dmfc0	k0, CP0_BADVADDR
@@ -134,18 +161,17 @@ LEAF(except_vec1_sb1)
 	bnez	k0, 1f
 #endif
 	.set    noat
-	dla     k0, handle_vec1_r4k
+	dla     k0, handle_vec1_sb1
 	jr      k0
 	 nop
 
 1:	eret
-	nop
 END(except_vec1_sb1)
 
 	__FINIT
 
 	.align  5
-LEAF(handle_vec1_r4k)
+LEAF(handle_vec1_sb1)
 	.set    noat
 	LOAD_PTE2 k1 k0 9f
 	ld	k0, 0(k1)			# get even pte
@@ -153,7 +179,6 @@ LEAF(handle_vec1_r4k)
 	PTE_RELOAD k0 k1
 	mtc0_tlbw_hazard
 	tlbwr
-1:	tlbw_eret_hazard
 	eret
 
 9:						# handle the vmalloc range
@@ -163,10 +188,8 @@ LEAF(handle_vec1_r4k)
 	PTE_RELOAD k0 k1
 	mtc0_tlbw_hazard
 	tlbwr
-	nop
-1:	tlbw_eret_hazard
 	eret
-END(handle_vec1_r4k)
+END(handle_vec1_sb1)
 
 
 	__INIT
@@ -194,7 +217,6 @@ LEAF(handle_vec1_r10k)
 	PTE_RELOAD k0 k1
 	mtc0_tlbw_hazard
 	tlbwr
-	tlbw_eret_hazard
 	eret
 
 9:						# handle the vmalloc range
@@ -204,7 +226,6 @@ LEAF(handle_vec1_r10k)
 	PTE_RELOAD k0 k1
 	mtc0_tlbw_hazard
 	tlbwr
-	tlbw_eret_hazard
 	eret
 END(handle_vec1_r10k)
 
Index: include/asm-mips/hazards.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/hazards.h,v
retrieving revision 1.1.2.3
diff -u -p -r1.1.2.3 hazards.h
--- include/asm-mips/hazards.h	3 Jun 2005 02:21:07 -0000	1.1.2.3
+++ include/asm-mips/hazards.h	3 Jun 2005 10:16:28 -0000
@@ -46,6 +46,7 @@
 #define mtc0_tlbw_hazard						\
 	b	. + 8
 #define tlbw_eret_hazard
+	nop
 #endif
 
 /*
Index: include/asm-mips64/hazards.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/Attic/hazards.h,v
retrieving revision 1.1.2.3
diff -u -p -r1.1.2.3 hazards.h
--- include/asm-mips64/hazards.h	3 Jun 2005 02:21:07 -0000	1.1.2.3
+++ include/asm-mips64/hazards.h	3 Jun 2005 10:16:28 -0000
@@ -46,6 +46,7 @@
 #define mtc0_tlbw_hazard						\
 	b	. + 8
 #define tlbw_eret_hazard
+	nop
 #endif
 
 /*
