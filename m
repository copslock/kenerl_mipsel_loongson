Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:20:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42243 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992186AbcKGLTWD6Swd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:19:22 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTP id AB76814036D16;
        Mon,  7 Nov 2016 11:19:12 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:19:14 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/7] MIPS: memcpy: Return uncopied bytes from __copy_user*() in v0
Date:   Mon, 7 Nov 2016 11:17:59 +0000
Message-ID: <20161107111802.12071-5-paul.burton@imgtec.com>
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
X-archive-position: 55698
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

The __copy_user*() functions have thus far returned the number of
uncopied bytes in the $a2 register used as the argument providing the
length of the memory region to be copied. As part of moving to use the
standard calling convention, return the number of uncopied bytes in v0
instead.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/cavium-octeon/octeon-memcpy.S | 18 +++++++++---------
 arch/mips/include/asm/uaccess.h         | 30 ++++++++++++++++++++----------
 arch/mips/lib/memcpy.S                  | 26 +++++++++++++-------------
 3 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 944f8f5..6f312a2 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -141,7 +141,7 @@
 	.set	noreorder
 	.set	noat
 
-	.macro __BUILD_COPY_USER mode
+	.macro __BUILD_COPY_USER mode, uncopied
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
 	 * Temps
@@ -358,12 +358,12 @@ EXC(	 sb	t0, N(dst), s_exc_p1)
 	COPY_BYTE(4)
 	COPY_BYTE(5)
 EXC(	lb	t0, NBYTES-2(src), l_exc)
-	SUB	len, len, 1
+	SUB	\uncopied, len, 1
 	jr	ra
 EXC(	 sb	t0, NBYTES-2(dst), s_exc_p1)
 .Ldone\@:
 	jr	ra
-	 nop
+	 move	\uncopied, len
 
 	/* memcpy shouldn't generate exceptions */
 	.if \mode != MEMCPY_MODE
@@ -410,13 +410,13 @@ l_exc:
 	bnez	src, 1b
 	 SUB	src, src, 1
 2:	jr	ra
-	 nop
+	 move	\uncopied, len
 
 
 #define SEXC(n)				\
 s_exc_p ## n ## u:			\
 	jr	ra;			\
-	 ADD	len, len, n*NBYTES
+	 ADD	\uncopied, len, n*NBYTES
 
 SEXC(16)
 SEXC(15)
@@ -437,10 +437,10 @@ SEXC(1)
 
 s_exc_p1:
 	jr	ra
-	 ADD	len, len, 1
+	 ADD	\uncopied, len, 1
 s_exc:
 	jr	ra
-	 nop
+	 move	\uncopied, len
 	.endif	/* \mode != MEMCPY_MODE */
 	.endm
 
@@ -458,7 +458,7 @@ s_exc:
 LEAF(memcpy)					/* a0=dst a1=src a2=len */
 EXPORT_SYMBOL(memcpy)
 	move	v0, dst				/* return value */
-	__BUILD_COPY_USER MEMCPY_MODE
+	__BUILD_COPY_USER MEMCPY_MODE len
 	END(memcpy)
 
 /*
@@ -475,7 +475,7 @@ LEAF(__copy_user)
 EXPORT_SYMBOL(__copy_user)
 	li	t7, 0				/* not inatomic */
 __copy_user_common:
