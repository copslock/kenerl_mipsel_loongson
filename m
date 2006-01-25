Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 11:29:58 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:56730 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133488AbWAYL3P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 11:29:15 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id 96D5731BF6C; Wed, 25 Jan 2006 20:33:31 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Wed, 25 Jan 2006 11:33:31 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 20CF0420196; Wed, 25 Jan 2006 20:33:37 +0900 (JST)
Date:	Wed, 25 Jan 2006 20:33:37 +0900
To:	linux-kernel@vger.kernel.org
Cc:	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <rmk@arm.linux.org.uk>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@lists.linux-m68k.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: [PATCH 4/6] use include/asm-generic/bitops for each architecture
Message-ID: <20060125113336.GE18584@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125112625.GA18584@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From:	mita@miraclelinux.com (Akinobu Mita)
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

compile test on i386, x86_64, ppc, sparc, sparc64, alpha
boot test on i386, x86_64, ppc

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
---
 asm-alpha/bitops.h     |  215 +----------------------
 asm-arm/bitops.h       |  164 +----------------
 asm-arm26/bitops.h     |  157 +---------------
 asm-cris/bitops.h      |  228 ------------------------
 asm-frv/bitops.h       |  165 -----------------
 asm-h8300/bitops.h     |  218 -----------------------
 asm-i386/bitops.h      |   62 +-----
 asm-ia64/bitops.h      |  142 +--------------
 asm-m32r/bitops.h      |  456 -------------------------------------------------
 asm-m68k/bitops.h      |   95 +---------
 asm-m68knommu/bitops.h |  218 -----------------------
 asm-mips/bitops.h      |  456 +------------------------------------------------
 asm-parisc/bitops.h    |  277 +----------------------------
 asm-powerpc/bitops.h   |  127 +------------
 asm-s390/bitops.h      |   55 +----
 asm-sh/bitops.h        |  338 ------------------------------------
 asm-sh64/bitops.h      |  377 ----------------------------------------
 asm-sparc/bitops.h     |  380 ----------------------------------------
 asm-sparc64/bitops.h   |  151 +---------------
 asm-v850/bitops.h      |  217 -----------------------
 asm-x86_64/bitops.h    |   55 +----
 asm-xtensa/bitops.h    |  341 +-----------------------------------
 22 files changed, 228 insertions(+), 4666 deletions(-)

Index: 2.6-git/include/asm-alpha/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-alpha/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-alpha/bitops.h	2006-01-25 19:14:13.000000000 +0900
@@ -38,17 +38,6 @@
 	:"Ir" (1UL << (nr & 31)), "m" (*m));
 }
 
-/*
- * WARNING: non atomic version.
- */
-static inline void
-__set_bit(unsigned long nr, volatile void * addr)
-{
-	int *m = ((int *) addr) + (nr >> 5);
-
-	*m |= 1 << (nr & 31);
-}
-
 #define smp_mb__before_clear_bit()	smp_mb()
 #define smp_mb__after_clear_bit()	smp_mb()
 
@@ -70,17 +59,6 @@
 	:"Ir" (1UL << (nr & 31)), "m" (*m));
 }
 
-/*
- * WARNING: non atomic version.
- */
-static __inline__ void
-__clear_bit(unsigned long nr, volatile void * addr)
-{
-	int *m = ((int *) addr) + (nr >> 5);
-
-	*m &= ~(1 << (nr & 31));
-}
-
 static inline void
 change_bit(unsigned long nr, volatile void * addr)
 {
@@ -99,17 +77,6 @@
 	:"Ir" (1UL << (nr & 31)), "m" (*m));
 }
 
-/*
- * WARNING: non atomic version.
- */
-static __inline__ void
-__change_bit(unsigned long nr, volatile void * addr)
-{
-	int *m = ((int *) addr) + (nr >> 5);
-
-	*m ^= 1 << (nr & 31);
-}
-
 static inline int
 test_and_set_bit(unsigned long nr, volatile void *addr)
 {
@@ -137,20 +104,6 @@
 	return oldbit != 0;
 }
 
-/*
- * WARNING: non atomic version.
- */
-static inline int
-__test_and_set_bit(unsigned long nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	int *m = ((int *) addr) + (nr >> 5);
-	int old = *m;
-
-	*m = old | mask;
-	return (old & mask) != 0;
-}
-
 static inline int
 test_and_clear_bit(unsigned long nr, volatile void * addr)
 {
@@ -178,20 +131,6 @@
 	return oldbit != 0;
 }
 
-/*
- * WARNING: non atomic version.
- */
-static inline int
-__test_and_clear_bit(unsigned long nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	int *m = ((int *) addr) + (nr >> 5);
-	int old = *m;
-
-	*m = old & ~mask;
-	return (old & mask) != 0;
-}
-
 static inline int
 test_and_change_bit(unsigned long nr, volatile void * addr)
 {
@@ -217,25 +156,7 @@
 	return oldbit != 0;
 }
 
-/*
- * WARNING: non atomic version.
- */
-static __inline__ int
-__test_and_change_bit(unsigned long nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	int *m = ((int *) addr) + (nr >> 5);
-	int old = *m;
-
-	*m = old ^ mask;
-	return (old & mask) != 0;
-}
-
-static inline int
-test_bit(int nr, const volatile void * addr)
-{
-	return (1UL & (((const int *) addr)[nr >> 5] >> (nr & 31))) != 0UL;
-}
+#define HAVE_ARCH_ATOMIC_BITOPS
 
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
@@ -276,6 +197,8 @@
 #endif
 }
 
+#define HAVE_ARCH_FFZ_BITOPS
+
 /*
  * __ffs = Find First set bit in word.  Undefined if no set bit exists.
  */
@@ -296,6 +219,8 @@
 #endif
 }
 
+#define HAVE_ARCH___FFS_BITOPS
+
 #ifdef __KERNEL__
 
 /*
@@ -310,6 +235,8 @@
 	return word ? result : 0;
 }
 
+#define HAVE_ARCH_FFS_BITOPS
+
 /*
  * fls: find last bit set.
  */
@@ -318,10 +245,8 @@
 {
 	return 64 - __kernel_ctlz(word & 0xffffffff);
 }
-#else
-#define fls	generic_fls
+#define HAVE_ARCH_FLS_BITOPS
 #endif
-#define fls64   generic_fls64
 
 /* Compute powers of two for the given integer.  */
 static inline long floor_log2(unsigned long word)
@@ -354,117 +279,18 @@
 	return __kernel_ctpop(w);
 }
 
+#define HAVE_ARCH_HEIGHT64_BITOPS
+
 #define hweight32(x)	(unsigned int) hweight64((x) & 0xfffffffful)
 #define hweight16(x)	(unsigned int) hweight64((x) & 0xfffful)
 #define hweight8(x)	(unsigned int) hweight64((x) & 0xfful)
-#else
-static inline unsigned long hweight64(unsigned long w)
-{
-	unsigned long result;
-	for (result = 0; w ; w >>= 1)
-		result += (w & 1);
-	return result;
-}
 
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x)  generic_hweight8(x)
+#define HAVE_ARCH_HEIGHT_BITOPS
+
 #endif
 
 #endif /* __KERNEL__ */
 
-/*
- * Find next zero bit in a bitmap reasonably efficiently..
- */
-static inline unsigned long
-find_next_zero_bit(const void *addr, unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr;
-	unsigned long result = offset & ~63UL;
-	unsigned long tmp;
-
-	p += offset >> 6;
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 63UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (64-offset);
-		if (size < 64)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 64;
-		result += 64;
-	}
-	while (size & ~63UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 64;
-		size -= 64;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
- found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)        /* Are any bits zero? */
-		return result + size; /* Nope. */
- found_middle:
-	return result + ffz(tmp);
-}
-
-/*
- * Find next one bit in a bitmap reasonably efficiently.
- */
-static inline unsigned long
-find_next_bit(const void * addr, unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr;
-	unsigned long result = offset & ~63UL;
-	unsigned long tmp;
-
-	p += offset >> 6;
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 63UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp &= ~0UL << offset;
-		if (size < 64)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 64;
-		result += 64;
-	}
-	while (size & ~63UL) {
-		if ((tmp = *(p++)))
-			goto found_middle;
-		result += 64;
-		size -= 64;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
- found_first:
-	tmp &= ~0UL >> (64 - size);
-	if (!tmp)
-		return result + size;
- found_middle:
-	return result + __ffs(tmp);
-}
-
-/*
- * The optimizer actually does good code for this case.
- */
-#define find_first_zero_bit(addr, size) \
-	find_next_zero_bit((addr), (size), 0)
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
-
 #ifdef __KERNEL__
 
 /*
@@ -487,22 +313,15 @@
 	return __ffs(b0) + ofs;
 }
 
+#define HAVE_ARCH_SCHED_BITOPS
 
-#define ext2_set_bit                 __test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
-#define ext2_clear_bit               __test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
-#define ext2_test_bit                test_bit
-#define ext2_find_first_zero_bit     find_first_zero_bit
-#define ext2_find_next_zero_bit      find_next_zero_bit
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
+
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _ALPHA_BITOPS_H */
Index: 2.6-git/include/asm-arm/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-arm/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-arm/bitops.h	2006-01-25 19:14:13.000000000 +0900
@@ -118,66 +118,6 @@
 }
 
 /*
- * Now the non-atomic variants.  We let the compiler handle all
- * optimisations for these.  These are all _native_ endian.
- */
-static inline void __set_bit(int nr, volatile unsigned long *p)
-{
-	p[nr >> 5] |= (1UL << (nr & 31));
-}
-
-static inline void __clear_bit(int nr, volatile unsigned long *p)
-{
-	p[nr >> 5] &= ~(1UL << (nr & 31));
-}
-
-static inline void __change_bit(int nr, volatile unsigned long *p)
-{
-	p[nr >> 5] ^= (1UL << (nr & 31));
-}
-
-static inline int __test_and_set_bit(int nr, volatile unsigned long *p)
-{
-	unsigned long oldval, mask = 1UL << (nr & 31);
-
-	p += nr >> 5;
-
-	oldval = *p;
-	*p = oldval | mask;
-	return oldval & mask;
-}
-
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *p)
-{
-	unsigned long oldval, mask = 1UL << (nr & 31);
-
-	p += nr >> 5;
-
-	oldval = *p;
-	*p = oldval & ~mask;
-	return oldval & mask;
-}
-
-static inline int __test_and_change_bit(int nr, volatile unsigned long *p)
-{
-	unsigned long oldval, mask = 1UL << (nr & 31);
-
-	p += nr >> 5;
-
-	oldval = *p;
-	*p = oldval ^ mask;
-	return oldval & mask;
-}
-
-/*
- * This routine doesn't need to be atomic.
- */
-static inline int __test_bit(int nr, const volatile unsigned long * p)
-{
-	return (p[nr >> 5] >> (nr & 31)) & 1UL;
-}
-
-/*
  *  A note about Endian-ness.
  *  -------------------------
  *
@@ -261,7 +201,6 @@
 #define test_and_set_bit(nr,p)		ATOMIC_BITOP_LE(test_and_set_bit,nr,p)
 #define test_and_clear_bit(nr,p)	ATOMIC_BITOP_LE(test_and_clear_bit,nr,p)
 #define test_and_change_bit(nr,p)	ATOMIC_BITOP_LE(test_and_change_bit,nr,p)
-#define test_bit(nr,p)			__test_bit(nr,p)
 #define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
 #define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
 #define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
@@ -280,7 +219,6 @@
 #define test_and_set_bit(nr,p)		ATOMIC_BITOP_BE(test_and_set_bit,nr,p)
 #define test_and_clear_bit(nr,p)	ATOMIC_BITOP_BE(test_and_clear_bit,nr,p)
 #define test_and_change_bit(nr,p)	ATOMIC_BITOP_BE(test_and_change_bit,nr,p)
-#define test_bit(nr,p)			__test_bit(nr,p)
 #define find_first_zero_bit(p,sz)	_find_first_zero_bit_be(p,sz)
 #define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_be(p,sz,off)
 #define find_first_bit(p,sz)		_find_first_bit_be(p,sz)
@@ -290,59 +228,10 @@
 
 #endif
 
-#if __LINUX_ARM_ARCH__ < 5
+#define HAVE_ARCH_ATOMIC_BITOPS
+#define HAVE_ARCH_FIND_BITOPS
 
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long ffz(unsigned long word)
-{
-	int k;
-
-	word = ~word;
-	k = 31;
-	if (word & 0x0000ffff) { k -= 16; word <<= 16; }
-	if (word & 0x00ff0000) { k -= 8;  word <<= 8;  }
-	if (word & 0x0f000000) { k -= 4;  word <<= 4;  }
-	if (word & 0x30000000) { k -= 2;  word <<= 2;  }
-	if (word & 0x40000000) { k -= 1; }
-        return k;
-}
-
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long __ffs(unsigned long word)
-{
-	int k;
-
-	k = 31;
-	if (word & 0x0000ffff) { k -= 16; word <<= 16; }
-	if (word & 0x00ff0000) { k -= 8;  word <<= 8;  }
-	if (word & 0x0f000000) { k -= 4;  word <<= 4;  }
-	if (word & 0x30000000) { k -= 2;  word <<= 2;  }
-	if (word & 0x40000000) { k -= 1; }
-        return k;
-}
-
-/*
- * fls: find last bit set.
- */
-
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
-
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-
-#define ffs(x) generic_ffs(x)
-
-#else
+#if __LINUX_ARM_ARCH__ >= 5
 
 /*
  * On ARMv5 and above those functions can be implemented around
@@ -352,56 +241,27 @@
 #define fls(x) \
 	( __builtin_constant_p(x) ? generic_fls(x) : \
 	  ({ int __r; asm("clz\t%0, %1" : "=r"(__r) : "r"(x) : "cc"); 32-__r; }) )
-#define fls64(x)   generic_fls64(x)
 #define ffs(x) ({ unsigned long __t = (x); fls(__t & -__t); })
 #define __ffs(x) (ffs(x) - 1)
 #define ffz(x) __ffs( ~(x) )
 
-#endif
+#define HAVE_ARCH_FLS_BITOPS
+#define HAVE_ARCH_FFS_BITOPS
+#define HAVE_ARCH___FFS_BITOPS
+#define HAVE_ARCH_FFZ_BITOPS
 
-/*
- * Find first bit set in a 168-bit bitmap, where the first
- * 128 bits are unlikely to be set.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	unsigned long v;
-	unsigned int off;
-
-	for (off = 0; v = b[off], off < 4; off++) {
-		if (unlikely(v))
-			break;
-	}
-	return __ffs(v) + off * 32;
-}
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#endif
 
 /*
  * Ext2 is defined to use little-endian byte ordering.
  * These do not need to be atomic.
  */
-#define ext2_set_bit(nr,p)			\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define ext2_set_bit_atomic(lock,nr,p)          \
                 test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_clear_bit(nr,p)			\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define ext2_clear_bit_atomic(lock,nr,p)        \
                 test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_test_bit(nr,p)			\
