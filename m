Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2005 22:18:51 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:4594 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225260AbVAMWSn>; Thu, 13 Jan 2005 22:18:43 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 1C5711881B; Thu, 13 Jan 2005 14:18:41 -0800 (PST)
Message-ID: <41E6F3C0.6050706@mvista.com>
Date: Thu, 13 Jan 2005 14:18:40 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] I/O helpers rework
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
In-Reply-To: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello Maciej,

Couple of things:

1. Have you tried this patch on 32-bit SMP Sibyte with 
CONFIG_SIBYTE_DMA_PAGEOPS turned on. I tried it out with 2.6.11-rc1 and 
the kernel crashes on bootup when doing a clear_page. The following code 
in arch/mips/mm/pg-sb1.c:

while (!(bus_readq((void *)(IOADDR(A_DM_REGISTER(cpu, 
R_DM_DSCR_BASE_DEBUG)) &
M_DM_DSCR_BASE_INTERRUPT))))

in clear_page seems to be causing a problem. I need to investigate more

2. Secondly, the Sibyte MAC driver drivers/net/sb1250-mac.c still uses 
__raw_readq and __raw_writeq calls. Those will also need to be converted 
to bus_* calls

Thanks
Manish Lachwani

Maciej W. Rozycki wrote:

>Hello,
>
> While trying using an IDE interface driver with big-endian systems, I've 
>noticed some of our port/mm I/O accessory functions/macros get endianness 
>incorrectly.  In particular a lot of drivers expect single I/O accesses to 
>return correct numerical value of data as seen by the CPU while string I/O 
>accesses to preserve byte ordering in memory.
>
> As the whole file seemed a bit messy to me I decided to rewrite these 
>functions/macros completely.  To ease long-term maintenance I created 
>common templates for all classes of accesses which expand to appropriate 
>code for different transfer unit width.  I made all operations to be 
>expressed as inline functions to catch dangerous/incorrect uses.  The 
>result are the following function classes:
>
>1. in*()/out*()/read*()/write*() perform single operations on data using 
>   little-endian ordering.
>
>2. __raw_in*()/__raw_out*()/__raw_read*()/__raw_write*() perform single 
>   operations on data using memory ordering.
>
>3. bus_read*()/bus_write*() perform single on data using CPU bus ordering 
>   (that is as it appears at the bus, regardless of any address or lane 
>   swappers that may modify it on the way between the CPU and a device).
>
>4. __bus_readq()/__bus_writeq() are hacks for 64-bit accesses avoiding 
>   interrupt masking when used with a 32-bit kernel and are otherwise the 
>   same as bus_readq()/bus_writeq().
>
>5. ins*()/outs*()/reads*()/writes*() perform string operations on data 
>   using memory ordering yielding the same result as a corresponding DMA 
>   transfer would.
>
>The naming of 1., 2. and perhaps 5. above is a bit unfortunate, but that's 
>what much code elsewhere expects.  These variants assume a ISA/EISA/PCI 
>bus, little-endian.  They perform minimum of swapping required -- they 
>avoid swapping data back and forth to keep good performance.  For 
>buses/devices that follow CPU endianness use 3. or perhaps 4. if 
>interrupts have already been masked.
>
> The changes have been verified with a Malta board for port I/O and with a 
>SWARM one for memory-mapped I/O (with an updated driver; to be sent 
>separately).  Broadcom SiByte systems are the only ones utilizing current 
>__raw_*() and ____raw_*() calls.  I have a patch to convert them to 
>bus_*() and __bus_*() ones as appropriate ready as well.
>
> OK to apply?
>
>  Maciej
>
>patch-mips-2.6.10-rc2-20041124-mips-ide-27
>diff -up --recursive --new-file linux-mips-2.6.10-rc2-20041124.macro/include/asm-mips/io.h linux-mips-2.6.10-rc2-20041124/include/asm-mips/io.h
>--- linux-mips-2.6.10-rc2-20041124.macro/include/asm-mips/io.h	2004-11-22 14:27:59.000000000 +0000
>+++ linux-mips-2.6.10-rc2-20041124/include/asm-mips/io.h	2004-12-13 13:05:29.000000000 +0000
>@@ -6,21 +6,26 @@
>  * Copyright (C) 1994, 1995 Waldorf GmbH
>  * Copyright (C) 1994 - 2000 Ralf Baechle
>  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
>+ * Copyright (C) 2004  MIPS Technologies, Inc.  All rights reserved.
>+ *	Author:	Maciej W. Rozycki <macro@mips.com>
>  */
> #ifndef _ASM_IO_H
> #define _ASM_IO_H
> 
> #include <linux/config.h>
> #include <linux/compiler.h>
>+#include <linux/kernel.h>
> #include <linux/types.h>
> 
> #include <asm/addrspace.h>
>+#include <asm/bug.h>
>+#include <asm/byteorder.h>
> #include <asm/cpu.h>
> #include <asm/cpu-features.h>
> #include <asm/page.h>
> #include <asm/pgtable-bits.h>
> #include <asm/processor.h>
>-#include <asm/byteorder.h>
>+
> #include <mangle-port.h>
> 
> /*
>@@ -29,34 +34,52 @@
> #undef CONF_SLOWDOWN_IO
> 
> /*
>- * Sane hardware offers swapping of I/O space accesses in hardware; less
>- * sane hardware forces software to fiddle with this ...
>+ * Sane hardware offers swapping of PCI/ISA I/O space accesses in hardware;
>+ * less sane hardware forces software to fiddle with this...
>  */
>-#if defined(CONFIG_SWAP_IO_SPACE) && defined(__MIPSEB__)
>+#if defined(CONFIG_SWAP_IO_SPACE)
> 
>-#define __ioswab8(x) (x)
>-
>-#ifdef CONFIG_SGI_IP22
>+# define ioswabb(x)		(x)
>+# define __raw_ioswabb(x)	(x)
>+# ifdef CONFIG_SGI_IP22
> /*
>  * IP22 seems braindead enough to swap 16bits values in hardware, but
>  * not 32bits.  Go figure... Can't tell without documentation.
>  */
>-#define __ioswab16(x) (x)
>-#else
>-#define __ioswab16(x) swab16(x)
>-#endif
>-#define __ioswab32(x) swab32(x)
>-#define __ioswab64(x) swab64(x)
>+#  define ioswabw(x)		(x)
>+#  define __raw_ioswabw(x)	le16_to_cpu(x)
>+# else
>+#  define ioswabw(x)		le16_to_cpu(x)
>+#  define __raw_ioswabw(x)	(x)
>+# endif
>+# define ioswabl(x)		le32_to_cpu(x)
>+# define __raw_ioswabl(x)	(x)
>+# define ioswabq(x)		le64_to_cpu(x)
>+# define __raw_ioswabq(x)	(x)
> 
> #else
> 
>-#define __ioswab8(x) (x)
>-#define __ioswab16(x) (x)
>-#define __ioswab32(x) (x)
>-#define __ioswab64(x) (x)
>+# define ioswabb(x)		(x)
>+# define __raw_ioswabb(x)	(x)
>+# define ioswabw(x)		(x)
>+# define __raw_ioswabw(x)	cpu_to_le16(x)
>+# define ioswabl(x)		(x)
>+# define __raw_ioswabl(x)	cpu_to_le32(x)
>+# define ioswabq(x)		(x)
>+# define __raw_ioswabq(x)	cpu_to_le64(x)
> 
> #endif
> 
>+/*
>+ * Native bus accesses never swapped.
>+ */
>+#define bus_ioswabb(x)		(x)
>+#define bus_ioswabw(x)		(x)
>+#define bus_ioswabl(x)		(x)
>+#define bus_ioswabq(x)		(x)
>+
>+#define __bus_ioswabq		bus_ioswabq
>+
> #define IO_SPACE_LIMIT 0xffff
> 
> /*
>@@ -245,108 +268,202 @@ static inline void iounmap(volatile void
> 	__iounmap(addr);
> }
> 
>-#define __raw_readb(addr)						\
>-	(*(volatile unsigned char *) __swizzle_addr_b((unsigned long)(addr)))
>-#define __raw_readw(addr)						\
>-	(*(volatile unsigned short *) __swizzle_addr_w((unsigned long)(addr)))
>-#define __raw_readl(addr)						\
>-	(*(volatile unsigned int *) __swizzle_addr_l((unsigned long)(addr)))
>-#ifdef CONFIG_MIPS32
>-#define ____raw_readq(addr)						\
>-({									\
>-	u64 __res;							\
>-									\
>-	__asm__ __volatile__ (						\
>-		"	.set	mips3		# ____raw_readq	\n"	\
>-		"	ld	%L0, (%1)			\n"	\
>-		"	dsra32	%M0, %L0, 0			\n"	\
>-		"	sll	%L0, %L0, 0			\n"	\
>-		"	.set	mips0				\n"	\
>-		: "=r" (__res)						\
>-		: "r" (__swizzle_addr_q((unsigned long)(addr))));	\
>-	__res;								\
>-})
>-#define __raw_readq(addr)						\
>-({									\
>-	unsigned long __flags;						\
>-	u64 __res;							\
>-									\
>-	local_irq_save(__flags);					\
>-	__res = ____raw_readq(addr);					\
>-	local_irq_restore(__flags);					\
>-	__res;								\
>-})
>-#endif
>-#ifdef CONFIG_MIPS64
>-#define ____raw_readq(addr)						\
>-	(*(volatile unsigned long *)__swizzle_addr_q((unsigned long)(addr)))
>-#define __raw_readq(addr)	____raw_readq(addr)
>-#endif
> 
>-#define readb(addr)		__ioswab8(__raw_readb(addr))
>-#define readw(addr)		__ioswab16(__raw_readw(addr))
>-#define readl(addr)		__ioswab32(__raw_readl(addr))
>-#define readq(addr)		__ioswab64(__raw_readq(addr))
>-#define readb_relaxed(addr)	readb(addr)
>-#define readw_relaxed(addr)	readw(addr)
>-#define readl_relaxed(addr)	readl(addr)
>-#define readq_relaxed(addr)	readq(addr)
>-
>-#define __raw_writeb(b,addr)						\
>-do {									\
>-	((*(volatile unsigned char *)__swizzle_addr_b((unsigned long)(addr))) = (b));	\
>-} while (0)
>-
>-#define __raw_writew(w,addr)						\
>-do {									\
>-	((*(volatile unsigned short *)__swizzle_addr_w((unsigned long)(addr))) = (w));	\
>-} while (0)
>-
>-#define __raw_writel(l,addr)						\
>-do {									\
>-	((*(volatile unsigned int *)__swizzle_addr_l((unsigned long)(addr))) = (l));	\
>-} while (0)
>-
>-#ifdef CONFIG_MIPS32
>-#define ____raw_writeq(val,addr)					\
>-do {									\
>-	u64 __tmp;							\
>-									\
>-	__asm__ __volatile__ (						\
>-		"	.set	mips3				\n"	\
>-		"	dsll32	%L0, %L0, 0	# ____raw_writeq\n"	\
>-		"	dsrl32	%L0, %L0, 0			\n"	\
>-		"	dsll32	%M0, %M0, 0			\n"	\
>-		"	or	%L0, %L0, %M0			\n"	\
>-		"	sd	%L0, (%2)			\n"	\
>-		"	.set	mips0				\n"	\
>-		: "=r" (__tmp)						\
>-		: "0" ((unsigned long long)val),			\
>-		  "r" (__swizzle_addr_q((unsigned long)(addr))));	\
>-} while (0)
>-
>-#define __raw_writeq(val,addr)						\
>-do {									\
>-	unsigned long __flags;						\
>-									\
>-	local_irq_save(__flags);					\
>-	____raw_writeq(val, addr);					\
>-	local_irq_restore(__flags);					\
>-} while (0)
>-#endif
>-#ifdef CONFIG_MIPS64
>-#define ____raw_writeq(q,addr)						\
>-do {									\
>-	*(volatile unsigned long *)__swizzle_addr_q((unsigned long)(addr)) = (q);	\
>-} while (0)
>+#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)			\
>+									\
>+static inline void pfx##write##bwlq(type val, void *mem)		\
>+{									\
>+	volatile type *__mem;						\
>+	type __val;							\
>+									\
>+	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
>+									\
>+	__val = pfx##ioswab##bwlq(val);					\
>+									\
>+	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long))	\
>+		*__mem = __val;						\
>+	else if (cpu_has_64bits) {					\
>+		unsigned long __flags;					\
>+		type __tmp;						\
>+									\
>+		if (irq)						\
>+			local_irq_save(__flags);			\
>+		__asm__ __volatile__(					\
>+			".set	mips3"		"\t\t# __writeq""\n\t"	\
>+			"dsll32	%L0, %L0, 0"			"\n\t"	\
>+			"dsrl32	%L0, %L0, 0"			"\n\t"	\
>+			"dsll32	%M0, %M0, 0"			"\n\t"	\
>+			"or	%L0, %L0, %M0"			"\n\t"	\
>+			"sd	%L0, %2"			"\n\t"	\
>+			".set	mips0"				"\n"	\
>+			: "=r" (__tmp)					\
>+			: "0" (__val), "m" (*__mem));			\
>+		if (irq)						\
>+			local_irq_restore(__flags);			\
>+	} else								\
>+		BUG();							\
>+}									\
>+									\
>+static inline type pfx##read##bwlq(void *mem)				\
>+{									\
>+	volatile type *__mem;						\
>+	type __val;							\
>+									\
>+	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
>+									\
>+	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long))	\
>+		__val = *__mem;						\
>+	else if (cpu_has_64bits) {					\
>+		unsigned long __flags;					\
>+									\
>+		local_irq_save(__flags);				\
>+		__asm__ __volatile__(					\
>+			".set	mips3"		"\t\t# __readq"	"\n\t"	\
>+			"ld	%L0, %1"			"\n\t"	\
>+			"dsra32	%M0, %L0, 0"			"\n\t"	\
>+			"sll	%L0, %L0, 0"			"\n\t"	\
>+			".set	mips0"				"\n"	\
>+			: "=r" (__val)					\
>+			: "m" (*__mem));				\
>+		local_irq_restore(__flags);				\
>+	} else {							\
>+		__val = 0;						\
>+		BUG();							\
>+	}								\
>+									\
>+	return pfx##ioswab##bwlq(__val);				\
>+}
> 
>-#define __raw_writeq(q,addr)	____raw_writeq(q, addr)
>-#endif
>+#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p, slow)			\
>+									\
>+static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
>+{									\
>+	volatile type *__addr;						\
>+	type __val;							\
>+									\
>+	port = __swizzle_addr_##bwlq(port);				\
>+	__addr = (void *)(mips_io_port_base + port);			\
>+									\
>+	__val = pfx##ioswab##bwlq(val);					\
>+									\
>+	if (sizeof(type) != sizeof(u64)) {				\
>+		*__addr = __val;					\
>+		slow;							\
>+	} else								\
>+		BUILD_BUG();						\
>+}									\
>+									\
>+static inline type pfx##in##bwlq##p(unsigned long port)			\
>+{									\
>+	volatile type *__addr;						\
>+	type __val;							\
>+									\
>+	port = __swizzle_addr_##bwlq(port);				\
>+	__addr = (void *)(mips_io_port_base + port);			\
>+									\
>+	if (sizeof(type) != sizeof(u64)) {				\
>+		__val = *__addr;					\
>+		slow;							\
>+	} else {							\
>+		__val = 0;						\
>+		BUILD_BUG();						\
>+	}								\
>+									\
>+	return pfx##ioswab##bwlq(__val);				\
>+}
>+
>+#define __BUILD_MEMORY_PFX(bus, bwlq, type)				\
>+									\
>+__BUILD_MEMORY_SINGLE(bus, bwlq, type, 1)
>+
>+#define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
>+									\
>+__BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)				\
>+__BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
>+
>+#define BUILDIO(bwlq, type)						\
>+									\
>+__BUILD_MEMORY_PFX(, bwlq, type)					\
>+__BUILD_MEMORY_PFX(__raw_, bwlq, type)					\
>+__BUILD_MEMORY_PFX(bus_, bwlq, type)					\
>+__BUILD_IOPORT_PFX(, bwlq, type)					\
>+__BUILD_IOPORT_PFX(__raw_, bwlq, type)
>+
>+#define __BUILDIO(bwlq, type)						\
>+									\
>+__BUILD_MEMORY_SINGLE(__bus_, bwlq, type, 0)
>+
>+BUILDIO(b, u8)
>+BUILDIO(w, u16)
>+BUILDIO(l, u32)
>+BUILDIO(q, u64)
>+
>+__BUILDIO(q, u64)
>+
>+#define readb_relaxed			readb
>+#define readw_relaxed			readw
>+#define readl_relaxed			readl
>+#define readq_relaxed			readq
>+
>+
>+#define __BUILD_MEMORY_STRING(bwlq, type)				\
>+									\
>+static inline void writes##bwlq(void *mem, void *addr,			\
>+				unsigned int count)			\
>+{									\
>+	volatile type *__addr = addr;					\
>+									\
>+	while (count--) {						\
>+		__raw_write##bwlq(*__addr, mem);			\
>+		__addr++;						\
>+	}								\
>+}									\
>+									\
>+static inline void reads##bwlq(void *mem, void *addr,			\
>+			       unsigned int count)			\
>+{									\
>+	volatile type *__addr = addr;					\
>+									\
>+	while (count--) {						\
>+		*__addr = __raw_read##bwlq(mem);			\
>+		__addr++;						\
>+	}								\
>+}
>+
>+#define __BUILD_IOPORT_STRING(bwlq, type)				\
>+									\
>+static inline void outs##bwlq(unsigned long port, void *addr,		\
>+			      unsigned int count)			\
>+{									\
>+	volatile type *__addr = addr;					\
>+									\
>+	while (count--) {						\
>+		__raw_out##bwlq(*__addr, port);				\
>+		__addr++;						\
>+	}								\
>+}									\
>+									\
>+static inline void ins##bwlq(unsigned long port, void *addr,		\
>+			     unsigned int count)			\
>+{									\
>+	volatile type *__addr = addr;					\
>+									\
>+	while (count--) {						\
>+		*__addr = __raw_in##bwlq(port);				\
>+		__addr++;						\
>+	}								\
>+}
>+
>+#define BUILDSTRING(bwlq, type)						\
>+									\
>+__BUILD_MEMORY_STRING(bwlq, type)					\
>+__BUILD_IOPORT_STRING(bwlq, type)
>+
>+BUILDSTRING(b, u8)
>+BUILDSTRING(w, u16)
>+BUILDSTRING(l, u32)
>+BUILDSTRING(q, u64)
> 
>-#define writeb(b,addr)		__raw_writeb(__ioswab8(b),(addr))
>-#define writew(w,addr)		__raw_writew(__ioswab16(w),(addr))
>-#define writel(l,addr)		__raw_writel(__ioswab32(l),(addr))
>-#define writeq(q,addr)		__raw_writeq(__ioswab64(q),(addr))
> 
> /* Depends on MIPS II instruction set */
> #define mmiowb() asm volatile ("sync" ::: "memory")
>@@ -394,7 +511,7 @@ do {									\
>  *     address should have been obtained by ioremap.
>  *     Returns 1 on a match.
>  */
>-static inline int check_signature(unsigned long io_addr,
>+static inline int check_signature(char __iomem *io_addr,
> 	const unsigned char *signature, int length)
> {
> 	int retval = 0;
>@@ -424,177 +541,6 @@ out:
>  */
> #define isa_check_signature(io, s, l)	check_signature(i,s,l)
> 
>-static inline void __outb(unsigned char val, unsigned long port)
>-{
>-	port = __swizzle_addr_b(port);
>-
>-	*(volatile u8 *)(mips_io_port_base + port) = __ioswab8(val);
>-}
>-
>-static inline void __outw(unsigned short val, unsigned long port)
>-{
>-	port = __swizzle_addr_w(port);
>-
>-	*(volatile u16 *)(mips_io_port_base + port) = __ioswab16(val);
>-}
>-
>-static inline void __outl(unsigned int val, unsigned long port)
>-{
>-	port = __swizzle_addr_l(port);
>-
>-	*(volatile u32 *)(mips_io_port_base + port) = __ioswab32(val);
>-}
>-
>-static inline void __outb_p(unsigned char val, unsigned long port)
>-{
>-	port = __swizzle_addr_b(port);
>-
>-	*(volatile u8 *)(mips_io_port_base + port) = __ioswab8(val);
>-	SLOW_DOWN_IO;
>-}
>-
>-static inline void __outw_p(unsigned short val, unsigned long port)
>-{
>-	port = __swizzle_addr_w(port);
>-
>-	*(volatile u16 *)(mips_io_port_base + port) = __ioswab16(val);
>-	SLOW_DOWN_IO;
>-}
>-
>-static inline void __outl_p(unsigned int val, unsigned long port)
>-{
>-	port = __swizzle_addr_l(port);
>-
>-	*(volatile u32 *)(mips_io_port_base + port) = __ioswab32(val);
>-	SLOW_DOWN_IO;
>-}
>-
>-#define outb(val, port)		__outb(val, port)
>-#define outw(val, port)		__outw(val, port)
>-#define outl(val, port)		__outl(val, port)
>-#define outb_p(val, port)	__outb_p(val, port)
>-#define outw_p(val, port)	__outw_p(val, port)
>-#define outl_p(val, port)	__outl_p(val, port)
>-
>-static inline unsigned char __inb(unsigned long port)
>-{
>-	port = __swizzle_addr_b(port);
>-
>-	return __ioswab8(*(volatile u8 *)(mips_io_port_base + port));
>-}
>-
>-static inline unsigned short __inw(unsigned long port)
>-{
>-	port = __swizzle_addr_w(port);
>-
>-	return __ioswab16(*(volatile u16 *)(mips_io_port_base + port));
>-}
>-
>-static inline unsigned int __inl(unsigned long port)
>-{
>-	port = __swizzle_addr_l(port);
>-
>-	return __ioswab32(*(volatile u32 *)(mips_io_port_base + port));
>-}
>-
>-static inline unsigned char __inb_p(unsigned long port)
>-{
>-	u8 __val;
>-
>-	port = __swizzle_addr_b(port);
>-
>-	__val = *(volatile u8 *)(mips_io_port_base + port);
>-	SLOW_DOWN_IO;
>-
>-	return __ioswab8(__val);
>-}
>-
>-static inline unsigned short __inw_p(unsigned long port)
>-{
>-	u16 __val;
>-
>-	port = __swizzle_addr_w(port);
>-
>-	__val = *(volatile u16 *)(mips_io_port_base + port);
>-	SLOW_DOWN_IO;
>-
>-	return __ioswab16(__val);
>-}
>-
>-static inline unsigned int __inl_p(unsigned long port)
>-{
>-	u32 __val;
>-
>-	port = __swizzle_addr_l(port);
>-
>-	__val = *(volatile u32 *)(mips_io_port_base + port);
>-	SLOW_DOWN_IO;
>-
>-	return __ioswab32(__val);
>-}
>-
>-#define inb(port)	__inb(port)
>-#define inw(port)	__inw(port)
>-#define inl(port)	__inl(port)
>-#define inb_p(port)	__inb_p(port)
>-#define inw_p(port)	__inw_p(port)
>-#define inl_p(port)	__inl_p(port)
>-
>-static inline void __outsb(unsigned long port, void *addr, unsigned int count)
>-{
>-	while (count--) {
>-		outb(*(u8 *)addr, port);
>-		addr++;
>-	}
>-}
>-
>-static inline void __insb(unsigned long port, void *addr, unsigned int count)
>-{
>-	while (count--) {
>-		*(u8 *)addr = inb(port);
>-		addr++;
>-	}
>-}
>-
>-static inline void __outsw(unsigned long port, void *addr, unsigned int count)
>-{
>-	while (count--) {
>-		outw(*(u16 *)addr, port);
>-		addr += 2;
>-	}
>-}
>-
>-static inline void __insw(unsigned long port, void *addr, unsigned int count)
>-{
>-	while (count--) {
>-		*(u16 *)addr = inw(port);
>-		addr += 2;
>-	}
>-}
>-
>-static inline void __outsl(unsigned long port, void *addr, unsigned int count)
>-{
>-	while (count--) {
>-		outl(*(u32 *)addr, port);
>-		addr += 4;
>-	}
>-}
>-
>-static inline void __insl(unsigned long port, void *addr, unsigned int count)
>-{
>-	while (count--) {
>-		*(u32 *)addr = inl(port);
>-		addr += 4;
>-	}
>-}
>-
>-#define outsb(port, addr, count)	__outsb(port, addr, count)
>-#define insb(port, addr, count)		__insb(port, addr, count)
>-#define outsw(port, addr, count)	__outsw(port, addr, count)
>-#define insw(port, addr, count)		__insw(port, addr, count)
>-#define outsl(port, addr, count)	__outsl(port, addr, count)
>-#define insl(port, addr, count)		__insl(port, addr, count)
>-
> /*
>  * The caches on some architectures aren't dma-coherent and have need to
>  * handle this in software.  There are three types of operations that
>diff -up --recursive --new-file linux-mips-2.6.10-rc2-20041124.macro/include/asm-mips/mach-generic/ide.h linux-mips-2.6.10-rc2-20041124/include/asm-mips/mach-generic/ide.h
>--- linux-mips-2.6.10-rc2-20041124.macro/include/asm-mips/mach-generic/ide.h	2004-11-24 21:37:52.000000000 +0000
>+++ linux-mips-2.6.10-rc2-20041124/include/asm-mips/mach-generic/ide.h	2004-12-14 17:25:36.000000000 +0000
>@@ -64,7 +64,17 @@ static __inline__ unsigned long ide_defa
> #define ide_init_default_irq(base)	ide_default_irq(base)
> #endif
> 
>-#include <asm-generic/ide_iops.h>
>+/* MIPS port and memory-mapped I/O string operations.  */
>+
>+#define __ide_insw	insw
>+#define __ide_insl	insl
>+#define __ide_outsw	outsw
>+#define __ide_outsl	outsl
>+
>+#define __ide_mm_insw	readsw
>+#define __ide_mm_insl	readsl
>+#define __ide_mm_outsw	writesw
>+#define __ide_mm_outsl	writesl
> 
> #endif /* __KERNEL__ */
> 
>
>
>  
>
