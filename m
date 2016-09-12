Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 11:59:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28689 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992100AbcILJ7CLt66v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Sep 2016 11:59:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B0ECAEC28C2C;
        Mon, 12 Sep 2016 10:58:42 +0100 (IST)
Received: from localhost (10.100.200.12) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 12 Sep
 2016 10:58:45 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "stable # v4 . 4+" <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Remove compact branch policy Kconfig entries
Date:   Mon, 12 Sep 2016 10:58:06 +0100
Message-ID: <20160912095806.4411-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.12]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55101
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

Commit c1a0e9bc885d ("MIPS: Allow compact branch policy to be changed")
added Kconfig entries allowing for the compact branch policy used by the
compiler for MIPSr6 kernels to be specified. This can be useful for
debugging, particularly in systems where compact branches have recently
been introduced.

Unfortunately mainline gcc 5.x supports MIPSr6 but not the
-mcompact-branches compiler flag, leading to MIPSr6 kernels failing to
build with gcc 5.x with errors such as:

  mipsel-linux-gnu-gcc: error: unrecognized command line option '-mcompact-branches=optimal'
  make[2]: *** [kernel/bounds.s] Error 1

Fixing this by hiding the Kconfig entry behind another seems to be more
hassle than it's worth, as MIPSr6 & compact branches have been around
for a while now and if policy does need to be set for debug it can be
done easily enough with KCFLAGS. Therefore remove the compact branch
policy Kconfig entries & their handling in the Makefile.

This reverts commit c1a0e9bc885d ("MIPS: Allow compact branch policy to
be changed").

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: c1a0e9bc885d ("MIPS: Allow compact branch policy to be changed")
Cc: stable <stable@vger.kernel.org> # v4.4+
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
---
Patches 13275[1] & 13276[2] seem to have gone nowhere, so this is a
simple alternative.

Ralf: if you're OK with this could we get it in ASAP, perhaps for v4.8?

[1] https://patchwork.linux-mips.org/patch/13275/
[2] https://patchwork.linux-mips.org/patch/13276/
---
 arch/mips/Kconfig.debug | 36 ------------------------------------
 arch/mips/Makefile      |  4 ----
 2 files changed, 40 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 94cb034..c6bfcb6 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -113,42 +113,6 @@ config SPINLOCK_TEST
 	help
 	  Add several files to the debugfs to test spinlock speed.
 
-if CPU_MIPSR6
-
-choice
-	prompt "Compact branch policy"
-	default MIPS_COMPACT_BRANCHES_OPTIMAL
-
-config MIPS_COMPACT_BRANCHES_NEVER
-	bool "Never (force delay slot branches)"
-	help
-	  Pass the -mcompact-branches=never flag to the compiler in order to
-	  force it to always emit branches with delay slots, and make no use
-	  of the compact branch instructions introduced by MIPSr6. This is
-	  useful if you suspect there may be an issue with compact branches in
-	  either the compiler or the CPU.
-
-config MIPS_COMPACT_BRANCHES_OPTIMAL
-	bool "Optimal (use where beneficial)"
-	help
-	  Pass the -mcompact-branches=optimal flag to the compiler in order for
-	  it to make use of compact branch instructions where it deems them
-	  beneficial, and use branches with delay slots elsewhere. This is the
-	  default compiler behaviour, and should be used unless you have a
-	  reason to choose otherwise.
-
-config MIPS_COMPACT_BRANCHES_ALWAYS
-	bool "Always (force compact branches)"
-	help
-	  Pass the -mcompact-branches=always flag to the compiler in order to
-	  force it to always emit compact branches, making no use of branch
-	  instructions with delay slots. This can result in more compact code
-	  which may be beneficial in some scenarios.
-
-endchoice
-
-endif # CPU_MIPSR6
-
 config SCACHE_DEBUGFS
 	bool "L2 cache debugfs entries"
 	depends on DEBUG_FS
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 4921b08..8a30b05 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -205,10 +205,6 @@ cflags-$(toolchain-virt)		+= -DTOOLCHAIN_SUPPORTS_VIRT
 toolchain-xpa				:= $(call cc-option-yn,$(mips-cflags) -mxpa)
 cflags-$(toolchain-virt)		+= -DTOOLCHAIN_SUPPORTS_XPA
 
-cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_NEVER)	+= -mcompact-branches=never
-cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_OPTIMAL)	+= -mcompact-branches=optimal
-cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_ALWAYS)	+= -mcompact-branches=always
-
 #
 # Firmware support
 #
-- 
2.9.3