-		__test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
-#define ext2_find_next_zero_bit(p,sz,off)	\
-		_find_next_zero_bit_le(p,sz,off)
+
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 /*
  * Minix is defined to use little-endian byte ordering.
@@ -418,6 +278,10 @@
 #define minix_find_first_zero_bit(p,sz)		\
 		_find_first_zero_bit_le(p,sz)
 
+#define HAVE_ARCH_MINIX_BITOPS
+
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _ARM_BITOPS_H */
Index: 2.6-git/include/asm-arm26/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-arm26/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-arm26/bitops.h	2006-01-25 19:14:14.000000000 +0900
@@ -118,66 +118,6 @@
 }
 
 /*
- * Now the non-atomic variants.  We let the compiler handle all
- * optimisations for these.  These are all _native_ endian.
- */
-static inline void __set_bit(int nr, volatile unsigned long *p)
-{
-	p[nr >> 5] |= (1UL << (nr & 31));
-}
-
-static inline void __clear_bit(int nr, volatile unsigned long *p)
-{
-	p[nr >> 5] &= ~(1UL << (nr & 31));
-}
-
-static inline void __change_bit(int nr, volatile unsigned long *p)
-{
-	p[nr >> 5] ^= (1UL << (nr & 31));
-}
-
-static inline int __test_and_set_bit(int nr, volatile unsigned long *p)
-{
-	unsigned long oldval, mask = 1UL << (nr & 31);
-
-	p += nr >> 5;
-
-	oldval = *p;
-	*p = oldval | mask;
-	return oldval & mask;
-}
-
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *p)
-{
-	unsigned long oldval, mask = 1UL << (nr & 31);
-
-	p += nr >> 5;
-
-	oldval = *p;
-	*p = oldval & ~mask;
-	return oldval & mask;
-}
-
-static inline int __test_and_change_bit(int nr, volatile unsigned long *p)
-{
-	unsigned long oldval, mask = 1UL << (nr & 31);
-
-	p += nr >> 5;
-
-	oldval = *p;
-	*p = oldval ^ mask;
-	return oldval & mask;
-}
-
-/*
- * This routine doesn't need to be atomic.
- */
-static inline int __test_bit(int nr, const volatile unsigned long * p)
-{
-	return (p[nr >> 5] >> (nr & 31)) & 1UL;
-}
-
-/*
  * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
  */
 extern void _set_bit_le(int nr, volatile unsigned long * p);
@@ -211,107 +151,28 @@
 #define test_and_set_bit(nr,p)		ATOMIC_BITOP_LE(test_and_set_bit,nr,p)
 #define test_and_clear_bit(nr,p)	ATOMIC_BITOP_LE(test_and_clear_bit,nr,p)
 #define test_and_change_bit(nr,p)	ATOMIC_BITOP_LE(test_and_change_bit,nr,p)
-#define test_bit(nr,p)			__test_bit(nr,p)
+
+#define HAVE_ARCH_ATOMIC_BITOPS
+
 #define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
 #define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
 #define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
 #define find_next_bit(p,sz,off)		_find_next_bit_le(p,sz,off)
 
-#define WORD_BITOFF_TO_LE(x)		((x))
-
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long ffz(unsigned long word)
-{
-	int k;
-
-	word = ~word;
-	k = 31;
-	if (word & 0x0000ffff) { k -= 16; word <<= 16; }
-	if (word & 0x00ff0000) { k -= 8;  word <<= 8;  }
-	if (word & 0x0f000000) { k -= 4;  word <<= 4;  }
-	if (word & 0x30000000) { k -= 2;  word <<= 2;  }
-	if (word & 0x40000000) { k -= 1; }
-        return k;
-}
-
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long __ffs(unsigned long word)
-{
-	int k;
-
-	k = 31;
-	if (word & 0x0000ffff) { k -= 16; word <<= 16; }
-	if (word & 0x00ff0000) { k -= 8;  word <<= 8;  }
-	if (word & 0x0f000000) { k -= 4;  word <<= 4;  }
-	if (word & 0x30000000) { k -= 2;  word <<= 2;  }
-	if (word & 0x40000000) { k -= 1; }
-        return k;
-}
-
-/*
- * fls: find last bit set.
- */
-
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
-
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-
-#define ffs(x) generic_ffs(x)
-
-/*
- * Find first bit set in a 168-bit bitmap, where the first
- * 128 bits are unlikely to be set.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	unsigned long v;
-	unsigned int off;
-
-	for (off = 0; v = b[off], off < 4; off++) {
-		if (unlikely(v))
-			break;
-	}
-	return __ffs(v) + off * 32;
-}
+#define HAVE_ARCH_FIND_BITOPS
 
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#define WORD_BITOFF_TO_LE(x)		((x))
 
 /*
  * Ext2 is defined to use little-endian byte ordering.
  * These do not need to be atomic.
  */
-#define ext2_set_bit(nr,p)			\
-		__test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define ext2_set_bit_atomic(lock,nr,p)          \
                 test_and_set_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_clear_bit(nr,p)			\
-		__test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
 #define ext2_clear_bit_atomic(lock,nr,p)        \
                 test_and_clear_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_test_bit(nr,p)			\
-		__test_bit(WORD_BITOFF_TO_LE(nr), (unsigned long *)(p))
-#define ext2_find_first_zero_bit(p,sz)		\
-		_find_first_zero_bit_le(p,sz)
-#define ext2_find_next_zero_bit(p,sz,off)	\
-		_find_next_zero_bit_le(p,sz,off)
+
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 /*
  * Minix is defined to use little-endian byte ordering.
@@ -328,6 +189,10 @@
 #define minix_find_first_zero_bit(p,sz)		\
 		_find_first_zero_bit_le(p,sz)
 
+#define HAVE_ARCH_MINIX_BITOPS
+
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _ARM_BITOPS_H */
Index: 2.6-git/include/asm-cris/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-cris/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-cris/bitops.h	2006-01-25 19:14:15.000000000 +0900
@@ -39,8 +39,6 @@
 
 #define set_bit(nr, addr)    (void)test_and_set_bit(nr, addr)
 
-#define __set_bit(nr, addr)    (void)__test_and_set_bit(nr, addr)
-
 /*
  * clear_bit - Clears a bit in memory
  * @nr: Bit to clear
@@ -54,8 +52,6 @@
 
 #define clear_bit(nr, addr)  (void)test_and_clear_bit(nr, addr)
 
-#define __clear_bit(nr, addr)  (void)__test_and_clear_bit(nr, addr)
-
 /*
  * change_bit - Toggle a bit in memory
  * @nr: Bit to change
@@ -68,18 +64,6 @@
 
 #define change_bit(nr, addr) (void)test_and_change_bit(nr, addr)
 
-/*
- * __change_bit - Toggle a bit in memory
- * @nr: the bit to change
- * @addr: the address to start counting from
- *
- * Unlike change_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-
-#define __change_bit(nr, addr) (void)__test_and_change_bit(nr, addr)
-
 /**
  * test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
@@ -105,18 +89,6 @@
 	return retval;
 }
 
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned int mask, retval;
-	unsigned int *adr = (unsigned int *)addr;
-	
-	adr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *adr) != 0;
-	*adr |= mask;
-	return retval;
-}
-
 /*
  * clear_bit() doesn't provide any barrier for the compiler.
  */
@@ -148,27 +120,6 @@
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.  
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned int mask, retval;
-	unsigned int *adr = (unsigned int *)addr;
-	
-	adr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *adr) != 0;
-	*adr &= ~mask;
-	return retval;
-}
-/**
  * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
@@ -191,38 +142,7 @@
 	return retval;
 }
 
-/* WARNING: non atomic and it can be reordered! */
-
-static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned int mask, retval;
-	unsigned int *adr = (unsigned int *)addr;
-
-	adr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *adr) != 0;
-	*adr ^= mask;
-
-	return retval;
-}
-
-/**
- * test_bit - Determine whether a bit is set
- * @nr: bit number to test
- * @addr: Address to start counting from
- *
- * This routine doesn't need to be atomic.
- */
-
-static inline int test_bit(int nr, const volatile unsigned long *addr)
-{
-	unsigned int mask;
-	unsigned int *adr = (unsigned int *)addr;
-	
-	adr += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	return ((mask & *adr) != 0);
-}
+#define HAVE_ARCH_ATOMIC_BITOPS
 
 /*
  * Find-bit routines..
@@ -235,153 +155,15 @@
  */
 #define ffs kernel_ffs
 
-/*
- * fls: find last bit set.
- */
-
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
-
-/*
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
+#define HAVE_ARCH_FFS_BITOPS
 
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-/**
- * find_next_zero_bit - find the first zero bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static inline int find_next_zero_bit (const unsigned long * addr, int size, int offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-	
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-	
- found_first:
-	tmp |= ~0UL >> size;
- found_middle:
-	return result + ffz(tmp);
-}
-
-/**
- * find_next_bit - find the first set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static __inline__ int find_next_bit(const unsigned long *addr, int size, int offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-        unsigned long result = offset & ~31UL;
-        unsigned long tmp;
-
-        if (offset >= size)
-                return size;
-        size -= result;
-        offset &= 31UL;
-        if (offset) {
-                tmp = *(p++);
-                tmp &= (~0UL << offset);
-                if (size < 32)
-                        goto found_first;
-                if (tmp)
-                        goto found_middle;
-                size -= 32;
-                result += 32;
-        }
-        while (size & ~31UL) {
-                if ((tmp = *(p++)))
-                        goto found_middle;
-                result += 32;
-                size -= 32;
-        }
-        if (!size)
-                return result;
-        tmp = *p;
-
-found_first:
-        tmp &= (~0UL >> (32 - size));
-        if (tmp == 0UL)        /* Are any bits set? */
-                return result + size; /* Nope. */
-found_middle:
-        return result + __ffs(tmp);
-}
-
-/**
- * find_first_zero_bit - find the first zero bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first zero bit, not the number of the byte
- * containing a bit.
- */
-
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-#define find_first_bit(addr, size) \
-        find_next_bit((addr), (size), 0)
-
-#define ext2_set_bit                 test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
-#define ext2_clear_bit               test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
-#define ext2_test_bit                test_bit
-#define ext2_find_first_zero_bit     find_first_zero_bit
-#define ext2_find_next_zero_bit      find_next_zero_bit
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (unlikely(b[3]))
-		return __ffs(b[3]) + 96;
-	if (b[4])
-		return __ffs(b[4]) + 128;
-	return __ffs(b[5]) + 32 + 128;
-}
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _CRIS_BITOPS_H */
Index: 2.6-git/include/asm-frv/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-frv/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-frv/bitops.h	2006-01-25 19:14:15.000000000 +0900
@@ -23,21 +23,6 @@
 #ifdef __KERNEL__
 
 /*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long ffz(unsigned long word)
-{
-	unsigned long result = 0;
-
-	while (word & 1) {
-		result++;
-		word >>= 1;
-	}
-	return result;
-}
-
-/*
  * clear_bit() doesn't provide any barrier for the compiler.
  */
 #define smp_mb__before_clear_bit()	barrier()
@@ -82,6 +67,8 @@
 	test_and_change_bit(nr, addr);
 }
 
+#define HAVE_ARCH_ATOMIC_BITOPS
+
 static inline void __clear_bit(int nr, volatile void * addr)
 {
 	volatile unsigned long *a = addr;
@@ -171,51 +158,7 @@
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)))
 