-	__BUILD_COPY_USER COPY_USER_MODE
+	__BUILD_COPY_USER COPY_USER_MODE v0
 	END(__copy_user)
 
 /*
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 89fa5c0b..81d632f 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -814,6 +814,7 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n);
 #ifndef CONFIG_EVA
 #define __invoke_copy_to_user(to, from, n)				\
 ({									\
+	register long __cu_ret_r __asm__("$2");				\
 	register void __user *__cu_to_r __asm__("$4");			\
 	register const void *__cu_from_r __asm__("$5");			\
 	register long __cu_len_r __asm__("$6");				\
@@ -823,11 +824,12 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n);
 	__cu_len_r = (n);						\
 	__asm__ __volatile__(						\
 	__MODULE_JAL(__copy_user)					\
-	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
+	: "=r"(__cu_ret_r), "+r" (__cu_to_r),				\
+	  "+r" (__cu_from_r), "+r" (__cu_len_r)				\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
 	  DADDI_SCRATCH, "memory");					\
-	__cu_len_r;							\
+	__cu_ret_r;							\
 })
 
 #define __invoke_copy_to_kernel(to, from, n)				\
@@ -963,6 +965,7 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 
 #define __invoke_copy_from_user(to, from, n)				\
 ({									\
+	register long __cu_ret_r __asm__("$2");				\
 	register void *__cu_to_r __asm__("$4");				\
 	register const void __user *__cu_from_r __asm__("$5");		\
 	register long __cu_len_r __asm__("$6");				\
@@ -977,11 +980,12 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__UA_ADDU "\t$1, %1, %2\n\t"					\
 	".set\tat\n\t"							\
 	".set\treorder"							\
-	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
+	: "=r"(__cu_ret_r), "+r" (__cu_to_r),				\
+	  "+r" (__cu_from_r), "+r" (__cu_len_r)				\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
 	  DADDI_SCRATCH, "memory");					\
-	__cu_len_r;							\
+	__cu_ret_r;							\
 })
 
 #define __invoke_copy_from_kernel(to, from, n)				\
@@ -997,6 +1001,7 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 
 #define __invoke_copy_from_user_inatomic(to, from, n)			\
 ({									\
+	register long __cu_ret_r __asm__("$2");				\
 	register void *__cu_to_r __asm__("$4");				\
 	register const void __user *__cu_from_r __asm__("$5");		\
 	register long __cu_len_r __asm__("$6");				\
@@ -1011,11 +1016,12 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__UA_ADDU "\t$1, %1, %2\n\t"					\
 	".set\tat\n\t"							\
 	".set\treorder"							\
-	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
+	: "=r"(__cu_ret_r), "+r" (__cu_to_r),				\
+	  "+r" (__cu_from_r), "+r" (__cu_len_r)				\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
 	  DADDI_SCRATCH, "memory");					\
-	__cu_len_r;							\
+	__cu_ret_r;							\
 })
 
 #define __invoke_copy_from_kernel_inatomic(to, from, n)			\
@@ -1035,6 +1041,7 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 
 #define __invoke_copy_from_user_eva_generic(to, from, n, func_ptr)	\
 ({									\
+	register long __cu_ret_r __asm__("$2");				\
 	register void *__cu_to_r __asm__("$4");				\
 	register const void __user *__cu_from_r __asm__("$5");		\
 	register long __cu_len_r __asm__("$6");				\
@@ -1049,15 +1056,17 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 	__UA_ADDU "\t$1, %1, %2\n\t"					\
 	".set\tat\n\t"							\
 	".set\treorder"							\
-	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
+	: "=r"(__cu_ret_r), "+r" (__cu_to_r),				\
+	  "+r" (__cu_from_r), "+r" (__cu_len_r)				\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
 	  DADDI_SCRATCH, "memory");					\
-	__cu_len_r;							\
+	__cu_ret_r;							\
 })
 
 #define __invoke_copy_to_user_eva_generic(to, from, n, func_ptr)	\
 ({									\
+	register long __cu_ret_r __asm__("$2");				\
 	register void *__cu_to_r __asm__("$4");				\
 	register const void __user *__cu_from_r __asm__("$5");		\
 	register long __cu_len_r __asm__("$6");				\
@@ -1067,11 +1076,12 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 	__cu_len_r = (n);						\
 	__asm__ __volatile__(						\
 	__MODULE_JAL(func_ptr)						\
-	: "+r" (__cu_to_r), "+r" (__cu_from_r), "+r" (__cu_len_r)	\
+	: "=r"(__cu_ret_r), "+r" (__cu_to_r),				\
+	  "+r" (__cu_from_r), "+r" (__cu_len_r)				\
 	:								\
 	: "$8", "$9", "$10", "$11", "$12", "$14", "$15", "$24", "$31",	\
 	  DADDI_SCRATCH, "memory");					\
-	__cu_len_r;							\
+	__cu_ret_r;							\
 })
 
 /*
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index bfbe23c..052f7a1 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -262,7 +262,7 @@
 	 * from : Source operand. USEROP or KERNELOP
 	 * to   : Destination operand. USEROP or KERNELOP
 	 */
