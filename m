Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 16:50:44 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:13012 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225341AbVAUQug>; Fri, 21 Jan 2005 16:50:36 +0000
Received: from localhost (p5203-ipad202funabasi.chiba.ocn.ne.jp [222.146.76.203])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0D9A88411; Sat, 22 Jan 2005 01:50:30 +0900 (JST)
Date:	Sat, 22 Jan 2005 01:50:40 +0900 (JST)
Message-Id: <20050122.015040.108744446.anemo@mba.ocn.ne.jp>
To:	macro@mips.com
Cc:	rsandifo@redhat.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org, macro@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.61.0501141956520.21179@perivale.mips.com>
	<20050107.004521.74752947.anemo@mba.ocn.ne.jp>
References: <Pine.LNX.4.61.0501131824350.21179@perivale.mips.com>
	<87k6qh2e6j.fsf@redhat.com>
	<Pine.LNX.4.61.0501141956520.21179@perivale.mips.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 07 Jan 2005 00:45:21 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> Thanks for your good job.  I have a few comments/requests.

Revised.

1. How about using 'const void *' for outs*()/reads*() ?  This will
   remove some compiler warnings too.  Also, it seems 'volatile' for
   memory buffer are unneeded.

2. In *in*()/*out*(), it would be better to call __swizzle_addr*()
   AFTER adding mips_io_port_base.  This unifies the meaning of the
   argument of __swizzle_addr*() (always virtual address).  Then,
   mach-specific __swizzle_addr*() can to every evil thing based on
   the argument.

3. How about Moving generic ioswab*() to mangle-port.h ?  Also how
   about passing virtual address to *ioswab*() ?  Then we can provide
   mach-specific ioswab*() and can do every evil thing based on its
   argument.  It is usefull on machines which have regions with
   different endian conversion scheme.

Here is a patch for CVS HEAD.


diff -urP linux-mips/include/asm-mips/io.h linux/include/asm-mips/io.h
--- linux-mips/include/asm-mips/io.h	2005-01-21 00:58:52.000000000 +0900
+++ linux/include/asm-mips/io.h	2005-01-22 01:34:49.000000000 +0900
@@ -39,46 +39,18 @@
  * hardware.  An example use would be for flash memory that's used for
  * execute in place.
  */
-# define __raw_ioswabb(x)	(x)
-# define __raw_ioswabw(x)	(x)
-# define __raw_ioswabl(x)	(x)
-# define __raw_ioswabq(x)	(x)
-
-/*
- * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardware;
- * less sane hardware forces software to fiddle with this...
- */
-#if defined(CONFIG_SWAP_IO_SPACE)
-
-# define ioswabb(x)		(x)
-# ifdef CONFIG_SGI_IP22
-/*
- * IP22 seems braindead enough to swap 16bits values in hardware, but
- * not 32bits.  Go figure... Can't tell without documentation.
- */
-#  define ioswabw(x)		(x)
-# else
-#  define ioswabw(x)		le16_to_cpu(x)
-# endif
-# define ioswabl(x)		le32_to_cpu(x)
-# define ioswabq(x)		le64_to_cpu(x)
-
-#else
-
-# define ioswabb(x)		(x)
-# define ioswabw(x)		(x)
-# define ioswabl(x)		(x)
-# define ioswabq(x)		(x)
-
-#endif
+# define __raw_ioswabb(a,x)	(x)
+# define __raw_ioswabw(a,x)	(x)
+# define __raw_ioswabl(a,x)	(x)
+# define __raw_ioswabq(a,x)	(x)
 
 /*
  * Native bus accesses never swapped.
  */
-#define bus_ioswabb(x)		(x)
-#define bus_ioswabw(x)		(x)
-#define bus_ioswabl(x)		(x)
-#define bus_ioswabq(x)		(x)
+#define bus_ioswabb(a,x)		(x)
+#define bus_ioswabw(a,x)		(x)
+#define bus_ioswabl(a,x)		(x)
+#define bus_ioswabq(a,x)		(x)
 
 #define __bus_ioswabq		bus_ioswabq
 
