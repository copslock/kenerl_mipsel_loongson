Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jun 2003 19:04:35 +0100 (BST)
Received: from janus.foobazco.org ([IPv6:::ffff:198.144.194.226]:14210 "EHLO
	mail.foobazco.org") by linux-mips.org with ESMTP
	id <S8225202AbTFOSEc>; Sun, 15 Jun 2003 19:04:32 +0100
Received: from fallout.sjc.foobazco.org (fallout.sjc.foobazco.org [192.168.21.20])
	by mail.foobazco.org (Postfix) with ESMTP id 08264FABB
	for <linux-mips@linux-mips.org>; Sun, 15 Jun 2003 11:04:26 -0700 (PDT)
Received: by fallout.sjc.foobazco.org (Postfix, from userid 1014)
	id B91E624; Sun, 15 Jun 2003 11:04:26 -0700 (PDT)
Date: Sun, 15 Jun 2003 11:04:26 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: linux-mips@linux-mips.org
Subject: PATCH: 64-bit IO for 32bit kernels
Message-ID: <20030615180426.GA21094@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <wesolows@foobazco.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wesolows@foobazco.org
Precedence: bulk
X-list: linux-mips

This makes 64-bit I/O functions like sibyte uses generic, because IP32
at least needs them.  I'm told it compiles.

Comments?

diff -urN -x CVS 2.5-mips/include/asm-mips/io64.h 2.5-mips-io64/include/asm-mips/io64.h
--- 2.5-mips/include/asm-mips/io64.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.5-mips-io64/include/asm-mips/io64.h	2003-06-15 10:22:37.423123555 -0700
@@ -0,0 +1,99 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000, 2001 Broadcom Corporation
+ * Copyright (C) 2002 Ralf Baechle
+ * Copyright (C) 2003 Keith M Wesolowski
+ */
+
+#ifndef __ASM_IO64_H
+#define __ASM_IO64_H
+
+#include <linux/types.h>
+
+/* Generic 64-bit I/O register reads and writes.  This does no byte-swapping
+ * as it makes little sense and no platform that needs this is insane enough
+ * to require it.
+ */
+
+#ifndef __ASSEMBLY__
+#if _MIPS_SZLONG >= 64
+static inline u64 __in64(unsigned long addr)
+{
+	return *(volatile u64 *)addr;
+}
+
+static inline void __out64(u64 val, unsigned long addr)
+{
+	*(volatile u64 *)addr = val;
+}
+
+#define in64(a)		__in64(a)
+#define out64(v,a)	__out64(v,a)
+
+#else /* _MIPS_SZLONG < 64 */
+
+#include <asm/system.h>
+
+static inline u64 __in64(unsigned long addr)
+{
+	u64 res;
+
+	asm volatile (
+		"	.set	mips3				\n"
+		"	ld	%L0, (%1)	# __in64	\n"
+		"	dsra	%M0, %L0, 32			\n"
+		"	sll	%L0, 0				\n"
+		"	.set	mips0				\n"
+		: "=r" (res)
+		: "r" (addr)
+	);
+
+	return res;
+}
+
+static inline u64 in64(unsigned long addr)
+{
+	unsigned long flags;
+	u64 res;
+
+	local_irq_save(flags);
+	res = __in64(addr);
+	local_irq_restore(flags);
+
+	return res;
+}
+
+static inline void __out64(u64 val, unsigned long addr)
+{
+	u64 tmp;
+
+	asm volatile (
+		"	.set	mips3				\n"
+		"	dsll	%L0, 32		# __out64	\n"
+		"	dsll	%M0, 32				\n"
+		"	dsrl	%L0, 32				\n"
+		"	or	%L0, %M0			\n"
+		"	sd	%L0, (%2)			\n"
+		"	.set	mips0				\n"
+		: "=&r" (tmp)
+		: "0" (val), "r" (addr)
+		: "memory"
+	);
+}
+
+static inline void out64(u64 val, unsigned long addr)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__out64(val, addr);
+	local_irq_restore(flags);
+}
+#endif /* _MIPS_SZLONG */
+#endif /* !__ASSEMBLY__ */
+
+
+#endif /* __ASM_IO64_H */
diff -urN -x CVS 2.5-mips/include/asm-mips/sibyte/64bit.h 2.5-mips-io64/include/asm-mips/sibyte/64bit.h
--- 2.5-mips/include/asm-mips/sibyte/64bit.h	2003-06-15 10:01:41.819344267 -0700
+++ 2.5-mips-io64/include/asm-mips/sibyte/64bit.h	2003-06-15 09:50:28.740647757 -0700
@@ -20,94 +20,9 @@
 #ifndef __ASM_SIBYTE_64BIT_H
 #define __ASM_SIBYTE_64BIT_H
 
