Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:20:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54765 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992096AbcKGLTH6Na7d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:19:07 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 90FA164631B61;
        Mon,  7 Nov 2016 11:18:58 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:19:00 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/7] MIPS: memcpy: Split __copy_user & memcpy
Date:   Mon, 7 Nov 2016 11:17:58 +0000
Message-ID: <20161107111802.12071-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111802.12071-1-paul.burton@imgtec.com>
References: <20161107111802.12071-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Up until now we have shared the same code for __copy_user() & memcpy(),
but this has the drawback that we use a non-standard ABI for __copy_user
and thus need to call it via inline assembly rather than a simple
function call. In order to allow for further patches to change this,
split the __copy_user() & memcpy() functions.

The resulting implementations of __copy_user() & memcpy() should differ
only in the existing difference of return value and that memcpy()
doesn't generate entries in the exception table or include exception
fixup code.

For octeon this involves introducing the __BUILD_COPY_USER macro &
renaming labels to remain unique, making the code match the non-octeon
memcpy implementation more closely.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/cavium-octeon/octeon-memcpy.S | 141 +++++++++++++++++++-------------
 arch/mips/lib/memcpy.S                  |  74 ++++++++++-------
 2 files changed, 131 insertions(+), 84 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 4336316..944f8f5 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -18,6 +18,9 @@
 #include <asm/export.h>
 #include <asm/regdef.h>
 
+#define MEMCPY_MODE	1
+#define USER_COPY_MODE	2
+
 #define dst a0
 #define src a1
 #define len a2
@@ -70,9 +73,11 @@
 
 #define EXC(inst_reg,addr,handler)		\
 9:	inst_reg, addr;				\
-	.section __ex_table,"a";		\
-	PTR	9b, handler;			\
-	.previous
+	.if	\mode != MEMCPY_MODE;		\
+		.section __ex_table,"a";	\
+		PTR	9b, handler;		\
+		.previous;			\
+	.endif
 
 /*
  * Only on the 64-bit kernel we can made use of 64-bit registers.
@@ -136,30 +141,7 @@
 	.set	noreorder
 	.set	noat
 
-/*
- * t7 is used as a flag to note inatomic mode.
- */
-LEAF(__copy_user_inatomic)
-EXPORT_SYMBOL(__copy_user_inatomic)
-	b	__copy_user_common
-	 li	t7, 1
-	END(__copy_user_inatomic)
-
-/*
- * A combined memcpy/__copy_user
- * __copy_user sets len to 0 for success; else to an upper bound of
- * the number of uncopied bytes.
- * memcpy sets v0 to dst.
- */
-	.align	5
-LEAF(memcpy)					/* a0=dst a1=src a2=len */
-EXPORT_SYMBOL(memcpy)
-	move	v0, dst				/* return value */
-__memcpy:
-FEXPORT(__copy_user)
-EXPORT_SYMBOL(__copy_user)
-	li	t7, 0				/* not inatomic */
-__copy_user_common:
+	.macro __BUILD_COPY_USER mode
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
 	 * Temps
@@ -170,15 +152,15 @@ __copy_user_common:
 	#
 	pref	0, 0(src)
 	sltu	t0, len, NBYTES		# Check if < 1 word
-	bnez	t0, copy_bytes_checklen
+	bnez	t0, .Lcopy_bytes_checklen\@
 	 and	t0, src, ADDRMASK	# Check if src unaligned
-	bnez	t0, src_unaligned
+	bnez	t0, .Lsrc_unaligned\@
 	 sltu	t0, len, 4*NBYTES	# Check if < 4 words
-	bnez	t0, less_than_4units
+	bnez	t0, .Lless_than_4units\@
 	 sltu	t0, len, 8*NBYTES	# Check if < 8 words
-	bnez	t0, less_than_8units
+	bnez	t0, .Lless_than_8units\@
 	 sltu	t0, len, 16*NBYTES	# Check if < 16 words
-	bnez	t0, cleanup_both_aligned
+	bnez	t0, .Lcleanup_both_aligned\@
 	 sltu	t0, len, 128+1		# Check if len < 129
 	bnez	t0, 1f			# Skip prefetch if len is too short
 	 sltu	t0, len, 256+1		# Check if len < 257