@@ -281,7 +253,7 @@
 									\
 	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
 									\
-	__val = pfx##ioswab##bwlq(val);					\
+	__val = pfx##ioswab##bwlq(__mem, val);				\
 									\
 	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long))	\
 		*__mem = __val;						\
@@ -334,7 +306,7 @@
 		BUG();							\
 	}								\
 									\
-	return pfx##ioswab##bwlq(__val);				\
+	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
 #define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p, slow)			\
@@ -344,10 +316,10 @@
 	volatile type *__addr;						\
 	type __val;							\
 									\
-	port = __swizzle_addr_##bwlq(port);				\
 	__addr = (void *)(mips_io_port_base + port);			\
+	__addr = (void *)__swizzle_addr_##bwlq((unsigned long)__addr);	\
 									\
-	__val = pfx##ioswab##bwlq(val);					\
+	__val = pfx##ioswab##bwlq(__addr, val);				\
 									\
 	if (sizeof(type) != sizeof(u64)) {				\
 		*__addr = __val;					\
@@ -361,8 +333,8 @@
 	volatile type *__addr;						\
 	type __val;							\
 									\
-	port = __swizzle_addr_##bwlq(port);				\
 	__addr = (void *)(mips_io_port_base + port);			\
+	__addr = (void *)__swizzle_addr_##bwlq((unsigned long)__addr);	\
 									\
 	if (sizeof(type) != sizeof(u64)) {				\
 		__val = *__addr;					\
@@ -372,7 +344,7 @@
 		BUILD_BUG();						\
 	}								\
 									\
-	return pfx##ioswab##bwlq(__val);				\
+	return pfx##ioswab##bwlq(__addr, __val);			\
 }
 
 #define __BUILD_MEMORY_PFX(bus, bwlq, type)				\
@@ -416,10 +388,10 @@
 
 #define __BUILD_MEMORY_STRING(bwlq, type)				\
 									\