-extern int find_next_bit(const unsigned long *addr, int size, int offset);
-
-#define find_first_bit(addr, size) find_next_bit(addr, size, 0)
-
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-
-static inline int find_next_zero_bit(const void *addr, int size, int offset)
-{
-	const unsigned long *p = ((const unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL >> size;
-found_middle:
-	return result + ffz(tmp);
-}
-
-#define ffs(x) generic_ffs(x)
-#define __ffs(x) (ffs(x) - 1)
+#define HAVE_ARCH_NON_ATOMIC_BITOPS
 
 /*
  * fls: find last bit set.
@@ -228,107 +171,13 @@
 							\
 	bit ? 33 - bit : bit;				\
 })
-#define fls64(x)   generic_fls64(x)
 
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-#define ext2_set_bit(nr, addr)		test_and_set_bit  ((nr) ^ 0x18, (addr))
-#define ext2_clear_bit(nr, addr)	test_and_clear_bit((nr) ^ 0x18, (addr))
+#define HAVE_ARCH_FLS_BITOPS
 
 #define ext2_set_bit_atomic(lock,nr,addr)	ext2_set_bit((nr), addr)
 #define ext2_clear_bit_atomic(lock,nr,addr)	ext2_clear_bit((nr), addr)
 
-static inline int ext2_test_bit(int nr, const volatile void * addr)
-{
-	const volatile unsigned char *ADDR = (const unsigned char *) addr;
-	int mask;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	return ((mask & *ADDR) != 0);
-}
-
-#define ext2_find_first_zero_bit(addr, size) \
-        ext2_find_next_zero_bit((addr), (size), 0)
-
-static inline unsigned long ext2_find_next_zero_bit(const void *addr,
-						    unsigned long size,
-						    unsigned long offset)
-{
-	const unsigned long *p = ((const unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if(offset) {
-		/* We hold the little endian value in tmp, but then the
-		 * shift is illegal. So we could keep a big endian value
-		 * in tmp, like this:
-		 *
-		 * tmp = __swab32(*(p++));
-		 * tmp |= ~0UL >> (32-offset);
-		 *
-		 * but this would decrease preformance, so we change the
-		 * shift:
-		 */
-		tmp = *(p++);
-		tmp |= __swab32(~0UL >> (32-offset));
-		if(size < 32)
-			goto found_first;
-		if(~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while(size & ~31UL) {
-		if(~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if(!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	/* tmp is little endian, so we would have to swab the shift,
-	 * see above. But then we have to swab tmp below for ffz, so
-	 * we might as well do this here.
-	 */
-	return result + ffz(__swab32(tmp) | (~0UL << size));
-found_middle:
-	return result + ffz(__swab32(tmp));
-}
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 /* Bitmap functions for the minix filesystem.  */
 #define minix_test_and_set_bit(nr,addr)		ext2_set_bit(nr,addr)
@@ -337,6 +186,10 @@
 #define minix_test_bit(nr,addr)			ext2_test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size)	ext2_find_first_zero_bit(addr,size)
 
+#define HAVE_ARCH_MINIX_BITOPS
+
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _ASM_BITOPS_H */
Index: 2.6-git/include/asm-h8300/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-h8300/bitops.h	2006-01-25 19:14:01.000000000 +0900
+++ 2.6-git/include/asm-h8300/bitops.h	2006-01-25 19:14:15.000000000 +0900
@@ -34,6 +34,8 @@
 	return result;
 }
 
+#define HAVE_ARCH_FFZ_BITOPS
+
 #define H8300_GEN_BITOP_CONST(OP,BIT)			    \
 	case BIT:					    \
 	__asm__(OP " #" #BIT ",@%0"::"r"(b_addr):"memory"); \
@@ -177,10 +179,8 @@
 #undef H8300_GEN_TEST_BITOP_CONST_INT
 #undef H8300_GEN_TEST_BITOP
 
-#define find_first_zero_bit(addr, size) \
-	find_next_zero_bit((addr), (size), 0)
-
-#define ffs(x) generic_ffs(x)
+#define HAVE_ARCH_ATOMIC_NAVIVE_BITOPS
+#define HAVE_ARCH_NON_ATOMIC_NAVIVE_BITOPS
 
 static __inline__ unsigned long __ffs(unsigned long word)
 {
@@ -196,216 +196,10 @@
 	return result;
 }
 
-static __inline__ int find_next_zero_bit (const unsigned long * addr, int size, int offset)
-{
-	unsigned long *p = (unsigned long *)(((unsigned long)addr + (offset >> 3)) & ~3);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL >> size;
-found_middle:
-	return result + ffz(tmp);
-}
-
-static __inline__ unsigned long find_next_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned long *p = (unsigned long *)(((unsigned long)addr + (offset >> 3)) & ~3);
-	unsigned int result = offset & ~31UL;
-	unsigned int tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp &= ~0UL << offset;
-		if (size < 32)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size >= 32) {
-		if ((tmp = *p++) != 0)
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= ~0UL >> (32 - size);
-	if (tmp == 0UL)
-		return result + size;
-found_middle:
-	return result + __ffs(tmp);
-}
-
-#define find_first_bit(addr, size) find_next_bit(addr, size, 0)
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-static __inline__ int ext2_set_bit(int nr, volatile void * addr)
-{
-	int		mask, retval;
-	unsigned long	flags;
-	volatile unsigned char	*ADDR = (unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
-	retval = (mask & *ADDR) != 0;
-	*ADDR |= mask;
-	local_irq_restore(flags);
-	return retval;
-}
-#define ext2_set_bit_atomic(lock, nr, addr) ext2_set_bit(nr, addr)
-
-static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
-{
-	int		mask, retval;
-	unsigned long	flags;
-	volatile unsigned char	*ADDR = (unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
-	retval = (mask & *ADDR) != 0;
-	*ADDR &= ~mask;
-	local_irq_restore(flags);
-	return retval;
-}
-#define ext2_clear_bit_atomic(lock, nr, addr) ext2_set_bit(nr, addr)
-
-static __inline__ int ext2_test_bit(int nr, const volatile void * addr)
-{
-	int			mask;
-	const volatile unsigned char	*ADDR = (const unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	return ((mask & *ADDR) != 0);
-}
-
-#define ext2_find_first_zero_bit(addr, size) \
-	ext2_find_next_zero_bit((addr), (size), 0)
-
-static __inline__ unsigned long ext2_find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if(offset) {
-		/* We hold the little endian value in tmp, but then the
-		 * shift is illegal. So we could keep a big endian value
-		 * in tmp, like this:
-		 *
-		 * tmp = __swab32(*(p++));
-		 * tmp |= ~0UL >> (32-offset);
-		 *
-		 * but this would decrease performance, so we change the
-		 * shift:
-		 */
-		tmp = *(p++);
-		tmp |= __swab32(~0UL >> (32-offset));
-		if(size < 32)
-			goto found_first;
-		if(~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while(size & ~31UL) {
-		if(~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if(!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	/* tmp is little endian, so we would have to swab the shift,
-	 * see above. But then we have to swab tmp below for ffz, so
-	 * we might as well do this here.
-	 */
-	return result + ffz(__swab32(tmp) | (~0UL << size));
-found_middle:
-	return result + ffz(__swab32(tmp));
-}
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
+#define HAVE_ARCH___FFS_BITOPS
 
 #endif /* __KERNEL__ */
 
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+#include <asm-generic/bitops.h>
 
 #endif /* _H8300_BITOPS_H */
Index: 2.6-git/include/asm-i386/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-i386/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-i386/bitops.h	2006-01-25 19:14:16.000000000 +0900
@@ -270,6 +270,9 @@
 
 #undef ADDR
 
+#define HAVE_ARCH_ATOMIC_BITOPS
+#define HAVE_ARCH_NON_ATOMIC_BITOPS
+
 /**
  * find_first_zero_bit - find the first zero bit in a memory region
  * @addr: The address to start the search at
@@ -310,6 +313,8 @@
  */
 int find_next_zero_bit(const unsigned long *addr, int size, int offset);
 
+#define HAVE_ARCH_FIND_BITOPS
+
 /**
  * __ffs - find first bit in word.
  * @word: The word to search
@@ -324,6 +329,8 @@
 	return word;
 }
 
+#define HAVE_ARCH___FFS_BITOPS
+
 /**
  * find_first_bit - find the first set bit in a memory region
  * @addr: The address to start the search at
@@ -367,29 +374,10 @@
 	return word;
 }
 
-#define fls64(x)   generic_fls64(x)
+#define HAVE_ARCH_FFZ_BITOPS
 
 #ifdef __KERNEL__
 
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
 /**
  * ffs - find first bit set
  * @x: the word to search
@@ -409,6 +397,8 @@
 	return r+1;
 }
 
+#define HAVE_ARCH_FFS_BITOPS
+
 /**
  * fls - find last bit set
  * @x: the word to search
@@ -426,43 +416,21 @@
 	return r+1;
 }
 
-/**
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#define HAVE_ARCH_FLS_BITOPS
 
 #endif /* __KERNEL__ */
 
 #ifdef __KERNEL__
 
-#define ext2_set_bit(nr,addr) \
-	__test_and_set_bit((nr),(unsigned long*)addr)
 #define ext2_set_bit_atomic(lock,nr,addr) \
         test_and_set_bit((nr),(unsigned long*)addr)
-#define ext2_clear_bit(nr, addr) \
-	__test_and_clear_bit((nr),(unsigned long*)addr)
 #define ext2_clear_bit_atomic(lock,nr, addr) \
 	        test_and_clear_bit((nr),(unsigned long*)addr)
-#define ext2_test_bit(nr, addr)      test_bit((nr),(unsigned long*)addr)
-#define ext2_find_first_zero_bit(addr, size) \
-	find_first_zero_bit((unsigned long*)addr, size)
-#define ext2_find_next_zero_bit(addr, size, off) \
-	find_next_zero_bit((unsigned long*)addr, size, off)
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,(void*)addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,(void*)addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,(void*)addr)
-#define minix_test_bit(nr,addr) test_bit(nr,(void*)addr)
-#define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_bit((void*)addr,size)
+
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _I386_BITOPS_H */
Index: 2.6-git/include/asm-ia64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-ia64/bitops.h	2006-01-25 19:14:02.000000000 +0900
+++ 2.6-git/include/asm-ia64/bitops.h	2006-01-25 19:14:17.000000000 +0900
@@ -47,21 +47,6 @@
 	} while (cmpxchg_acq(m, old, new) != old);
 }
 
-/**
- * __set_bit - Set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike set_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static __inline__ void
-__set_bit (int nr, volatile void *addr)
-{
-	*((__u32 *) addr + (nr >> 5)) |= (1 << (nr & 31));
-}
-
 /*
  * clear_bit() has "acquire" semantics.
  */
@@ -95,17 +80,6 @@
 }
 
 /**
- * __clear_bit - Clears a bit in memory (non-atomic version)
- */
-static __inline__ void
-__clear_bit (int nr, volatile void *addr)
-{
-	volatile __u32 *p = (__u32 *) addr + (nr >> 5);
-	__u32 m = 1 << (nr & 31);
-	*p &= ~m;
-}
-
-/**
  * change_bit - Toggle a bit in memory
  * @nr: Bit to clear
  * @addr: Address to start counting from
@@ -131,21 +105,6 @@
 }
 
 /**
- * __change_bit - Toggle a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike change_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static __inline__ void
-__change_bit (int nr, volatile void *addr)
-{
-	*((__u32 *) addr + (nr >> 5)) ^= (1 << (nr & 31));
-}
-
-/**
  * test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -171,26 +130,6 @@
 }
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.  
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static __inline__ int
-__test_and_set_bit (int nr, volatile void *addr)
-{
-	__u32 *p = (__u32 *) addr + (nr >> 5);
-	__u32 m = 1 << (nr & 31);
-	int oldbitset = (*p & m) != 0;
-
-	*p |= m;
-	return oldbitset;
-}
-
-/**
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -216,26 +155,6 @@
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.  
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static __inline__ int
-__test_and_clear_bit(int nr, volatile void * addr)
-{
-	__u32 *p = (__u32 *) addr + (nr >> 5);
-	__u32 m = 1 << (nr & 31);
-	int oldbitset = *p & m;
-
-	*p &= ~m;
-	return oldbitset;
-}
-
-/**
  * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -260,25 +179,7 @@
 	return (old & bit) != 0;
 }
 
-/*
- * WARNING: non atomic version.
- */
-static __inline__ int
-__test_and_change_bit (int nr, void *addr)
-{
-	__u32 old, bit = (1 << (nr & 31));
-	__u32 *m = (__u32 *) addr + (nr >> 5);
-
-	old = *m;
-	*m = old ^ bit;
-	return (old & bit) != 0;
-}
-
-static __inline__ int
-test_bit (int nr, const volatile void *addr)
-{
-	return 1 & (((const volatile __u32 *) addr)[nr >> 5] >> (nr & 31));
-}
+#define HAVE_ARCH_ATOMIC_BITOPS
 
 /**
  * ffz - find the first zero bit in a long word
@@ -296,6 +197,8 @@
 	return result;
 }
 
+#define HAVE_ARCH_FFZ_BITOPS
+
 /**
  * __ffs - find first bit in word.
  * @x: The word to search
@@ -311,6 +214,8 @@
 	return result;
 }
 
+#define HAVE_ARCH___FFS_BITOPS
+
 #ifdef __KERNEL__
 
 /*
@@ -345,7 +250,8 @@
 	x |= x >> 16;
 	return ia64_popcnt(x);
 }
-#define fls64(x)   generic_fls64(x)
+
+#define HAVE_ARCH_FLS_BITOPS
 
 /*
  * ffs: find first bit set. This is defined the same way as the libc and compiler builtin
@@ -355,6 +261,8 @@
  */
 #define ffs(x)	__builtin_ffs(x)
 
+#define HAVE_ARCH_FFS_BITOPS
+
 /*
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
@@ -367,10 +275,14 @@
 	return result;
 }
 
+#define HAVE_ARCH_HWEIGHT64_BITOPS
+
 #define hweight32(x)	(unsigned int) hweight64((x) & 0xfffffffful)
 #define hweight16(x)	(unsigned int) hweight64((x) & 0xfffful)
 #define hweight8(x)	(unsigned int) hweight64((x) & 0xfful)
 
+#define HAVE_ARCH_HWEIGHT_BITOPS
+
 #endif /* __KERNEL__ */
 
 extern int __find_next_zero_bit (const void *addr, unsigned long size,
@@ -390,35 +302,17 @@
 
 #define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
 
-#ifdef __KERNEL__
+#define HAVE_ARCH_FIND_BITOPS
 
-#define __clear_bit(nr, addr)		clear_bit(nr, addr)
+#ifdef __KERNEL__
 
-#define ext2_set_bit			__test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)	test_and_set_bit(n,a)
-#define ext2_clear_bit			__test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a)	test_and_clear_bit(n,a)
-#define ext2_test_bit			test_bit
-#define ext2_find_first_zero_bit	find_first_zero_bit
-#define ext2_find_next_zero_bit		find_next_zero_bit
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)		__test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr)			__set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr)	__test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr)			test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size)	find_first_zero_bit(addr,size)
 
-static inline int
-sched_find_first_bit (unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return 64 + __ffs(b[1]);
-	return __ffs(b[2]) + 128;
-}
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _ASM_IA64_BITOPS_H */
Index: 2.6-git/include/asm-m32r/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-m32r/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-m32r/bitops.h	2006-01-25 19:14:18.000000000 +0900
@@ -63,25 +63,6 @@
 }
 
 /**
- * __set_bit - Set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike set_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static __inline__ void __set_bit(int nr, volatile void * addr)
-{
-	__u32 mask;
-	volatile __u32 *a = addr;
-
-	a += (nr >> 5);
-	mask = (1 << (nr & 0x1F));
-	*a |= mask;
-}
-
-/**
  * clear_bit - Clears a bit in memory
  * @nr: Bit to clear
  * @addr: Address to start counting from
@@ -118,39 +99,10 @@
 	local_irq_restore(flags);
 }
 
-static __inline__ void __clear_bit(int nr, volatile unsigned long * addr)
-{
-	unsigned long mask;
-	volatile unsigned long *a = addr;
-
-	a += (nr >> 5);
-	mask = (1 << (nr & 0x1F));
-	*a &= ~mask;
-}
-
 #define smp_mb__before_clear_bit()	barrier()
 #define smp_mb__after_clear_bit()	barrier()
 
 /**
- * __change_bit - Toggle a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike change_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static __inline__ void __change_bit(int nr, volatile void * addr)
-{
-	__u32 mask;
-	volatile __u32 *a = addr;
-
-	a += (nr >> 5);
-	mask = (1 << (nr & 0x1F));
-	*a ^= mask;
-}
-
-/**
  * change_bit - Toggle a bit in memory
  * @nr: Bit to clear
  * @addr: Address to start counting from
@@ -221,28 +173,6 @@
 }
 
 /**
- * __test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
-{
-	__u32 mask, oldbit;
-	volatile __u32 *a = addr;
-
-	a += (nr >> 5);
-	mask = (1 << (nr & 0x1F));
-	oldbit = (*a & mask);
-	*a |= mask;
-
-	return (oldbit != 0);
-}
-
-/**
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -280,42 +210,6 @@
 }
 
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static __inline__ int __test_and_clear_bit(int nr, volatile void * addr)
-{
-	__u32 mask, oldbit;
-	volatile __u32 *a = addr;
-
-	a += (nr >> 5);
-	mask = (1 << (nr & 0x1F));
-	oldbit = (*a & mask);
-	*a &= ~mask;
-
-	return (oldbit != 0);
-}
-
-/* WARNING: non atomic and it can be reordered! */
-static __inline__ int __test_and_change_bit(int nr, volatile void * addr)
-{
-	__u32 mask, oldbit;
-	volatile __u32 *a = addr;
-
-	a += (nr >> 5);
-	mask = (1 << (nr & 0x1F));
-	oldbit = (*a & mask);
-	*a ^= mask;
-
-	return (oldbit != 0);
-}
-
-/**
  * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -350,354 +244,8 @@
 	return (oldbit != 0);
 }
 
-/**
- * test_bit - Determine whether a bit is set
- * @nr: bit number to test
- * @addr: Address to start counting from
- */
-static __inline__ int test_bit(int nr, const volatile void * addr)
-{
-	__u32 mask;
-	const volatile __u32 *a = addr;
-
-	a += (nr >> 5);
-	mask = (1 << (nr & 0x1F));
-
-	return ((*a & mask) != 0);
-}
-
-/**
- * ffz - find first zero in word.
- * @word: The word to search
- *
- * Undefined if no zero exists, so code should check against ~0UL first.
- */
-static __inline__ unsigned long ffz(unsigned long word)
-{
-	int k;
-
-	word = ~word;
-	k = 0;
-	if (!(word & 0x0000ffff)) { k += 16; word >>= 16; }
-	if (!(word & 0x000000ff)) { k += 8; word >>= 8; }
-	if (!(word & 0x0000000f)) { k += 4; word >>= 4; }
-	if (!(word & 0x00000003)) { k += 2; word >>= 2; }
-	if (!(word & 0x00000001)) { k += 1; }
-
-	return k;
-}
-
-/**
- * find_first_zero_bit - find the first zero bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first zero bit, not the number of the byte
- * containing a bit.
- */
-
-#define find_first_zero_bit(addr, size) \
-	find_next_zero_bit((addr), (size), 0)
-
-/**
- * find_next_zero_bit - find the first zero bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static __inline__ int find_next_zero_bit(const unsigned long *addr,
-					 int size, int offset)
-{
-	const unsigned long *p = addr + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL << size;
-found_middle:
-	return result + ffz(tmp);
-}
-
-/**
- * __ffs - find first bit in word.
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- */
-static __inline__ unsigned long __ffs(unsigned long word)
-{
-	int k = 0;
-
-	if (!(word & 0x0000ffff)) { k += 16; word >>= 16; }
-	if (!(word & 0x000000ff)) { k += 8; word >>= 8; }
-	if (!(word & 0x0000000f)) { k += 4; word >>= 4; }
-	if (!(word & 0x00000003)) { k += 2; word >>= 2; }
-	if (!(word & 0x00000001)) { k += 1;}
-
-	return k;
-}
-
-/*
- * fls: find last bit set.
- */
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
-
-#ifdef __KERNEL__
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
-/**
- * find_next_bit - find the first set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static inline unsigned long find_next_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
-	unsigned int result = offset & ~31UL;
-	unsigned int tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *p++;
-		tmp &= ~0UL << offset;
-		if (size < 32)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size >= 32) {
-		if ((tmp = *p++) != 0)
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= ~0UL >> (32 - size);
-	if (tmp == 0UL)        /* Are any bits set? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + __ffs(tmp);
-}
-
-/**
- * find_first_bit - find the first set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first set bit, not the number of the byte
- * containing a bit.
- */
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
-
-/**
- * ffs - find first bit set
- * @x: the word to search
- *
- * This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-#define ffs(x)	generic_ffs(x)
-
-/**
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-#define hweight32(x)	generic_hweight32(x)
-#define hweight16(x)	generic_hweight16(x)
-#define hweight8(x)	generic_hweight8(x)
-
-#endif /* __KERNEL__ */
-
-#ifdef __KERNEL__
-
-/*
- * ext2_XXXX function
- * orig: include/asm-sh/bitops.h
- */
-
-#ifdef __LITTLE_ENDIAN__
-#define ext2_set_bit			test_and_set_bit
-#define ext2_clear_bit			__test_and_clear_bit
-#define ext2_test_bit			test_bit
-#define ext2_find_first_zero_bit	find_first_zero_bit
-#define ext2_find_next_zero_bit		find_next_zero_bit
-#else
-static inline int ext2_set_bit(int nr, volatile void * addr)
-{
-	__u8 mask, oldbit;
-	volatile __u8 *a = addr;
-
-	a += (nr >> 3);
-	mask = (1 << (nr & 0x07));
-	oldbit = (*a & mask);
-	*a |= mask;
-
-	return (oldbit != 0);
-}
-
-static inline int ext2_clear_bit(int nr, volatile void * addr)
-{
-	__u8 mask, oldbit;
-	volatile __u8 *a = addr;
-
-	a += (nr >> 3);
-	mask = (1 << (nr & 0x07));
-	oldbit = (*a & mask);
-	*a &= ~mask;
-
-	return (oldbit != 0);
-}
-
-static inline int ext2_test_bit(int nr, const volatile void * addr)
-{
-	__u32 mask;
-	const volatile __u8 *a = addr;
-
-	a += (nr >> 3);
-	mask = (1 << (nr & 0x07));
-
-	return ((mask & *a) != 0);
-}
-
-#define ext2_find_first_zero_bit(addr, size) \
-	ext2_find_next_zero_bit((addr), (size), 0)
-
-static inline unsigned long ext2_find_next_zero_bit(void *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if(offset) {
-		/* We hold the little endian value in tmp, but then the
-		 * shift is illegal. So we could keep a big endian value
-		 * in tmp, like this:
-		 *
-		 * tmp = __swab32(*(p++));
-		 * tmp |= ~0UL >> (32-offset);
-		 *
-		 * but this would decrease preformance, so we change the
-		 * shift:
-		 */
-		tmp = *(p++);
-		tmp |= __swab32(~0UL >> (32-offset));
-		if(size < 32)
-			goto found_first;
-		if(~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while(size & ~31UL) {
-		if(~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if(!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	/* tmp is little endian, so we would have to swab the shift,
-	 * see above. But then we have to swab tmp below for ffz, so
-	 * we might as well do this here.
-	 */
-	return result + ffz(__swab32(tmp) | (~0UL << size));
-found_middle:
-	return result + ffz(__swab32(tmp));
-}
-#endif
-
-#define ext2_set_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_set_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-#define ext2_clear_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_clear_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)		__test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr)			__set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr)	__test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size)	find_first_zero_bit(addr,size)
+#define HAVE_ARCH_ATOMIC_BITOPS
 
-#endif /* __KERNEL__ */
+#include <asm-generic/bitops.h>
 
 #endif /* _ASM_M32R_BITOPS_H */
Index: 2.6-git/include/asm-m68k/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-m68k/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-m68k/bitops.h	2006-01-25 19:14:19.000000000 +0900
@@ -172,6 +172,9 @@
 	return (vaddr[nr >> 5] & (1UL << (nr & 31))) != 0;
 }
 
+#define HAVE_ARCH_ATOMIC_BITOPS
+#define HAVE_ARCH_NON_ATOMIC_BITOPS
+
 static inline int find_first_zero_bit(const unsigned long *vaddr,
 				      unsigned size)
 {
@@ -267,6 +270,8 @@
 	return offset + res;
 }
 
+#define HAVE_ARCH_FIND_BITOPS
+
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
@@ -280,6 +285,8 @@
 	return res ^ 31;
 }
 
+#define HAVE_ARCH_FFZ_BITOPS
+
 #ifdef __KERNEL__
 
 /*
@@ -298,6 +305,9 @@
 }
 #define __ffs(x) (ffs(x) - 1)
 
+#define HAVE_ARCH_FFS_BITOPS
+#define HAVE_ARCH___FFS_BITOPS
+
 /*
  * fls: find last bit set.
  */
@@ -310,36 +320,8 @@
 
 	return 32 - cnt;
 }
-#define fls64(x)   generic_fls64(x)
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
 
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#define HAVE_ARCH_FLS_BITOPS
 
 /* Bitmap functions for the minix filesystem */
 
@@ -377,61 +359,14 @@
 
 /* Bitmap functions for the ext2 filesystem. */
 
-#define ext2_set_bit(nr, addr)			test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
 #define ext2_set_bit_atomic(lock, nr, addr)	test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
-#define ext2_clear_bit(nr, addr)		test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
 #define ext2_clear_bit_atomic(lock, nr, addr)	test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
 
-static inline int ext2_test_bit(int nr, const void *vaddr)
-{
-	const unsigned char *p = vaddr;
-	return (p[nr >> 3] & (1U << (nr & 7))) != 0;
-}
-
-static inline int ext2_find_first_zero_bit(const void *vaddr, unsigned size)
-{
-	const unsigned long *p = vaddr, *addr = vaddr;
-	int res;
-
-	if (!size)
-		return 0;
-
-	size = (size >> 5) + ((size & 31) > 0);
-	while (*p++ == ~0UL)
-	{
-		if (--size == 0)
-			return (p - addr) << 5;
-	}
-
-	--p;
-	for (res = 0; res < 32; res++)
-		if (!ext2_test_bit (res, p))
-			break;
-	return (p - addr) * 32 + res;
-}
-
-static inline int ext2_find_next_zero_bit(const void *vaddr, unsigned size,
-					  unsigned offset)
-{
-	const unsigned long *addr = vaddr;
-	const unsigned long *p = addr + (offset >> 5);
-	int bit = offset & 31UL, res;
-
-	if (offset >= size)
-		return size;
-
-	if (bit) {
-		/* Look for zero in first longword */
-		for (res = bit; res < 32; res++)
-			if (!ext2_test_bit (res, p))
-				return (p - addr) * 32 + res;
-		p++;
-	}
-	/* No zero yet, search remaining full bytes for a zero */
-	res = ext2_find_first_zero_bit (p, size - 32 * (p - addr));
-	return (p - addr) * 32 + res;
-}
+#define HAVE_ARCH_MINIX_BITOPS
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _M68K_BITOPS_H */
Index: 2.6-git/include/asm-m68knommu/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-m68knommu/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-m68knommu/bitops.h	2006-01-25 19:14:20.000000000 +0900
@@ -12,105 +12,6 @@
 
 #ifdef __KERNEL__
 
-/*
- *	Generic ffs().
- */
-static inline int ffs(int x)
-{
-	int r = 1;
-
-	if (!x)
-		return 0;
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
-	return r;
-}
-
-/*
- *	Generic __ffs().
- */
-static inline int __ffs(int x)
-{
-	int r = 0;
-
-	if (!x)
-		return 0;
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
-	return r;
-}
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static __inline__ unsigned long ffz(unsigned long word)
-{
-	unsigned long result = 0;
-
-	while(word & 1) {
-		result++;
-		word >>= 1;
-	}
-	return result;
-}
-
-
 static __inline__ void set_bit(int nr, volatile unsigned long * addr)
 {
 #ifdef CONFIG_COLDFIRE
@@ -254,98 +155,8 @@
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)))
 
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-#define find_first_bit(addr, size) \
-        find_next_bit((addr), (size), 0)
-
-static __inline__ int find_next_zero_bit (const void * addr, int size, int offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL << size;
-found_middle:
-	return result + ffz(tmp);
-}
-
-/*
- * Find next one bit in a bitmap reasonably efficiently.
- */
-static __inline__ unsigned long find_next_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
-	unsigned int result = offset & ~31UL;
-	unsigned int tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *p++;
-		tmp &= ~0UL << offset;
-		if (size < 32)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size >= 32) {
-		if ((tmp = *p++) != 0)
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= ~0UL >> (32 - size);
-	if (tmp == 0UL)        /* Are any bits set? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + __ffs(tmp);
-}
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
+#define HAVE_ARCH_ATOMIC_BITOPS
+#define HAVE_ARCH_NON_ATOMIC_BITOPS
 
 static __inline__ int ext2_set_bit(int nr, volatile void * addr)
 {
@@ -475,30 +286,11 @@
 	return result + ffz(__swab32(tmp));
 }
 
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
-
-/**
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
+#define HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS
 
 #endif /* __KERNEL__ */
 
-/*
- * fls: find last bit set.
- */
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+#include <asm-generic/bitops.h>
 
 #endif /* _M68KNOMMU_BITOPS_H */
Index: 2.6-git/include/asm-mips/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-mips/bitops.h	2006-01-25 19:14:05.000000000 +0900
+++ 2.6-git/include/asm-mips/bitops.h	2006-01-25 19:14:21.000000000 +0900
@@ -105,22 +105,6 @@
 }
 
 /*
- * __set_bit - Set a bit in memory
- * @nr: the bit to set
- * @addr: the address to start counting from
- *
- * Unlike set_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static inline void __set_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long * m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-
-	*m |= 1UL << (nr & SZLONG_MASK);
-}
-
-/*
  * clear_bit - Clears a bit in memory
  * @nr: Bit to clear
  * @addr: Address to start counting from
@@ -169,22 +153,6 @@
 }
 
 /*
- * __clear_bit - Clears a bit in memory
- * @nr: Bit to clear
- * @addr: Address to start counting from
- *
- * Unlike clear_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static inline void __clear_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long * m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-
-	*m &= ~(1UL << (nr & SZLONG_MASK));
-}
-
-/*
  * change_bit - Toggle a bit in memory
  * @nr: Bit to change
  * @addr: Address to start counting from
@@ -235,22 +203,6 @@
 }
 
 /*
- * __change_bit - Toggle a bit in memory
- * @nr: the bit to change
- * @addr: the address to start counting from
- *
- * Unlike change_bit(), this function is non-atomic and may be reordered.
- * If it's called on the same region of memory simultaneously, the effect
- * may be that only one operation succeeds.
- */
-static inline void __change_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long * m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-
-	*m ^= 1UL << (nr & SZLONG_MASK);
-}
-
-/*
  * test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -321,30 +273,6 @@
 }
 
 /*
- * __test_and_set_bit - Set a bit and return its old value
- * @nr: Bit to set
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static inline int __test_and_set_bit(unsigned long nr,
-	volatile unsigned long *addr)
-{
-	volatile unsigned long *a = addr;
-	unsigned long mask;
-	int retval;
-
-	a += nr >> SZLONG_LOG;
-	mask = 1UL << (nr & SZLONG_MASK);
-	retval = (mask & *a) != 0;
-	*a |= mask;
-
-	return retval;
-}
-
-/*
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
@@ -417,30 +345,6 @@
 }
 
 /*
- * __test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to clear
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static inline int __test_and_clear_bit(unsigned long nr,
-	volatile unsigned long * addr)
-{
-	volatile unsigned long *a = addr;
-	unsigned long mask;
-	int retval;
-
-	a += (nr >> SZLONG_LOG);
-	mask = 1UL << (nr & SZLONG_MASK);
-	retval = ((mask & *a) != 0);
-	*a &= ~mask;
-
-	return retval;
-}
-
-/*
  * test_and_change_bit - Change a bit and return its old value
  * @nr: Bit to change
  * @addr: Address to count from
@@ -509,43 +413,11 @@
 	}
 }
 
-/*
- * __test_and_change_bit - Change a bit and return its old value
- * @nr: Bit to change
- * @addr: Address to count from
- *
- * This operation is non-atomic and can be reordered.
- * If two examples of this operation race, one can appear to succeed
- * but actually fail.  You must protect multiple accesses with a lock.
- */
-static inline int __test_and_change_bit(unsigned long nr,
-	volatile unsigned long *addr)
-{
-	volatile unsigned long *a = addr;
-	unsigned long mask;
-	int retval;
-
-	a += (nr >> SZLONG_LOG);
-	mask = 1UL << (nr & SZLONG_MASK);
-	retval = ((mask & *a) != 0);
-	*a ^= mask;
-
-	return retval;
-}
-
 #undef __bi_flags
 #undef __bi_local_irq_save
 #undef __bi_local_irq_restore
 
