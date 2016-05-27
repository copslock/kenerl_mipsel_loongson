Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2016 17:46:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3342 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27036050AbcE0PqPKlROz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 May 2016 17:46:15 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 558DEE9433922;
        Fri, 27 May 2016 16:46:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 27 May 2016 16:46:08 +0100
Received: from localhost (10.100.200.32) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 27 May
 2016 16:46:07 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-arch@vger.kernel.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "# v4 . 4+" <stable@vger.kernel.org>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Robert Suchanek <robert.suchanek@imgtec.com>
Subject: [PATCH v2 2/2] MIPS: Workaround GCC __builtin_unreachable reordering bug
Date:   Fri, 27 May 2016 16:45:27 +0100
Message-ID: <20160527154527.6806-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160527154527.6806-1-paul.burton@imgtec.com>
References: <20160527154527.6806-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.32]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53673
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

Current versions of GCC for the MIPS architecture suffer from a bug
which can lead to instructions from beyond an unreachable statement
being incorrectly reordered into earlier branch delay slots if the
unreachable statement is the only content of a case in a switch
statement. This can lead to seemingly random behaviour, such as invalid
memory accesses from incorrectly reordered loads or stores.

See this potential GCC fix for details:

    https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html

Work around this bug by placing a volatile asm statement, which GCC is
prevented from reordering past, prior to the __builtin_unreachable call.

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
This is an alternative approach to this earlier patch which seems to
have been rejected:

    https://patchwork.linux-mips.org/patch/12556/
    https://marc.info/?l=linux-mips&m=145555921408274&w=2

Changes in v2:
- Remove generic-y entry.
---
 arch/mips/include/asm/Kbuild         |  1 -
 arch/mips/include/asm/compiler-gcc.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/compiler-gcc.h

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 9ccb519..c7fe4d0 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # MIPS headers
 generic-(CONFIG_GENERIC_CSUM) += checksum.h
-generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += dma-contiguous.h
diff --git a/arch/mips/include/asm/compiler-gcc.h b/arch/mips/include/asm/compiler-gcc.h
new file mode 100644
index 0000000..565be9b
--- /dev/null
+++ b/arch/mips/include/asm/compiler-gcc.h
@@ -0,0 +1,29 @@
+/*
+ * With GCC v4.5 onwards can use __builtin_unreachable to indicate to the
+ * compiler that a particular code path will never be hit. This allows it to be
+ * optimised out of the generated binary.
+ *
+ * Unfortunately GCC from at least v4.9.2 to current head of tree as of May
+ * 2016 suffer from a bug that can lead to instructions from beyond an
+ * unreachable statement being incorrectly reordered into earlier delay slots
+ * if the unreachable statement is the only content of a case in a switch
+ * statement. This can lead to seemingly random behaviour, such as invalid
+ * memory accesses from incorrectly reordered loads or stores. See this
+ * potential GCC fix for details:
+ *
+ *   https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html
+ *
+ * We work around this by placing a volatile asm statement, which GCC is
+ * prevented from reordering past, prior to the __builtin_unreachable call. The
+ * .insn statement is required to ensure that any branches to the statement,
+ * which sadly must be kept due to the asm statement, are known to be branches
+ * to code and satisfy linker requirements for microMIPS kernels.
+ */
+#if GCC_VERSION >= 40500
+# define unreachable() do {			\
+	asm volatile(".insn");			\
+	__builtin_unreachable();		\
+} while (0)
+#endif
+
+#include <asm-generic/compiler-gcc.h>
-- 
2.8.3