-static inline void writes##bwlq(volatile void __iomem *mem, void *addr,	\
+static inline void writes##bwlq(volatile void __iomem *mem, const void *addr, \
 				unsigned int count)			\
 {									\
-	volatile type *__addr = addr;					\
+	const type *__addr = addr;					\
 									\
 	while (count--) {						\
 		__raw_write##bwlq(*__addr, mem);			\
@@ -430,7 +402,7 @@
 static inline void reads##bwlq(volatile void __iomem *mem, void *addr,	\
 			       unsigned int count)			\
 {									\
-	volatile type *__addr = addr;					\
+	type *__addr = addr;						\
 									\
 	while (count--) {						\
 		*__addr = __raw_read##bwlq(mem);			\
@@ -440,10 +412,10 @@
 
 #define __BUILD_IOPORT_STRING(bwlq, type)				\
 									\
-static inline void outs##bwlq(unsigned long port, void *addr,		\
+static inline void outs##bwlq(unsigned long port, const void *addr,	\
 			      unsigned int count)			\
 {									\
-	volatile type *__addr = addr;					\
+	const type *__addr = addr;					\
 									\
 	while (count--) {						\
 		__raw_out##bwlq(*__addr, port);				\
@@ -454,7 +426,7 @@
 static inline void ins##bwlq(unsigned long port, void *addr,		\
 			     unsigned int count)			\
 {									\
-	volatile type *__addr = addr;					\
+	type *__addr = addr;						\
 									\
 	while (count--) {						\
 		*__addr = __raw_in##bwlq(port);				\
diff -urP linux-mips/include/asm-mips/mach-generic/mangle-port.h linux/include/asm-mips/mach-generic/mangle-port.h
--- linux-mips/include/asm-mips/mach-generic/mangle-port.h	2004-08-21 00:34:13.000000000 +0900
+++ linux/include/asm-mips/mach-generic/mangle-port.h	2005-01-22 01:35:03.000000000 +0900
@@ -13,4 +13,24 @@
 #define __swizzle_addr_l(port)	(port)
 #define __swizzle_addr_q(port)	(port)
 
+/*
+ * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardware;
+ * less sane hardware forces software to fiddle with this...
+ */
+#if defined(CONFIG_SWAP_IO_SPACE)
+
+# define ioswabb(a,x)		(x)
+# define ioswabw(a,x)		le16_to_cpu(x)
+# define ioswabl(a,x)		le32_to_cpu(x)
+# define ioswabq(a,x)		le64_to_cpu(x)
+
+#else
+
+# define ioswabb(a,x)		(x)
+# define ioswabw(a,x)		(x)
+# define ioswabl(a,x)		(x)
+# define ioswabq(a,x)		(x)
+
+#endif
+
 #endif /* __ASM_MACH_GENERIC_MANGLE_PORT_H */
diff -urP linux-mips/include/asm-mips/mach-ip22/mangle-port.h linux/include/asm-mips/mach-ip22/mangle-port.h
--- linux-mips/include/asm-mips/mach-ip22/mangle-port.h	1970-01-01 09:00:00.000000000 +0900
+++ linux/include/asm-mips/mach-ip22/mangle-port.h	2005-01-22 01:40:59.000000000 +0900
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 2004 Ralf Baechle
+ */
+#ifndef __ASM_MACH_IP22_MANGLE_PORT_H
+#define __ASM_MACH_IP22_MANGLE_PORT_H
+
+#define __swizzle_addr_b(port)	(port)
+#define __swizzle_addr_w(port)	(port)
+#define __swizzle_addr_l(port)	(port)
+#define __swizzle_addr_q(port)	(port)
+
+/*
+ * IP22 seems braindead enough to swap 16bits values in hardware, but
+ * not 32bits.  Go figure... Can't tell without documentation.
+ */
+#define ioswabb(a,x)		(x)
+#define ioswabw(a,x)		(x)
+#define ioswabl(a,x)		le32_to_cpu(x)
+#define ioswabq(a,x)		le64_to_cpu(x)
+
+#endif /* __ASM_MACH_IP22_MANGLE_PORT_H */
diff -urP linux-mips/include/asm-mips/mach-ip27/mangle-port.h linux/include/asm-mips/mach-ip27/mangle-port.h
--- linux-mips/include/asm-mips/mach-ip27/mangle-port.h	2004-08-21 00:34:13.000000000 +0900
+++ linux/include/asm-mips/mach-ip27/mangle-port.h	2005-01-22 01:35:17.000000000 +0900
@@ -13,4 +13,9 @@
 #define __swizzle_addr_l(port)	(port)
 #define __swizzle_addr_q(port)	(port)
 
+#define ioswabb(a,x)		(x)
+#define ioswabw(a,x)		(x)
+#define ioswabl(a,x)		(x)
+#define ioswabq(a,x)		(x)
+
 #endif /* __ASM_MACH_IP27_MANGLE_PORT_H */
diff -urP linux-mips/include/asm-mips/mach-ip32/mangle-port.h linux/include/asm-mips/mach-ip32/mangle-port.h
--- linux-mips/include/asm-mips/mach-ip32/mangle-port.h	2004-10-27 23:30:28.000000000 +0900
+++ linux/include/asm-mips/mach-ip32/mangle-port.h	2005-01-22 01:35:23.000000000 +0900
@@ -14,4 +14,9 @@
 #define __swizzle_addr_l(port)	(port)
 #define __swizzle_addr_q(port)	(port)
 
+#define ioswabb(a,x)		(x)
+#define ioswabw(a,x)		(x)
+#define ioswabl(a,x)		(x)
+#define ioswabq(a,x)		(x)
+
 #endif /* __ASM_MACH_IP32_MANGLE_PORT_H */


---
Atsushi Nemoto