-	.macro __BUILD_COPY_USER mode, from, to
+	.macro __BUILD_COPY_USER mode, from, to, uncopied
 
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
@@ -398,7 +398,7 @@
 	SHIFT_DISCARD t0, t0, bits
 	STREST(t0, -1(t1), .Ls_exc\@)
 	jr	ra
-	 move	len, zero
+	 move	\uncopied, zero
 .Ldst_unaligned\@:
 	/*
 	 * dst is unaligned
@@ -500,12 +500,12 @@
 	COPY_BYTE(5)
 #endif
 	LOADB(t0, NBYTES-2(src), .Ll_exc\@)
-	SUB	len, len, 1
+	SUB	\uncopied, len, 1
 	jr	ra
 	STOREB(t0, NBYTES-2(dst), .Ls_exc_p1\@)
 .Ldone\@:
 	jr	ra
-	 nop
+	 move	\uncopied, len
 
 #ifdef CONFIG_CPU_MIPSR6
 .Lcopy_unaligned_bytes\@:
@@ -584,13 +584,13 @@
 	.set	pop
 #endif
 	jr	ra
-	 nop
+	 move	\uncopied, len
 
 
 #define SEXC(n)							\
 	.set	reorder;			/* DADDI_WAR */ \
 .Ls_exc_p ## n ## u\@:						\
-	ADD	len, len, n*NBYTES;				\
+	ADD	\uncopied, len, n*NBYTES;			\
 	jr	ra;						\
 	.set	noreorder
 
@@ -605,12 +605,12 @@ SEXC(1)
 
 .Ls_exc_p1\@:
 	.set	reorder				/* DADDI_WAR */
-	ADD	len, len, 1
+	ADD	\uncopied, len, 1
 	jr	ra
 	.set	noreorder
 .Ls_exc\@:
 	jr	ra
-	 nop
+	 move	\uncopied, len
 
 	.endif	/* \mode != MEMCPY_MODE */
 	.endm
@@ -632,7 +632,7 @@ EXPORT_SYMBOL(memcpy)
 .L__memcpy:
 	li	t6, 0	/* not inatomic */
 	/* Legacy Mode, user <-> user */
-	__BUILD_COPY_USER MEMCPY_MODE USEROP USEROP
+	__BUILD_COPY_USER MEMCPY_MODE USEROP USEROP len
 	END(memcpy)
 
 /*
@@ -651,7 +651,7 @@ EXPORT_SYMBOL(__copy_user)
 	li	t6, 0	/* not inatomic */
 __copy_user_common:
 	/* Legacy Mode, user <-> user */
-	__BUILD_COPY_USER LEGACY_MODE USEROP USEROP
+	__BUILD_COPY_USER LEGACY_MODE USEROP USEROP v0
 	END(__copy_user)
 
 /*
@@ -686,7 +686,7 @@ LEAF(__copy_from_user_eva)
 EXPORT_SYMBOL(__copy_from_user_eva)
 	li	t6, 0	/* not inatomic */
 __copy_from_user_common:
-	__BUILD_COPY_USER EVA_MODE USEROP KERNELOP
+	__BUILD_COPY_USER EVA_MODE USEROP KERNELOP v0
 END(__copy_from_user_eva)
 
 
@@ -697,7 +697,7 @@ END(__copy_from_user_eva)
 
 LEAF(__copy_to_user_eva)
 EXPORT_SYMBOL(__copy_to_user_eva)
-__BUILD_COPY_USER EVA_MODE KERNELOP USEROP
+__BUILD_COPY_USER EVA_MODE KERNELOP USEROP v0
 END(__copy_to_user_eva)
 
 /*
@@ -706,7 +706,7 @@ END(__copy_to_user_eva)
 
 LEAF(__copy_in_user_eva)
 EXPORT_SYMBOL(__copy_in_user_eva)
-__BUILD_COPY_USER EVA_MODE USEROP USEROP
+__BUILD_COPY_USER EVA_MODE USEROP USEROP v0
 END(__copy_in_user_eva)
 
 #endif
-- 
2.10.2
