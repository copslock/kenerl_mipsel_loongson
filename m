Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2006 16:30:51 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:64743 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133442AbWBPQa3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 16 Feb 2006 16:30:29 +0000
Received: from localhost (p6076-ipad212funabasi.chiba.ocn.ne.jp [58.91.170.76])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DA922AE97; Fri, 17 Feb 2006 01:36:36 +0900 (JST)
Date:	Fri, 17 Feb 2006 01:36:24 +0900 (JST)
Message-Id: <20060217.013624.04769497.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] make I/O helpers more customizable
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
X-archive-position: 10478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

1. Move ioswab*() and __mem_ioswab*() to mangle-port.h.  Now io.h is
clean from CONFIG_SGI_IP22.

2. Pass a virtual address to *ioswab*().  Then we can provide
mach-specific *ioswab*() and can do every evil thing based on its
argument.  It could be useful on machines which have regions with
different endian conversion scheme.

3. Call __swizzle_addr*() _after_ adding mips_io_port_base.  This
unifies the meaning of the argument of __swizzle_addr*() (always
virtual address).  Then mach-specific __swizzle_addr*() can do every
evil thing based on the argument.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index 10ea7ca..7efac6d 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -40,56 +40,13 @@
  * hardware.  An example use would be for flash memory that's used for
  * execute in place.
  */
-# define __raw_ioswabb(x)	(x)
-# define __raw_ioswabw(x)	(x)
-# define __raw_ioswabl(x)	(x)
-# define __raw_ioswabq(x)	(x)
-# define ____raw_ioswabq(x)	(x)
-
-/*
- * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardware;
- * less sane hardware forces software to fiddle with this...
- *
- * Regardless, if the host bus endianness mismatches that of PCI/ISA, then
- * you can't have the numerical value of data and byte addresses within
- * multibyte quantities both preserved at the same time.  Hence two
- * variations of functions: non-prefixed ones that preserve the value
- * and prefixed ones that preserve byte addresses.  The latters are
- * typically used for moving raw data between a peripheral and memory (cf.
- * string I/O functions), hence the "__mem_" prefix.
- */
-#if defined(CONFIG_SWAP_IO_SPACE)
-
-# define ioswabb(x)		(x)
-# define __mem_ioswabb(x)	(x)
-# ifdef CONFIG_SGI_IP22
-/*
- * IP22 seems braindead enough to swap 16bits values in hardware, but
- * not 32bits.  Go figure... Can't tell without documentation.
- */
-#  define ioswabw(x)		(x)
-#  define __mem_ioswabw(x)	le16_to_cpu(x)
-# else
-#  define ioswabw(x)		le16_to_cpu(x)
-#  define __mem_ioswabw(x)	(x)
-# endif
-# define ioswabl(x)		le32_to_cpu(x)
-# define __mem_ioswabl(x)	(x)
-# define ioswabq(x)		le64_to_cpu(x)
-# define __mem_ioswabq(x)	(x)
+# define __raw_ioswabb(a,x)	(x)
+# define __raw_ioswabw(a,x)	(x)
+# define __raw_ioswabl(a,x)	(x)
+# define __raw_ioswabq(a,x)	(x)
+# define ____raw_ioswabq(a,x)	(x)
 
-#else
-
-# define ioswabb(x)		(x)
-# define __mem_ioswabb(x)	(x)
-# define ioswabw(x)		(x)
-# define __mem_ioswabw(x)	cpu_to_le16(x)
-# define ioswabl(x)		(x)
-# define __mem_ioswabl(x)	cpu_to_le32(x)
-# define ioswabq(x)		(x)
-# define __mem_ioswabq(x)	cpu_to_le32(x)
-
-#endif
+/* ioswab[bwlq], __mem_ioswab[bwlq] are defined in mangle-port.h */
 
 #define IO_SPACE_LIMIT 0xffff
 
@@ -316,7 +273,7 @@ static inline void pfx##write##bwlq(type
 									\
 	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
 									\
-	__val = pfx##ioswab##bwlq(val);					\
+	__val = pfx##ioswab##bwlq(__mem, val);				\
 									\
 	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long))	\
 		*__mem = __val;						\
@@ -371,7 +328,7 @@ static inline type pfx##read##bwlq(const
 		BUG();							\
 	}								\
 									\
-	return pfx##ioswab##bwlq(__val);				\
+	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
 #define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p, slow)			\
@@ -381,10 +338,9 @@ static inline void pfx##out##bwlq##p(typ
 	volatile type *__addr;						\
 	type __val;							\
 									\
-	port = __swizzle_addr_##bwlq(port);				\
-	__addr = (void *)(mips_io_port_base + port);			\
+	__addr = (void *)__swizzle_addr_##bwlq(mips_io_port_base + port); \
 									\
-	__val = pfx##ioswab##bwlq(val);					\
+	__val = pfx##ioswab##bwlq(__addr, val);				\
 									\
 	/* Really, we want this to be atomic */				\
 	BUILD_BUG_ON(sizeof(type) > sizeof(unsigned long));		\
