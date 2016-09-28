Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2016 11:09:42 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:46407 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990519AbcI1JJen0jzG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2016 11:09:34 +0200
Received: from localhost (unknown [89.202.203.52])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B758E8A6;
        Wed, 28 Sep 2016 09:09:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 64/73] MIPS: Remove compact branch policy Kconfig entries
Date:   Wed, 28 Sep 2016 11:05:34 +0200
Message-Id: <20160928090438.487342314@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160928090434.509091655@linuxfoundation.org>
References: <20160928090434.509091655@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55273
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit b03c1e3b8eed9026733c473071d1f528358a0e50 upstream.

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
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14241/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig.debug |   36 ------------------------------------
 arch/mips/Makefile      |    4 ----
 2 files changed, 40 deletions(-)

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
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -204,10 +204,6 @@ toolchain-msa				:= $(call cc-option-yn,
 cflags-$(toolchain-msa)			+= -DTOOLCHAIN_SUPPORTS_MSA
 endif
 
-cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_NEVER)	+= -mcompact-branches=never
-cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_OPTIMAL)	+= -mcompact-branches=optimal
-cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_ALWAYS)	+= -mcompact-branches=always
-
 #
 # Firmware support
 #
