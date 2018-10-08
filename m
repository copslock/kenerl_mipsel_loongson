Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2018 02:38:22 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994427AbeJHAhX0GPlL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Oct 2018 02:37:23 +0200
Date:   Mon, 8 Oct 2018 01:37:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MIPS: Provide actually relaxed MMIO accessors
In-Reply-To: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810070328410.7757@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Improve performance for the relevant systems and remove the DMA ordering 
barrier from `readX_relaxed' and `writeX_relaxed' MMIO accessors, where 
it is not needed according to our requirements[1].  For consistency make 
the same arrangement with low-level port I/O accessors, but do not 
actually provide any accessors making use of it.

References:

[1] "LINUX KERNEL MEMORY BARRIERS", Documentation/memory-barriers.txt,
    Section "KERNEL I/O BARRIER EFFECTS"

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/include/asm/io.h |   48 ++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

linux-mips-readx-writex-relaxed.patch
Index: linux-20180930-3maxp/arch/mips/include/asm/io.h
===================================================================
--- linux-20180930-3maxp.orig/arch/mips/include/asm/io.h
+++ linux-20180930-3maxp/arch/mips/include/asm/io.h
@@ -51,6 +51,11 @@
 # define __raw_ioswabq(a, x)	(x)
 # define ____raw_ioswabq(a, x)	(x)
 
+# define __relaxed_ioswabb ioswabb
+# define __relaxed_ioswabw ioswabw
+# define __relaxed_ioswabl ioswabl
+# define __relaxed_ioswabq ioswabq
+
 /* ioswab[bwlq], __mem_ioswab[bwlq] are defined in mangle-port.h */
 
 #define IO_SPACE_LIMIT 0xffff
@@ -337,7 +342,7 @@ static inline void iounmap(const volatil
 #define war_io_reorder_wmb()		barrier()
 #endif
 
-#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, barrier, irq)		\
+#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, barrier, relax, irq)	\
 									\
 static inline void pfx##write##bwlq(type val,				\
 				    volatile void __iomem *mem)		\
@@ -411,11 +416,12 @@ static inline type pfx##read##bwlq(const
 	}								\
 									\
 	/* prevent prefetching of coherent DMA data prematurely */	\
-	rmb();								\
+	if (!relax)							\
+		rmb();							\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, barrier, p, slow)		\
+#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, barrier, relax, p, slow)	\
 									\
 static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 {									\
@@ -454,19 +460,21 @@ static inline type pfx##in##bwlq##p(unsi
 	slow;								\
 									\
 	/* prevent prefetching of coherent DMA data prematurely */	\
-	rmb();								\
+	if (!relax)							\
+		rmb();							\
 	return pfx##ioswab##bwlq(__addr, __val);			\
 }
 
-#define __BUILD_MEMORY_PFX(bus, bwlq, type)				\
+#define __BUILD_MEMORY_PFX(bus, bwlq, type, relax)			\
 									\
-__BUILD_MEMORY_SINGLE(bus, bwlq, type, 1, 1)
+__BUILD_MEMORY_SINGLE(bus, bwlq, type, 1, relax, 1)
 
 #define BUILDIO_MEM(bwlq, type)						\
 									\
-__BUILD_MEMORY_PFX(__raw_, bwlq, type)					\
-__BUILD_MEMORY_PFX(, bwlq, type)					\
-__BUILD_MEMORY_PFX(__mem_, bwlq, type)					\
+__BUILD_MEMORY_PFX(__raw_, bwlq, type, 0)				\
+__BUILD_MEMORY_PFX(__relaxed_, bwlq, type, 1)				\
+__BUILD_MEMORY_PFX(__mem_, bwlq, type, 0)				\
+__BUILD_MEMORY_PFX(, bwlq, type, 0)
 
 BUILDIO_MEM(b, u8)
 BUILDIO_MEM(w, u16)
@@ -474,8 +482,8 @@ BUILDIO_MEM(l, u32)
 BUILDIO_MEM(q, u64)
 
 #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, ,)			\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, _p, SLOW_DOWN_IO)
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, ,)			\
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, _p, SLOW_DOWN_IO)
 
 #define BUILDIO_IOPORT(bwlq, type)					\
 	__BUILD_IOPORT_PFX(, bwlq, type)				\
@@ -490,19 +498,19 @@ BUILDIO_IOPORT(q, u64)
 
 #define __BUILDIO(bwlq, type)						\
 									\
-__BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 1, 0)
+__BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 1, 0, 0)
 
 __BUILDIO(q, u64)
 
-#define readb_relaxed			readb
-#define readw_relaxed			readw
-#define readl_relaxed			readl
-#define readq_relaxed			readq
+#define readb_relaxed			__relaxed_readb
+#define readw_relaxed			__relaxed_readw
+#define readl_relaxed			__relaxed_readl
+#define readq_relaxed			__relaxed_readq
 
-#define writeb_relaxed			writeb
-#define writew_relaxed			writew
-#define writel_relaxed			writel
-#define writeq_relaxed			writeq
+#define writeb_relaxed			__relaxed_writeb
+#define writew_relaxed			__relaxed_writew
+#define writel_relaxed			__relaxed_writel
+#define writeq_relaxed			__relaxed_writeq
 
 #define readb_be(addr)							\
 	__raw_readb((__force unsigned *)(addr))
