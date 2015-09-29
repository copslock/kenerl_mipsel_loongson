Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Sep 2015 12:28:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46209 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007497AbbI2K24Aqh1C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Sep 2015 12:28:56 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t8TAStJO001324
        for <linux-mips@linux-mips.org>; Tue, 29 Sep 2015 12:28:55 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t8TAStNT001323
        for linux-mips@linux-mips.org; Tue, 29 Sep 2015 12:28:55 +0200
Date:   Tue, 29 Sep 2015 12:28:55 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Use ARCH_USE_BUILTIN_BSWAP.
Message-ID: <20150929102855.GA1319@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

ARCH_USE_BUILTIN_BSWAP will use __builtin_bswap16(), __builtin_bswap32()
and __builtin_bswap64() where available.  This allows better instruction
scheduling.  On pre-R2 processors it will result in 32 bit and 64 bit
swapping being performed in a call to a __bswapsi2() rsp. __bswapdi2()
functions, so we add these, too.

For a 4.2 kernel with GCC 4.9 this yields the following kernel sizes:

   text    data     bss     dec     hex filename
3996071  155804   88992 4240867  40b5e3 vmlinux         ip22 baseline
3985687  159900   88992 4234579  409d53 vmlinux         ip22 + bswap patch
6913157  378552  251024 7542733  7317cd vmlinux         ip27 baseline
6878581  378552  251024 7508157  7290bd vmlinux         ip27 + bswap patch
5773777  268752  187424 6229953  5f0fc1 vmlinux         malta baseline
5773401  268752  187424 6229577  5f0e49 vmlinux         malta + bswap patch

Presumably the code size improvments yield better cache hit rate thus
better performance compensating for the extra function call but this
will still need to be benchmarked.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/Kconfig       |  1 +
 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/bswapdi.c | 11 +++++++++++
 arch/mips/lib/bswapsi.c |  7 +++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a228e34..4ccb683 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3,6 +3,7 @@ config MIPS
 	default y
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_USE_BUILTIN_BSWAP
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 1e9e900..0344e57 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -15,4 +15,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
+obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
diff --git a/arch/mips/lib/bswapdi.c b/arch/mips/lib/bswapdi.c
new file mode 100644
index 0000000..f69c41f
--- /dev/null
+++ b/arch/mips/lib/bswapdi.c
@@ -0,0 +1,11 @@
+unsigned long long __bswapdi2 (unsigned long long u)
+{
+	return (((u) & 0xff00000000000000ull) >> 56) |
+	       (((u) & 0x00ff000000000000ull) >> 40) |
+	       (((u) & 0x0000ff0000000000ull) >> 24) |
+	       (((u) & 0x000000ff00000000ull) >>  8) |
+	       (((u) & 0x00000000ff000000ull) <<  8) |
+	       (((u) & 0x0000000000ff0000ull) << 24) |
+	       (((u) & 0x000000000000ff00ull) << 40) |
+	       (((u) & 0x00000000000000ffull) << 56);
+}
diff --git a/arch/mips/lib/bswapsi.c b/arch/mips/lib/bswapsi.c
new file mode 100644
index 0000000..2e3ba7f
--- /dev/null
+++ b/arch/mips/lib/bswapsi.c
@@ -0,0 +1,7 @@
+unsigned int __bswapsi2 (unsigned int u)
+{
+	return (((u) & 0xff000000) >> 24) |
+	       (((u) & 0x00ff0000) >>  8) |
+	       (((u) & 0x0000ff00) <<  8) |
+	       (((u) & 0x000000ff) << 24);
+}
