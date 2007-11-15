Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 16:22:05 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.185]:51658 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20031829AbXKOQV4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Nov 2007 16:21:56 +0000
Received: by mu-out-0910.google.com with SMTP id g7so604959muf
        for <linux-mips@linux-mips.org>; Thu, 15 Nov 2007 08:21:46 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=IdK9Gg3Edjg4TeueMZMoWS9xj81foWrf8o/q02d80vs=;
        b=dZHayId60+3VCxuwTaPQQ7tPRMJRZ0pKT3sWfo57z9pYLNwZfvhPStR/WxbPVayS4Nw/oEVmeEFp6f+1aEeVlf1VE6rLNGHR+XpRsQovx1btRC5epszRNNOEkPwVx4+X+kmUGxkLgjs8U/YrOQ71IU942XnFh/jlRgoobAkQg6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=l3aD9EhvNgqkanw8oXgP9LP2+4QvMLinAM82NfcTPGozeOdRf0UheB84+LIcXn8ZMRbA5slUp40UbAHp66pD+jWYGBYxWjajCZC+ZN/AxQJxjNrYZ/ItqrgmsFgp0d64c4lUerSvKEvv4wh+KhT0IOI5YUhRF3TIcqk5VwqMGdk=
Received: by 10.82.183.19 with SMTP id g19mr2336904buf.1195143705756;
        Thu, 15 Nov 2007 08:21:45 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id w7sm3359260mue.2007.11.15.08.21.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Nov 2007 08:21:41 -0800 (PST)
