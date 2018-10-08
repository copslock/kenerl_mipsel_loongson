Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2018 02:37:31 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994248AbeJHAhHk-6vL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Oct 2018 02:37:07 +0200
Date:   Mon, 8 Oct 2018 01:37:07 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] MIPS: Correct `mmiowb' barrier for `wbflush' platforms
In-Reply-To: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810070303380.7757@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810070229190.7757@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66718
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

Redefine `mmiowb' in terms of `iobarrier_w' so that it works correctly 
for MIPS I platforms, which have no SYNC machine instruction and use a 
call to `wbflush' instead.

This doesn't change the semantics for CONFIG_CPU_CAVIUM_OCTEON, because 
`iobarrier_w' expands to `wmb', which is ultimately the same as the 
current arrangement.  For MIPS I platforms this not only makes any code 
that would happen to use `mmiowb' build and run, but it actually 
enforces the ordering required as well, as `iobarrier_w' has it already 
covered with the use of `wmb'.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/include/asm/io.h |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

linux-mips-mmiowb.patch
Index: linux-20180930-3maxp/arch/mips/include/asm/io.h
===================================================================
--- linux-20180930-3maxp.orig/arch/mips/include/asm/io.h
+++ linux-20180930-3maxp/arch/mips/include/asm/io.h
@@ -91,6 +91,9 @@ static inline void set_io_port_base(unsi
 #define iobarrier_w() wmb()
 #define iobarrier_sync() iob()
 
+/* Some callers use this older API instead.  */
+#define mmiowb() iobarrier_w()
+
 /*
  * Thanks to James van Artsdalen for a better timing-fix than
  * the two short jumps: using outb's to a nonexistent port seems
@@ -573,14 +576,6 @@ BUILDSTRING(l, u32)
 BUILDSTRING(q, u64)
 #endif
 
-
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-#define mmiowb() wmb()
-#else
-/* Depends on MIPS II instruction set */
-#define mmiowb() asm volatile ("sync" ::: "memory")
-#endif
-
 static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
 	memset((void __force *) addr, val, count);
