Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2004 14:57:46 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:31419 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225841AbUFON5l>; Tue, 15 Jun 2004 14:57:41 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 09FD2478A3; Tue, 15 Jun 2004 15:57:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id E09F445837; Tue, 15 Jun 2004 15:57:29 +0200 (CEST)
Date: Tue, 15 Jun 2004 15:57:29 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Bradley D. LaRonde" <brad@laronde.org>, linux-mips@linux-mips.org
Subject: Re: inconsistent operand constraints in 'asm' in unaligned.h:66
 using gcc 3.4
In-Reply-To: <20040423131445.GA16274@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0406151552500.22664@jurand.ds.pg.gda.pl>
References: <06d601c428e2$3ba1dcc0$8d01010a@prefect>
 <Pine.LNX.4.55.0404231454120.14494@jurand.ds.pg.gda.pl>
 <20040423131445.GA16274@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 23 Apr 2004, Ralf Baechle wrote:

> >  Ralf, I can see 2.6 already does the right thing -- I suppose you won't
> > mind me backporting (copying?) it?
> 
> I certainly won't.  I think the 2.4 implementation was originally written
> necessary upto egcs 1.0 which were generating correct but very inefficient
> code for __attribute((packed)).

 I've applied the following changes, which update the files to the
corresponding one from 2.6, modulo trivial formatting fixes.

 We may consider renaming function arguments to something less
Alpha-specific in the future. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.26-20040531-mips-unaligned-1
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/include/asm-mips/unaligned.h linux-mips-2.4.26-20040531/include/asm-mips/unaligned.h
--- linux-mips-2.4.26-20040531.macro/include/asm-mips/unaligned.h	2002-08-06 02:58:21.000000000 +0000
+++ linux-mips-2.4.26-20040531/include/asm-mips/unaligned.h	2004-06-14 20:53:34.000000000 +0000
@@ -3,157 +3,142 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1996, 1999, 2000 by Ralf Baechle
- * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 1996, 1999, 2000, 2001, 2003 by Ralf Baechle
+ * Copyright (C) 1999, 2000, 2001 Silicon Graphics, Inc.
  */
 #ifndef _ASM_UNALIGNED_H
 #define _ASM_UNALIGNED_H
 
-extern void __get_unaligned_bad_length(void);
-extern void __put_unaligned_bad_length(void);
+#include <linux/types.h>
 
 /*
- * Load double unaligned.
+ * get_unaligned - get value from possibly mis-aligned location
+ * @ptr: pointer to value
+ *
+ * This macro should be used for accessing values larger in size than
+ * single bytes at locations that are expected to be improperly aligned,
+ * e.g. retrieving a u16 value from a location not u16-aligned.
  *
- * This could have been implemented in plain C like IA64 but egcs 1.0.3a
- * inflates this to 23 instructions ...
+ * Note that unaligned accesses can be very expensive on some architectures.
  */
-static inline unsigned long long __ldq_u(const unsigned long long * __addr)
-{
-	unsigned long long __res;
+#define get_unaligned(ptr) \
+	((__typeof__(*(ptr)))__get_unaligned((ptr), sizeof(*(ptr))))
 
-	__asm__("ulw\t%0, %1\n\t"
-		"ulw\t%D0, 4+%1"
-		: "=&r" (__res)
-		: "m" (*__addr));
-
-	return __res;
-}
+/*
+ * put_unaligned - put value to a possibly mis-aligned location
+ * @val: value to place
+ * @ptr: pointer to location
+ *
+ * This macro should be used for placing values larger in size than
+ * single bytes at locations that are expected to be improperly aligned,
+ * e.g. writing a u16 value to a location not u16-aligned.
+ *
+ * Note that unaligned accesses can be very expensive on some architectures.
+ */
+#define put_unaligned(x,ptr) \
+	__put_unaligned((__u64)(x), (ptr), sizeof(*(ptr)))
 
 /*
- * Load word unaligned.
+ * This is a silly but good way to make sure that
+ * the get/put functions are indeed always optimized,
+ * and that we use the correct sizes.
  */
-static inline unsigned long __ldl_u(const unsigned int * __addr)
-{
-	unsigned long __res;
+extern void bad_unaligned_access_length(void);
 
-	__asm__("ulw\t%0,%1"
-		: "=&r" (__res)
-		: "m" (*__addr));
+/*
+ * EGCS 1.1 knows about arbitrary unaligned loads.  Define some
+ * packed structures to talk about such things with.
+ */
 
-	return __res;
-}
+struct __una_u64 { __u64 x __attribute__((packed)); };
+struct __una_u32 { __u32 x __attribute__((packed)); };
+struct __una_u16 { __u16 x __attribute__((packed)); };
 
 /*
- * Load halfword unaligned.
+ * Elemental unaligned loads
  */
