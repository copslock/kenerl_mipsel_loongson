Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 09:00:42 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:63049 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133401AbWBAI6Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Feb 2006 08:58:24 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id C270931C203; Wed,  1 Feb 2006 18:03:22 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Wed, 01 Feb 2006 09:03:22 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 2BA974201E0; Wed,  1 Feb 2006 18:03:22 +0900 (JST)
Message-Id: <20060201090322.062243000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date:	Wed, 01 Feb 2006 18:02:28 +0900
From:	Akinobu Mita <mita@miraclelinux.com>
To:	linux-kernel@vger.kernel.org
Cc:	dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@lists.linux-m68k.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Chris Zankel <chris@zankel.net>,
	Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 04/44] use non atomic operations for minix_*_bit() and ext2_*_bit()
Content-Disposition: inline; filename=use-non-atomic.patch
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

Bitmap functions for the minix filesystem and the ext2 filesystem do not
require the atomic guarantees except ext2_set_bit_atomic() and
ext2_clear_bit_atomic().

But these are defined by using atomic bit operations on several architectures.
(cris, frv, h8300, ia64, m32r, m68k, m68knommu, mips, s390, sh, sh64, sparc,
 sparc64, v850, and xtensa)

This patch switches to non atomic bit operation.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/asm-cris/bitops.h      |    8 ++++----
 include/asm-frv/bitops.h       |   14 +++++++-------
 include/asm-h8300/bitops.h     |    6 +++---
 include/asm-ia64/bitops.h      |   10 +++++-----
 include/asm-m32r/bitops.h      |    2 +-
 include/asm-m68k/bitops.h      |   10 +++++-----
 include/asm-m68knommu/bitops.h |    6 +++---
 include/asm-mips/bitops.h      |    6 +++---
 include/asm-s390/bitops.h      |   10 +++++-----
 include/asm-sh/bitops.h        |   16 +++++-----------
 include/asm-sh64/bitops.h      |   16 +++++-----------
 include/asm-sparc/bitops.h     |    6 +++---
 include/asm-sparc64/bitops.h   |    6 +++---
 include/asm-v850/bitops.h      |   10 +++++-----
 include/asm-xtensa/bitops.h    |    6 +++---
 15 files changed, 60 insertions(+), 72 deletions(-)