@@ -398,15 +354,14 @@ static inline type pfx##in##bwlq##p(unsi
 	volatile type *__addr;						\
 	type __val;							\
 									\
-	port = __swizzle_addr_##bwlq(port);				\
-	__addr = (void *)(mips_io_port_base + port);			\
+	__addr = (void *)__swizzle_addr_##bwlq(mips_io_port_base + port); \
 									\
 	BUILD_BUG_ON(sizeof(type) > sizeof(unsigned long));		\
 									\
 	__val = *__addr;						\
 	slow;								\
 									\
-	return pfx##ioswab##bwlq(__val);				\
+	return pfx##ioswab##bwlq(__addr, __val);			\
 }
 
 #define __BUILD_MEMORY_PFX(bus, bwlq, type)				\
diff --git a/include/asm-mips/mach-generic/mangle-port.h b/include/asm-mips/mach-generic/mangle-port.h
index 4a98d83..6e1b0c0 100644
--- a/include/asm-mips/mach-generic/mangle-port.h
+++ b/include/asm-mips/mach-generic/mangle-port.h
@@ -13,4 +13,40 @@
 #define __swizzle_addr_l(port)	(port)
 #define __swizzle_addr_q(port)	(port)
 
+/*
+ * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardware;
+ * less sane hardware forces software to fiddle with this...
+ *
+ * Regardless, if the host bus endianness mismatches that of PCI/ISA, then
+ * you can't have the numerical value of data and byte addresses within
+ * multibyte quantities both preserved at the same time.  Hence two
+ * variations of functions: non-prefixed ones that preserve the value
+ * and prefixed ones that preserve byte addresses.  The latters are
+ * typically used for moving raw data between a peripheral and memory (cf.
+ * string I/O functions), hence the "__mem_" prefix.
+ */
+#if defined(CONFIG_SWAP_IO_SPACE)
+
+# define ioswabb(a,x)		(x)
+# define __mem_ioswabb(a,x)	(x)
+# define ioswabw(a,x)		le16_to_cpu(x)
+# define __mem_ioswabw(a,x)	(x)
+# define ioswabl(a,x)		le32_to_cpu(x)
+# define __mem_ioswabl(a,x)	(x)
+# define ioswabq(a,x)		le64_to_cpu(x)
+# define __mem_ioswabq(a,x)	(x)
+
+#else
+
+# define ioswabb(a,x)		(x)
+# define __mem_ioswabb(a,x)	(x)
+# define ioswabw(a,x)		(x)
+# define __mem_ioswabw(a,x)	cpu_to_le16(x)
+# define ioswabl(a,x)		(x)
+# define __mem_ioswabl(a,x)	cpu_to_le32(x)
+# define ioswabq(a,x)		(x)
+# define __mem_ioswabq(a,x)	cpu_to_le32(x)
+
+#endif
+
 #endif /* __ASM_MACH_GENERIC_MANGLE_PORT_H */
diff --git a/include/asm-mips/mach-ip27/mangle-port.h b/include/asm-mips/mach-ip27/mangle-port.h
index f76c448..d615312 100644
--- a/include/asm-mips/mach-ip27/mangle-port.h
+++ b/include/asm-mips/mach-ip27/mangle-port.h
@@ -13,4 +13,13 @@
 #define __swizzle_addr_l(port)	(port)
 #define __swizzle_addr_q(port)	(port)
 
+# define ioswabb(a,x)		(x)
+# define __mem_ioswabb(a,x)	(x)
+# define ioswabw(a,x)		(x)
+# define __mem_ioswabw(a,x)	cpu_to_le16(x)
+# define ioswabl(a,x)		(x)
+# define __mem_ioswabl(a,x)	cpu_to_le32(x)
+# define ioswabq(a,x)		(x)
+# define __mem_ioswabq(a,x)	cpu_to_le32(x)
+
 #endif /* __ASM_MACH_IP27_MANGLE_PORT_H */
diff --git a/include/asm-mips/mach-ip32/mangle-port.h b/include/asm-mips/mach-ip32/mangle-port.h
index 6e25b52..81320eb 100644
--- a/include/asm-mips/mach-ip32/mangle-port.h
+++ b/include/asm-mips/mach-ip32/mangle-port.h
@@ -14,4 +14,13 @@
 #define __swizzle_addr_l(port)	(port)
 #define __swizzle_addr_q(port)	(port)
 
+# define ioswabb(a,x)		(x)
+# define __mem_ioswabb(a,x)	(x)
+# define ioswabw(a,x)		(x)
+# define __mem_ioswabw(a,x)	cpu_to_le16(x)
+# define ioswabl(a,x)		(x)
+# define __mem_ioswabl(a,x)	cpu_to_le32(x)
+# define ioswabq(a,x)		(x)
+# define __mem_ioswabq(a,x)	cpu_to_le32(x)
+
 #endif /* __ASM_MACH_IP32_MANGLE_PORT_H */
