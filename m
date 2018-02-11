Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2018 08:29:36 +0100 (CET)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:57940 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeBKH33dgBZs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2018 08:29:29 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 6E5013F5E1;
        Sun, 11 Feb 2018 08:29:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kv1QlF4FEokd; Sun, 11 Feb 2018 08:29:17 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id CB2123F5D0;
        Sun, 11 Feb 2018 08:29:11 +0100 (CET)
Date:   Sun, 11 Feb 2018 08:29:10 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Cc:     linux-mips@linux-mips.org
Subject: [RFC] MIPS: R5900: Workaround for the short loop bug
Message-ID: <20180211072908.GA2222@localhost.localdomain>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The short loop bug under certain conditions causes loops to execute
only once or twice. GCC 2.95 that shipped with Sony PS2 Linux had a
patch with the following note:

    On the R5900, we must ensure that the compiler never generates
    loops that satisfy all of the following conditions:

    - a loop consists of less than equal to six instructions
      (including the branch delay slot);
    - a loop contains only one conditional branch instruction at
      the end of the loop;
    - a loop does not contain any other branch or jump instructions;
    - a branch delay slot of the loop is not NOP (EE 2.9 or later).

    We need to do this because of a bug in the chip.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
The exact NOP placements in this patch are provisional. Request for comment
on the method to use. I believe there are at least three alternatives:

1. Add #ifdefs or macros in the source code (similar to this patch).
2. Modify the assembler to automatically insert NOPs as required.
3. Avoid assembly and use C versions of memcpy etc. instead.

This change has been ported from v2.6 patches.

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 7f12d7e27c94..9659fb55abd2 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -37,6 +37,12 @@ extern void (*r4k_blast_icache)(void);
  *    without ifdefs we let the compiler do it by a type cast.
  */
 #define INDEX_BASE	CKSEG0
+#ifdef CONFIG_CPU_R5900
+/* Workaround for short loops on R5900. */
+#define R5900_LOOP_WAR() do { __asm__ __volatile__("nop;nop;\n"); } while(0)
+#else
+#define R5900_LOOP_WAR() do { } while(0)
+#endif
 
 #define cache_op(op,addr)						\
 	__asm__ __volatile__(						\
@@ -689,6 +695,7 @@ static inline void prot##extra##blast_##pfx##cache##_range(unsigned long start,
 									\
 	while (1) {							\
 		prot##cache_op(hitop, addr);				\
+		R5900_LOOP_WAR();  /* FIXME: Is this needed in C? */	\
 		if (addr == aend)					\
 			break;						\
 		addr += lsize;						\
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 03e3304d6ae5..713015f6faa2 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -339,6 +339,12 @@
 	STORE(t1, UNIT(-1)(dst), .Ls_exc_p1u\@)
 	PREFS(	0, 8*32(src) )
 	PREFD(	1, 8*32(dst) )
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	bne	len, rem, 1b
 	 nop
 
@@ -382,6 +388,12 @@
 	STORE(t0, 0(dst), .Ls_exc_p1u\@)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	bne	rem, len, 1b
 	.set	noreorder
 
@@ -467,6 +479,12 @@
 	PREFD(	1, 9*32(dst) )		# 1 is PREF_STORE (not streamed)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	bne	len, rem, 1b
 	.set	noreorder
 
@@ -484,6 +502,12 @@
 	STORE(t0, 0(dst), .Ls_exc_p1u\@)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, NBYTES
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	bne	len, rem, 1b
 	.set	noreorder
 
@@ -528,6 +552,12 @@
 	COPY_BYTE(6)
 	COPY_BYTE(7)
 	ADD	src, src, 8
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	b	1b
 	 ADD	dst, dst, 8
 #endif /* CONFIG_CPU_MIPSR6 */
@@ -557,6 +587,12 @@
 	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 1
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	bne	src, t0, 1b
 	.set	noreorder
 .Ll_exc\@:
@@ -623,6 +659,12 @@ LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
 	SUB	a1, a1, 0x1
 	.set	reorder				/* DADDI_WAR */
 	SUB	a0, a0, 0x1
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	bnez	a2, .Lr_end_bytes
 	.set	noreorder
 
@@ -638,6 +680,12 @@ LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
 	ADD	a1, a1, 0x1
 	.set	reorder				/* DADDI_WAR */
 	ADD	a0, a0, 0x1
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	bnez	a2, .Lr_end_bytes_up
 	.set	noreorder
 
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index a1456664d6c2..489bc9cffcbd 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -156,6 +156,12 @@
 1:	PTR_ADDIU	a0, 64
 	R10KCBARRIER(0(ra))
 	f_fill64 a0, -64, FILL64RG, .Lfwd_fixup\@, \mode
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	bne		t1, a0, 1b
 	.set		noreorder
 
@@ -218,6 +224,12 @@
 
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	bne		t1, a0, 1b
 	sb		a1, -1(a0)
 
diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index acdff66bd5d2..44cc346fd400 100644
--- a/arch/mips/lib/strncpy_user.S
+++ b/arch/mips/lib/strncpy_user.S
@@ -48,6 +48,10 @@ LEAF(__strncpy_from_\func\()_asm)
 	beqz		v0, 2f
 	PTR_ADDIU	t0, 1
 	PTR_ADDIU	a0, 1
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+#endif
 	bne		t0, a2, 1b
 2:	PTR_ADDU	v0, a1, t0
 	xor		v0, a1
diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
index e1bacf5a3abe..474979641a8d 100644
--- a/arch/mips/lib/strnlen_user.S
+++ b/arch/mips/lib/strnlen_user.S
@@ -46,6 +46,12 @@ LEAF(__strnlen_\func\()_asm)
 	EX(lbe, t0, (v0), .Lfault\@)
 .endif
 	.set		noreorder
+#ifdef CONFIG_CPU_R5900
+	/* No short loops. */
+	nop
+	nop
+	nop
+#endif
 	bnez		t0, 1b
 1:
 #ifndef CONFIG_CPU_DADDI_WORKAROUNDS
