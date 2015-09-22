Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:08:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30768 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008556AbbIVRIFQc0fr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:08:05 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C8E86782BD92;
        Tue, 22 Sep 2015 18:07:55 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:07:59 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:07:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: allow compact branch policy to be changed
Date:   Tue, 22 Sep 2015 10:07:41 -0700
Message-ID: <1442941661-31539-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49274
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

When debugging it can be helpful to change the policy for compiler use
of MIPSr6 compact branches, in order to rule out or home in on their
involvement in bugs. Allow the GCC -mcompact-branches= flag to be set
via Kconfig under the "Kernel hacking" menu.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig.debug | 36 ++++++++++++++++++++++++++++++++++++
 arch/mips/Makefile      |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index e250524..13d7965 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -113,4 +113,40 @@ config SPINLOCK_TEST
 	help
 	  Add several files to the debugfs to test spinlock speed.
 
+if CPU_MIPSR6
+
+choice
+	prompt "Compact branch policy"
+	default MIPS_COMPACT_BRANCHES_OPTIMAL
+
+config MIPS_COMPACT_BRANCHES_NEVER
+	bool "Never (force delay slot branches)"
+	help
+	  Pass the -mcompact-branches=never flag to the compiler in order to
+	  force it to always emit branches with delay slots, and make no use
+	  of the compact branch instructions introduced by MIPSr6. This is
+	  useful if you suspect there may be an issue with compact branches in
+	  either the compiler or the CPU.
+
+config MIPS_COMPACT_BRANCHES_OPTIMAL
+	bool "Optimal (use where beneficial)"
+	help
+	  Pass the -mcompact-branches=optimal flag to the compiler in order for
+	  it to make use of compact branch instructions where it deems them
+	  beneficial, and use branches with delay slots elsewhere. This is the
+	  default compiler behaviour, and should be used unless you have a
+	  reason to choose otherwise.
+
+config MIPS_COMPACT_BRANCHES_ALWAYS
+	bool "Always (force compact branches)"
+	help
+	  Pass the -mcompact-branches=always flag to the compiler in order to
+	  force it to always emit compact branches, making no use of branch
+	  instructions with delay slots. This can result in more compact code
+	  which may be beneficial in some scenarios.
+
+endchoice
+
+endif # CPU_MIPSR6
+
 endmenu
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 252e347..3f70ba5 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -204,6 +204,10 @@ toolchain-msa				:= $(call cc-option-yn,$(mips-cflags) -mhard-float -mfp64 -Wa$(
 cflags-$(toolchain-msa)			+= -DTOOLCHAIN_SUPPORTS_MSA
 endif
 
+cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_NEVER)	+= -mcompact-branches=never
+cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_OPTIMAL)	+= -mcompact-branches=optimal
+cflags-$(CONFIG_MIPS_COMPACT_BRANCHES_ALWAYS)	+= -mcompact-branches=always
+
 #
 # Firmware support
 #
-- 
2.5.3
