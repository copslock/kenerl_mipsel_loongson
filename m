Return-Path: <SRS0=K/c0=Q7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14414C4360F
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 07:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F2520661
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 07:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbfBXHPL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 24 Feb 2019 02:15:11 -0500
Received: from smtpbgau1.qq.com ([54.206.16.166]:36456 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfBXHPL (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 24 Feb 2019 02:15:11 -0500
X-QQ-mid: bizesmtp3t1550992504t428kckql
Received: from localhost.localdomain (unknown [116.236.177.50])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 24 Feb 2019 15:14:58 +0800 (CST)
X-QQ-SSF: 01400000002000C0EF72B00A0000000
X-QQ-FEAT: LuumuPbnbyBJ06WUMXmgQOrl6VoQW1uEQvsGo6tg4N0U3CI2ms78M3nxYMnlC
        kH9dxEjcgONdFJ4uUiBBdSYeKSPFS7UbhQ494BcAOHTybwmvjvUW/HdUlYiJm+G/+7KuONw
        hDb38GufFkY8ezHmY3sMYFxqyz3Mq/Anq05STjjZ5DqmbJN3RQBAh6+/0qL0P5+eEcqVztf
        tN7/1OaOfE97mSab7huqVpadat9xEAjCjSMaz2ZttAiBf5qsHq2dp1rCcEMU85uBzhyHpry
        X+lLQz78jbEnZZKjR+acDVQL4SxBMQNYYQoQ==
X-QQ-GoodBg: 2
From:   Wang Xuerui <wangxuerui@qiniu.com>
To:     linux-mips@vger.kernel.org
Cc:     Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alex Belits <alex.belits@cavium.com>,
        James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 2/4] MIPS: refactor virtual address size selection
Date:   Sun, 24 Feb 2019 15:13:53 +0800
Message-Id: <20190224071355.14488-3-wangxuerui@qiniu.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20190224071355.14488-1-wangxuerui@qiniu.com>
References: <20190224071355.14488-1-wangxuerui@qiniu.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:qiniu.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

To facilitate future extensions of VA space, put all VA size selection
under a choice section, and add an entry corresponding to previous
default behavior.

Also, for sharing the implementation, rename the former MIPS_VA_BITS_48
symbol to MIPS_LARGE_VA, but re-use the name in the choice section for
config file compatibility.

Signed-off-by: Wang Xuerui <wangxuerui@qiniu.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Alex Belits <alex.belits@cavium.com>
Cc: James Hogan <james.hogan@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig                  | 28 ++++++++++++++++++++++++----
 arch/mips/include/asm/pgtable-64.h | 10 +++++-----
 arch/mips/include/asm/processor.h  |  2 +-
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a84c24d894aa..b0068a1e1e33 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2158,12 +2158,27 @@ config KVM_GUEST_TIMER_FREQ
 	  emulation when determining guest CPU Frequency. Instead, the guest's
 	  timer frequency is specified directly.
 
+choice
+	prompt "Virtual address size"
+	default MIPS_VA_BITS_DEFAULT
+
+config MIPS_VA_BITS_DEFAULT
+	bool "40 bits or less virtual memory"
+	help
+	  This is the default setting on MIPS platforms since antiquity,
+	  which gives 40 bits or less of virtual address space, depending on
+	  the CPU.
+
+	  If unsure, say Y.
+
 config MIPS_VA_BITS_48
 	bool "48 bits virtual memory"
 	depends on 64BIT
+	select MIPS_LARGE_VA
 	help
 	  Support a maximum at least 48 bits of application virtual
-	  memory.  Default is 40 bits or less, depending on the CPU.
+	  memory.
+
 	  For page sizes 16k and above, this option results in a small
 	  memory overhead for page tables.  For 4k page size, a fourth
 	  level of page tables is added which imposes both a memory
@@ -2171,6 +2186,11 @@ config MIPS_VA_BITS_48
 
 	  If unsure, say N.
 
+endchoice
+
+config MIPS_LARGE_VA
+	bool
+
 choice
 	prompt "Kernel page size"
 	default PAGE_SIZE_4KB
@@ -2187,7 +2207,7 @@ config PAGE_SIZE_4KB
 config PAGE_SIZE_8KB
 	bool "8kB"
 	depends on CPU_R8000 || CPU_CAVIUM_OCTEON
-	depends on !MIPS_VA_BITS_48
+	depends on !MIPS_LARGE_VA
 	help
 	  Using 8kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available
@@ -2206,7 +2226,7 @@ config PAGE_SIZE_16KB
 config PAGE_SIZE_32KB
 	bool "32kB"
 	depends on CPU_CAVIUM_OCTEON
-	depends on !MIPS_VA_BITS_48
+	depends on !MIPS_LARGE_VA
 	help
 	  Using 32kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available
@@ -3070,7 +3090,7 @@ config HAVE_LATENCYTOP_SUPPORT
 
 config PGTABLE_LEVELS
 	int
-	default 4 if PAGE_SIZE_4KB && MIPS_VA_BITS_48
+	default 4 if PAGE_SIZE_4KB && MIPS_LARGE_VA
 	default 3 if 64BIT && !PAGE_SIZE_64KB
 	default 2
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 93a9dce31f25..77a71be71b51 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -18,9 +18,9 @@
 #include <asm/fixmap.h>
 
 #define __ARCH_USE_5LEVEL_HACK
-#if defined(CONFIG_PAGE_SIZE_64KB) && !defined(CONFIG_MIPS_VA_BITS_48)
+#if defined(CONFIG_PAGE_SIZE_64KB) && !defined(CONFIG_MIPS_LARGE_VA)
 #include <asm-generic/pgtable-nopmd.h>
-#elif !(defined(CONFIG_PAGE_SIZE_4KB) && defined(CONFIG_MIPS_VA_BITS_48))
+#elif !(defined(CONFIG_PAGE_SIZE_4KB) && defined(CONFIG_MIPS_LARGE_VA))
 #include <asm-generic/pgtable-nopud.h>
 #endif
 
@@ -83,7 +83,7 @@
  * of virtual address space.
  */
 #ifdef CONFIG_PAGE_SIZE_4KB
-# ifdef CONFIG_MIPS_VA_BITS_48
+# ifdef CONFIG_MIPS_LARGE_VA
 #  define PGD_ORDER		0
 #  define PUD_ORDER		0
 # else
@@ -100,7 +100,7 @@
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_16KB
-#ifdef CONFIG_MIPS_VA_BITS_48
+#ifdef CONFIG_MIPS_LARGE_VA
 #define PGD_ORDER               1
 #else
 #define PGD_ORDER               0
@@ -118,7 +118,7 @@
 #ifdef CONFIG_PAGE_SIZE_64KB
 #define PGD_ORDER		0
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
-#ifdef CONFIG_MIPS_VA_BITS_48
+#ifdef CONFIG_MIPS_LARGE_VA
 #define PMD_ORDER		0
 #else
 #define PMD_ORDER		aieeee_attempt_to_allocate_pmd
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index c50cba85d145..226cf46cc89c 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -62,7 +62,7 @@ extern unsigned int vced_count, vcei_count;
  * 8192EB ...
  */
 #define TASK_SIZE32	0x7fff8000UL
-#ifdef CONFIG_MIPS_VA_BITS_48
+#ifdef CONFIG_MIPS_LARGE_VA
 #define TASK_SIZE64     (0x1UL << min(cpu_data[0].vmbits, 48))
 #else
 #define TASK_SIZE64     0x10000000000UL
-- 
2.16.1



