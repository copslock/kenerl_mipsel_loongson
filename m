Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 18:27:28 +0200 (CEST)
Received: from [65.98.92.6] ([65.98.92.6]:4537 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492235AbZFNQ1V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Jun 2009 18:27:21 +0200
Received: (qmail 25445 invoked from network); 14 Jun 2009 16:26:42 -0000
Received: from softdnserror (HELO two) (127.0.0.1)
  by softdnserror with SMTP; 14 Jun 2009 16:26:42 -0000
Received: by two (sSMTP sendmail emulation); Sun, 14 Jun 2009 09:26:02 -0700
Message-Id: <4600b10a05ad646981412c9aaedc51da@localhost>
From:	Kevin Cernekee <cernekee@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:	Sun, 14 Jun 2009 09:12:18 -0700
Subject: [PATCH] MIPS: Disable address swizzling on __raw MMIO operations (resend)
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

{read,write}[bwlq] are used for PCI and may therefore need to implement
address or data swizzling on big-endian systems.  Those operations are
unaffected by this patch.

__raw_{read,write}[bwlq] should always implement unswizzled accesses.
Currently on MIPS, the __raw operations do not swizzle data (good) but
do swizzle addresses (bad).  This causes problems with code that
assumes the __raw operations use the system's native endianness, such
as the MTD physmap/CFI drivers.

It also means that the __raw behavior is not consistent between
BE systems that use address swizzling (IP32) and BE systems that
use CONFIG_SWAP_IO_SPACE for data swizzling (IP22).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/io.h |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 436878e..ea0647c 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -301,7 +301,7 @@ static inline void iounmap(const volatile void __iomem *addr)
 #define war_octeon_io_reorder_wmb()		do { } while (0)
 #endif
 
-#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)			\
+#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq, swiz)		\
 									\
 static inline void pfx##write##bwlq(type val,				\
 				    volatile void __iomem *mem)		\
@@ -311,7 +311,9 @@ static inline void pfx##write##bwlq(type val,				\
 									\
 	war_octeon_io_reorder_wmb();					\
 									\
-	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
+	__mem = swiz ?							\
+		(void *)__swizzle_addr_##bwlq((unsigned long)(mem)) :	\
+		(void *)mem;						\
 									\
 	__val = pfx##ioswab##bwlq(__mem, val);				\
 									\
@@ -344,7 +346,9 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 	volatile type *__mem;						\
 	type __val;							\
 									\
-	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
+	__mem = swiz ?							\
+		(void *)__swizzle_addr_##bwlq((unsigned long)(mem)) :	\
+		(void *)mem;						\
 									\
 	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long))	\
 		__val = *__mem;						\
@@ -406,15 +410,15 @@ static inline type pfx##in##bwlq##p(unsigned long port)			\
 	return pfx##ioswab##bwlq(__addr, __val);			\
 }
 
-#define __BUILD_MEMORY_PFX(bus, bwlq, type)				\
+#define __BUILD_MEMORY_PFX(bus, bwlq, type, swiz)			\
 									\
-__BUILD_MEMORY_SINGLE(bus, bwlq, type, 1)
+__BUILD_MEMORY_SINGLE(bus, bwlq, type, 1, swiz)
 
 #define BUILDIO_MEM(bwlq, type)						\
 									\
-__BUILD_MEMORY_PFX(__raw_, bwlq, type)					\
-__BUILD_MEMORY_PFX(, bwlq, type)					\
-__BUILD_MEMORY_PFX(__mem_, bwlq, type)					\
+__BUILD_MEMORY_PFX(__raw_, bwlq, type, 0)				\
+__BUILD_MEMORY_PFX(, bwlq, type, 1)					\
+__BUILD_MEMORY_PFX(__mem_, bwlq, type, 1)				\
 
 BUILDIO_MEM(b, u8)
 BUILDIO_MEM(w, u16)
@@ -438,7 +442,7 @@ BUILDIO_IOPORT(q, u64)
 
 #define __BUILDIO(bwlq, type)						\
 									\
-__BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 0)
+__BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 0, 0)
 
 __BUILDIO(q, u64)
 
-- 
1.5.3.6