-/*
- * test_bit - Determine whether a bit is set
- * @nr: bit number to test
- * @addr: Address to start counting from
- */
-static inline int test_bit(unsigned long nr, const volatile unsigned long *addr)
-{
-	return 1UL & (addr[nr >> SZLONG_LOG] >> (nr & SZLONG_MASK));
-}
+#define HAVE_ARCH_ATOMIC_BITOPS
 
 /*
  * Return the bit position (0..63) of the most significant 1 bit in a word
@@ -580,6 +452,8 @@
 	return 63 - lz;
 }
 
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
+
 /*
  * __ffs - find first bit in word.
  * @word: The word to search
@@ -589,33 +463,11 @@
  */
 static inline unsigned long __ffs(unsigned long word)
 {
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
 	return __ilog2(word & -word);
-#else
-	int b = 0, s;
-
-#ifdef CONFIG_32BIT
-	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
-	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
-	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
-	s =  2; if (word << 30 != 0) s = 0; b += s; word >>= s;
-	s =  1; if (word << 31 != 0) s = 0; b += s;
-
-	return b;
-#endif
-#ifdef CONFIG_64BIT
-	s = 32; if (word << 32 != 0) s = 0; b += s; word >>= s;
-	s = 16; if (word << 48 != 0) s = 0; b += s; word >>= s;
-	s =  8; if (word << 56 != 0) s = 0; b += s; word >>= s;
-	s =  4; if (word << 60 != 0) s = 0; b += s; word >>= s;
-	s =  2; if (word << 62 != 0) s = 0; b += s; word >>= s;
-	s =  1; if (word << 63 != 0) s = 0; b += s;
-
-	return b;
-#endif
-#endif
 }
 