-static inline unsigned long __ldw_u(const unsigned short * __addr)
+
+static inline __u64 __uldq(const __u64 * r11)
 {
-	unsigned long __res;
+	const struct __una_u64 *ptr = (const struct __una_u64 *) r11;
+	return ptr->x;
+}
 
-	__asm__("ulh\t%0,%1"
-		: "=&r" (__res)
-		: "m" (*__addr));
+static inline __u32 __uldl(const __u32 * r11)
+{
+	const struct __una_u32 *ptr = (const struct __una_u32 *) r11;
+	return ptr->x;
+}
 
-	return __res;
+static inline __u16 __uldw(const __u16 * r11)
+{
+	const struct __una_u16 *ptr = (const struct __una_u16 *) r11;
+	return ptr->x;
 }
 
 /*
- * Store doubleword ununaligned.
+ * Elemental unaligned stores
  */
-static inline void __stq_u(unsigned long __val, unsigned long long * __addr)
+
+static inline void __ustq(__u64 r5, __u64 * r11)
 {
-	__asm__("usw\t%1, %0\n\t"
-		"usw\t%D1, 4+%0"
-		: "=m" (*__addr)
-		: "r" (__val));
+	struct __una_u64 *ptr = (struct __una_u64 *) r11;
+	ptr->x = r5;
 }
 
-/*
- * Store long ununaligned.
- */
-static inline void __stl_u(unsigned long __val, unsigned int * __addr)
+static inline void __ustl(__u32 r5, __u32 * r11)
 {
-	__asm__("usw\t%1, %0"
-		: "=m" (*__addr)
-		: "r" (__val));
+	struct __una_u32 *ptr = (struct __una_u32 *) r11;
+	ptr->x = r5;
 }
 
-/*
- * Store word ununaligned.
- */
-static inline void __stw_u(unsigned long __val, unsigned short * __addr)
+static inline void __ustw(__u16 r5, __u16 * r11)
 {
-	__asm__("ush\t%1, %0"
-		: "=m" (*__addr)
-		: "r" (__val));
+	struct __una_u16 *ptr = (struct __una_u16 *) r11;
+	ptr->x = r5;
 }
 
-/*
- * get_unaligned - get value from possibly mis-aligned location
- * @ptr: pointer to value
- *
- * This macro should be used for accessing values larger in size than
- * single bytes at locations that are expected to be improperly aligned,
- * e.g. retrieving a u16 value from a location not u16-aligned.
- *
- * Note that unaligned accesses can be very expensive on some architectures.
- */
-#define get_unaligned(ptr)						\
-({									\
-	__typeof__(*(ptr)) __val;					\
-									\
-	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		__val = *(const unsigned char *)ptr;			\
-		break;							\
-	case 2:								\
-		__val = __ldw_u((const unsigned short *)ptr);		\
-		break;							\
-	case 4:								\
-		__val = __ldl_u((const unsigned int *)ptr);		\
-		break;							\
-	case 8:								\
-		__val = __ldq_u((const unsigned long long *)ptr);	\
-		break;							\
-	default:							\
-		__get_unaligned_bad_length();				\
-		break;							\
-	}								\
-									\
-	__val;								\
-})
+static inline __u64 __get_unaligned(const void *ptr, size_t size)
+{
+	__u64 val;
 
-/*
- * put_unaligned - put value to a possibly mis-aligned location
- * @val: value to place
- * @ptr: pointer to location
- *
- * This macro should be used for placing values larger in size than
- * single bytes at locations that are expected to be improperly aligned,
- * e.g. writing a u16 value to a location not u16-aligned.
- *
- * Note that unaligned accesses can be very expensive on some architectures.
- */
-#define put_unaligned(val,ptr)						\
-do {									\
-	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		*(unsigned char *)(ptr) = (val);			\
-		break;							\
-	case 2:								\
-		__stw_u(val, (unsigned short *)(ptr));			\
-		break;							\
-	case 4:								\
-		__stl_u(val, (unsigned int *)(ptr));			\
-		break;							\
-	case 8:								\
-		__stq_u(val, (unsigned long long *)(ptr));		\
-		break;							\
-	default:							\
-		__put_unaligned_bad_length();				\
-		break;							\
-	}								\
-} while(0)
+	switch (size) {
+	case 1:
+		val = *(const __u8 *)ptr;
+		break;
+	case 2:
+		val = __uldw((const __u16 *)ptr);
+		break;
+	case 4:
+		val = __uldl((const __u32 *)ptr);
+		break;
+	case 8:
+		val = __uldq((const __u64 *)ptr);
+		break;
+	default:
+		bad_unaligned_access_length();
+	}
+	return val;
+}
+
+static inline void __put_unaligned(__u64 val, void *ptr, size_t size)
+{
+	switch (size) {
+	      case 1:
+		*(__u8 *)ptr = (val);
+	        break;
+	      case 2:
+		__ustw(val, (__u16 *)ptr);
+		break;
+	      case 4:
+		__ustl(val, (__u32 *)ptr);
+		break;
+	      case 8:
+		__ustq(val, (__u64 *)ptr);
+		break;
+	      default:
+	    	bad_unaligned_access_length();
+	}
+}
 
 #endif /* _ASM_UNALIGNED_H */
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/include/asm-mips64/unaligned.h linux-mips-2.4.26-20040531/include/asm-mips64/unaligned.h
--- linux-mips-2.4.26-20040531.macro/include/asm-mips64/unaligned.h	2002-10-02 17:22:56.000000000 +0000
+++ linux-mips-2.4.26-20040531/include/asm-mips64/unaligned.h	2004-06-14 20:53:34.000000000 +0000
@@ -3,152 +3,142 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1996, 1999, 2000, 2001 by Ralf Baechle
+ * Copyright (C) 1996, 1999, 2000, 2001, 2003 by Ralf Baechle
  * Copyright (C) 1999, 2000, 2001 Silicon Graphics, Inc.
  */
 #ifndef _ASM_UNALIGNED_H
 #define _ASM_UNALIGNED_H
 
