Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2018 19:53:20 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992934AbeKBSxJI1iyP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Nov 2018 19:53:09 +0100
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB9520848;
        Fri,  2 Nov 2018 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184788;
        bh=UnStb8iSjgMhmvGho6Kd013wBhCng5A2W8hpvXIHyIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vF2RtogERt7pST935hlR9O9Zmjlhb688Ak5QVmkN137DOKPUDWbAMrQ482btYnqNR
         RDEKIja+OcZSMCtlZ21ZKKx399l1gEKbQyx2LGy6zpQV56CbxB51kpRyfQ2t1wx+xO
         o4FYlmJD58xs+H4GadXTSnGmV6QnIlcWCzIVWkPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 096/143] compiler.h: Allow arch-specific asm/compiler.h
Date:   Fri,  2 Nov 2018 19:34:41 +0100
Message-Id: <20181102182905.564377295@linuxfoundation.org>
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
X-archive-position: 67055
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

[ Upstream commit 04f264d3a8b0eb25d378127bd78c3c9a0261c828 ]

We have a need to override the definition of
barrier_before_unreachable() for MIPS, which means we either need to add
architecture-specific code into linux/compiler-gcc.h or we need to allow
the architecture to provide a header that can define the macro before
the generic definition. The latter seems like the better approach.

A straightforward approach to the per-arch header is to make use of
asm-generic to provide a default empty header & adjust architectures
which don't need anything specific to make use of that by adding the
header to generic-y. Unfortunately this doesn't work so well due to
commit 28128c61e08e ("kconfig.h: Include compiler types to avoid missed
struct attributes") which caused linux/compiler_types.h to be included
in the compilation of every C file via the -include linux/kconfig.h flag
in c_flags.

Because the -include flag is present for all C files we compile, we need
the architecture-provided header to be present before any C files are
compiled. If any C files can be compiled prior to the asm-generic header
wrappers being generated then we hit a build failure due to missing
header. Such cases do exist - one pointed out by the kbuild test robot
is the compilation of arch/ia64/kernel/nr-irqs.c, which occurs as part
of the archprepare target [1].

This leaves us with a few options:

  1) Use generic-y & fix any build failures we find by enforcing
     ordering such that the asm-generic target occurs before any C
     compilation, such that linux/compiler_types.h can always include
     the generated asm-generic wrapper which in turn includes the empty
     asm-generic header. This would rely on us finding all the
     problematic cases - I don't know for sure that the ia64 issue is
     the only one.

  2) Add an actual empty header to each architecture, so that we don't
     need the generated asm-generic wrapper. This seems messy.

  3) Give up & add #ifdef CONFIG_MIPS or similar to
     linux/compiler_types.h. This seems messy too.

  4) Include the arch header only when it's actually needed, removing
     the need for the asm-generic wrapper for all other architectures.

This patch allows us to use approach 4, by including an asm/compiler.h
header from linux/compiler_types.h after the inclusion of the
compiler-specific linux/compiler-*.h header(s). We do this
conditionally, only when CONFIG_HAVE_ARCH_COMPILER_H is selected, in
order to avoid the need for asm-generic wrappers & the associated build
ordering issue described above. The asm/compiler.h header is included
after the generic linux/compiler-*.h header(s) for consistency with the
way linux/compiler-intel.h & linux/compiler-clang.h are included after
the linux/compiler-gcc.h header that they override.

[1] https://lists.01.org/pipermail/kbuild-all/2018-August/051175.html

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Patchwork: https://patchwork.linux-mips.org/patch/20269/
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/Kconfig                   |  8 ++++++++
 include/linux/compiler_types.h | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 40dc31fea90c..77b3e21c4844 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -965,4 +965,12 @@ config REFCOUNT_FULL
 	  against various use-after-free conditions that can be used in
 	  security flaw exploits.
 
+config HAVE_ARCH_COMPILER_H
+	bool
+	help
+	  An architecture can select this if it provides an
+	  asm/compiler.h header that should be included after
+	  linux/compiler-*.h in order to override macro definitions that those
+	  headers generally provide.
+
 source "kernel/gcov/Kconfig"
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6b79a9bba9a7..4be464a07612 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -78,6 +78,18 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 #include <linux/compiler-clang.h>
 #endif
 
+/*
+ * Some architectures need to provide custom definitions of macros provided
+ * by linux/compiler-*.h, and can do so using asm/compiler.h. We include that
+ * conditionally rather than using an asm-generic wrapper in order to avoid
+ * build failures if any C compilation, which will include this file via an
+ * -include argument in c_flags, occurs prior to the asm-generic wrappers being
+ * generated.
+ */
+#ifdef CONFIG_HAVE_ARCH_COMPILER_H
+#include <asm/compiler.h>
+#endif
+
 /*
  * Generic compiler-dependent macros required for kernel
  * build go below this comment. Actual compiler/compiler version
-- 
2.17.1
