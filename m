Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2016 18:33:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4284 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993297AbcKXRc5r-WS2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Nov 2016 18:32:57 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EA0BF82CC1663;
        Thu, 24 Nov 2016 17:32:47 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 24 Nov 2016 17:32:51 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <kernel-hardening@lists.openwall.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        Daniel Cashman <dcashman@android.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MIPS: Add support for ARCH_MMAP_RND_{COMPAT_}BITS
Date:   Thu, 24 Nov 2016 17:32:45 +0000
Message-ID: <1480008765-3876-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

arch_mmap_rnd() uses hard-coded limits of 16MB for the randomisation
of mmap within 32bit processes and 256MB in 64bit processes. Since v4.4
other arches support tuning this value in /proc/sys/vm/mmap_rnd_bits.
Add support for this to MIPS.

Set the minimum(default) number of bits randomisation for 32bit to 8 -
which with 4k pagesize is unchanged from the current 16MB total
randomness. The minimum(default) for 64bit is 12bits, again with 4k
pagesize this is the same as the current 256MB.

This patch is necessary for MIPS32 to pass the Android CTS tests, with
the number of random bits set to 15.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/Kconfig   | 16 ++++++++++++++++
 arch/mips/mm/mmap.c | 10 +++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde43d34..d72cf6129b2c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -13,6 +13,8 @@ config MIPS
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if MMU && COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT if !CPU_MICROMIPS
@@ -3073,6 +3075,20 @@ config MMU
 	bool
 	default y
 
+config ARCH_MMAP_RND_BITS_MIN
+	default 12 if 64BIT
+	default 8
+
+config ARCH_MMAP_RND_BITS_MAX
+	default 18 if 64BIT
+	default 15
+
+config ARCH_MMAP_RND_COMPAT_BITS_MIN
+       default 8
+
+config ARCH_MMAP_RND_COMPAT_BITS_MAX
+       default 15
+
 config I8253
 	bool
 	select CLKSRC_I8253
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index d08ea3ff0f53..d6d92c02308d 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -146,14 +146,14 @@ unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
-	rnd = get_random_long();
-	rnd <<= PAGE_SHIFT;
+#ifdef CONFIG_COMPAT
 	if (TASK_IS_32BIT_ADDR)
-		rnd &= 0xfffffful;
+		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
 	else
-		rnd &= 0xffffffful;
+#endif /* CONFIG_COMPAT */
+		rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
 
-	return rnd;
+	return rnd << PAGE_SHIFT;
 }
 
 void arch_pick_mmap_layout(struct mm_struct *mm)
-- 
2.7.4
