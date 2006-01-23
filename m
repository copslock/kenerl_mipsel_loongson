Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 15:02:49 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:32786 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465554AbWAWPBw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 15:01:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0NF58r1019404;
	Mon, 23 Jan 2006 15:05:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0NF57dq019403;
	Mon, 23 Jan 2006 15:05:07 GMT
Date:	Mon, 23 Jan 2006 15:05:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>,
	Stuart Anderson <anderson@netsweng.com>,
	David Daney <ddaney@avtrex.com>
Subject: Fixes for uaccess.h with gcc >= 4.0.1
Message-ID: <20060123150507.GA18665@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 18, 2006 at 01:37:59PM +0000, Martin Michlmayr wrote:

> * Ralf Baechle <ralf@linux-mips.org> [2006-01-18 13:05]:
> > > With current linux-mips git I still get the problem.  As a reminder,
> > > the error is:
> > > 
> > >   CC      fs/compat_ioctl.o
> > > fs/compat_ioctl.c: In function 'fd_ioctl_trans':
> > > fs/compat_ioctl.c:1831: error: read-only variable '__gu_val' used as 'asm' output
> > I have not been able to find some construct that keeps gcc happy and at the
> > same time doesn't result in significantly worse code.  That matters because
> > get_user / put_user are used very often throughout the kernel.
> 
> Who could help with that?  Maciej?  David Daney?
> 
> (See the original discussion and the proposed patch at
> http://www.spinics.net/lists/mips/msg20671.html)

I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
below.

  Ralf

 include/asm-mips/uaccess.h |   71 ++++++++++++++++++++++-----------------------
 1 files changed, 36 insertions(+), 35 deletions(-)

Index: linux-mips/include/asm-mips/uaccess.h
===================================================================
--- linux-mips.orig/include/asm-mips/uaccess.h
+++ linux-mips/include/asm-mips/uaccess.h
@@ -202,49 +202,49 @@ struct __large_struct { unsigned long bu
  * Yuck.  We need two variants, one for 64bit operation and one
  * for 32 bit mode and old iron.
  */
-#ifdef __mips64
-#define __GET_USER_DW(ptr) __get_user_asm("ld", ptr)
-#else
-#define __GET_USER_DW(ptr) __get_user_asm_ll32(ptr)
+#ifdef CONFIG_32BIT
+#define __GET_USER_DW(val, ptr) __get_user_asm_ll32(val, ptr)
+#endif
+#ifdef CONFIG_64BIT
+#define __GET_USER_DW(val, ptr) __get_user_asm(val, "ld", ptr)
 #endif
 
-#define __get_user_nocheck(x,ptr,size)					\
-({									\
-	__typeof(*(ptr)) __gu_val =  (__typeof(*(ptr))) 0;		\
-	long __gu_err = 0;						\
-									\
+extern void __get_user_unknown(void);
+
+#define __get_user_common(val, size, ptr)				\
+do {									\
 	switch (size) {							\
-	case 1: __get_user_asm("lb", ptr); break;			\
-	case 2: __get_user_asm("lh", ptr); break;			\
-	case 4: __get_user_asm("lw", ptr); break;			\
-	case 8: __GET_USER_DW(ptr); break;				\
+	case 1: __get_user_asm(val, "lb", ptr); break;			\
+	case 2: __get_user_asm(val, "lh", ptr); break;			\
+	case 4: __get_user_asm(val, "lw", ptr); break;			\
+	case 8: __GET_USER_DW(val, ptr); break;				\
 	default: __get_user_unknown(); break;				\
 	}								\
-	(x) = (__typeof__(*(ptr))) __gu_val;				\
+} while (0)
+
+#define __get_user_nocheck(x,ptr,size)					\
+({									\
+	long __gu_err;							\
+									\
+	__get_user_common((x), size, ptr);				\
 	__gu_err;							\
 })
 
 #define __get_user_check(x,ptr,size)					\
 ({									\
-	const __typeof__(*(ptr)) __user * __gu_addr = (ptr);		\
-	__typeof__(*(ptr)) __gu_val = 0;				\
 	long __gu_err = -EFAULT;					\
+	void * __gu_ptr = (ptr);					\
+									\
+	if (likely(access_ok(VERIFY_READ,  __gu_ptr, size)))		\
+		__get_user_common((x), size, __gu_ptr);			\
 									\
-	if (likely(access_ok(VERIFY_READ,  __gu_addr, size))) {		\
-		switch (size) {						\
-		case 1: __get_user_asm("lb", __gu_addr); break;		\
-		case 2: __get_user_asm("lh", __gu_addr); break;		\
-		case 4: __get_user_asm("lw", __gu_addr); break;		\
-		case 8: __GET_USER_DW(__gu_addr); break;		\
-		default: __get_user_unknown(); break;			\
-		}							\
-	}								\
-	(x) = (__typeof__(*(ptr))) __gu_val;				\
 	__gu_err;							\
 })
 
-#define __get_user_asm(insn, addr)					\
+#define __get_user_asm(val, insn, addr)					\
 {									\
+	long __gu_tmp;							\
+									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%1, %3				\n"	\
 	"2:							\n"	\
@@ -255,14 +255,16 @@ struct __large_struct { unsigned long bu
 	"	.section __ex_table,\"a\"			\n"	\
 	"	"__UA_ADDR "\t1b, 3b				\n"	\
 	"	.previous					\n"	\
-	: "=r" (__gu_err), "=r" (__gu_val)				\
+	: "=r" (__gu_err), "=r" (__gu_tmp)				\
 	: "0" (0), "o" (__m(addr)), "i" (-EFAULT));			\
+									\
+	(val) = (__typeof__(val)) __gu_tmp;				\
 }
 
 /*
  * Get a long long 64 using 32 bit registers.
  */
-#define __get_user_asm_ll32(addr)					\
+#define __get_user_asm_ll32(val, addr)					\
 {									\
 	__asm__ __volatile__(						\
 	"1:	lw	%1, (%3)				\n"	\
@@ -278,21 +280,20 @@ struct __large_struct { unsigned long bu
 	"	" __UA_ADDR "	1b, 4b				\n"	\
 	"	" __UA_ADDR "	2b, 4b				\n"	\
 	"	.previous					\n"	\
-	: "=r" (__gu_err), "=&r" (__gu_val)				\
+	: "=r" (__gu_err), "=&r" (val)					\
 	: "0" (0), "r" (addr), "i" (-EFAULT));				\
 }
 
-extern void __get_user_unknown(void);
-
 /*
  * Yuck.  We need two variants, one for 64bit operation and one
  * for 32 bit mode and old iron.
  */
-#ifdef __mips64
-#define __PUT_USER_DW(ptr) __put_user_asm("sd", ptr)
-#else
+#ifdef CONFIG_32BIT
 #define __PUT_USER_DW(ptr) __put_user_asm_ll32(ptr)
 #endif
+#ifdef CONFIG_64BIT
+#define __PUT_USER_DW(ptr) __put_user_asm("sd", ptr)
+#endif
 
 #define __put_user_nocheck(x,ptr,size)					\
 ({									\
