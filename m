Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2018 19:52:14 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992803AbeKBSwKWBW6P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Nov 2018 19:52:10 +0100
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2890320848;
        Fri,  2 Nov 2018 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184728;
        bh=Z6Ub2tRtSPs/uadt4ZTVk7P55mPBITINgiMBc7azbdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rxq41SUV6k6KvT9L3vevtkMcChLjUG1rij8AUDU4l1BdWXlrIxMB4ieDX9967jEqs
         w8KWSb1Q545tW/QA/OmUjVCDUCiOnaOU4RtYu1S+GqdrASlXxZ98CInSzzd33w2x2o
         PMREPfhESPuqTjW9dS/FnH2OF9kY7OKgqv4ZPC+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 082/143] MIPS: Workaround GCC __builtin_unreachable reordering bug
Date:   Fri,  2 Nov 2018 19:34:27 +0100
Message-Id: <20181102182904.158014903@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <SRS0=l4Il=NN=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 906d441febc0de974b2a6ef848a8f058f3bfada3 ]

Some versions of GCC for the MIPS architecture suffer from a bug which
can lead to instructions from beyond an unreachable statement being
incorrectly reordered into earlier branch delay slots if the unreachable
statement is the only content of a case in a switch statement. This can
lead to seemingly random behaviour, such as invalid memory accesses from
incorrectly reordered loads or stores, and link failures on microMIPS
builds.

See this potential GCC fix for details:

    https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html

Runtime problems resulting from this bug were initially observed using a
maltasmvp_defconfig v4.4 kernel built using GCC 4.9.2 (from a Codescape
SDK 2015.06-05 toolchain), with the result being an address exception
taken after log messages about the L1 caches (during probe of the L2
cache):

    Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
    VPE topology {2,2} total 4
    Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
    Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
    <AdEL exception here>

This is early enough that the kernel exception vectors are not in use,
so any further output depends upon the bootloader. This is reproducible
in QEMU where no further output occurs - ie. the system hangs here.
Given the nature of the bug it may potentially be hit with differing
symptoms. The bug is known to affect GCC versions as recent as 7.3, and
it is unclear whether GCC 8 fixed it or just happens not to encounter
the bug in the testcase found at the link above due to differing
optimizations.

This bug can be worked around by placing a volatile asm statement, which
GCC is prevented from reordering past, prior to the
__builtin_unreachable call.

That was actually done already for other reasons by commit 173a3efd3edb
("bug.h: work around GCC PR82365 in BUG()"), but creates problems for
microMIPS builds due to the lack of a .insn directive. The microMIPS ISA
allows for interlinking with regular MIPS32 code by repurposing bit 0 of
the program counter as an ISA mode bit. To switch modes one changes the
value of this bit in the PC. However typical branch instructions encode
their offsets as multiples of 2-byte instruction halfwords, which means
they cannot change ISA mode - this must be done using either an indirect
branch (a jump-register in MIPS terminology) or a dedicated jalx
instruction. In order to ensure that regular branches don't attempt to
target code in a different ISA which they can't actually switch to, the
linker will check that branch targets are code in the same ISA as the
branch.

Unfortunately our empty asm volatile statements don't qualify as code,
and the link for microMIPS builds fails with errors such as:

    arch/mips/mm/dma-default.s:3265: Error: branch to a symbol in another ISA mode
    arch/mips/mm/dma-default.s:5027: Error: branch to a symbol in another ISA mode

Resolve this by adding a .insn directive within the asm statement which
declares that what comes next is code. This may or may not be true,
since we don't really know what comes next, but as this code is in an
unreachable path anyway that doesn't matter since we won't execute it.

We do this in asm/compiler.h & select CONFIG_HAVE_ARCH_COMPILER_H in
order to have this included by linux/compiler_types.h after
linux/compiler-gcc.h. This will result in asm/compiler.h being included
in all C compilations via the -include linux/compiler_types.h argument
in c_flags, which should be harmless.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()")
Patchwork: https://patchwork.linux-mips.org/patch/20270/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/Kconfig                |  1 +
 arch/mips/include/asm/compiler.h | 35 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c82457b0e733..23e3d3e0ee5b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -29,6 +29,7 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select HANDLE_DOMAIN_IRQ
+	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
index e081a265f422..cc2eb1b06050 100644
--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -8,6 +8,41 @@
 #ifndef _ASM_COMPILER_H
 #define _ASM_COMPILER_H
 
+/*
+ * With GCC 4.5 onwards we can use __builtin_unreachable to indicate to the
+ * compiler that a particular code path will never be hit. This allows it to be
+ * optimised out of the generated binary.
+ *
+ * Unfortunately at least GCC 4.6.3 through 7.3.0 inclusive suffer from a bug
+ * that can lead to instructions from beyond an unreachable statement being
+ * incorrectly reordered into earlier delay slots if the unreachable statement
+ * is the only content of a case in a switch statement. This can lead to
+ * seemingly random behaviour, such as invalid memory accesses from incorrectly
+ * reordered loads or stores. See this potential GCC fix for details:
+ *
+ *   https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html
+ *
+ * It is unclear whether GCC 8 onwards suffer from the same issue - nothing
+ * relevant is mentioned in GCC 8 release notes and nothing obviously relevant
+ * stands out in GCC commit logs, but these newer GCC versions generate very
+ * different code for the testcase which doesn't exhibit the bug.
+ *
+ * GCC also handles stack allocation suboptimally when calling noreturn
+ * functions or calling __builtin_unreachable():
+ *
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365
+ *
+ * We work around both of these issues by placing a volatile asm statement,
+ * which GCC is prevented from reordering past, prior to __builtin_unreachable
+ * calls.
+ *
+ * The .insn statement is required to ensure that any branches to the
+ * statement, which sadly must be kept due to the asm statement, are known to
+ * be branches to code and satisfy linker requirements for microMIPS kernels.
+ */
+#undef barrier_before_unreachable
+#define barrier_before_unreachable() asm volatile(".insn")
+
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
 #define GCC_IMM_ASM() "n"
 #define GCC_REG_ACCUM "$0"
-- 
2.17.1