+#define HAVE_ARCH___FFS_BITOPS
+
 /*
  * ffs - find first bit set.
  * @word: The word to search
@@ -632,6 +484,8 @@
 	return __ffs(word) + 1;
 }
 
+#define HAVE_ARCH_FFS_BITOPS
+
 /*
  * ffz - find first zero in word.
  * @word: The word to search
@@ -643,6 +497,8 @@
 	return __ffs (~word);
 }
 
+#define HAVE_ARCH_FFZ_BITOPS
+
 /*
  * flz - find last zero in word.
  * @word: The word to search
@@ -652,33 +508,7 @@
  */
 static inline unsigned long flz(unsigned long word)
 {
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
 	return __ilog2(~word);
-#else
-#ifdef CONFIG_32BIT
-	int r = 31, s;
-	word = ~word;
-	s = 16; if ((word & 0xffff0000)) s = 0; r -= s; word <<= s;
-	s = 8;  if ((word & 0xff000000)) s = 0; r -= s; word <<= s;
-	s = 4;  if ((word & 0xf0000000)) s = 0; r -= s; word <<= s;
-	s = 2;  if ((word & 0xc0000000)) s = 0; r -= s; word <<= s;
-	s = 1;  if ((word & 0x80000000)) s = 0; r -= s;
-
-	return r;
-#endif
-#ifdef CONFIG_64BIT
-	int r = 63, s;
-	word = ~word;
-	s = 32; if ((word & 0xffffffff00000000UL)) s = 0; r -= s; word <<= s;
-	s = 16; if ((word & 0xffff000000000000UL)) s = 0; r -= s; word <<= s;
-	s = 8;  if ((word & 0xff00000000000000UL)) s = 0; r -= s; word <<= s;
-	s = 4;  if ((word & 0xf000000000000000UL)) s = 0; r -= s; word <<= s;
-	s = 2;  if ((word & 0xc000000000000000UL)) s = 0; r -= s; word <<= s;
-	s = 1;  if ((word & 0x8000000000000000UL)) s = 0; r -= s;
-
-	return r;
-#endif
-#endif
 }
 
 /*
@@ -695,273 +525,11 @@
 
 	return flz(~word) + 1;
 }
-#define fls64(x)   generic_fls64(x)
-
-/*
- * find_next_zero_bit - find the first zero bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static inline unsigned long find_next_zero_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> SZLONG_LOG);
-	unsigned long result = offset & ~SZLONG_MASK;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= SZLONG_MASK;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (_MIPS_SZLONG-offset);
-		if (size < _MIPS_SZLONG)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= _MIPS_SZLONG;
-		result += _MIPS_SZLONG;
-	}
-	while (size & ~SZLONG_MASK) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += _MIPS_SZLONG;
-		size -= _MIPS_SZLONG;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)		/* Are any bits zero? */
-		return result + size;	/* Nope. */
-found_middle:
-	return result + ffz(tmp);
-}
-
-#define find_first_zero_bit(addr, size) \
-	find_next_zero_bit((addr), (size), 0)
-
-/*
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static inline unsigned long find_next_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> SZLONG_LOG);
-	unsigned long result = offset & ~SZLONG_MASK;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= SZLONG_MASK;
-	if (offset) {
-		tmp = *(p++);
-		tmp &= ~0UL << offset;
-		if (size < _MIPS_SZLONG)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= _MIPS_SZLONG;
-		result += _MIPS_SZLONG;
-	}
-	while (size & ~SZLONG_MASK) {
-		if ((tmp = *(p++)))
-			goto found_middle;
-		result += _MIPS_SZLONG;
-		size -= _MIPS_SZLONG;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= ~0UL >> (_MIPS_SZLONG - size);
-	if (tmp == 0UL)			/* Are any bits set? */
-		return result + size;	/* Nope. */
-found_middle:
-	return result + __ffs(tmp);
-}
-
-/*
- * find_first_bit - find the first set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first set bit, not the number of the byte
- * containing a bit.
- */
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
-
-#ifdef __KERNEL__
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-#ifdef CONFIG_32BIT
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-#endif
-#ifdef CONFIG_64BIT
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 64;
-	return __ffs(b[2]) + 128;
-#endif
-}
-
-/*
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
 
-#define hweight64(x)	generic_hweight64(x)
-#define hweight32(x)	generic_hweight32(x)
-#define hweight16(x)	generic_hweight16(x)
-#define hweight8(x)	generic_hweight8(x)
-
-static inline int __test_and_set_le_bit(unsigned long nr, unsigned long *addr)
-{
-	unsigned char	*ADDR = (unsigned char *) addr;
-	int		mask, retval;
+#define HAVE_ARCH_FLS_BITOPS
 
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR |= mask;
-
-	return retval;
-}
-
-static inline int __test_and_clear_le_bit(unsigned long nr, unsigned long *addr)
-{
-	unsigned char	*ADDR = (unsigned char *) addr;
-	int		mask, retval;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR &= ~mask;
-
-	return retval;
-}
-
-static inline int test_le_bit(unsigned long nr, const unsigned long * addr)
-{
-	const unsigned char	*ADDR = (const unsigned char *) addr;
-	int			mask;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-
-	return ((mask & *ADDR) != 0);
-}
-
-static inline unsigned long find_next_zero_le_bit(unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> SZLONG_LOG);
-	unsigned long result = offset & ~SZLONG_MASK;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= SZLONG_MASK;
-	if (offset) {
-		tmp = cpu_to_lelongp(p++);
-		tmp |= ~0UL >> (_MIPS_SZLONG-offset); /* bug or feature ? */
-		if (size < _MIPS_SZLONG)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= _MIPS_SZLONG;
-		result += _MIPS_SZLONG;
-	}
-	while (size & ~SZLONG_MASK) {
-		if (~(tmp = cpu_to_lelongp(p++)))
-			goto found_middle;
-		result += _MIPS_SZLONG;
-		size -= _MIPS_SZLONG;
-	}
-	if (!size)
-		return result;
-	tmp = cpu_to_lelongp(p);
-
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)		/* Are any bits zero? */
-		return result + size;	/* Nope. */
-
-found_middle:
-	return result + ffz(tmp);
-}
-
-#define find_first_zero_le_bit(addr, size) \
-	find_next_zero_le_bit((addr), (size), 0)
-
-#define ext2_set_bit(nr,addr) \
-	__test_and_set_le_bit((nr),(unsigned long*)addr)
-#define ext2_clear_bit(nr, addr) \
-	__test_and_clear_le_bit((nr),(unsigned long*)addr)
- #define ext2_set_bit_atomic(lock, nr, addr)		\
-({							\
-	int ret;					\
-	spin_lock(lock);				\
-	ret = ext2_set_bit((nr), (addr));		\
-	spin_unlock(lock);				\
-	ret;						\
-})
-
-#define ext2_clear_bit_atomic(lock, nr, addr)		\
-({							\
-	int ret;					\
-	spin_lock(lock);				\
-	ret = ext2_clear_bit((nr), (addr));		\
-	spin_unlock(lock);				\
-	ret;						\
-})
-#define ext2_test_bit(nr, addr)	test_le_bit((nr),(unsigned long*)addr)
-#define ext2_find_first_zero_bit(addr, size) \
-	find_first_zero_le_bit((unsigned long*)addr, size)
-#define ext2_find_next_zero_bit(addr, size, off) \
-	find_next_zero_le_bit((unsigned long*)addr, size, off)
-
-/*
- * Bitmap functions for the minix filesystem.
- *
- * FIXME: These assume that Minix uses the native byte/bitorder.
- * This limits the Minix filesystem's value for data exchange very much.
- */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
+#endif /*defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) */
 
-#endif /* __KERNEL__ */
+#include <asm-generic/bitops.h>
 
 #endif /* _ASM_BITOPS_H */
Index: 2.6-git/include/asm-parisc/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-parisc/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-parisc/bitops.h	2006-01-25 19:14:22.000000000 +0900
@@ -35,13 +35,6 @@
 	_atomic_spin_unlock_irqrestore(addr, flags);
 }
 
-static __inline__ void __set_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long *m = (unsigned long *) addr + (nr >> SHIFT_PER_LONG);
-
-	*m |= 1UL << CHOP_SHIFTCOUNT(nr);
-}
-
 static __inline__ void clear_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = ~(1UL << CHOP_SHIFTCOUNT(nr));
@@ -53,13 +46,6 @@
 	_atomic_spin_unlock_irqrestore(addr, flags);
 }
 
-static __inline__ void __clear_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long *m = (unsigned long *) addr + (nr >> SHIFT_PER_LONG);
-
-	*m &= ~(1UL << CHOP_SHIFTCOUNT(nr));
-}
-
 static __inline__ void change_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
@@ -71,13 +57,6 @@
 	_atomic_spin_unlock_irqrestore(addr, flags);
 }
 
-static __inline__ void __change_bit(unsigned long nr, volatile unsigned long * addr)
-{
-	unsigned long *m = (unsigned long *) addr + (nr >> SHIFT_PER_LONG);
-
-	*m ^= 1UL << CHOP_SHIFTCOUNT(nr);
-}
-
 static __inline__ int test_and_set_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
@@ -93,18 +72,6 @@
 	return (oldbit & mask) ? 1 : 0;
 }
 
-static __inline__ int __test_and_set_bit(int nr, volatile unsigned long * address)
-{
-	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
-	unsigned long oldbit;
-	unsigned long *addr = (unsigned long *)address + (nr >> SHIFT_PER_LONG);
-
-	oldbit = *addr;
-	*addr = oldbit | mask;
-
-	return (oldbit & mask) ? 1 : 0;
-}
-
 static __inline__ int test_and_clear_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
@@ -120,18 +87,6 @@
 	return (oldbit & mask) ? 1 : 0;
 }
 
-static __inline__ int __test_and_clear_bit(int nr, volatile unsigned long * address)
-{
-	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
-	unsigned long *addr = (unsigned long *)address + (nr >> SHIFT_PER_LONG);
-	unsigned long oldbit;
-
-	oldbit = *addr;
-	*addr = oldbit & ~mask;
-
-	return (oldbit & mask) ? 1 : 0;
-}
-
 static __inline__ int test_and_change_bit(int nr, volatile unsigned long * addr)
 {
 	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
@@ -147,25 +102,7 @@
 	return (oldbit & mask) ? 1 : 0;
 }
 
-static __inline__ int __test_and_change_bit(int nr, volatile unsigned long * address)
-{
-	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
-	unsigned long *addr = (unsigned long *)address + (nr >> SHIFT_PER_LONG);
-	unsigned long oldbit;
-
-	oldbit = *addr;
-	*addr = oldbit ^ mask;
-
-	return (oldbit & mask) ? 1 : 0;
-}
-
-static __inline__ int test_bit(int nr, const volatile unsigned long *address)
-{
-	unsigned long mask = 1UL << CHOP_SHIFTCOUNT(nr);
-	const unsigned long *addr = (const unsigned long *)address + (nr >> SHIFT_PER_LONG);
-	
-	return !!(*addr & mask);
-}
+#define HAVE_ARCH_ATOMIC_BITOPS
 
 #ifdef __KERNEL__
 
@@ -219,8 +156,7 @@
 	return ret;
 }
 
-/* Undefined if no bit is zero. */
-#define ffz(x)	__ffs(~x)
+#define HAVE_ARCH___FFS_BITOPS
 
 /*
  * ffs: find first bit set. returns 1 to BITS_PER_LONG or 0 (if none set)
@@ -232,6 +168,8 @@
 	return x ? (__ffs((unsigned long)x) + 1) : 0;
 }
 
+#define HAVE_ARCH_FFS_BITOPS
+
 /*
  * fls: find last (most significant) bit set.
  * fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
@@ -263,139 +201,11 @@
 
 	return ret;
 }
-#define fls64(x)   generic_fls64(x)
 
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-#define hweight64(x) generic_hweight64(x)
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-#ifdef __LP64__
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 64;
-	return __ffs(b[2]) + 128;
-#else
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-#endif
-}
+#define HAVE_ARCH_FLS_BITOPS
 
 #endif /* __KERNEL__ */
 
-/*
- * This implementation of find_{first,next}_zero_bit was stolen from
- * Linus' asm-alpha/bitops.h.
- */
-#define find_first_zero_bit(addr, size) \
-	find_next_zero_bit((addr), (size), 0)
-
-static __inline__ unsigned long find_next_zero_bit(const void * addr, unsigned long size, unsigned long offset)
-{
-	const unsigned long * p = ((unsigned long *) addr) + (offset >> SHIFT_PER_LONG);
-	unsigned long result = offset & ~(BITS_PER_LONG-1);
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= (BITS_PER_LONG-1);
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (BITS_PER_LONG-offset);
-		if (size < BITS_PER_LONG)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= BITS_PER_LONG;
-		result += BITS_PER_LONG;
-	}
-	while (size & ~(BITS_PER_LONG -1)) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += BITS_PER_LONG;
-		size -= BITS_PER_LONG;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-found_first:
-	tmp |= ~0UL << size;
-found_middle:
-	return result + ffz(tmp);
-}
-
-static __inline__ unsigned long find_next_bit(const unsigned long *addr, unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> SHIFT_PER_LONG);
-	unsigned long result = offset & ~(BITS_PER_LONG-1);
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= (BITS_PER_LONG-1);
-	if (offset) {
-		tmp = *(p++);
-		tmp &= (~0UL << offset);
-		if (size < BITS_PER_LONG)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= BITS_PER_LONG;
-		result += BITS_PER_LONG;
-	}
-	while (size & ~(BITS_PER_LONG-1)) {
-		if ((tmp = *(p++)))
-			goto found_middle;
-		result += BITS_PER_LONG;
-		size -= BITS_PER_LONG;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= (~0UL >> (BITS_PER_LONG - size));
-	if (tmp == 0UL)        /* Are any bits set? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + __ffs(tmp);
-}
-
-/**
- * find_first_bit - find the first set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first set bit, not the number of the byte
- * containing a bit.
- */
-#define find_first_bit(addr, size) \
-        find_next_bit((addr), (size), 0)
-
-#define _EXT2_HAVE_ASM_BITOPS_
-
 #ifdef __KERNEL__
 /*
  * test_and_{set,clear}_bit guarantee atomicity without
@@ -405,13 +215,6 @@
 /* '3' is bits per byte */
 #define LE_BYTE_ADDR ((sizeof(unsigned long) - 1) << 3)
 
-#define ext2_test_bit(nr, addr) \
-			test_bit((nr)	^ LE_BYTE_ADDR, (unsigned long *)addr)
-#define ext2_set_bit(nr, addr)	\
-		__test_and_set_bit((nr) ^ LE_BYTE_ADDR, (unsigned long *)addr)
-#define ext2_clear_bit(nr, addr) \
-		__test_and_clear_bit((nr) ^ LE_BYTE_ADDR, (unsigned long *)addr)
-
 #define ext2_set_bit_atomic(l,nr,addr) \
 		test_and_set_bit((nr)   ^ LE_BYTE_ADDR, (unsigned long *)addr)
 #define ext2_clear_bit_atomic(l,nr,addr) \
@@ -419,71 +222,7 @@
 
 #endif	/* __KERNEL__ */
 
-
-#define ext2_find_first_zero_bit(addr, size) \
-	ext2_find_next_zero_bit((addr), (size), 0)
-
-/* include/linux/byteorder does not support "unsigned long" type */
-static inline unsigned long ext2_swabp(unsigned long * x)
-{
-#ifdef __LP64__
-	return (unsigned long) __swab64p((u64 *) x);
-#else
-	return (unsigned long) __swab32p((u32 *) x);
-#endif
-}
-
-/* include/linux/byteorder doesn't support "unsigned long" type */
-static inline unsigned long ext2_swab(unsigned long y)
-{
-#ifdef __LP64__
-	return (unsigned long) __swab64((u64) y);
-#else
-	return (unsigned long) __swab32((u32) y);
-#endif
-}
-
-static __inline__ unsigned long ext2_find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = (unsigned long *) addr + (offset >> SHIFT_PER_LONG);
-	unsigned long result = offset & ~(BITS_PER_LONG - 1);
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= (BITS_PER_LONG - 1UL);
-	if (offset) {
-		tmp = ext2_swabp(p++);
-		tmp |= (~0UL >> (BITS_PER_LONG - offset));
-		if (size < BITS_PER_LONG)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= BITS_PER_LONG;
-		result += BITS_PER_LONG;
-	}
-
-	while (size & ~(BITS_PER_LONG - 1)) {
-		if (~(tmp = *(p++)))
-			goto found_middle_swap;
-		result += BITS_PER_LONG;
-		size -= BITS_PER_LONG;
-	}
-	if (!size)
-		return result;
-	tmp = ext2_swabp(p);
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)	/* Are any bits zero? */
-		return result + size; /* Nope. Skip ffz */
-found_middle:
-	return result + ffz(tmp);
-
-found_middle_swap:
-	return result + ffz(ext2_swab(tmp));
-}
-
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 /* Bitmap functions for the minix filesystem.  */
 #define minix_test_and_set_bit(nr,addr) ext2_set_bit(nr,addr)
@@ -492,4 +231,8 @@
 #define minix_test_bit(nr,addr) ext2_test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) ext2_find_first_zero_bit(addr,size)
 
+#define HAVE_ARCH_MINIX_BITOPS
+
+#include <asm-generic/bitops.h>
+
 #endif /* _PARISC_BITOPS_H */
Index: 2.6-git/include/asm-powerpc/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-powerpc/bitops.h	2006-01-25 19:07:13.000000000 +0900
+++ 2.6-git/include/asm-powerpc/bitops.h	2006-01-25 19:14:23.000000000 +0900
@@ -184,72 +184,7 @@
 	: "cc");
 }
 
