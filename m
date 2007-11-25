Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 22:42:21 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:49638 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28573742AbXKZWkS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2007 22:40:18 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Iwmch-0006QN-05; Mon, 26 Nov 2007 23:40:15 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 9BAAAC2B26; Mon, 26 Nov 2007 23:39:55 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Date:	Sun, 25 Nov 2007 11:47:56 +0100
Subject: [PATCH] IP28: added cache barrier to assembly routines
Message-Id: <20071126223955.9BAAAC2B26@solo.franken.de>
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

IP28 needs special treatment to avoid speculative accesses. gcc
takes care for .c code, but for assembly code we need to do it
manually.

This is taken from Peter Fuersts IP28 patches.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/lib/memcpy.S       |   10 ++++++++++
 arch/mips/lib/memset.S       |    5 +++++
 arch/mips/lib/strncpy_user.S |    1 +
 include/asm-mips/asm.h       |    8 ++++++++
 4 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index a526c62..054399d 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -194,6 +194,7 @@ FEXPORT(__copy_user)
 	 */
 #define rem t8
 
+	R10KCBARRIER(0(ra))
 	/*
 	 * The "issue break"s below are very approximate.
 	 * Issue delays for dcache fills will perturb the schedule, as will
@@ -226,6 +227,7 @@ both_aligned:
 	PREF(	1, 3*32(dst) )
 	.align	4
 1:
+	R10KCBARRIER(0(ra))
 EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
 EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
 EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
@@ -267,6 +269,7 @@ EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
 EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
 	SUB	len, len, 4*NBYTES
 	ADD	src, src, 4*NBYTES
+	R10KCBARRIER(0(ra))
 EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p4u)
 EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
 EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
@@ -280,6 +283,7 @@ less_than_4units:
 	beq	rem, len, copy_bytes
 	 nop
 1:
+	R10KCBARRIER(0(ra))
 EXC(	LOAD	t0, 0(src),		l_exc)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
@@ -325,6 +329,7 @@ EXC(	LDFIRST	t3, FIRST(0)(src),	l_exc)
 EXC(	LDREST	t3, REST(0)(src),	l_exc_copy)
 	SUB	t2, t2, t1	# t2 = number of bytes copied
 	xor	match, t0, t1
+	R10KCBARRIER(0(ra))
 EXC(	STFIRST t3, FIRST(0)(dst),	s_exc)
 	beq	len, t2, done
 	 SUB	len, len, t2
@@ -345,6 +350,7 @@ src_unaligned_dst_aligned:
  * It's OK to load FIRST(N+1) before REST(N) because the two addresses
  * are to the same unit (unless src is aligned, but it's not).
  */
+	R10KCBARRIER(0(ra))
 EXC(	LDFIRST	t0, FIRST(0)(src),	l_exc)
 EXC(	LDFIRST	t1, FIRST(1)(src),	l_exc_copy)
 	SUB     len, len, 4*NBYTES
@@ -373,6 +379,7 @@ cleanup_src_unaligned:
 	beq	rem, len, copy_bytes
 	 nop
 1:
+	R10KCBARRIER(0(ra))
 EXC(	LDFIRST t0, FIRST(0)(src),	l_exc)
 EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)
 	ADD	src, src, NBYTES
@@ -386,6 +393,7 @@ copy_bytes_checklen:
 	 nop
 copy_bytes:
 	/* 0 < len < NBYTES  */
+	R10KCBARRIER(0(ra))
 #define COPY_BYTE(N)			\
 EXC(	lb	t0, N(src), l_exc);	\
 	SUB	len, len, 1;		\
@@ -498,6 +506,7 @@ LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
 	ADD	a1, a2				# src = src + len
 
 r_end_bytes:
+	R10KCBARRIER(0(ra))
 	lb	t0, -1(a1)
 	SUB	a2, a2, 0x1
 	sb	t0, -1(a0)
@@ -510,6 +519,7 @@ r_out:
 	 move	a2, zero
 
 r_end_bytes_up:
+	R10KCBARRIER(0(ra))
 	lb	t0, (a1)
 	SUB	a2, a2, 0x1
 	sb	t0, (a0)
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 3f8b8b3..aad0639 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -77,6 +77,7 @@ FEXPORT(__bzero)
 	beqz		t0, 1f
 	 PTR_SUBU	t0, LONGSIZE		/* alignment in bytes */
 
+	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(LONG_S_L, a1, (a0), first_fixup)	/* make word/dword aligned */
 #endif
@@ -94,11 +95,13 @@ FEXPORT(__bzero)
 	PTR_ADDU	t1, a0			/* end address */
 	.set		reorder
 1:	PTR_ADDIU	a0, 64
+	R10KCBARRIER(0(ra))
 	f_fill64 a0, -64, a1, fwd_fixup
 	bne		t1, a0, 1b
 	.set		noreorder
 
 memset_partial:
+	R10KCBARRIER(0(ra))
 	PTR_LA		t1, 2f			/* where to start */
 #if LONGSIZE == 4
 	PTR_SUBU	t1, t0
@@ -120,6 +123,7 @@ memset_partial:
 
 	beqz		a2, 1f
 	 PTR_ADDU	a0, a2			/* What's left */
+	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(LONG_S_R, a1, -1(a0), last_fixup)
 #endif
@@ -134,6 +138,7 @@ small_memset:
 	 PTR_ADDU	t1, a0, a2
 
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
+	R10KCBARRIER(0(ra))
 	bne		t1, a0, 1b
 	 sb		a1, -1(a0)
 
diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index d16c76f..8fd21d5 100644
--- a/arch/mips/lib/strncpy_user.S
+++ b/arch/mips/lib/strncpy_user.S
@@ -38,6 +38,7 @@ FEXPORT(__strncpy_from_user_nocheck_asm)
 	.set		noreorder
 1:	EX(lbu, t0, (v1), fault)
 	PTR_ADDIU	v1, 1
+	R10KCBARRIER(0(ra))
 	beqz		t0, 2f
 	 sb		t0, (a0)
 	PTR_ADDIU	v0, 1
diff --git a/include/asm-mips/asm.h b/include/asm-mips/asm.h
index 12e1758..608cfcf 100644
--- a/include/asm-mips/asm.h
+++ b/include/asm-mips/asm.h
@@ -398,4 +398,12 @@ symbol		=	value
 
 #define SSNOP		sll zero, zero, 1
 
+#ifdef CONFIG_SGI_IP28
+/* Inhibit speculative stores to volatile (e.g.DMA) or invalid addresses. */
+#include <asm/cacheops.h>
+#define R10KCBARRIER(addr)  cache   Cache_Barrier, addr;
+#else
+#define R10KCBARRIER(addr)
+#endif
+
 #endif /* __ASM_ASM_H */
-- 
1.4.4.4
