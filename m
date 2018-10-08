Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2018 02:37:12 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994427AbeJHAhBnNEAL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Oct 2018 02:37:01 +0200
Date:   Mon, 8 Oct 2018 01:37:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] MIPS: Define MMIO ordering barriers
In-Reply-To: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810070232470.7757@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66717
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

Define MMIO ordering barriers as separate operations so as to allow 
making places where such a barrier is required distinct from places 
where a memory or a DMA barrier is needed.

Architecturally MIPS does not specify ordering requirements for uncached 
bus accesses such as MMIO operations normally use and therefore explicit 
barriers have to be inserted between MMIO accesses where unspecified 
ordering of operations would cause unpredictable results.

MIPS MMIO ordering barriers are implemented using the same underlying 
mechanism that memory or a DMA barrier ordering barriers use, that is 
either a suitable SYNC instruction or a platform-specific `wbflush' 
call.  However platforms may implement different ordering rules for 
different kinds of bus activity, so having a separate API makes it 
possible to remove unnecessary barriers and avoid a performance hit they 
may cause due to unrelated bus activity by making their implementation 
expand to nil while keeping the necessary ones.

Also having distinct barriers for each kind of use makes it easier for 
the reader to understand what code has been intended to do.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/include/asm/io.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

linux-mips-iobarrier.patch
Index: linux-20180930-3maxp/arch/mips/include/asm/io.h
===================================================================
--- linux-20180930-3maxp.orig/arch/mips/include/asm/io.h
+++ linux-20180930-3maxp/arch/mips/include/asm/io.h
@@ -20,6 +20,7 @@
 #include <linux/irqflags.h>
 
 #include <asm/addrspace.h>
+#include <asm/barrier.h>
 #include <asm/bug.h>
 #include <asm/byteorder.h>
 #include <asm/cpu.h>
@@ -80,6 +81,17 @@ static inline void set_io_port_base(unsi
 }
 
 /*
+ * Enforce in-order execution of data I/O.  In the MIPS architecture
+ * these are equivalent to corresponding platform-specific memory
+ * barriers defined in <asm/barrier.h>.  API pinched from PowerPC,
+ * with sync additionally defined.
+ */
+#define iobarrier_rw() mb()
+#define iobarrier_r() rmb()
+#define iobarrier_w() wmb()
+#define iobarrier_sync() iob()
+
+/*
  * Thanks to James van Artsdalen for a better timing-fix than
  * the two short jumps: using outb's to a nonexistent port seems
  * to guarantee better timings even on fast machines.