@@ -233,10 +215,10 @@ EXC(	STORE	t3, UNIT(-1)(dst),	s_exc_p1u)
 	#
 	# Jump here if there are less than 16*NBYTES left.
 	#
-cleanup_both_aligned:
-	beqz	len, done
+.Lcleanup_both_aligned\@:
+	beqz	len, .Ldone\@
 	 sltu	t0, len, 8*NBYTES
-	bnez	t0, less_than_8units
+	bnez	t0, .Lless_than_8units\@
 	 nop
 EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
 EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
@@ -256,14 +238,14 @@ EXC(	STORE	t1, UNIT(5)(dst),	s_exc_p3u)
 EXC(	STORE	t2, UNIT(6)(dst),	s_exc_p2u)
 EXC(	STORE	t3, UNIT(7)(dst),	s_exc_p1u)
 	ADD	src, src, 8*NBYTES
-	beqz	len, done
+	beqz	len, .Ldone\@
 	 ADD	dst, dst, 8*NBYTES
 	#
 	# Jump here if there are less than 8*NBYTES left.
 	#
-less_than_8units:
+.Lless_than_8units\@:
 	sltu	t0, len, 4*NBYTES
-	bnez	t0, less_than_4units
+	bnez	t0, .Lless_than_4units\@
 	 nop
 EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
 EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
@@ -275,15 +257,15 @@ EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
 EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
 EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p1u)
 	ADD	src, src, 4*NBYTES
-	beqz	len, done
+	beqz	len, .Ldone\@
 	 ADD	dst, dst, 4*NBYTES
 	#
 	# Jump here if there are less than 4*NBYTES left. This means
 	# we may need to copy up to 3 NBYTES words.
 	#
-less_than_4units:
+.Lless_than_4units\@:
 	sltu	t0, len, 1*NBYTES
-	bnez	t0, copy_bytes_checklen
+	bnez	t0, .Lcopy_bytes_checklen\@
 	 nop
 	#
 	# 1) Copy NBYTES, then check length again
@@ -293,7 +275,7 @@ EXC(	LOAD	t0, 0(src),		l_exc)
 	sltu	t1, len, 8
 EXC(	STORE	t0, 0(dst),		s_exc_p1u)
 	ADD	src, src, NBYTES
-	bnez	t1, copy_bytes_checklen
+	bnez	t1, .Lcopy_bytes_checklen\@
 	 ADD	dst, dst, NBYTES
 	#
 	# 2) Copy NBYTES, then check length again
@@ -303,7 +285,7 @@ EXC(	LOAD	t0, 0(src),		l_exc)
 	sltu	t1, len, 8
 EXC(	STORE	t0, 0(dst),		s_exc_p1u)
 	ADD	src, src, NBYTES
-	bnez	t1, copy_bytes_checklen
+	bnez	t1, .Lcopy_bytes_checklen\@
 	 ADD	dst, dst, NBYTES
 	#
 	# 3) Copy NBYTES, then check length again
@@ -312,13 +294,13 @@ EXC(	LOAD	t0, 0(src),		l_exc)
 	SUB	len, len, NBYTES
 	ADD	src, src, NBYTES
 	ADD	dst, dst, NBYTES
-	b copy_bytes_checklen
+	b .Lcopy_bytes_checklen\@
 EXC(	 STORE	t0, -8(dst),		s_exc_p1u)
 
-src_unaligned:
+.Lsrc_unaligned\@:
 #define rem t8
 	SRL	t0, len, LOG_NBYTES+2	 # +2 for 4 units/iter
