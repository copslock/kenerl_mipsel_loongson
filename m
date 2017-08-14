Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 20:19:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42878 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993944AbdHNSTD7JE0p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 20:19:03 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 8AD148096665D;
        Mon, 14 Aug 2017 19:18:53 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 14 Aug 2017 19:18:56
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 1/8] MIPS: Introduce CPU_ISA_GE_* Kconfig entries
Date:   Mon, 14 Aug 2017 11:18:12 -0700
Message-ID: <20170814181819.7376-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170814181819.7376-1-paul.burton@imgtec.com>
References: <20170814181819.7376-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59571
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

Various entries in Kconfig depend upon the ISA that the kernel build is
targeting being greater than or equal to some revision. The way in which
we've handled that so far has been to OR the Kconfig entries for all
applicable ISAs or CPUs. This leads to us having lists in Kconfig which:

 - Require expansion when new architecture revisions are introduced.

 - Don't always clearly show what we actually depend upon.

 - Make it difficult for code, or board Kconfig fragments in a later
   patch, to depend upon a range of ISA revisions in a maintainable way.

This patch introduces new Kconfig entries which indicate that the ISA
being targeted is greater than or equal to a particular revision, which
allows us to express requirements on potentially open-ended ranges of
ISA revisions rather than only upon specific revisions.

For example, we currently express the dependency of hardware watchpoint
support on a MIPSr1 or higher ISA like so:

  default y if CPU_MIPSR1 || CPU_MIPSR2 || CPU_MIPSR6

With the new Kconfig entries introduced by this patch this can be
simplified to:

  default y if CPU_ISA_GE_R1

Which makes it clearer what the actual dependency is & won't require
extending if we add further architecture revisions in the future (so
long as they support hardware watchpoints).

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

Changes in v2:
- New patch.

 arch/mips/Kconfig | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 14ab86d7ea59..0f1c1adfbff3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2023,21 +2023,40 @@ config CPU_MIPS64
 config CPU_MIPSR1
 	bool
 	default y if CPU_MIPS32_R1 || CPU_MIPS64_R1
+	select CPU_ISA_GE_R1
 
 config CPU_MIPSR2
 	bool
 	default y if CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_CAVIUM_OCTEON
 	select CPU_HAS_RIXI
+	select CPU_ISA_GE_R2
 	select MIPS_SPRAM
 
 config CPU_MIPSR6
 	bool
 	default y if CPU_MIPS32_R6 || CPU_MIPS64_R6
 	select CPU_HAS_RIXI
+	select CPU_ISA_GE_R6
 	select HAVE_ARCH_BITREVERSE
 	select MIPS_ASID_BITS_VARIABLE
 	select MIPS_SPRAM
 
+#
+# The following CPU_ISA_GE_* entries indicate that the ISA we're targeting is
+# greater than or equal to the appropriate revision. They can be used to
+# require a particular range of ISA revisions.
+#
+config CPU_ISA_GE_R1
+	bool
+
+config CPU_ISA_GE_R2
+	bool
+	select CPU_ISA_GE_R1
+
+config CPU_ISA_GE_R6
+	bool
+	select CPU_ISA_GE_R2
+
 config EVA
 	bool
 
@@ -2062,14 +2081,14 @@ config CPU_SUPPORTS_UNCACHED_ACCELERATED
 	bool
 config MIPS_PGD_C0_CONTEXT
 	bool
-	default y if 64BIT && (CPU_MIPSR2 || CPU_MIPSR6) && !CPU_XLP
+	default y if 64BIT && CPU_ISA_GE_R2 && !CPU_XLP
 
 #
 # Set to y for ptrace access to watch registers.
 #
 config HARDWARE_WATCHPOINTS
        bool
-       default y if CPU_MIPSR1 || CPU_MIPSR2 || CPU_MIPSR6
+       default y if CPU_ISA_GE_R1
 
 menu "Kernel type"
 
@@ -2574,7 +2593,7 @@ config SYS_SUPPORTS_NUMA
 
 config RELOCATABLE
 	bool "Relocatable kernel"
-	depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 || CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6 || CAVIUM_OCTEON_SOC)
+	depends on SYS_SUPPORTS_RELOCATABLE && CPU_ISA_GE_R2
 	help
 	  This builds a kernel image that retains relocation information
 	  so it can be loaded someplace besides the default 1MB.
-- 
2.14.0