-/* Non-atomic versions */
-static __inline__ int test_bit(unsigned long nr,
-			       __const__ volatile unsigned long *addr)
-{
-	return 1UL & (addr[BITOP_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
-}
-
-static __inline__ void __set_bit(unsigned long nr,
-				 volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-
-	*p  |= mask;
-}
-
-static __inline__ void __clear_bit(unsigned long nr,
-				   volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-
-	*p &= ~mask;
-}
-
-static __inline__ void __change_bit(unsigned long nr,
-				    volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-
-	*p ^= mask;
-}
-
-static __inline__ int __test_and_set_bit(unsigned long nr,
-					 volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-	unsigned long old = *p;
-
-	*p = old | mask;
-	return (old & mask) != 0;
-}
-
-static __inline__ int __test_and_clear_bit(unsigned long nr,
-					   volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-	unsigned long old = *p;
-
-	*p = old & ~mask;
-	return (old & mask) != 0;
-}
-
-static __inline__ int __test_and_change_bit(unsigned long nr,
-					    volatile unsigned long *addr)
-{
-	unsigned long mask = BITOP_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
-	unsigned long old = *p;
-
-	*p = old ^ mask;
-	return (old & mask) != 0;
-}
+#define HAVE_ARCH_ATOMIC_BITOPS
 
 /*
  * Return the zero-based bit position (LE, not IBM bit numbering) of
@@ -283,11 +218,15 @@
 	return __ilog2(x & -x);
 }
 
+#define HAVE_ARCH_FFZ_BITOPS
+
 static __inline__ int __ffs(unsigned long x)
 {
 	return __ilog2(x & -x);
 }
 
+#define HAVE_ARCH___FFS_BITOPS
+
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
@@ -299,6 +238,8 @@
 	return __ilog2(i & -i) + 1;
 }
 
+#define HAVE_ARCH_FFS_BITOPS
+
 /*
  * fls: find last (most-significant) bit set.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
@@ -310,16 +251,7 @@
 	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (x));
 	return 32 - lz;
 }
-#define fls64(x)   generic_fls64(x)
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-#define hweight64(x) generic_hweight64(x)
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#define HAVE_ARCH_FLS_BITOPS
 
 #define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
 unsigned long find_next_zero_bit(const unsigned long *addr,
@@ -336,6 +268,8 @@
 unsigned long find_next_bit(const unsigned long *addr,
 			    unsigned long size, unsigned long offset);
 
+#define HAVE_ARCH_FIND_BITOPS
+
 /* Little-endian versions */
 
 static __inline__ int test_le_bit(unsigned long nr,
@@ -366,22 +300,12 @@
 
 /* Bitmap functions for the ext2 filesystem */
 
-#define ext2_set_bit(nr,addr) \
-	__test_and_set_le_bit((nr), (unsigned long*)addr)
-#define ext2_clear_bit(nr, addr) \
-	__test_and_clear_le_bit((nr), (unsigned long*)addr)
-
 #define ext2_set_bit_atomic(lock, nr, addr) \
 	test_and_set_le_bit((nr), (unsigned long*)addr)
 #define ext2_clear_bit_atomic(lock, nr, addr) \
 	test_and_clear_le_bit((nr), (unsigned long*)addr)
 
-#define ext2_test_bit(nr, addr)      test_le_bit((nr),(unsigned long*)addr)
-
-#define ext2_find_first_zero_bit(addr, size) \
-	find_first_zero_le_bit((unsigned long*)addr, size)
-#define ext2_find_next_zero_bit(addr, size, off) \
-	find_next_zero_le_bit((unsigned long*)addr, size, off)
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 /* Bitmap functions for the minix filesystem.  */
 
@@ -397,33 +321,10 @@
 #define minix_find_first_zero_bit(addr,size) \
 	find_first_zero_le_bit((unsigned long *)addr, size)
 
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-#ifdef CONFIG_PPC64
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 64;
-	return __ffs(b[2]) + 128;
-#else
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-#endif
-}
+#define HAVE_ARCH_MINIX_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _ASM_POWERPC_BITOPS_H */
Index: 2.6-git/include/asm-s390/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-s390/bitops.h	2006-01-25 19:14:05.000000000 +0900
+++ 2.6-git/include/asm-s390/bitops.h	2006-01-25 19:14:24.000000000 +0900
@@ -527,6 +527,9 @@
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)) )
 
+#define HAVE_ARCH_ATOMIC_BITOPS
+#define HAVE_ARCH_NON_ATOMIC_BITOPS
+
 /*
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
@@ -552,6 +555,8 @@
 	return bit + _zb_findmap[word & 0xff];
 }
 
+#define HAVE_ARCH_FFZ_BITOPS
+
 /*
  * __ffs = find first bit in word. Undefined if no bit exists,
  * so code should check against 0UL first..
@@ -577,6 +582,8 @@
 	return bit + _sb_findmap[word & 0xff];
 }
 
+#define HAVE_ARCH___FFS_BITOPS
+
 /*
  * Find-bit routines..
  */
@@ -817,6 +824,8 @@
 	return offset + find_first_bit(p, size);
 }
 
+#define HAVE_ARCH_FIND_BITOPS
+
 /*
  * Every architecture must define this function. It's the fastest
  * way of searching a 140-bit bitmap where the first 100 bits are
@@ -828,35 +837,7 @@
 	return find_first_bit(b, 140);
 }
 
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-#define ffs(x) generic_ffs(x)
-
-/*
- * fls: find last bit set.
- */
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-#define hweight64(x)						\
-({								\
-	unsigned long __x = (x);				\
-	unsigned int __w;					\
-	__w = generic_hweight32((unsigned int) __x);		\
-	__w += generic_hweight32((unsigned int) (__x>>32));	\
-	__w;							\
-})
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
+#define HAVE_ARCH_SCHED_BITOPS
 
 #ifdef __KERNEL__
 
@@ -1011,19 +992,11 @@
 	return offset + ext2_find_first_zero_bit(p, size);
 }
 
-/* Bitmap functions for the minix filesystem.  */
-/* FIXME !!! */
-#define minix_test_and_set_bit(nr,addr) \
-	__test_and_set_bit(nr,(unsigned long *)addr)
-#define minix_set_bit(nr,addr) \
-	__set_bit(nr,(unsigned long *)addr)
-#define minix_test_and_clear_bit(nr,addr) \
-	__test_and_clear_bit(nr,(unsigned long *)addr)
-#define minix_test_bit(nr,addr) \
-	test_bit(nr,(unsigned long *)addr)
-#define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_bit(addr,size)
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
+#define HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _S390_BITOPS_H */
Index: 2.6-git/include/asm-sh/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sh/bitops.h	2006-01-25 19:14:06.000000000 +0900
+++ 2.6-git/include/asm-sh/bitops.h	2006-01-25 19:14:24.000000000 +0900
@@ -19,16 +19,6 @@
 	local_irq_restore(flags);
 }
 
-static __inline__ void __set_bit(int nr, volatile void * addr)
-{
-	int	mask;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	*a |= mask;
-}
-
 /*
  * clear_bit() doesn't provide any barrier for the compiler.
  */
@@ -47,16 +37,6 @@
 	local_irq_restore(flags);
 }
 
-static __inline__ void __clear_bit(int nr, volatile void * addr)
-{
-	int	mask;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	*a &= ~mask;
-}
-
 static __inline__ void change_bit(int nr, volatile void * addr)
 {
 	int	mask;
@@ -70,16 +50,6 @@
 	local_irq_restore(flags);
 }
 
-static __inline__ void __change_bit(int nr, volatile void * addr)
-{
-	int	mask;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	*a ^= mask;
-}
-
 static __inline__ int test_and_set_bit(int nr, volatile void * addr)
 {
 	int	mask, retval;
@@ -96,19 +66,6 @@
 	return retval;
 }
 
-static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
-{
-	int	mask, retval;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *a) != 0;
-	*a |= mask;
-
-	return retval;
-}
-
 static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
 {
 	int	mask, retval;
@@ -125,19 +82,6 @@
 	return retval;
 }
 
-static __inline__ int __test_and_clear_bit(int nr, volatile void * addr)
-{
-	int	mask, retval;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *a) != 0;
-	*a &= ~mask;
-
-	return retval;
-}
-
 static __inline__ int test_and_change_bit(int nr, volatile void * addr)
 {
 	int	mask, retval;
@@ -154,23 +98,7 @@
 	return retval;
 }
 
-static __inline__ int __test_and_change_bit(int nr, volatile void * addr)
-{
-	int	mask, retval;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *a) != 0;
-	*a ^= mask;
-
-	return retval;
-}
-
-static __inline__ int test_bit(int nr, const volatile void *addr)
-{
-	return 1UL & (((const volatile unsigned int *) addr)[nr >> 5] >> (nr & 31));
-}
+#define HAVE_ARCH_ATOMIC_BITOPS
 
 static __inline__ unsigned long ffz(unsigned long word)
 {
@@ -186,6 +114,8 @@
 	return result;
 }
 
+#define HAVE_ARCH_FFZ_BITOPS
+
 /**
  * __ffs - find first bit in word.
  * @word: The word to search
@@ -206,266 +136,10 @@
 	return result;
 }
 
-/**
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static __inline__ unsigned long find_next_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
-	unsigned int result = offset & ~31UL;
-	unsigned int tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *p++;
-		tmp &= ~0UL << offset;
-		if (size < 32)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size >= 32) {
-		if ((tmp = *p++) != 0)
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= ~0UL >> (32 - size);
-	if (tmp == 0UL)        /* Are any bits set? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + __ffs(tmp);
-}
-
-/**
- * find_first_bit - find the first set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first set bit, not the number of the byte
- * containing a bit.
- */
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
-
-static __inline__ int find_next_zero_bit(const unsigned long *addr, int size, int offset)
-{
-	const unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL << size;
-found_middle:
-	return result + ffz(tmp);
-}
-
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-
-#define ffs(x) generic_ffs(x)
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
-#ifdef __LITTLE_ENDIAN__
-#define ext2_set_bit(nr, addr) __test_and_set_bit((nr), (addr))
-#define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr), (addr))
-#define ext2_test_bit(nr, addr) test_bit((nr), (addr))
-#define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
-#define ext2_find_next_zero_bit(addr, size, offset) \
-                find_next_zero_bit((unsigned long *)(addr), (size), (offset))
-#else
-static __inline__ int ext2_set_bit(int nr, volatile void * addr)
-{
-	int		mask, retval;
-	volatile unsigned char	*ADDR = (unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR |= mask;
-	return retval;
-}
-
-static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
-{
-	int		mask, retval;
-	volatile unsigned char	*ADDR = (unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR &= ~mask;
-	return retval;
-}
-
-static __inline__ int ext2_test_bit(int nr, const volatile void * addr)
-{
-	int			mask;
-	const volatile unsigned char	*ADDR = (const unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	return ((mask & *ADDR) != 0);
-}
-
-#define ext2_find_first_zero_bit(addr, size) \
-        ext2_find_next_zero_bit((addr), (size), 0)
-
-static __inline__ unsigned long ext2_find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if(offset) {
-		/* We hold the little endian value in tmp, but then the
-		 * shift is illegal. So we could keep a big endian value
-		 * in tmp, like this:
-		 *
-		 * tmp = __swab32(*(p++));
-		 * tmp |= ~0UL >> (32-offset);
-		 *
-		 * but this would decrease preformance, so we change the
-		 * shift:
-		 */
-		tmp = *(p++);
-		tmp |= __swab32(~0UL >> (32-offset));
-		if(size < 32)
-			goto found_first;
-		if(~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while(size & ~31UL) {
-		if(~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if(!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	/* tmp is little endian, so we would have to swab the shift,
-	 * see above. But then we have to swab tmp below for ffz, so
-	 * we might as well do this here.
-	 */
-	return result + ffz(__swab32(tmp) | (~0UL << size));
-found_middle:
-	return result + ffz(__swab32(tmp));
-}
-#endif
-
-#define ext2_set_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_set_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-#define ext2_clear_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_clear_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
-
-/*
- * fls: find last bit set.
- */
-
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+#define HAVE_ARCH___FFS_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* __ASM_SH_BITOPS_H */
Index: 2.6-git/include/asm-sh64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sh64/bitops.h	2006-01-25 19:14:07.000000000 +0900
+++ 2.6-git/include/asm-sh64/bitops.h	2006-01-25 19:14:24.000000000 +0900
@@ -31,16 +31,6 @@
 	local_irq_restore(flags);
 }
 
-static inline void __set_bit(int nr, void *addr)
-{
-	int	mask;
-	unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	*a |= mask;
-}
-
 /*
  * clear_bit() doesn't provide any barrier for the compiler.
  */
@@ -58,15 +48,6 @@
 	local_irq_restore(flags);
 }
 
-static inline void __clear_bit(int nr, volatile unsigned long *a)
-{
-	int	mask;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	*a &= ~mask;
-}
-
 static __inline__ void change_bit(int nr, volatile void * addr)
 {
 	int	mask;
@@ -80,16 +61,6 @@
 	local_irq_restore(flags);
 }
 
-static __inline__ void __change_bit(int nr, volatile void * addr)
-{
-	int	mask;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	*a ^= mask;
-}
-
 static __inline__ int test_and_set_bit(int nr, volatile void * addr)
 {
 	int	mask, retval;
@@ -106,19 +77,6 @@
 	return retval;
 }
 
-static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
-{
-	int	mask, retval;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *a) != 0;
-	*a |= mask;
-
-	return retval;
-}
-
 static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
 {
 	int	mask, retval;
@@ -135,19 +93,6 @@
 	return retval;
 }
 
-static __inline__ int __test_and_clear_bit(int nr, volatile void * addr)
-{
-	int	mask, retval;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *a) != 0;
-	*a &= ~mask;
-
-	return retval;
-}
-
 static __inline__ int test_and_change_bit(int nr, volatile void * addr)
 {
 	int	mask, retval;
@@ -164,23 +109,7 @@
 	return retval;
 }
 
-static __inline__ int __test_and_change_bit(int nr, volatile void * addr)
-{
-	int	mask, retval;
-	volatile unsigned int *a = addr;
-
-	a += nr >> 5;
-	mask = 1 << (nr & 0x1f);
-	retval = (mask & *a) != 0;
-	*a ^= mask;
-
-	return retval;
-}
-
-static __inline__ int test_bit(int nr, const volatile void *addr)
-{
-	return 1UL & (((const volatile unsigned int *) addr)[nr >> 5] >> (nr & 31));
-}
+#define HAVE_ARCH_ATOMIC_BITOPS
 
 static __inline__ unsigned long ffz(unsigned long word)
 {
@@ -204,308 +133,10 @@
 	return result;
 }
 
-/**
- * __ffs - find first bit in word
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- */
-static inline unsigned long __ffs(unsigned long word)
-{
-	int r = 0;
-
-	if (!word)
-		return 0;
-	if (!(word & 0xffff)) {
-		word >>= 16;
-		r += 16;
-	}
-	if (!(word & 0xff)) {
-		word >>= 8;
-		r += 8;
-	}
-	if (!(word & 0xf)) {
-		word >>= 4;
-		r += 4;
-	}
-	if (!(word & 3)) {
-		word >>= 2;
-		r += 2;
-	}
-	if (!(word & 1)) {
-		word >>= 1;
-		r += 1;
-	}
-	return r;
-}
-
-/**
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- */
-static inline unsigned long find_next_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
-	unsigned int result = offset & ~31UL;
-	unsigned int tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *p++;
-		tmp &= ~0UL << offset;
-		if (size < 32)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size >= 32) {
-		if ((tmp = *p++) != 0)
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= ~0UL >> (32 - size);
-	if (tmp == 0UL)        /* Are any bits set? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + __ffs(tmp);
-}
-
-/**
- * find_first_bit - find the first set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first set bit, not the number of the byte
- * containing a bit.
- */
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
-
-
-static inline int find_next_zero_bit(void *addr, int size, int offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL << size;
-found_middle:
-	return result + ffz(tmp);
-}
-
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x)	generic_hweight32(x)
-#define hweight16(x)	generic_hweight16(x)
-#define hweight8(x)	generic_hweight8(x)
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-
-#define ffs(x) generic_ffs(x)
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-#ifdef __LITTLE_ENDIAN__
-#define ext2_set_bit(nr, addr) __test_and_set_bit((nr), (addr))
-#define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr), (addr))
-#define ext2_test_bit(nr, addr) test_bit((nr), (addr))
-#define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
-#define ext2_find_next_zero_bit(addr, size, offset) \
-                find_next_zero_bit((addr), (size), (offset))
-#else
-static __inline__ int ext2_set_bit(int nr, volatile void * addr)
-{
-	int		mask, retval;
-	volatile unsigned char	*ADDR = (unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR |= mask;
-	return retval;
-}
-
-static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
-{
-	int		mask, retval;
-	volatile unsigned char	*ADDR = (unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR &= ~mask;
-	return retval;
-}
-
-static __inline__ int ext2_test_bit(int nr, const volatile void * addr)
-{
-	int			mask;
-	const volatile unsigned char	*ADDR = (const unsigned char *) addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	return ((mask & *ADDR) != 0);
-}
-
-#define ext2_find_first_zero_bit(addr, size) \
-        ext2_find_next_zero_bit((addr), (size), 0)
-
-static __inline__ unsigned long ext2_find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if(offset) {
-		/* We hold the little endian value in tmp, but then the
-		 * shift is illegal. So we could keep a big endian value
-		 * in tmp, like this:
-		 *
-		 * tmp = __swab32(*(p++));
-		 * tmp |= ~0UL >> (32-offset);
-		 *
-		 * but this would decrease preformance, so we change the
-		 * shift:
-		 */
-		tmp = *(p++);
-		tmp |= __swab32(~0UL >> (32-offset));
-		if(size < 32)
-			goto found_first;
-		if(~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while(size & ~31UL) {
-		if(~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if(!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	/* tmp is little endian, so we would have to swab the shift,
-	 * see above. But then we have to swab tmp below for ffz, so
-	 * we might as well do this here.
-	 */
-	return result + ffz(__swab32(tmp) | (~0UL << size));
-found_middle:
-	return result + ffz(__swab32(tmp));
-}
-#endif
-
-#define ext2_set_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_set_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-#define ext2_clear_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_clear_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
-
-#define ffs(x)	generic_ffs(x)
-#define fls(x)	generic_fls(x)
-#define fls64(x)   generic_fls64(x)
+#define HAVE_ARCH_FFZ_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* __ASM_SH64_BITOPS_H */
Index: 2.6-git/include/asm-sparc/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sparc/bitops.h	2006-01-25 19:14:08.000000000 +0900
+++ 2.6-git/include/asm-sparc/bitops.h	2006-01-25 19:14:25.000000000 +0900
@@ -152,387 +152,13 @@
 	: "memory", "cc");
 }
 
-/*
- * non-atomic versions
- */
-static inline void __set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-
-	*p |= mask;
-}
-
-static inline void __clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-
-	*p &= ~mask;
-}
-
-static inline void __change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-
-	*p ^= mask;
-}
-
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long old = *p;
-
-	*p = old | mask;
-	return (old & mask) != 0;
-}
-
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long old = *p;
-
-	*p = old & ~mask;
-	return (old & mask) != 0;
-}
-
-static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1UL << (nr & 0x1f);
-	unsigned long *p = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long old = *p;
-
-	*p = old ^ mask;
-	return (old & mask) != 0;
-}
+#define HAVE_ARCH_ATOMIC_BITOPS
 
 #define smp_mb__before_clear_bit()	do { } while(0)
 #define smp_mb__after_clear_bit()	do { } while(0)
 