-#include <linux/config.h>
+#include <asm/io64.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_MIPS32
-
-#include <asm/system.h>
-
-/*
- * This is annoying...we can't actually write the 64-bit IO register properly
- * without having access to 64-bit registers...  which doesn't work by default
- * in o32 format...grrr...
- */
-static inline void __out64(u64 val, unsigned long addr)
-{
-	u64 tmp;
-
-	__asm__ __volatile__ (
-		"	.set	mips3				\n"
-		"	dsll32	%L0, %L0, 0	# __out64	\n"
-		"	dsrl32	%L0, %L0, 0			\n"
-		"	dsll32	%M0, %M0, 0			\n"
-		"	or	%L0, %L0, %M0			\n"
-		"	sd	%L0, (%2)			\n"
-		"	.set	mips0				\n"
-		: "=r" (tmp)
-		: "0" (val), "r" (addr));
-}
-
-static inline void out64(u64 val, unsigned long addr)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__out64(val, addr);
-	local_irq_restore(flags);
-}
-
-static inline u64 __in64(unsigned long addr)
-{
-	u64 res;
-
-	__asm__ __volatile__ (
-		"	.set	mips3		# __in64	\n"
-		"	ld	%L0, (%1)			\n"
-		"	dsra32	%M0, %L0, 0			\n"
-		"	sll	%L0, %L0, 0			\n"
-		"	.set	mips0				\n"
-		: "=r" (res)
-		: "r" (addr));
-
-	return res;
-}
-
-static inline u64 in64(unsigned long addr)
-{
-	unsigned long flags;
-	u64 res;
-
-	local_irq_save(flags);
-	res = __in64(addr);
-	local_irq_restore(flags);
-
-	return res;
-}
-
-#endif /* CONFIG_MIPS32 */
-
-#ifdef CONFIG_MIPS64
-
-/*
- * These are provided so as to be able to use common
- * driver code for the 32-bit and 64-bit trees
- */
-extern inline void out64(u64 val, unsigned long addr)
-{
-	*(volatile unsigned long *)addr = val;
-}
-
-extern inline u64 in64(unsigned long addr)
-{
-	return *(volatile unsigned long *)addr;
-}
-
-#define __in64(a)	in64(a)
-#define __out64(v,a)	out64(v,a)
-
-#endif /* CONFIG_MIPS64 */
-
 /*
  * Avoid interrupt mucking, just adjust the address for 4-byte access.
  * Assume the addresses are 8-byte aligned.
diff -urN -x CVS 2.5-mips/include/asm-mips64/io64.h 2.5-mips-io64/include/asm-mips64/io64.h
--- 2.5-mips/include/asm-mips64/io64.h	1969-12-31 16:00:00.000000000 -0800
+++ 2.5-mips-io64/include/asm-mips64/io64.h	2003-06-15 10:22:48.300649235 -0700
@@ -0,0 +1,99 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000, 2001 Broadcom Corporation
+ * Copyright (C) 2002 Ralf Baechle
+ * Copyright (C) 2003 Keith M Wesolowski
+ */
+
+#ifndef __ASM_IO64_H
+#define __ASM_IO64_H
+
+#include <linux/types.h>
+
+/* Generic 64-bit I/O register reads and writes.  This does no byte-swapping
+ * as it makes little sense and no platform that needs this is insane enough
+ * to require it.
+ */
+
+#ifndef __ASSEMBLY__
+#if _MIPS_SZLONG >= 64
+static inline u64 __in64(unsigned long addr)
+{
+	return *(volatile u64 *)addr;
+}
+
+static inline void __out64(u64 val, unsigned long addr)
+{
+	*(volatile u64 *)addr = val;
+}
+
+#define in64(a)		__in64(a)
+#define out64(v,a)	__out64(v,a)
+
+#else /* _MIPS_SZLONG < 64 */
+
+#include <asm/system.h>
+
+static inline u64 __in64(unsigned long addr)
+{
+	u64 res;
+
+	asm volatile (
+		"	.set	mips3				\n"
+		"	ld	%L0, (%1)	# __in64	\n"
+		"	dsra	%M0, %L0, 32			\n"
+		"	sll	%L0, 0				\n"
+		"	.set	mips0				\n"
+		: "=r" (res)
+		: "r" (addr)
+	);
+
+	return res;
+}
+
+static inline u64 in64(unsigned long addr)
+{
+	unsigned long flags;
+	u64 res;
+
+	local_irq_save(flags);
+	res = __in64(addr);
+	local_irq_restore(flags);
+
+	return res;
+}
+
+static inline void __out64(u64 val, unsigned long addr)
+{
+	u64 tmp;
+
+	asm volatile (
+		"	.set	mips3				\n"
+		"	dsll	%L0, 32		# __out64	\n"
+		"	dsll	%M0, 32				\n"
+		"	dsrl	%L0, 32				\n"
+		"	or	%L0, %M0			\n"
+		"	sd	%L0, (%2)			\n"
+		"	.set	mips0				\n"
+		: "=&r" (tmp)
+		: "0" (val), "r" (addr)
+		: "memory"
+	);
+}
+
+static inline void out64(u64 val, unsigned long addr)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__out64(val, addr);
+	local_irq_restore(flags);
+}
+#endif /* _MIPS_SZLONG */
+#endif /* !__ASSEMBLY__ */
+
+
+#endif /* __ASM_IO64_H */
diff -urN -x CVS 2.5-mips/include/asm-mips64/ip32/crime.h 2.5-mips-io64/include/asm-mips64/ip32/crime.h
--- 2.5-mips/include/asm-mips64/ip32/crime.h	2003-06-15 10:07:13.904324165 -0700
+++ 2.5-mips-io64/include/asm-mips64/ip32/crime.h	2003-06-15 10:05:50.892572980 -0700
@@ -11,6 +11,7 @@
 #ifndef __ASM_CRIME_H__
 #define __ASM_CRIME_H__
 
