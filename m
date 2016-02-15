Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 18:59:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60346 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011948AbcBOR7sG0m0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 18:59:48 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 7B15381B947A2;
        Mon, 15 Feb 2016 17:59:38 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 15 Feb 2016 17:59:41 +0000
Received: from localhost (10.100.200.11) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 15 Feb
 2016 17:59:39 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "# v4 . 4+" <stable@vger.kernel.org>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Robert Suchanek <robert.suchanek@imgtec.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Perches <joe@perches.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: [PATCH] compiler-gcc: Workaround MIPS GCC reordering bug
Date:   Mon, 15 Feb 2016 09:59:05 -0800
Message-ID: <1455559145-26805-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.11]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

GCC for MIPS currently has a bug which leads to it reordering
instructions into branch delay slots incorrectly when a call to
__builtin_unreachable is the only content of the default case of a
switch statement. See this thread for details:

    https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html

Work around this bug by placing an empty volatile asm statement before
the __builtin_unreachable call, which prevents GCC's delay slot filler
from seeing past the asm statement (& thus the call to
__builtin_unreachable) to instructions it shouldn't reorder. It would be
good to guard this based upon GCC_VERSION once the bug is fixed in GCC,
but meanwhile this workaround has no known negative side effects.

This bug affects at least a maltasmvp_defconfig kernel built from the
v4.4 tag using GCC 4.9.2 (from a Codescape SDK 2015.06-05 toolchain),
with the result being an address exception taken after log messages
about the L1 caches (during probe of the L2 cache):

    Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
    VPE topology {2,2} total 4
    Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
    Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
    <AdEL exception here>

This is early enough that the kernel exception vectors are not in use,
so any further output depends upon the bootloader. This is reproducible
in QEMU where no further output occurs - ie. the system hangs here.
Given the affected v4.4 configuration this patch is marked for stable
backport to v4.4, however I cannot test every configuration so it's
entirely possible that this bug hits other platforms in earlier kernel
versions. Given the nature of the bug it may potentially be hit with
differing symptoms.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: <stable@vger.kernel.org> # v4.4+
Cc: Matthew Fortune <matthew.fortune@imgtec.com>
Cc: Robert Suchanek <robert.suchanek@imgtec.com>
---

 include/linux/compiler-gcc.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 22ab246..e7c3502 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -196,7 +196,25 @@
  * this in the preprocessor, but we can live with this because they're
  * unreleased.  Really, we need to have autoconf for the kernel.
  */
-#define unreachable() __builtin_unreachable()
+#if defined(__mips__)
+/*
+ * GCC for MIPS currently has a bug which leads to it incorrectly
+ * reordering instructions into branch delay slots when a call to
+ * __builtin_unreachable() is the only thing in the default case of a
+ * switch statement. We avoid this bug for those versions of GCC by
+ * placing an empty volatile asm statement before the call to
+ * __builtin_unreachable, which GCC is prevented from reordering past.
+ *
+ * See this thread for details:
+ * https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html
+ */
+# define unreachable() do {		\
+	asm volatile("");		\
+	__builtin_unreachable();	\
+} while (0)
+#else
+# define unreachable() __builtin_unreachable()
+#endif
 
 /* Mark a function definition as prohibited from being cloned. */
 #define __noclone	__attribute__((__noclone__))
-- 
2.7.1