-/* The following routine need not be atomic. */
-static inline int test_bit(int nr, __const__ volatile unsigned long *addr)
-{
-	return (1UL & (((unsigned long *)addr)[nr >> 5] >> (nr & 31))) != 0UL;
-}
-
-/* The easy/cheese version for now. */
-static inline unsigned long ffz(unsigned long word)
-{
-	unsigned long result = 0;
-
-	while(word & 1) {
-		result++;
-		word >>= 1;
-	}
-	return result;
-}
-
-/**
- * __ffs - find first bit in word.
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- */
-static inline int __ffs(unsigned long word)
-{
-	int num = 0;
-
-	if ((word & 0xffff) == 0) {
-		num += 16;
-		word >>= 16;
-	}
-	if ((word & 0xff) == 0) {
-		num += 8;
-		word >>= 8;
-	}
-	if ((word & 0xf) == 0) {
-		num += 4;
-		word >>= 4;
-	}
-	if ((word & 0x3) == 0) {
-		num += 2;
-		word >>= 2;
-	}
-	if ((word & 0x1) == 0)
-		num += 1;
-	return num;
-}
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-static inline int ffs(int x)
-{
-	if (!x)
-		return 0;
-	return __ffs((unsigned long)x) + 1;
-}
-
-/*
- * fls: find last (most-significant) bit set.
- * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
- */
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
-
-/*
- * find_next_zero_bit() finds the first zero bit in a bit string of length
- * 'size' bits, starting the search at bit 'offset'. This is largely based
- * on Linus's ALPHA routines, which are pretty portable BTW.
- */
-static inline unsigned long find_next_zero_bit(const unsigned long *addr,
-    unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *(p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL << size;
-	if (tmp == ~0UL)        /* Are any bits zero? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + ffz(tmp);
-}
-
-/*
- * Linus sez that gcc can optimize the following correctly, we'll see if this
- * holds on the Sparc as it does for the ALPHA.
- */
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
-
-/**
- * find_next_bit - find the first set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The maximum size to search
- *
- * Scheduler induced bitop, do not use.
- */
-static inline int find_next_bit(const unsigned long *addr, int size, int offset)
-{
-	const unsigned long *p = addr + (offset >> 5);
-	int num = offset & ~0x1f;
-	unsigned long word;
-
-	word = *p++;
-	word &= ~((1 << (offset & 0x1f)) - 1);
-	while (num < size) {
-		if (word != 0) {
-			return __ffs(word) + num;
-		}
-		word = *p++;
-		num += 0x20;
-	}
-	return num;
-}
-
-/**
- * find_first_bit - find the first set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first set bit, not the number of the byte
- * containing a bit.
- */
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
-
-/*
- */
-static inline int test_le_bit(int nr, __const__ unsigned long * addr)
-{
-	__const__ unsigned char *ADDR = (__const__ unsigned char *) addr;
-	return (ADDR[nr >> 3] >> (nr & 7)) & 1;
-}
-
-/*
- * non-atomic versions
- */
-static inline void __set_le_bit(int nr, unsigned long *addr)
-{
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	*ADDR |= 1 << (nr & 0x07);
-}
-
-static inline void __clear_le_bit(int nr, unsigned long *addr)
-{
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	*ADDR &= ~(1 << (nr & 0x07));
-}
-
-static inline int __test_and_set_le_bit(int nr, unsigned long *addr)
-{
-	int mask, retval;
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR |= mask;
-	return retval;
-}
-
-static inline int __test_and_clear_le_bit(int nr, unsigned long *addr)
-{
-	int mask, retval;
-	unsigned char *ADDR = (unsigned char *)addr;
-
-	ADDR += nr >> 3;
-	mask = 1 << (nr & 0x07);
-	retval = (mask & *ADDR) != 0;
-	*ADDR &= ~mask;
-	return retval;
-}
-
-static inline unsigned long find_next_zero_le_bit(const unsigned long *addr,
-    unsigned long size, unsigned long offset)
-{
-	const unsigned long *p = addr + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if(offset) {
-		tmp = *(p++);
-		tmp |= __swab32(~0UL >> (32-offset));
-		if(size < 32)
-			goto found_first;
-		if(~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while(size & ~31UL) {
-		if(~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if(!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp = __swab32(tmp) | (~0UL << size);
-	if (tmp == ~0UL)        /* Are any bits zero? */
-		return result + size; /* Nope. */
-	return result + ffz(tmp);
-
-found_middle:
-	return result + ffz(__swab32(tmp));
-}
-
-#define find_first_zero_le_bit(addr, size) \
-        find_next_zero_le_bit((addr), (size), 0)
-
-#define ext2_set_bit(nr,addr)	\
-	__test_and_set_le_bit((nr),(unsigned long *)(addr))
-#define ext2_clear_bit(nr,addr)	\
-	__test_and_clear_le_bit((nr),(unsigned long *)(addr))
-
-#define ext2_set_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_set_bit((nr), (unsigned long *)(addr)); \
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-#define ext2_clear_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_clear_bit((nr), (unsigned long *)(addr)); \
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-#define ext2_test_bit(nr,addr)	\
-	test_le_bit((nr),(unsigned long *)(addr))
-#define ext2_find_first_zero_bit(addr, size) \
-	find_first_zero_le_bit((unsigned long *)(addr), (size))
-#define ext2_find_next_zero_bit(addr, size, off) \
-	find_next_zero_le_bit((unsigned long *)(addr), (size), (off))
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)	\
-	__test_and_set_bit((nr),(unsigned long *)(addr))
-#define minix_set_bit(nr,addr)		\
-	__set_bit((nr),(unsigned long *)(addr))
-#define minix_test_and_clear_bit(nr,addr) \
-	__test_and_clear_bit((nr),(unsigned long *)(addr))
-#define minix_test_bit(nr,addr)		\
-	test_bit((nr),(unsigned long *)(addr))
-#define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_bit((unsigned long *)(addr),(size))
-
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* defined(_SPARC_BITOPS_H) */
Index: 2.6-git/include/asm-sparc64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sparc64/bitops.h	2006-01-25 19:14:08.000000000 +0900
+++ 2.6-git/include/asm-sparc64/bitops.h	2006-01-25 19:14:25.000000000 +0900
@@ -18,58 +18,7 @@
 extern void clear_bit(unsigned long nr, volatile unsigned long *addr);
 extern void change_bit(unsigned long nr, volatile unsigned long *addr);
 
-/* "non-atomic" versions... */
-
-static inline void __set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-
-	*m |= (1UL << (nr & 63));
-}
-
-static inline void __clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-
-	*m &= ~(1UL << (nr & 63));
-}
-
-static inline void __change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-
-	*m ^= (1UL << (nr & 63));
-}
-
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-	unsigned long old = *m;
-	unsigned long mask = (1UL << (nr & 63));
-
-	*m = (old | mask);
-	return ((old & mask) != 0);
-}
-
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-	unsigned long old = *m;
-	unsigned long mask = (1UL << (nr & 63));
-
-	*m = (old & ~mask);
-	return ((old & mask) != 0);
-}
-
-static inline int __test_and_change_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long *m = ((unsigned long *)addr) + (nr >> 6);
-	unsigned long old = *m;
-	unsigned long mask = (1UL << (nr & 63));
-
-	*m = (old ^ mask);
-	return ((old & mask) != 0);
-}
+#define HAVE_ARCH_ATOMIC_BITOPS
 
 #ifdef CONFIG_SMP
 #define smp_mb__before_clear_bit()	membar_storeload_loadload()
@@ -79,80 +28,9 @@
 #define smp_mb__after_clear_bit()	barrier()
 #endif
 
-static inline int test_bit(int nr, __const__ volatile unsigned long *addr)
-{
-	return (1UL & (addr[nr >> 6] >> (nr & 63))) != 0UL;
-}
-
-/* The easy/cheese version for now. */
-static inline unsigned long ffz(unsigned long word)
-{
-	unsigned long result;
-
-	result = 0;
-	while(word & 1) {
-		result++;
-		word >>= 1;
-	}
-	return result;
-}
-
-/**
- * __ffs - find first bit in word.
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- */
-static inline unsigned long __ffs(unsigned long word)
-{
-	unsigned long result = 0;
-
-	while (!(word & 1UL)) {
-		result++;
-		word >>= 1;
-	}
-	return result;
-}
-
-/*
- * fls: find last bit set.
- */
-
-#define fls(x) generic_fls(x)
-#define fls64(x)   generic_fls64(x)
-
 #ifdef __KERNEL__
 
 /*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is cleared.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(((unsigned int)b[1])))
-		return __ffs(b[1]) + 64;
-	if (b[1] >> 32)
-		return __ffs(b[1] >> 32) + 96;
-	return __ffs(b[2]) + 128;
-}
-
-/*
- * ffs: find first bit set. This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-static inline int ffs(int x)
-{
-	if (!x)
-		return 0;
-	return __ffs((unsigned long)x) + 1;
-}
-
-/*
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
  */
@@ -167,6 +45,8 @@
 	return res;
 }
 
+#define HAVE_ARCH_HWEIGHT64_BITOPS
+
 static inline unsigned int hweight32(unsigned int w)
 {
 	unsigned int res;
@@ -191,14 +71,10 @@
 	return res;
 }
 
-#else
-
-#define hweight64(x) generic_hweight64(x)
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#define HAVE_ARCH_HWEIGHT_BITOPS
 
 #endif
+
 #endif /* __KERNEL__ */
 
 /**
@@ -232,6 +108,8 @@
 #define find_first_zero_bit(addr, size) \
         find_next_zero_bit((addr), (size), 0)
 
+#define HAVE_ARCH_FIND_BITOPS
+
 #define test_and_set_le_bit(nr,addr)	\
 	test_and_set_bit((nr) ^ 0x38, (addr))
 #define test_and_clear_le_bit(nr,addr)	\
@@ -278,18 +156,11 @@
 #define ext2_find_next_zero_bit(addr, size, off) \
 	find_next_zero_le_bit((unsigned long *)(addr), (size), (off))
 
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)	\
-	__test_and_set_bit((nr),(unsigned long *)(addr))
-#define minix_set_bit(nr,addr)	\
-	__set_bit((nr),(unsigned long *)(addr))
-#define minix_test_and_clear_bit(nr,addr) \
-	__test_and_clear_bit((nr),(unsigned long *)(addr))
-#define minix_test_bit(nr,addr)	\
-	test_bit((nr),(unsigned long *)(addr))
-#define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_bit((unsigned long *)(addr),(size))
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
+#define HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* defined(_SPARC64_BITOPS_H) */
Index: 2.6-git/include/asm-v850/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-v850/bitops.h	2006-01-25 19:14:08.000000000 +0900
+++ 2.6-git/include/asm-v850/bitops.h	2006-01-25 19:14:25.000000000 +0900
@@ -26,22 +26,6 @@
  * The __ functions are not atomic
  */
 
-/*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
- */
-static inline unsigned long ffz (unsigned long word)
-{
-	unsigned long result = 0;
-
-	while (word & 1) {
-		result++;
-		word >>= 1;
-	}
-	return result;
-}
-
-
 /* In the following constant-bit-op macros, a "g" constraint is used when
    we really need an integer ("i" constraint).  This is to avoid
    warnings/errors from the compiler in the case where the associated
@@ -148,209 +132,20 @@
    ? __const_test_bit ((nr), (addr))					\
    : __test_bit ((nr), (addr)))
 
+#define HAVE_ARCH_ATOMIC_BITOPS
+#define HAVE_ARCH_NON_ATOMIC_BITOPS
 
 /* clear_bit doesn't provide any barrier for the compiler.  */
 #define smp_mb__before_clear_bit()	barrier ()
 #define smp_mb__after_clear_bit()	barrier ()
 