-extern void __get_unaligned_bad_length(void);
-extern void __put_unaligned_bad_length(void);
+#include <linux/types.h>
 
 /*
- * Load quad unaligned.
+ * get_unaligned - get value from possibly mis-aligned location
+ * @ptr: pointer to value
+ *
+ * This macro should be used for accessing values larger in size than
+ * single bytes at locations that are expected to be improperly aligned,
+ * e.g. retrieving a u16 value from a location not u16-aligned.
+ *
+ * Note that unaligned accesses can be very expensive on some architectures.
  */
-static inline unsigned long __ldq_u(const unsigned long * __addr)
-{
-	unsigned long __res;
-
-	__asm__("uld\t%0,%1"
-		: "=&r" (__res)
-		: "m" (*__addr));
+#define get_unaligned(ptr) \
+	((__typeof__(*(ptr)))__get_unaligned((ptr), sizeof(*(ptr))))
 
-	return __res;
-}
+/*
+ * put_unaligned - put value to a possibly mis-aligned location
+ * @val: value to place
+ * @ptr: pointer to location
+ *
+ * This macro should be used for placing values larger in size than
+ * single bytes at locations that are expected to be improperly aligned,
+ * e.g. writing a u16 value to a location not u16-aligned.
+ *
+ * Note that unaligned accesses can be very expensive on some architectures.
+ */
+#define put_unaligned(x,ptr) \
+	__put_unaligned((__u64)(x), (ptr), sizeof(*(ptr)))
 
 /*
- * Load long unaligned.
+ * This is a silly but good way to make sure that
+ * the get/put functions are indeed always optimized,
+ * and that we use the correct sizes.
  */
-static inline unsigned long __ldl_u(const unsigned int * __addr)
-{
-	unsigned long __res;
+extern void bad_unaligned_access_length(void);
 
-	__asm__("ulw\t%0,%1"
-		: "=&r" (__res)
-		: "m" (*__addr));
+/*
+ * EGCS 1.1 knows about arbitrary unaligned loads.  Define some
+ * packed structures to talk about such things with.
+ */
 
-	return __res;
-}
+struct __una_u64 { __u64 x __attribute__((packed)); };
+struct __una_u32 { __u32 x __attribute__((packed)); };
+struct __una_u16 { __u16 x __attribute__((packed)); };
 
 /*
- * Load word unaligned.
+ * Elemental unaligned loads
  */
-static inline unsigned long __ldw_u(const unsigned short * __addr)
+
+static inline __u64 __uldq(const __u64 * r11)
 {
-	unsigned long __res;
+	const struct __una_u64 *ptr = (const struct __una_u64 *) r11;
+	return ptr->x;
+}
 
-	__asm__("ulh\t%0,%1"
-		: "=&r" (__res)
-		: "m" (*__addr));
+static inline __u32 __uldl(const __u32 * r11)
+{
+	const struct __una_u32 *ptr = (const struct __una_u32 *) r11;
+	return ptr->x;
+}
 