+#include <asm/io64.h>
 #include <asm/addrspace.h>
 
 /*
@@ -23,12 +24,8 @@
 #endif
 
 #ifndef __ASSEMBLY__
-static inline u64 crime_read_64 (unsigned long __offset) {
-        return *((volatile u64 *) (CRIME_BASE + __offset));
-}
-static inline void crime_write_64 (unsigned long __offset, u64 __val) {
-        *((volatile u64 *) (CRIME_BASE + __offset)) = __val;
-}
+#define crime_read_64(__offset)		__in64(CRIME_BASE+(__offset))
+#define crime_write_64(__offset,__val)	__out64(__val,CRIME_BASE+(__offset))
 #endif
 
 #undef BIT
diff -urN -x CVS 2.5-mips/include/asm-mips64/ip32/mace.h 2.5-mips-io64/include/asm-mips64/ip32/mace.h
--- 2.5-mips/include/asm-mips64/ip32/mace.h	2003-06-15 10:07:14.097297946 -0700
+++ 2.5-mips-io64/include/asm-mips64/ip32/mace.h	2003-06-15 10:57:56.605873141 -0700
@@ -11,6 +11,7 @@
 #ifndef __ASM_MACE_H__
 #define __ASM_MACE_H__
 
+#include <asm/io64.h>
 #include <asm/addrspace.h>
 
 /*
@@ -220,7 +221,7 @@
 
 static inline u64 mace_read_64 (unsigned long __offset)
 {
-	return *((volatile u64 *) (MACE_BASE + __offset));
+	return __in64 (MACE_BASE + __offset);
 }
 
 static inline void mace_write_8 (unsigned long __offset, u8 __val)
@@ -240,7 +241,7 @@
 
 static inline void mace_write_64 (unsigned long __offset, u64 __val)
 {
-	*((volatile u64 *) (MACE_BASE + __offset)) = __val;
+	__out64 (__val, MACE_BASE + __offset);
 }
 
 /* Call it whenever device needs to read data from main memory coherently */