-	beqz	t0, cleanup_src_unaligned
+	beqz	t0, .Lcleanup_src_unaligned\@
 	 and	rem, len, (4*NBYTES-1)	 # rem = len % 4*NBYTES
 1:
 /*
@@ -344,10 +326,10 @@ EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p1u)
 	bne	len, rem, 1b
 	 ADD	dst, dst, 4*NBYTES
 
-cleanup_src_unaligned:
-	beqz	len, done
+.Lcleanup_src_unaligned\@:
+	beqz	len, .Ldone\@
 	 and	rem, len, NBYTES-1  # rem = len % NBYTES
-	beq	rem, len, copy_bytes
+	beq	rem, len, .Lcopy_bytes\@
 	 nop
 1:
 EXC(	LDFIRST t0, FIRST(0)(src),	l_exc)
@@ -358,15 +340,15 @@ EXC(	STORE	t0, 0(dst),		s_exc_p1u)
 	bne	len, rem, 1b
 	 ADD	dst, dst, NBYTES
 
-copy_bytes_checklen:
-	beqz	len, done
+.Lcopy_bytes_checklen\@:
+	beqz	len, .Ldone\@
 	 nop
-copy_bytes:
+.Lcopy_bytes\@:
 	/* 0 < len < NBYTES  */
 #define COPY_BYTE(N)			\
 EXC(	lb	t0, N(src), l_exc);	\
 	SUB	len, len, 1;		\
-	beqz	len, done;		\
+	beqz	len, .Ldone\@;		\
 EXC(	 sb	t0, N(dst), s_exc_p1)
 
 	COPY_BYTE(0)
@@ -379,10 +361,12 @@ EXC(	lb	t0, NBYTES-2(src), l_exc)
 	SUB	len, len, 1
 	jr	ra
 EXC(	 sb	t0, NBYTES-2(dst), s_exc_p1)
-done:
+.Ldone\@:
 	jr	ra
 	 nop
-	END(memcpy)
+
+	/* memcpy shouldn't generate exceptions */
+	.if \mode != MEMCPY_MODE
 
 l_exc_copy:
 	/*
@@ -419,7 +403,7 @@ l_exc:
 	 * Clear len bytes starting at dst.  Can't call __bzero because it
 	 * might modify len.  An inefficient loop for these rare times...
 	 */
-	beqz	len, done
+	beqz	len, .Ldone\@
 	 SUB	src, len, 1
 1:	sb	zero, 0(dst)
 	ADD	dst, dst, 1
@@ -457,3 +441,48 @@ s_exc_p1:
 s_exc:
 	jr	ra
 	 nop
+	.endif	/* \mode != MEMCPY_MODE */
+	.endm
+
+/*
+ * memcpy() - Copy memory
+ * @a0 - destination
+ * @a1 - source
+ * @a2 - length
+ *
+ * Copy @a2 bytes of memory from @a1 to @a0.
+ *
+ * Returns: the destination pointer
+ */
+	.align	5
+LEAF(memcpy)					/* a0=dst a1=src a2=len */
+EXPORT_SYMBOL(memcpy)
+	move	v0, dst				/* return value */
+	__BUILD_COPY_USER MEMCPY_MODE
+	END(memcpy)
+
+/*
+ * __copy_user() - Copy memory
+ * @a0 - destination
+ * @a1 - source
+ * @a2 - length
+ *
+ * Copy @a2 bytes of memory from @a1 to @a0.
+ *
+ * Returns: the number of uncopied bytes in @a2
+ */
+LEAF(__copy_user)
+EXPORT_SYMBOL(__copy_user)
+	li	t7, 0				/* not inatomic */
+__copy_user_common:
+	__BUILD_COPY_USER COPY_USER_MODE
+	END(__copy_user)
+
+/*
+ * t7 is used as a flag to note inatomic mode.
+ */
+LEAF(__copy_user_inatomic)
+EXPORT_SYMBOL(__copy_user_inatomic)
+	b	__copy_user_common
+	 li	t7, 1
+	END(__copy_user_inatomic)
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index b8d34d9..bfbe23c 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -92,6 +92,7 @@
 #define DST_PREFETCH 2
 #define LEGACY_MODE 1
 #define EVA_MODE    2
+#define MEMCPY_MODE 3
 #define USEROP   1
 #define KERNELOP 2
 
@@ -107,7 +108,9 @@
  */
 
 #define EXC(insn, type, reg, addr, handler)			\
-	.if \mode == LEGACY_MODE;				\
+	.if \mode == MEMCPY_MODE;				\
+		insn reg, addr;					\
+	.elseif \mode == LEGACY_MODE;				\
 9:		insn reg, addr;					\
 		.section __ex_table,"a";			\
 		PTR	9b, handler;				\