-
-#define find_first_zero_bit(addr, size) \
-  find_next_zero_bit ((addr), (size), 0)
-
-static inline int find_next_zero_bit(const void *addr, int size, int offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = * (p++);
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~ (tmp = * (p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
- found_first:
-	tmp |= ~0UL >> size;
- found_middle:
-	return result + ffz (tmp);
-}
-
-
-/* This is the same as generic_ffs, but we can't use that because it's
-   inline and the #include order mucks things up.  */
-static inline int generic_ffs_for_find_next_bit(int x)
-{
-	int r = 1;
-
-	if (!x)
-		return 0;
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
-	return r;
-}
-
-/*
- * Find next one bit in a bitmap reasonably efficiently.
- */
-static __inline__ unsigned long find_next_bit(const unsigned long *addr,
-	unsigned long size, unsigned long offset)
-{
-	unsigned int *p = ((unsigned int *) addr) + (offset >> 5);
-	unsigned int result = offset & ~31UL;
-	unsigned int tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *p++;
-		tmp &= ~0UL << offset;
-		if (size < 32)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size >= 32) {
-		if ((tmp = *p++) != 0)
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= ~0UL >> (32 - size);
-	if (tmp == 0UL)        /* Are any bits set? */
-		return result + size; /* Nope. */
-found_middle:
-	return result + generic_ffs_for_find_next_bit(tmp);
-}
-
-/*
- * find_first_bit - find the first set bit in a memory region
- */
-#define find_first_bit(addr, size) \
-	find_next_bit((addr), (size), 0)
-
-
-#define ffs(x) generic_ffs (x)
-#define fls(x) generic_fls (x)
-#define fls64(x) generic_fls64(x)
-#define __ffs(x) ffs(x)
-
-
-/*
- * This is just `generic_ffs' from <linux/bitops.h>, except that it assumes
- * that at least one bit is set, and returns the real index of the bit
- * (rather than the bit index + 1, like ffs does).
- */
-static inline int sched_ffs(int x)
-{
-	int r = 0;
-
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
-	return r;
-}
-
-/*
- * Every architecture must define this function. It's the fastest
- * way of searching a 140-bit bitmap where the first 100 bits are
- * unlikely to be set. It's guaranteed that at least one of the 140
- * bits is set.
- */
-static inline int sched_find_first_bit(unsigned long *b)
-{
-	unsigned offs = 0;
-	while (! *b) {
-		b++;
-		offs += 32;
-	}
-	return sched_ffs (*b) + offs;
-}
-
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-#define hweight32(x) 			generic_hweight32 (x)
-#define hweight16(x) 			generic_hweight16 (x)
-#define hweight8(x) 			generic_hweight8 (x)
-
-#define ext2_set_bit			__test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)      test_and_set_bit(n,a)
-#define ext2_clear_bit			__test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a)    test_and_clear_bit(n,a)
-#define ext2_test_bit			test_bit
-#define ext2_find_first_zero_bit	find_first_zero_bit
-#define ext2_find_next_zero_bit		find_next_zero_bit
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit		__test_and_set_bit
-#define minix_set_bit			__set_bit
-#define minix_test_and_clear_bit	__test_and_clear_bit
-#define minix_test_bit 			test_bit
-#define minix_find_first_zero_bit 	find_first_zero_bit
+
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* __V850_BITOPS_H__ */
Index: 2.6-git/include/asm-x86_64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-x86_64/bitops.h	2006-01-25 19:07:12.000000000 +0900
+++ 2.6-git/include/asm-x86_64/bitops.h	2006-01-25 19:14:25.000000000 +0900
@@ -254,6 +254,9 @@
 
 #undef ADDR
 
+#define HAVE_ARCH_ATOMIC_BITOPS
+#define HAVE_ARCH_NON_ATOMIC_BITOPS
+
 extern long find_first_zero_bit(const unsigned long * addr, unsigned long size);
 extern long find_next_zero_bit (const unsigned long * addr, long size, long offset);
 extern long find_first_bit(const unsigned long * addr, unsigned long size);
@@ -286,6 +289,8 @@
   ((off)+(__scanbit(~(((*(unsigned long *)addr)) >> (off)),(size)-(off)))) : \
 	find_next_zero_bit(addr,size,off)))
 
+#define HAVE_ARCH_FIND_BITOPS
+
 /* 
  * Find string of zero bits in a bitmap. -1 when not found.
  */ 
@@ -326,6 +331,8 @@
 	return word;
 }
 
+#define HAVE_ARCH_FFZ_BITOPS
+
 /**
  * __ffs - find first bit in word.
  * @word: The word to search
@@ -340,6 +347,8 @@
 	return word;
 }
 
+#define HAVE_ARCH___FFS_BITOPS
+
 /*
  * __fls: find last bit set.
  * @word: The word to search
@@ -356,15 +365,6 @@
 
 #ifdef __KERNEL__
 
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	if (b[0])
-		return __ffs(b[0]);
-	if (b[1])
-		return __ffs(b[1]) + 64;
-	return __ffs(b[2]) + 128;
-}
-
 /**
  * ffs - find first bit set
  * @x: the word to search
@@ -383,6 +383,8 @@
 	return r+1;
 }
 
+#define HAVE_ARCH_FFS_BITOPS
+
 /**
  * fls64 - find last bit set in 64 bit word
  * @x: the word to search
@@ -396,6 +398,8 @@
 	return __fls(x) + 1;
 }
 
+#define HAVE_ARCH_FLS64_BITOPS
+
 /**
  * fls - find last bit set
  * @x: the word to search
@@ -412,44 +416,21 @@
 	return r+1;
 }
 
-/**
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-#define hweight64(x) generic_hweight64(x)
-#define hweight32(x) generic_hweight32(x)
-#define hweight16(x) generic_hweight16(x)
-#define hweight8(x) generic_hweight8(x)
+#define HAVE_ARCH_FLS_BITOPS
 
 #endif /* __KERNEL__ */
 
 #ifdef __KERNEL__
 
-#define ext2_set_bit(nr,addr) \
-	__test_and_set_bit((nr),(unsigned long*)addr)
 #define ext2_set_bit_atomic(lock,nr,addr) \
 	        test_and_set_bit((nr),(unsigned long*)addr)
-#define ext2_clear_bit(nr, addr) \
-	__test_and_clear_bit((nr),(unsigned long*)addr)
 #define ext2_clear_bit_atomic(lock,nr,addr) \
 	        test_and_clear_bit((nr),(unsigned long*)addr)
-#define ext2_test_bit(nr, addr)      test_bit((nr),(unsigned long*)addr)
-#define ext2_find_first_zero_bit(addr, size) \
-	find_first_zero_bit((unsigned long*)addr, size)
-#define ext2_find_next_zero_bit(addr, size, off) \
-	find_next_zero_bit((unsigned long*)addr, size, off)
-
-/* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,(void*)addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,(void*)addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,(void*)addr)
-#define minix_test_bit(nr,addr) test_bit(nr,(void*)addr)
-#define minix_find_first_zero_bit(addr,size) \
-	find_first_zero_bit((void*)addr,size)
+
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif /* _X86_64_BITOPS_H */
Index: 2.6-git/include/asm-xtensa/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-xtensa/bitops.h	2006-01-25 19:14:08.000000000 +0900
+++ 2.6-git/include/asm-xtensa/bitops.h	2006-01-25 19:14:25.000000000 +0900
@@ -23,44 +23,6 @@
 # error SMP not supported on this architecture
 #endif
 
-static __inline__ void set_bit(int nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	*a |= mask;
-	local_irq_restore(flags);
-}
-
-static __inline__ void __set_bit(int nr, volatile unsigned long * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-
-	*a |= mask;
-}
-
-static __inline__ void clear_bit(int nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	*a &= ~mask;
-	local_irq_restore(flags);
-}
-
-static __inline__ void __clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-
-	*a &= ~mask;
-}
-
 /*
  * clear_bit() doesn't provide any barrier for the compiler.
  */
@@ -68,112 +30,6 @@
 #define smp_mb__before_clear_bit()	barrier()
 #define smp_mb__after_clear_bit()	barrier()
 
-static __inline__ void change_bit(int nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	*a ^= mask;
-	local_irq_restore(flags);
-}
-
-static __inline__ void __change_bit(int nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-
-	*a ^= mask;
-}
-
-static __inline__ int test_and_set_bit(int nr, volatile void * addr)
-{
-  	unsigned long retval;
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	retval = (mask & *a) != 0;
-	*a |= mask;
-	local_irq_restore(flags);
-
-	return retval;
-}
-
-static __inline__ int __test_and_set_bit(int nr, volatile void * addr)
-{
-  	unsigned long retval;
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-
-	retval = (mask & *a) != 0;
-	*a |= mask;
-
-	return retval;
-}
-
-static __inline__ int test_and_clear_bit(int nr, volatile void * addr)
-{
-  	unsigned long retval;
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-	retval = (mask & *a) != 0;
-	*a &= ~mask;
-	local_irq_restore(flags);
-
-	return retval;
-}
-
-static __inline__ int __test_and_clear_bit(int nr, volatile void * addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-  	unsigned long old = *a;
-
-	*a = old & ~mask;
-	return (old & mask) != 0;
-}
-
-static __inline__ int test_and_change_bit(int nr, volatile void * addr)
-{
-  	unsigned long retval;
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	retval = (mask & *a) != 0;
-	*a ^= mask;
-	local_irq_restore(flags);
-
-	return retval;
-}
-
-/*
- * non-atomic version; can be reordered
- */
-
-static __inline__ int __test_and_change_bit(int nr, volatile void *addr)
-{
-	unsigned long mask = 1 << (nr & 0x1f);
-	unsigned long *a = ((unsigned long *)addr) + (nr >> 5);
-	unsigned long old = *a;
-
-	*a = old ^ mask;
-	return (old & mask) != 0;
-}
-
-static __inline__ int test_bit(int nr, const volatile void *addr)
-{
-	return 1UL & (((const volatile unsigned int *)addr)[nr>>5] >> (nr&31));
-}
-
 #if XCHAL_HAVE_NSA
 
 static __inline__ int __cntlz (unsigned long x)
@@ -216,6 +72,8 @@
 	return __cntlz(x & -x);
 }
 
+#define HAVE_ARCH_FFZ_BITOPS
+
 /*
  * __ffs: Find first bit set in word. Return 0 for bit 0
  */
@@ -225,6 +83,8 @@
 	return __cntlz(x & -x);
 }
 
+#define HAVE_ARCH___FFS_BITOPS
+
 /*
  * ffs: Find first bit set in word. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
@@ -236,6 +96,8 @@
 	return __cntlz(x & -x) + 1;
 }
 
+#define HAVE_ARCH_FFS_BITOPS
+
 /*
  * fls: Find last (most-significant) bit set in word.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
@@ -245,203 +107,26 @@
 {
 	return __cntlz(x);
 }
-#define fls64(x)   generic_fls64(x)
-
-static __inline__ int
-find_next_bit(const unsigned long *addr, int size, int offset)
-{
-	const unsigned long *p = addr + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *p++;
-		tmp &= ~0UL << offset;
-		if (size < 32)
-			goto found_first;
-		if (tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size >= 32) {
-		if ((tmp = *p++) != 0)
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp &= ~0UL >> (32 - size);
-	if (tmp == 0UL)	/* Are any bits set? */
-		return result + size;	/* Nope. */
-found_middle:
-	return result + __ffs(tmp);
-}
-
-/**
- * find_first_bit - find the first set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first set bit, not the number of the byte
- * containing a bit.
- */
-
-#define find_first_bit(addr, size) \
-        find_next_bit((addr), (size), 0)
-
-static __inline__ int
-find_next_zero_bit(const unsigned long *addr, int size, int offset)
-{
-	const unsigned long *p = addr + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if (offset) {
-		tmp = *p++;
-		tmp |= ~0UL >> (32-offset);
-		if (size < 32)
-			goto found_first;
-		if (~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while (size & ~31UL) {
-		if (~(tmp = *p++))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if (!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	tmp |= ~0UL << size;
-found_middle:
-	return result + ffz(tmp);
-}
-
-#define find_first_zero_bit(addr, size) \
-        find_next_zero_bit((addr), (size), 0)
+#define HAVE_ARCH_FLS_BITOPS
 
 #ifdef __XTENSA_EL__
-# define ext2_set_bit(nr,addr) __test_and_set_bit((nr), (addr))
+
 # define ext2_set_bit_atomic(lock,nr,addr) test_and_set_bit((nr),(addr))
-# define ext2_clear_bit(nr,addr) __test_and_clear_bit((nr), (addr))
 # define ext2_clear_bit_atomic(lock,nr,addr) test_and_clear_bit((nr),(addr))
-# define ext2_test_bit(nr,addr) test_bit((nr), (addr))
-# define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr),(size))
-# define ext2_find_next_zero_bit(addr, size, offset) \
-                find_next_zero_bit((addr), (size), (offset))
+
 #elif defined(__XTENSA_EB__)
-# define ext2_set_bit(nr,addr) __test_and_set_bit((nr) ^ 0x18, (addr))
+
 # define ext2_set_bit_atomic(lock,nr,addr) test_and_set_bit((nr) ^ 0x18, (addr))
-# define ext2_clear_bit(nr,addr) __test_and_clear_bit((nr) ^ 18, (addr))
 # define ext2_clear_bit_atomic(lock,nr,addr) test_and_clear_bit((nr)^0x18,(addr))
-# define ext2_test_bit(nr,addr) test_bit((nr) ^ 0x18, (addr))
-# define ext2_find_first_zero_bit(addr, size) \
-        ext2_find_next_zero_bit((addr), (size), 0)
-
-static __inline__ unsigned long ext2_find_next_zero_bit(void *addr, unsigned long size, unsigned long offset)
-{
-	unsigned long *p = ((unsigned long *) addr) + (offset >> 5);
-	unsigned long result = offset & ~31UL;
-	unsigned long tmp;
-
-	if (offset >= size)
-		return size;
-	size -= result;
-	offset &= 31UL;
-	if(offset) {
-		/* We hold the little endian value in tmp, but then the
-		 * shift is illegal. So we could keep a big endian value
-		 * in tmp, like this:
-		 *
-		 * tmp = __swab32(*(p++));
-		 * tmp |= ~0UL >> (32-offset);
-		 *
-		 * but this would decrease preformance, so we change the
-		 * shift:
-		 */
-		tmp = *(p++);
-		tmp |= __swab32(~0UL >> (32-offset));
-		if(size < 32)
-			goto found_first;
-		if(~tmp)
-			goto found_middle;
-		size -= 32;
-		result += 32;
-	}
-	while(size & ~31UL) {
-		if(~(tmp = *(p++)))
-			goto found_middle;
-		result += 32;
-		size -= 32;
-	}
-	if(!size)
-		return result;
-	tmp = *p;
-
-found_first:
-	/* tmp is little endian, so we would have to swab the shift,
-	 * see above. But then we have to swab tmp below for ffz, so
-	 * we might as well do this here.
-	 */
-	return result + ffz(__swab32(tmp) | (~0UL << size));
-found_middle:
-	return result + ffz(__swab32(tmp));
-}
 
 #else
 # error processor byte order undefined!
 #endif
 
-
-#define hweight32(x)	generic_hweight32(x)
-#define hweight16(x)	generic_hweight16(x)
-#define hweight8(x)	generic_hweight8(x)
-
-/*
- * Find the first bit set in a 140-bit bitmap.
- * The first 100 bits are unlikely to be set.
- */
-
-static inline int sched_find_first_bit(const unsigned long *b)
-{
-	if (unlikely(b[0]))
-		return __ffs(b[0]);
-	if (unlikely(b[1]))
-		return __ffs(b[1]) + 32;
-	if (unlikely(b[2]))
-		return __ffs(b[2]) + 64;
-	if (b[3])
-		return __ffs(b[3]) + 96;
-	return __ffs(b[4]) + 128;
-}
-
-
-/* Bitmap functions for the minix filesystem.  */
-
-#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) __set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
-#define minix_test_bit(nr,addr) test_bit(nr,addr)
-#define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
+#define HAVE_ARCH_EXT2_ATOMIC_BITOPS
 
 #endif	/* __KERNEL__ */
 
+#include <asm-generic/bitops.h>
+
 #endif	/* _XTENSA_BITOPS_H */