-	return __res;
+static inline __u16 __uldw(const __u16 * r11)
+{
+	const struct __una_u16 *ptr = (const struct __una_u16 *) r11;
+	return ptr->x;
 }
 
 /*
- * Store quad unaligned.
+ * Elemental unaligned stores
  */
-static inline void __stq_u(unsigned long __val, unsigned long * __addr)
+
+static inline void __ustq(__u64 r5, __u64 * r11)
 {
-	__asm__("usd\t%1, %0"
-		: "=m" (*__addr)
-		: "r" (__val));
+	struct __una_u64 *ptr = (struct __una_u64 *) r11;
+	ptr->x = r5;
 }
 
-/*
- * Store long unaligned.
- */
-static inline void __stl_u(unsigned long __val, unsigned int * __addr)
+static inline void __ustl(__u32 r5, __u32 * r11)
 {
-	__asm__("usw\t%1, %0"
-		: "=m" (*__addr)
-		: "r" (__val));
+	struct __una_u32 *ptr = (struct __una_u32 *) r11;
+	ptr->x = r5;
 }
 
-/*
- * Store word unaligned.
- */
-static inline void __stw_u(unsigned long __val, unsigned short * __addr)
+static inline void __ustw(__u16 r5, __u16 * r11)
 {
-	__asm__("ush\t%1, %0"
-		: "=m" (*__addr)
-		: "r" (__val));
+	struct __una_u16 *ptr = (struct __una_u16 *) r11;
+	ptr->x = r5;
 }
 
-/*
- * get_unaligned - get value from possibly mis-aligned location
- * @ptr: pointer to value
- *
- * This macro should be used for accessing values larger in size than
- * single bytes at locations that are expected to be improperly aligned,
- * e.g. retrieving a u16 value from a location not u16-aligned.
- *
- * Note that unaligned accesses can be very expensive on some architectures.
- */
-#define get_unaligned(ptr)						\
-({									\
-	__typeof__(*(ptr)) __val;					\
-									\
-	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		__val = *(const unsigned char *)(ptr);			\
-		break;							\
-	case 2:								\
-		__val = __ldw_u((const unsigned short *)(ptr));		\
-		break;							\
-	case 4:								\
-		__val = __ldl_u((const unsigned int *)(ptr));		\
-		break;							\
-	case 8:								\
-		__val = __ldq_u((const unsigned long *)(ptr));		\
-		break;							\
-	default:							\
-		__get_unaligned_bad_length();				\
-		break;							\
-	}								\
-									\
-	__val;								\
-})
+static inline __u64 __get_unaligned(const void *ptr, size_t size)
+{
+	__u64 val;
 
-/*
- * put_unaligned - put value to a possibly mis-aligned location
- * @val: value to place
- * @ptr: pointer to location
- *
- * This macro should be used for placing values larger in size than
- * single bytes at locations that are expected to be improperly aligned,
- * e.g. writing a u16 value to a location not u16-aligned.
- *
- * Note that unaligned accesses can be very expensive on some architectures.
- */
-#define put_unaligned(val,ptr)						\
-do {									\
-	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		*(unsigned char *)(ptr) = (val);			\
-		break;							\
-	case 2:								\
-		__stw_u((val), (unsigned short *)(ptr));		\
-		break;							\
-	case 4:								\
-		__stl_u((val), (unsigned int *)(ptr));			\
-		break;							\
-	case 8:								\
-		__stq_u((val), (unsigned long long *)(ptr));		\
-		break;							\
-	default:							\
-		__put_unaligned_bad_length();				\
-		break;							\
-	}								\
-} while(0)
+	switch (size) {
+	case 1:
+		val = *(const __u8 *)ptr;
+		break;
+	case 2:
+		val = __uldw((const __u16 *)ptr);
+		break;
+	case 4:
+		val = __uldl((const __u32 *)ptr);
+		break;
+	case 8:
+		val = __uldq((const __u64 *)ptr);
+		break;
+	default:
+		bad_unaligned_access_length();
+	}
+	return val;
+}
+
+static inline void __put_unaligned(__u64 val, void *ptr, size_t size)
+{
+	switch (size) {
+	      case 1:
+		*(__u8 *)ptr = (val);
+	        break;
+	      case 2:
+		__ustw(val, (__u16 *)ptr);
+		break;
+	      case 4:
+		__ustl(val, (__u32 *)ptr);
+		break;
+	      case 8:
+		__ustq(val, (__u64 *)ptr);
+		break;
+	      default:
+	    	bad_unaligned_access_length();
+	}
+}
 
 #endif /* _ASM_UNALIGNED_H */