diff -urN -x CVS 2.5-mips/include/asm-mips64/sibyte/64bit.h 2.5-mips-io64/include/asm-mips64/sibyte/64bit.h
--- 2.5-mips/include/asm-mips64/sibyte/64bit.h	2003-02-19 13:07:27.000000000 -0800
+++ 2.5-mips-io64/include/asm-mips64/sibyte/64bit.h	2003-06-15 10:00:59.031149508 -0700
@@ -20,94 +20,9 @@
 #ifndef __ASM_SIBYTE_64BIT_H
 #define __ASM_SIBYTE_64BIT_H
 
-#include <linux/config.h>
+#include <asm/io64.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_MIPS32
-
-#include <asm/system.h>
-
-/*
- * This is annoying...we can't actually write the 64-bit IO register properly
- * without having access to 64-bit registers...  which doesn't work by default
- * in o32 format...grrr...
- */
-static inline void __out64(u64 val, unsigned long addr)
-{
-	u64 tmp;
-
-	__asm__ __volatile__ (
-		"	.set	mips3				\n"
-		"	dsll32	%L0, %L0, 0	# __out64	\n"
-		"	dsrl32	%L0, %L0, 0			\n"
-		"	dsll32	%M0, %M0, 0			\n"
-		"	or	%L0, %L0, %M0			\n"
-		"	sd	%L0, (%2)			\n"
-		"	.set	mips0				\n"
-		: "=r" (tmp)
-		: "0" (val), "r" (addr));
-}
-
-static inline void out64(u64 val, unsigned long addr)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__out64(val, addr);
-	local_irq_restore(flags);
-}
-
-static inline u64 __in64(unsigned long addr)
-{
-	u64 res;
-
-	__asm__ __volatile__ (
-		"	.set	mips3		# __in64	\n"
-		"	ld	%L0, (%1)			\n"
-		"	dsra32	%M0, %L0, 0			\n"
-		"	sll	%L0, %L0, 0			\n"
-		"	.set	mips0				\n"
-		: "=r" (res)
-		: "r" (addr));
-
-	return res;
-}
-
-static inline u64 in64(unsigned long addr)
-{
-	unsigned long flags;
-	u64 res;
-
-	local_irq_save(flags);
-	res = __in64(addr);
-	local_irq_restore(flags);
-
-	return res;
-}
-
-#endif /* CONFIG_MIPS32 */
-
-#ifdef CONFIG_MIPS64
-
-/*
- * These are provided so as to be able to use common
- * driver code for the 32-bit and 64-bit trees
- */
-extern inline void out64(u64 val, unsigned long addr)
-{
-	*(volatile unsigned long *)addr = val;
-}
-
-extern inline u64 in64(unsigned long addr)
-{
-	return *(volatile unsigned long *)addr;
-}
-
-#define __in64(a)	in64(a)
-#define __out64(v,a)	out64(v,a)
-
-#endif /* CONFIG_MIPS64 */
-
 /*
  * Avoid interrupt mucking, just adjust the address for 4-byte access.
  * Assume the addresses are 8-byte aligned.


-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