Message-ID: <473C720B.7000100@gmail.com>
Date:	Thu, 15 Nov 2007 17:21:31 +0100
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thiemo Seufer <ths@networkno.de>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Introduce __fill_user() and kill __bzero() [take #2]
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Currently memset() is used to fill a user space area (clear_user) or
kernel one (memset). These two functions don't have the same
prototype, the former returning the number of bytes not copied and the
latter returning the start address of the area to clear. This forces
memset() to actually returns two values in an unconventional way ie
the number of bytes not copied is given by $a2. Therefore clear_user()
needs to call memset() using inline assembly.

Instead this patch creates __fill_user() which is the same as memset()
except it always returns the number of bytes not copied. This simplify
clear_user() and makes its definition saner.

Also an out of line version of memset is given because gcc generates
some calls to it since builtin functions have been disabled. It allows
assembly code to call it too.

Eventually __bzero() has been removed because it's not part of the
Linux uaccess API. And the nano-optimization it brings is not
worthing.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Thimeo,

 I put the out of line version of memset in kernel/mips_ksym.c. I
 haven't found a better place. But if you really think we should
 create a lib/memset.c and rename lib/memset.S into lib/fill_user.S, I
 can change it.

 Thanks,
		Franck

 arch/mips/kernel/mips_ksyms.c |   13 +++++++++++--
 arch/mips/lib/csum_partial.S  |    2 +-
 arch/mips/lib/memcpy.S        |    2 +-
 arch/mips/lib/memset.S        |   34 +++++++++++++++++-----------------
 include/asm-mips/string.h     |    7 ++++++-
 include/asm-mips/uaccess.h    |   17 +++--------------
 6 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
index 225755d..091275e 100644
--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -14,7 +14,6 @@
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 
-extern void *__bzero(void *__s, size_t __count);
 extern long __strncpy_from_user_nocheck_asm(char *__to,
                                             const char *__from, long __len);
 extern long __strncpy_from_user_asm(char *__to, const char *__from,
@@ -36,9 +35,9 @@ EXPORT_SYMBOL(kernel_thread);
 /*
  * Userspace access stuff.
  */
+EXPORT_SYMBOL(__fill_user);
 EXPORT_SYMBOL(__copy_user);
 EXPORT_SYMBOL(__copy_user_inatomic);
-EXPORT_SYMBOL(__bzero);
 EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm);
 EXPORT_SYMBOL(__strncpy_from_user_asm);
 EXPORT_SYMBOL(__strlen_user_nocheck_asm);
@@ -51,3 +50,13 @@ EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(__csum_partial_copy_user);
 
 EXPORT_SYMBOL(invalid_pte_table);
+
+/*
+ * An outline version of memset, which should be used either by gcc or
+ * by assembly code.
+ */
+void *memset(void *s, int c, __kernel_size_t len)
+{
+	__fill_user(s, c, len);
+	return s;
+}
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index c0a77fe..8d3fa1e 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -694,7 +694,7 @@ l_exc:
 	ADD	dst, t0			# compute start address in a1
 	SUB	dst, src
 	/*
-	 * Clear len bytes starting at dst.  Can't call __bzero because it
+	 * Clear len bytes starting at dst.  Can't call memset because it
 	 * might modify len.  An inefficient loop for these rare times...
 	 */
 	beqz	len, done
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index a526c62..425f2c3 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -443,7 +443,7 @@ l_exc:
 	ADD	dst, t0			# compute start address in a1
 	SUB	dst, src
 	/*
-	 * Clear len bytes starting at dst.  Can't call __bzero because it
+	 * Clear len bytes starting at dst.  Can't call memset because it
 	 * might modify len.  An inefficient loop for these rare times...
 	 */
 	beqz	len, done
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 3f8b8b3..4329811 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -46,17 +46,19 @@
 	.endm
 
 /*
- * memset(void *s, int c, size_t n)
+ * __kernel_size_t __fill_user(void __user *s, long c, __kernel_size_t n)
  *
  * a0: start of area to clear
  * a1: char to fill with
  * a2: size of area to clear
+ *
+ * Returns the number of bytes NOT set or 0 on success.
  */
 	.set	noreorder
 	.align	5
-LEAF(memset)
+LEAF(__fill_user)
 	beqz		a1, 1f
-	 move		v0, a0			/* result */
+	 move		v0, zero		/* result */
 
 	andi		a1, 0xff		/* spread fillword */
 	LONG_SLL		t1, a1, 8
@@ -68,8 +70,6 @@ LEAF(memset)
 #endif
 	or		a1, t1
 1:
-
-FEXPORT(__bzero)
 	sltiu		t0, a2, LONGSIZE	/* very small region? */
 	bnez		t0, small_memset
 	 andi		t0, a0, LONGMASK	/* aligned? */
@@ -127,7 +127,7 @@ memset_partial:
 	EX(LONG_S_L, a1, -1(a0), last_fixup)
 #endif
 1:	jr		ra
-	 move		a2, zero
+	 nop
 
 small_memset:
 	beqz		a2, 2f
@@ -138,29 +138,29 @@ small_memset:
 	 sb		a1, -1(a0)
 
 2:	jr		ra			/* done */
-	 move		a2, zero
-	END(memset)
+	 nop
+END(__fill_user)
 
 first_fixup:
-	jr	ra
-	 nop
+	jr		ra
+	 move		v0, a2
 
 fwd_fixup:
 	PTR_L		t0, TI_TASK($28)
 	LONG_L		t0, THREAD_BUADDR(t0)
-	andi		a2, 0x3f
-	LONG_ADDU	a2, t1
+	andi		v0, a2, 0x3f
+	LONG_ADDU	v0, t1
 	jr		ra
-	 LONG_SUBU	a2, t0
+	 LONG_SUBU	v0, t0
 
 partial_fixup:
 	PTR_L		t0, TI_TASK($28)
 	LONG_L		t0, THREAD_BUADDR(t0)
-	andi		a2, LONGMASK
-	LONG_ADDU	a2, t1
+	andi		v0, a2, LONGMASK
+	LONG_ADDU	v0, t1
 	jr		ra
-	 LONG_SUBU	a2, t0
+	 LONG_SUBU	v0, t0
 
 last_fixup:
 	jr		ra
-	 andi		v1, a2, LONGMASK
+	 andi		v0, a2, LONGMASK
diff --git a/include/asm-mips/string.h b/include/asm-mips/string.h
index 436e3ad..2bba927 100644
--- a/include/asm-mips/string.h
+++ b/include/asm-mips/string.h
@@ -10,6 +10,7 @@
 #ifndef _ASM_STRING_H
 #define _ASM_STRING_H
 
+#include <asm/uaccess.h>	/* __fill_user() */
 
 /*
  * Most of the inline functions are rather naive implementations so I just
@@ -132,7 +133,11 @@ strncmp(__const__ char *__cs, __const__ char *__ct, size_t __count)
 #endif /* CONFIG_32BIT */
 
 #define __HAVE_ARCH_MEMSET
-extern void *memset(void *__s, int __c, size_t __count);
+extern inline void *memset(void *s, int c, size_t count)
+{
+	__fill_user(s, c, count);
+	return s;
+}
 
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
diff --git a/include/asm-mips/uaccess.h b/include/asm-mips/uaccess.h
index c30c718..8c0d226 100644
--- a/include/asm-mips/uaccess.h
+++ b/include/asm-mips/uaccess.h
@@ -11,7 +11,6 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/thread_info.h>
 #include <asm-generic/uaccess.h>
 
 /*
@@ -633,23 +632,13 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
  * Returns number of bytes that could not be cleared.
  * On success, this will be zero.
  */
+extern __kernel_size_t __fill_user(void __user *s, long c, __kernel_size_t n);
+
 static inline __kernel_size_t
 __clear_user(void __user *addr, __kernel_size_t size)
 {
-	__kernel_size_t res;
-
 	might_sleep();
-	__asm__ __volatile__(
-		"move\t$4, %1\n\t"
-		"move\t$5, $0\n\t"
-		"move\t$6, %2\n\t"
-		__MODULE_JAL(__bzero)
-		"move\t%0, $6"
-		: "=r" (res)
-		: "r" (addr), "r" (size)
-		: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
-
-	return res;
+	return __fill_user(addr, 0, size);
 }
 
 #define clear_user(addr,n)						\
