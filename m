Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 02:48:38 +0100 (BST)
Received: from [65.98.92.6] ([65.98.92.6]:2193 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023949AbZE0Bsb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 May 2009 02:48:31 +0100
Received: (qmail 28805 invoked from network); 27 May 2009 01:48:29 -0000
Received: from softdnserror (HELO two) (127.0.0.1)
  by softdnserror with SMTP; 27 May 2009 01:48:29 -0000
Received: by two (sSMTP sendmail emulation); Tue, 26 May 2009 18:47:49 -0700
Message-Id: <1add207f621f4d12c0f93b1aa64e77c1db70a2a5@localhost>
In-Reply-To: <26a78e954b7e1570179fba0c56aa129af1a247e0@localhost>
References: <26a78e954b7e1570179fba0c56aa129af1a247e0@localhost>
From:	Kevin Cernekee <cernekee@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:	Tue, 26 May 2009 16:59:56 -0700
Subject: [PATCH 1/1] MIPS: Disable address swizzling on __raw MMIO operations
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

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