Index: 2.6-git/include/asm-h8300/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-h8300/bitops.h
+++ 2.6-git/include/asm-h8300/bitops.h
@@ -397,9 +397,9 @@ found_middle:
 }
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-ia64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-ia64/bitops.h
+++ 2.6-git/include/asm-ia64/bitops.h
@@ -394,18 +394,18 @@ extern int __find_next_bit(const void *a
 
 #define __clear_bit(nr, addr)		clear_bit(nr, addr)
 
-#define ext2_set_bit			test_and_set_bit
+#define ext2_set_bit			__test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)	test_and_set_bit(n,a)
-#define ext2_clear_bit			test_and_clear_bit
+#define ext2_clear_bit			__test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a)	test_and_clear_bit(n,a)
 #define ext2_test_bit			test_bit
 #define ext2_find_first_zero_bit	find_first_zero_bit
 #define ext2_find_next_zero_bit		find_next_zero_bit
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)		test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr)			set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr)	test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr)		__test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr)			__set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr)	__test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr)			test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size)	find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-mips/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-mips/bitops.h
+++ 2.6-git/include/asm-mips/bitops.h
@@ -956,9 +956,9 @@ found_middle:
  * FIXME: These assume that Minix uses the native byte/bitorder.
  * This limits the Minix filesystem's value for data exchange very much.
  */
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-s390/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-s390/bitops.h
+++ 2.6-git/include/asm-s390/bitops.h
@@ -871,11 +871,11 @@ static inline int sched_find_first_bit(u
  */
 
 #define ext2_set_bit(nr, addr)       \
-	test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
+	__test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_set_bit_atomic(lock, nr, addr)       \
 	test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_clear_bit(nr, addr)     \
-	test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
+	__test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_clear_bit_atomic(lock, nr, addr)     \
 	test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_test_bit(nr, addr)      \
@@ -1014,11 +1014,11 @@ ext2_find_next_zero_bit(void *vaddr, uns
 /* Bitmap functions for the minix filesystem.  */
 /* FIXME !!! */
 #define minix_test_and_set_bit(nr,addr) \
-	test_and_set_bit(nr,(unsigned long *)addr)
+	__test_and_set_bit(nr,(unsigned long *)addr)
 #define minix_set_bit(nr,addr) \
-	set_bit(nr,(unsigned long *)addr)
+	__set_bit(nr,(unsigned long *)addr)
 #define minix_test_and_clear_bit(nr,addr) \
-	test_and_clear_bit(nr,(unsigned long *)addr)
+	__test_and_clear_bit(nr,(unsigned long *)addr)
 #define minix_test_bit(nr,addr) \
 	test_bit(nr,(unsigned long *)addr)
 #define minix_find_first_zero_bit(addr,size) \
Index: 2.6-git/include/asm-sh/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sh/bitops.h
+++ 2.6-git/include/asm-sh/bitops.h
@@ -339,8 +339,8 @@ static inline int sched_find_first_bit(c
 }
 
 #ifdef __LITTLE_ENDIAN__
-#define ext2_set_bit(nr, addr) test_and_set_bit((nr), (addr))
-#define ext2_clear_bit(nr, addr) test_and_clear_bit((nr), (addr))
+#define ext2_set_bit(nr, addr) __test_and_set_bit((nr), (addr))
+#define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr), (addr))
 #define ext2_test_bit(nr, addr) test_bit((nr), (addr))
 #define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
 #define ext2_find_next_zero_bit(addr, size, offset) \
@@ -349,30 +349,24 @@ static inline int sched_find_first_bit(c
 static __inline__ int ext2_set_bit(int nr, volatile void * addr)
 {
 	int		mask, retval;
-	unsigned long	flags;
 	volatile unsigned char	*ADDR = (unsigned char *) addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
 	retval = (mask & *ADDR) != 0;
 	*ADDR |= mask;
-	local_irq_restore(flags);
 	return retval;
 }
 
 static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
 {
 	int		mask, retval;
-	unsigned long	flags;
 	volatile unsigned char	*ADDR = (unsigned char *) addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
 	retval = (mask & *ADDR) != 0;
 	*ADDR &= ~mask;
-	local_irq_restore(flags);
 	return retval;
 }
 
@@ -459,9 +453,9 @@ found_middle:
 	})
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-sh64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sh64/bitops.h
+++ 2.6-git/include/asm-sh64/bitops.h
@@ -382,8 +382,8 @@ static inline int sched_find_first_bit(u
 #define hweight8(x) generic_hweight8(x)
 
 #ifdef __LITTLE_ENDIAN__
-#define ext2_set_bit(nr, addr) test_and_set_bit((nr), (addr))
-#define ext2_clear_bit(nr, addr) test_and_clear_bit((nr), (addr))
+#define ext2_set_bit(nr, addr) __test_and_set_bit((nr), (addr))
+#define ext2_clear_bit(nr, addr) __test_and_clear_bit((nr), (addr))
 #define ext2_test_bit(nr, addr) test_bit((nr), (addr))
 #define ext2_find_first_zero_bit(addr, size) find_first_zero_bit((addr), (size))
 #define ext2_find_next_zero_bit(addr, size, offset) \
@@ -392,30 +392,24 @@ static inline int sched_find_first_bit(u
 static __inline__ int ext2_set_bit(int nr, volatile void * addr)
 {
 	int		mask, retval;
-	unsigned long	flags;
 	volatile unsigned char	*ADDR = (unsigned char *) addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
 	retval = (mask & *ADDR) != 0;
 	*ADDR |= mask;
-	local_irq_restore(flags);
 	return retval;
 }
 
 static __inline__ int ext2_clear_bit(int nr, volatile void * addr)
 {
 	int		mask, retval;
-	unsigned long	flags;
 	volatile unsigned char	*ADDR = (unsigned char *) addr;
 
 	ADDR += nr >> 3;
 	mask = 1 << (nr & 0x07);
-	local_irq_save(flags);
 	retval = (mask & *ADDR) != 0;
 	*ADDR &= ~mask;
-	local_irq_restore(flags);
 	return retval;
 }
 
@@ -502,9 +496,9 @@ found_middle:
 	})
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-sparc/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sparc/bitops.h
+++ 2.6-git/include/asm-sparc/bitops.h
@@ -523,11 +523,11 @@ found_middle:
 
 /* Bitmap functions for the minix filesystem.  */
 #define minix_test_and_set_bit(nr,addr)	\
-	test_and_set_bit((nr),(unsigned long *)(addr))
+	__test_and_set_bit((nr),(unsigned long *)(addr))
 #define minix_set_bit(nr,addr)		\
-	set_bit((nr),(unsigned long *)(addr))
+	__set_bit((nr),(unsigned long *)(addr))
 #define minix_test_and_clear_bit(nr,addr) \
-	test_and_clear_bit((nr),(unsigned long *)(addr))
+	__test_and_clear_bit((nr),(unsigned long *)(addr))
 #define minix_test_bit(nr,addr)		\
 	test_bit((nr),(unsigned long *)(addr))
 #define minix_find_first_zero_bit(addr,size) \
Index: 2.6-git/include/asm-sparc64/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-sparc64/bitops.h
+++ 2.6-git/include/asm-sparc64/bitops.h
@@ -280,11 +280,11 @@ extern unsigned long find_next_zero_le_b
 
 /* Bitmap functions for the minix filesystem.  */
 #define minix_test_and_set_bit(nr,addr)	\
-	test_and_set_bit((nr),(unsigned long *)(addr))
+	__test_and_set_bit((nr),(unsigned long *)(addr))
 #define minix_set_bit(nr,addr)	\
-	set_bit((nr),(unsigned long *)(addr))
+	__set_bit((nr),(unsigned long *)(addr))
 #define minix_test_and_clear_bit(nr,addr) \
-	test_and_clear_bit((nr),(unsigned long *)(addr))
+	__test_and_clear_bit((nr),(unsigned long *)(addr))
 #define minix_test_bit(nr,addr)	\
 	test_bit((nr),(unsigned long *)(addr))
 #define minix_find_first_zero_bit(addr,size) \
Index: 2.6-git/include/asm-v850/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-v850/bitops.h
+++ 2.6-git/include/asm-v850/bitops.h
@@ -336,18 +336,18 @@ static inline int sched_find_first_bit(u
 #define hweight16(x) 			generic_hweight16 (x)
 #define hweight8(x) 			generic_hweight8 (x)
 
-#define ext2_set_bit			test_and_set_bit
+#define ext2_set_bit			__test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)      test_and_set_bit(n,a)
-#define ext2_clear_bit			test_and_clear_bit
+#define ext2_clear_bit			__test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a)    test_and_clear_bit(n,a)
 #define ext2_test_bit			test_bit
 #define ext2_find_first_zero_bit	find_first_zero_bit
 #define ext2_find_next_zero_bit		find_next_zero_bit
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit		test_and_set_bit
-#define minix_set_bit			set_bit
-#define minix_test_and_clear_bit	test_and_clear_bit
+#define minix_test_and_set_bit		__test_and_set_bit
+#define minix_set_bit			__set_bit
+#define minix_test_and_clear_bit	__test_and_clear_bit
 #define minix_test_bit 			test_bit
 #define minix_find_first_zero_bit 	find_first_zero_bit
 
Index: 2.6-git/include/asm-xtensa/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-xtensa/bitops.h
+++ 2.6-git/include/asm-xtensa/bitops.h
@@ -436,9 +436,9 @@ static inline int sched_find_first_bit(c
 
 /* Bitmap functions for the minix filesystem.  */
 
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-m32r/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-m32r/bitops.h
+++ 2.6-git/include/asm-m32r/bitops.h
@@ -575,7 +575,7 @@ found_middle:
  */
 
 #ifdef __LITTLE_ENDIAN__
-#define ext2_set_bit			test_and_set_bit
+#define ext2_set_bit			__test_and_set_bit
 #define ext2_clear_bit			__test_and_clear_bit
 #define ext2_test_bit			test_bit
 #define ext2_find_first_zero_bit	find_first_zero_bit
Index: 2.6-git/include/asm-cris/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-cris/bitops.h
+++ 2.6-git/include/asm-cris/bitops.h
@@ -352,17 +352,17 @@ found_middle:
 #define find_first_bit(addr, size) \
         find_next_bit((addr), (size), 0)
 
-#define ext2_set_bit                 test_and_set_bit
+#define ext2_set_bit                 __test_and_set_bit
 #define ext2_set_bit_atomic(l,n,a)   test_and_set_bit(n,a)
-#define ext2_clear_bit               test_and_clear_bit
+#define ext2_clear_bit               __test_and_clear_bit
 #define ext2_clear_bit_atomic(l,n,a) test_and_clear_bit(n,a)
 #define ext2_test_bit                test_bit
 #define ext2_find_first_zero_bit     find_first_zero_bit
 #define ext2_find_next_zero_bit      find_next_zero_bit
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-frv/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-frv/bitops.h
+++ 2.6-git/include/asm-frv/bitops.h
@@ -259,11 +259,11 @@ static inline int sched_find_first_bit(c
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
 
-#define ext2_set_bit(nr, addr)		test_and_set_bit  ((nr) ^ 0x18, (addr))
-#define ext2_clear_bit(nr, addr)	test_and_clear_bit((nr) ^ 0x18, (addr))
+#define ext2_set_bit(nr, addr)		__test_and_set_bit  ((nr) ^ 0x18, (addr))
+#define ext2_clear_bit(nr, addr)	__test_and_clear_bit((nr) ^ 0x18, (addr))
 
-#define ext2_set_bit_atomic(lock,nr,addr)	ext2_set_bit((nr), addr)
-#define ext2_clear_bit_atomic(lock,nr,addr)	ext2_clear_bit((nr), addr)
+#define ext2_set_bit_atomic(lock,nr,addr)	test_and_set_bit  ((nr) ^ 0x18, (addr))
+#define ext2_clear_bit_atomic(lock,nr,addr)	test_and_clear_bit((nr) ^ 0x18, (addr))
 
 static inline int ext2_test_bit(int nr, const volatile void * addr)
 {
@@ -331,9 +331,9 @@ found_middle:
 }
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr)		ext2_set_bit(nr,addr)
-#define minix_set_bit(nr,addr)			ext2_set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr)	ext2_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr)		__test_and_set_bit  ((nr) ^ 0x18, (addr))
+#define minix_set_bit(nr,addr)			__set_bit((nr) ^ 0x18, (addr))
+#define minix_test_and_clear_bit(nr,addr)	__test_and_clear_bit((nr) ^ 0x18, (addr))
 #define minix_test_bit(nr,addr)			ext2_test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size)	ext2_find_first_zero_bit(addr,size)
 
Index: 2.6-git/include/asm-m68k/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-m68k/bitops.h
+++ 2.6-git/include/asm-m68k/bitops.h
@@ -365,9 +365,9 @@ static inline int minix_find_first_zero_
 	return ((p - addr) << 4) + (res ^ 31);
 }
 
-#define minix_test_and_set_bit(nr, addr)	test_and_set_bit((nr) ^ 16, (unsigned long *)(addr))
-#define minix_set_bit(nr,addr)			set_bit((nr) ^ 16, (unsigned long *)(addr))
-#define minix_test_and_clear_bit(nr, addr)	test_and_clear_bit((nr) ^ 16, (unsigned long *)(addr))
+#define minix_test_and_set_bit(nr, addr)	__test_and_set_bit((nr) ^ 16, (unsigned long *)(addr))
+#define minix_set_bit(nr,addr)			__set_bit((nr) ^ 16, (unsigned long *)(addr))
+#define minix_test_and_clear_bit(nr, addr)	__test_and_clear_bit((nr) ^ 16, (unsigned long *)(addr))
 
 static inline int minix_test_bit(int nr, const void *vaddr)
 {
@@ -377,9 +377,9 @@ static inline int minix_test_bit(int nr,
 
 /* Bitmap functions for the ext2 filesystem. */
 
-#define ext2_set_bit(nr, addr)			test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
+#define ext2_set_bit(nr, addr)			__test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
 #define ext2_set_bit_atomic(lock, nr, addr)	test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
-#define ext2_clear_bit(nr, addr)		test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
+#define ext2_clear_bit(nr, addr)		__test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
 #define ext2_clear_bit_atomic(lock, nr, addr)	test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
 
 static inline int ext2_test_bit(int nr, const void *vaddr)
Index: 2.6-git/include/asm-m68knommu/bitops.h
===================================================================
--- 2.6-git.orig/include/asm-m68knommu/bitops.h
+++ 2.6-git/include/asm-m68knommu/bitops.h
@@ -476,9 +476,9 @@ found_middle:
 }
 
 /* Bitmap functions for the minix filesystem.  */
-#define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
-#define minix_set_bit(nr,addr) set_bit(nr,addr)
-#define minix_test_and_clear_bit(nr,addr) test_and_clear_bit(nr,addr)
+#define minix_test_and_set_bit(nr,addr) __test_and_set_bit(nr,addr)
+#define minix_set_bit(nr,addr) __set_bit(nr,addr)
+#define minix_test_and_clear_bit(nr,addr) __test_and_clear_bit(nr,addr)
 #define minix_test_bit(nr,addr) test_bit(nr,addr)
 #define minix_find_first_zero_bit(addr,size) find_first_zero_bit(addr,size)
 

--
