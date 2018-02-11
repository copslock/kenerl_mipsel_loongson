Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2018 09:29:33 +0100 (CET)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:54334 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993497AbeBKI305IscD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2018 09:29:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 8AA4C3F390;
        Sun, 11 Feb 2018 09:29:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MDd4Blpnt-mE; Sun, 11 Feb 2018 09:29:22 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 5291F3F594;
        Sun, 11 Feb 2018 09:29:15 +0100 (CET)
Date:   Sun, 11 Feb 2018 09:29:14 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Cc:     linux-mips@linux-mips.org
Subject: [RFC] MIPS: R5900: Use mandatory SYNC.L in exception handlers
Message-ID: <20180211082913.GF2222@localhost.localdomain>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62491
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

Hi Jürgen,

Would you be able to explain the notes

	/* In an error exception handler the user space could be uncached. */

in the patch ported from v2.6 below?

Fredrik

diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index b463f2aa5a61..79390b194e6d 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -19,9 +19,12 @@
 extern void _mcount(void);
 #define mcount _mcount
 
+#ifdef CONFIG_CPU_R5900
 #define safe_load(load, src, dst, error)		\
 do {							\
 	asm volatile (					\
+		/* In an error exception handler the user space could be uncached. */ \
+		"sync.l							\n"	\
 		"1: " load " %[tmp_dst], 0(%[tmp_src])\n"	\
 		"   li %[tmp_err], 0\n"			\
 		"2: .insn\n"				\
@@ -40,7 +43,55 @@ do {							\
 		: "memory"				\
 	);						\
 } while (0)
+#else
+#define safe_load(load, src, dst, error)		\
+do {							\
+	asm volatile (					\
+		"1: " load " %[" STR(dst) "], 0(%[" STR(src) "])\n"\
+		"   li %[" STR(error) "], 0\n"		\
+		"2:\n"					\
+							\
+		".section .fixup, \"ax\"\n"		\
+		"3: li %[" STR(error) "], 1\n"		\
+		"   j 2b\n"				\
+		".previous\n"				\
+							\
+		".section\t__ex_table,\"a\"\n\t"	\
+		STR(PTR) "\t1b, 3b\n\t"			\
+		".previous\n"				\
+							\
+		: [dst] "=&r" (dst), [error] "=r" (error)\
+		: [src] "r" (src)			\
+		: "memory"				\
+	);						\
+} while (0)
+#endif
 
+#ifdef CONFIG_CPU_R5900
+#define safe_store(store, src, dst, error)	\
+do {						\
+	asm volatile (				\
+		/* In an error exception handler the user space could be uncached. */ \
+		"sync.l							\n"	\
+		"1: " store " %[" STR(src) "], 0(%[" STR(dst) "])\n"\
+		"   li %[" STR(error) "], 0\n"	\
+		"2:\n"				\
+						\
+		".section .fixup, \"ax\"\n"	\
+		"3: li %[" STR(error) "], 1\n"	\
+		"   j 2b\n"			\
+		".previous\n"			\
+						\
+		".section\t__ex_table,\"a\"\n\t"\
+		STR(PTR) "\t1b, 3b\n\t"		\
+		".previous\n"			\
+						\
+		: [error] "=r" (error)		\
+		: [dst] "r" (dst), [src] "r" (src)\
+		: "memory"			\
+	);					\
+} while (0)
+#else
 #define safe_store(store, src, dst, error)	\
 do {						\
 	asm volatile (				\
@@ -62,6 +113,7 @@ do {						\
 		: "memory"			\
 	);					\
 } while (0)
+#endif
 
 #define safe_load_code(dst, src, error) \
 	safe_load(STR(lw), src, dst, error)
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index b71306947290..a4eecafc524b 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -315,11 +315,14 @@ do {									\
 	__gu_err;							\
 })
 
+#ifdef CONFIG_CPU_R5900
 #define __get_data_asm(val, insn, addr)					\
 {									\
 	long __gu_tmp;							\
 									\
 	__asm__ __volatile__(						\
+	/* In an error exception handler the user space could be uncached. */ \
+	"sync.l							\n"	\
 	"1:	"insn("%1", "%3")"				\n"	\
 	"2:							\n"	\
 	"	.insn						\n"	\
@@ -336,10 +339,32 @@ do {									\
 									\
 	(val) = (__typeof__(*(addr))) __gu_tmp;				\
 }
+#else
+#define __get_data_asm(val, insn, addr)					\
+{									\
+	long __gu_tmp;							\
+									\
+	__asm__ __volatile__(						\
+	"1:	"insn("%1", "%3")"				\n"	\
+	"2:							\n"	\
+	"	.section .fixup,\"ax\"				\n"	\
+	"3:	li	%0, %4					\n"	\
+	"	j	2b					\n"	\
+	"	.previous					\n"	\
+	"	.section __ex_table,\"a\"			\n"	\
+	"	"__UA_ADDR "\t1b, 3b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__gu_err), "=r" (__gu_tmp)				\
+	: "0" (0), "o" (__m(addr)), "i" (-EFAULT));			\
+									\
+	(val) = (__typeof__(*(addr))) __gu_tmp;				\
+}
+#endif
 
 /*
  * Get a long long 64 using 32 bit registers.
  */
+#ifdef CONFIG_CPU_R5900
 #define __get_data_asm_ll32(val, insn, addr)				\
 {									\
 	union {								\
@@ -348,7 +373,11 @@ do {									\
 	} __gu_tmp;							\
 									\
 	__asm__ __volatile__(						\
+	/* In an error exception handler the user space could be uncached. */ \
+	"sync.l							\n"	\
 	"1:	" insn("%1", "(%3)")"				\n"	\
+	/* In an error exception handler the user space could be uncached. */ \
+	"sync.l							\n"	\
 	"2:	" insn("%D1", "4(%3)")"				\n"	\
 	"3:							\n"	\
 	"	.insn						\n"	\
@@ -367,6 +396,33 @@ do {									\
 									\
 	(val) = __gu_tmp.t;						\
 }
+#else
+#define __get_data_asm_ll32(val, insn, addr)				\
+{									\
+	union {								\
+		unsigned long long	l;				\
+		__typeof__(*(addr))	t;				\
+	} __gu_tmp;							\
+									\
+	__asm__ __volatile__(						\
+	"1:	" insn("%1", "(%3)")"				\n"	\
+	"2:	" insn("%D1", "4(%3)")"				\n"	\
+	"3:	.section	.fixup,\"ax\"			\n"	\
+	"4:	li	%0, %4					\n"	\
+	"	move	%1, $0					\n"	\
+	"	move	%D1, $0					\n"	\
+	"	j	3b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 4b				\n"	\
+	"	" __UA_ADDR "	2b, 4b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__gu_err), "=&r" (__gu_tmp.l)				\
+	: "0" (0), "r" (addr), "i" (-EFAULT));				\
+									\
+	(val) = __gu_tmp.t;						\
+}
+#endif
 
 #ifndef CONFIG_EVA
 #define __put_kernel_common(ptr, size) __put_user_common(ptr, size)
@@ -456,6 +512,38 @@ do {									\
 	__pu_err;							\
 })
 
+#define __put_user_check_atomic(x, ptr, size)				\
+({									\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
+	__typeof__(*(ptr)) __pu_val = (x);				\
+	int __pu_err = -EFAULT;						\
+									\
+	if (likely(access_ok(VERIFY_WRITE,  __pu_addr, size))) {	\
+		__put_kernel_common(ptr, size);				\
+	}								\
+	__pu_err;							\
+})
+
+#ifdef CONFIG_CPU_R5900
+#define __put_data_asm(insn, ptr)					\
+{									\
+	__asm__ __volatile__(						\
+	/* In an error exception handler the user space could be uncached. */ \
+	"sync.l							\n"	\
+	"1:	"insn("%z2", "%3")"	# __put_data_asm	\n"	\
+	"2:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"3:	li	%0, %4					\n"	\
+	"	j	2b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 3b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__pu_err)						\
+	: "0" (0), "Jr" (__pu_val), "o" (__m(ptr)),			\
+	  "i" (-EFAULT));						\
+}
+#else
 #define __put_data_asm(insn, ptr)					\
 {									\
 	__asm__ __volatile__(						\
@@ -473,7 +561,32 @@ do {									\
 	: "0" (0), "Jr" (__pu_val), "o" (__m(ptr)),			\
 	  "i" (-EFAULT));						\
 }
+#endif
 
+#ifdef CONFIG_CPU_R5900
+#define __put_data_asm_ll32(insn, ptr)					\
+{									\
+	__asm__ __volatile__(						\
+	/* In an error exception handler the user space could be uncached. */ \
+	"sync.l							\n"	\
+	"1:	"insn("%2", "(%3)")"	# __put_data_asm_ll32	\n"	\
+	/* In an error exception handler the user space could be uncached. */ \
+	"sync.l							\n"	\
+	"2:	"insn("%D2", "4(%3)")"				\n"	\
+	"3:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"4:	li	%0, %4					\n"	\
+	"	j	3b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 4b				\n"	\
+	"	" __UA_ADDR "	2b, 4b				\n"	\
+	"	.previous"						\
+	: "=r" (__pu_err)						\
+	: "0" (0), "r" (__pu_val), "r" (ptr),				\
+	  "i" (-EFAULT));						\
+}
+#else
 #define __put_data_asm_ll32(insn, ptr)					\
 {									\
 	__asm__ __volatile__(						\
@@ -493,6 +606,7 @@ do {									\
 	: "0" (0), "r" (__pu_val), "r" (ptr),				\
 	  "i" (-EFAULT));						\
 }
+#endif
 
 extern void __put_user_unknown(void);
 
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index b280a3d775a1..625b74de1ce4 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -488,10 +488,15 @@ do {                                                        \
 
 #else /* __BIG_ENDIAN */
 
+	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
+	/* FIXME: Is ".set push\n" etc. needed? */
+	/* In an error exception handler the user space could be uncached. */
 #define     _LoadHW(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (".set\tnoat\n"        \
+			"sync.l\n\t"                        \
 			"1:\t"type##_lb("%0", "1(%2)")"\n"  \
+			"sync.l\n\t"                        \
 			"2:\t"type##_lbu("$1", "0(%2)")"\n\t"\
 			"sll\t%0, 0x8\n\t"                  \
 			"or\t%0, $1\n\t"                    \
@@ -511,10 +516,14 @@ do {                                                        \
 } while(0)
 
 #ifndef CONFIG_CPU_MIPSR6
+	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
+	/* In an error exception handler the user space could be uncached. */
 #define     _LoadW(addr, value, res, type)   \
 do {                                                        \
 		__asm__ __volatile__ (                      \
+			"sync.l\n\t"                        \
 			"1:\t"type##_lwl("%0", "3(%2)")"\n" \
+			"sync.l\n\t"                        \
 			"2:\t"type##_lwr("%0", "(%2)")"\n\t"\
 			"li\t%1, 0\n"                       \
 			"3:\n\t"                            \
@@ -569,11 +578,15 @@ do {                                                        \
 #endif /* CONFIG_CPU_MIPSR6 */
 
 
+	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
+	/* In an error exception handler the user space could be uncached. */
 #define     _LoadHWU(addr, value, res, type) \
 do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
+			"sync.l\n\t"                        \
 			"1:\t"type##_lbu("%0", "1(%2)")"\n" \
+			"sync.l\n\t"                        \
 			"2:\t"type##_lbu("$1", "0(%2)")"\n\t"\
 			"sll\t%0, 0x8\n\t"                  \
 			"or\t%0, $1\n\t"                    \
@@ -594,10 +607,14 @@ do {                                                        \
 } while(0)
 
 #ifndef CONFIG_CPU_MIPSR6
+	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
+	/* In an error exception handler the user space could be uncached. */
 #define     _LoadWU(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
+			"sync.l\n\t"                        \
 			"1:\t"type##_lwl("%0", "3(%2)")"\n" \
+			"sync.l\n\t"                        \
 			"2:\t"type##_lwr("%0", "(%2)")"\n\t"\
 			"dsll\t%0, %0, 32\n\t"              \
 			"dsrl\t%0, %0, 32\n\t"              \
@@ -616,10 +633,14 @@ do {                                                        \
 			: "r" (addr), "i" (-EFAULT));       \
 } while(0)
 
+	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
+	/* In an error exception handler the user space could be uncached. */
 #define     _LoadDW(addr, value, res)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
+			"sync.l\n\t"                        \
 			"1:\tldl\t%0, 7(%2)\n"              \
+			"sync.l\n\t"                        \
 			"2:\tldr\t%0, (%2)\n\t"             \
 			"li\t%1, 0\n"                       \
 			"3:\n\t"                            \
@@ -721,11 +742,15 @@ do {                                                        \
 } while(0)
 #endif /* CONFIG_CPU_MIPSR6 */
 
+	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
+	/* In an error exception handler the user space could be uncached. */
 #define     _StoreHW(addr, value, res, type) \
 do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
+			"sync.l\n\t"                        \
 			"1:\t"type##_sb("%1", "0(%2)")"\n"  \
+			"sync.l\n\t"                        \
 			"srl\t$1,%1, 0x8\n"                 \
 			"2:\t"type##_sb("$1", "1(%2)")"\n"  \
 			".set\tat\n\t"                      \
@@ -745,10 +770,13 @@ do {                                                        \
 } while(0)
 
 #ifndef CONFIG_CPU_MIPSR6
+	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
 #define     _StoreW(addr, value, res, type)  \
 do {                                                        \
 		__asm__ __volatile__ (                      \
+			"sync.l\n\t"                        \
 			"1:\t"type##_swl("%1", "3(%2)")"\n" \
+			"sync.l\n\t"                        \
 			"2:\t"type##_swr("%1", "(%2)")"\n\t"\
 			"li\t%0, 0\n"                       \
 			"3:\n\t"                            \
@@ -765,10 +793,14 @@ do {                                                        \
 		: "r" (value), "r" (addr), "i" (-EFAULT));  \
 } while(0)
 
+	/* FIXME: Use #ifdef CONFIG_CPU_R5900 */
+	/* In an error exception handler the user space could be uncached. */
 #define     _StoreDW(addr, value, res) \
 do {                                                        \
 		__asm__ __volatile__ (                      \
+			"sync.l\n\t"                        \
 			"1:\tsdl\t%1, 7(%2)\n"              \
+			"sync.l\n\t"                        \
 			"2:\tsdr\t%1, (%2)\n\t"             \
 			"li\t%0, 0\n"                       \
 			"3:\n\t"                            \
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 2ff84f4b1717..36e48682e1e1 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -357,7 +357,10 @@ EXPORT_SYMBOL(csum_partial)
  * addr    : Address
  * handler : Exception handler
  */
+/* FIXME: #ifdef CONFIG_CPU_R5900 */
 #define EXC(insn, type, reg, addr, handler)	\
+	/* In an error exception handler the user space could be uncached. */ \
+	sync.l;						\
 	.if \mode == LEGACY_MODE;		\
 9:		insn reg, addr;			\
 		.section __ex_table,"a";	\
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 489bc9cffcbd..b37731f53f46 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -46,6 +46,11 @@
 #define ___BUILD_EVA_INSN(insn, reg, addr) __EVAFY(insn, reg, addr)
 
 #define EX(insn,reg,addr,handler)			\
+	/* In an error exception handler the user space could be uncached. */ \
+	.set push;					\
+	.set noreorder;					\
+	sync.l;						\
+	.set pop;					\
 	.if \mode == LEGACY_MODE;			\
 9:		insn	reg, addr;			\
 	.else;						\
@@ -171,6 +176,19 @@
 #ifdef CONFIG_CPU_MICROMIPS
 	LONG_SRL	t7, t0, 1
 #endif
+#ifdef CONFIG_CPU_R5900
+	/* Each instruction has a leading sync.l */
+#if LONGSIZE == 4
+	.set		noat
+	/* 2 instructions for 4 Byte. */
+	LONG_SLL	AT, t0, 1
+	PTR_SUBU	t1, AT
+	.set		at
+#else
+	/* Verify memset for R5900 with 64 bit. 2 instructions for 8 Byte. */
+	PTR_SUBU	t1, t0
+#endif
+#else
 #if LONGSIZE == 4
 	PTR_SUBU	t1, FILLPTRG
 #else
@@ -179,6 +197,7 @@
 	PTR_SUBU	t1, AT
 	.set		at
 #endif
+#endif /* CONFIG_CPU_R5900 */
 	jr		t1
 	PTR_ADDU	a0, t0			/* dest ptr */
 
diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index 44cc346fd400..0cf9a6660130 100644
--- a/arch/mips/lib/strncpy_user.S
+++ b/arch/mips/lib/strncpy_user.S
@@ -13,6 +13,8 @@
 #include <asm/regdef.h>
 
 #define EX(insn,reg,addr,handler)			\
+	/* In an error exception handler the user space could be uncached. */ \
+	sync.l;							\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a";			\
 	PTR	9b, handler;				\
diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
index 474979641a8d..55f7e069a960 100644
--- a/arch/mips/lib/strnlen_user.S
+++ b/arch/mips/lib/strnlen_user.S
@@ -12,6 +12,8 @@
 #include <asm/regdef.h>
 
 #define EX(insn,reg,addr,handler)			\
+	/* In an error exception handler the user space could be uncached. */ \
+	sync.l;							\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a";			\
 	PTR	9b, handler;				\