@@ -199,7 +202,7 @@
 #define STOREB(reg, addr, handler)	EXC(sb, ST_INSN, reg, addr, handler)
 
 #define _PREF(hint, addr, type)						\
-	.if \mode == LEGACY_MODE;					\
+	.if \mode != EVA_MODE;						\
 		PREF(hint, addr);					\
 	.else;								\
 		.if ((\from == USEROP) && (type == SRC_PREFETCH)) ||	\
@@ -255,18 +258,12 @@
 	/*
 	 * Macro to build the __copy_user common code
 	 * Arguments:
-	 * mode : LEGACY_MODE or EVA_MODE
+	 * mode : LEGACY_MODE, EVA_MODE or MEMCPY_MODE
 	 * from : Source operand. USEROP or KERNELOP
 	 * to   : Destination operand. USEROP or KERNELOP
 	 */
 	.macro __BUILD_COPY_USER mode, from, to
 
-	/* initialize __memcpy if this the first time we execute this macro */
-	.ifnotdef __memcpy
-	.set __memcpy, 1
-	.hidden __memcpy /* make sure it does not leak */
-	.endif
-
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
 	 * Temps
@@ -525,11 +522,9 @@
 	b	1b
 	 ADD	dst, dst, 8
 #endif /* CONFIG_CPU_MIPSR6 */
-	.if __memcpy == 1
-	END(memcpy)
-	.set __memcpy, 0
-	.hidden __memcpy
-	.endif
+
+	/* memcpy shouldn't generate exceptions */
+	.if	\mode != MEMCPY_MODE
 
 .Ll_exc_copy\@:
 	/*
@@ -616,34 +611,57 @@ SEXC(1)
 .Ls_exc\@:
 	jr	ra
 	 nop
-	.endm
 
-/*
- * t6 is used as a flag to note inatomic mode.
- */
-LEAF(__copy_user_inatomic)
-EXPORT_SYMBOL(__copy_user_inatomic)
-	b	__copy_user_common
-	li	t6, 1
-	END(__copy_user_inatomic)
+	.endif	/* \mode != MEMCPY_MODE */
+	.endm
 
 /*
- * A combined memcpy/__copy_user
- * __copy_user sets len to 0 for success; else to an upper bound of
- * the number of uncopied bytes.
- * memcpy sets v0 to dst.
+ * memcpy() - Copy memory
+ * @a0 - destination
+ * @a1 - source
+ * @a2 - length
+ *
+ * Copy @a2 bytes of memory from @a1 to @a0.
+ *
+ * Returns: the destination pointer
  */
 	.align	5
 LEAF(memcpy)					/* a0=dst a1=src a2=len */
 EXPORT_SYMBOL(memcpy)
 	move	v0, dst				/* return value */
 .L__memcpy:
-FEXPORT(__copy_user)
+	li	t6, 0	/* not inatomic */
+	/* Legacy Mode, user <-> user */
+	__BUILD_COPY_USER MEMCPY_MODE USEROP USEROP
+	END(memcpy)
+
+/*
+ * __copy_user() - Copy memory
+ * @a0 - destination
+ * @a1 - source
+ * @a2 - length
+ *
+ * Copy @a2 bytes of memory from @a1 to @a0.
+ *
+ * Returns: the number of uncopied bytes in @a2
+ */
+	.align	5
+LEAF(__copy_user)
 EXPORT_SYMBOL(__copy_user)
 	li	t6, 0	/* not inatomic */
 __copy_user_common:
 	/* Legacy Mode, user <-> user */
 	__BUILD_COPY_USER LEGACY_MODE USEROP USEROP
+	END(__copy_user)
+
+/*
+ * t6 is used as a flag to note inatomic mode.
+ */
+LEAF(__copy_user_inatomic)
+EXPORT_SYMBOL(__copy_user_inatomic)
+	b	__copy_user_common
+	li	t6, 1
+	END(__copy_user_inatomic)
 
 #ifdef CONFIG_EVA
 
-- 
2.10.2
