Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 15:14:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:15835 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038486AbWJSOOa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2006 15:14:30 +0100
Received: from localhost (p1050-ipad31funabasi.chiba.ocn.ne.jp [221.189.125.50])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F2C7F438; Thu, 19 Oct 2006 23:14:23 +0900 (JST)
Date:	Thu, 19 Oct 2006 23:16:45 +0900 (JST)
Message-Id: <20061019.231645.126573493.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Use "long" for 64-bit values on 64-bit kernel.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Just resend again to avoid being obscured by discussion.

This would get rid of some warnings about "long" vs. "long long".

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
index 45c706e..7401711 100644
--- a/include/asm-mips/addrspace.h
+++ b/include/asm-mips/addrspace.h
@@ -19,12 +19,17 @@ #ifdef __ASSEMBLY__
 #define _ATYPE_
 #define _ATYPE32_
 #define _ATYPE64_
-#define _LLCONST_(x)	x
+#define _CONST64_(x)	x
 #else
 #define _ATYPE_		__PTRDIFF_TYPE__
 #define _ATYPE32_	int
+#ifdef CONFIG_64BIT
+#define _ATYPE64_	long
+#define _CONST64_(x)	x ## L
+#else
 #define _ATYPE64_	long long
-#define _LLCONST_(x)	x ## LL
+#define _CONST64_(x)	x ## LL
+#endif
 #endif
 
 /*
@@ -48,7 +53,7 @@ #define KSEGX(a)		((_ACAST32_ (a)) & 0xe
  */
 #define CPHYSADDR(a)		((_ACAST32_(a)) & 0x1fffffff)
 #define XPHYSADDR(a)            ((_ACAST64_(a)) &			\
-				 _LLCONST_(0x000000ffffffffff))
+				 _CONST64_(0x000000ffffffffff))
 
 #ifdef CONFIG_64BIT
 
@@ -57,14 +62,14 @@ #ifdef CONFIG_64BIT
  * The compatibility segments use the full 64-bit sign extended value.  Note
  * the R8000 doesn't have them so don't reference these in generic MIPS code.
  */
-#define XKUSEG			_LLCONST_(0x0000000000000000)
-#define XKSSEG			_LLCONST_(0x4000000000000000)
-#define XKPHYS			_LLCONST_(0x8000000000000000)
-#define XKSEG			_LLCONST_(0xc000000000000000)
-#define CKSEG0			_LLCONST_(0xffffffff80000000)
-#define CKSEG1			_LLCONST_(0xffffffffa0000000)
-#define CKSSEG			_LLCONST_(0xffffffffc0000000)
-#define CKSEG3			_LLCONST_(0xffffffffe0000000)
+#define XKUSEG			_CONST64_(0x0000000000000000)
+#define XKSSEG			_CONST64_(0x4000000000000000)
+#define XKPHYS			_CONST64_(0x8000000000000000)
+#define XKSEG			_CONST64_(0xc000000000000000)
+#define CKSEG0			_CONST64_(0xffffffff80000000)
+#define CKSEG1			_CONST64_(0xffffffffa0000000)
+#define CKSSEG			_CONST64_(0xffffffffc0000000)
+#define CKSEG3			_CONST64_(0xffffffffe0000000)
 
 #define CKSEG0ADDR(a)		(CPHYSADDR(a) | CKSEG0)
 #define CKSEG1ADDR(a)		(CPHYSADDR(a) | CKSEG1)
@@ -122,7 +127,7 @@ #define K_CALG_UNCACHED_ACCEL	7
 #define PHYS_TO_XKSEG_UNCACHED(p)	PHYS_TO_XKPHYS(K_CALG_UNCACHED,(p))
 #define PHYS_TO_XKSEG_CACHED(p)		PHYS_TO_XKPHYS(K_CALG_COH_SHAREABLE,(p))
 #define XKPHYS_TO_PHYS(p)		((p) & TO_PHYS_MASK)
-#define PHYS_TO_XKPHYS(cm,a)		(_LLCONST_(0x8000000000000000) | \
+#define PHYS_TO_XKPHYS(cm,a)		(_CONST64_(0x8000000000000000) | \
 					 ((cm)<<59) | (a))
 
 #if defined (CONFIG_CPU_R4300)						\
@@ -132,20 +137,20 @@ #if defined (CONFIG_CPU_R4300)						\
     || defined (CONFIG_CPU_NEVADA)					\
     || defined (CONFIG_CPU_TX49XX)					\
     || defined (CONFIG_CPU_MIPS64)
-#define TO_PHYS_MASK	_LLCONST_(0x0000000fffffffff)	/* 2^^36 - 1 */
+#define TO_PHYS_MASK	_CONST64_(0x0000000fffffffff)	/* 2^^36 - 1 */
 #endif
 
 #if defined (CONFIG_CPU_R8000)
 /* We keep KUSIZE consistent with R4000 for now (2^^40) instead of (2^^48) */
-#define TO_PHYS_MASK	_LLCONST_(0x000000ffffffffff)	/* 2^^40 - 1 */
+#define TO_PHYS_MASK	_CONST64_(0x000000ffffffffff)	/* 2^^40 - 1 */
 #endif
 
 #if defined (CONFIG_CPU_R10000)
-#define TO_PHYS_MASK	_LLCONST_(0x000000ffffffffff)	/* 2^^40 - 1 */
+#define TO_PHYS_MASK	_CONST64_(0x000000ffffffffff)	/* 2^^40 - 1 */
 #endif
 
 #if defined(CONFIG_CPU_SB1) || defined(CONFIG_CPU_SB1A)
-#define TO_PHYS_MASK	_LLCONST_(0x00000fffffffffff)	/* 2^^44 - 1 */
+#define TO_PHYS_MASK	_CONST64_(0x00000fffffffffff)	/* 2^^44 - 1 */
 #endif
 
 #ifndef CONFIG_CPU_R8000
@@ -155,7 +160,7 @@ #ifndef CONFIG_CPU_R8000
  * in order to catch bugs in the source code.
  */
 
-#define COMPAT_K1BASE32		_LLCONST_(0xffffffffa0000000)
+#define COMPAT_K1BASE32		_CONST64_(0xffffffffa0000000)
 #define PHYS_TO_COMPATK1(x)	((x) | COMPAT_K1BASE32) /* 32-bit compat k1 */
 
 #endif
