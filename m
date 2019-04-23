Return-Path: <SRS0=+ZmA=SZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C79C282DD
	for <linux-mips@archiver.kernel.org>; Tue, 23 Apr 2019 03:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B1D21738
	for <linux-mips@archiver.kernel.org>; Tue, 23 Apr 2019 03:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mCn02M/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfDWDXG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:23:06 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:58021 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbfDWDW6 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 22 Apr 2019 23:22:58 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x3N3L8LL031384;
        Tue, 23 Apr 2019 12:21:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x3N3L8LL031384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555989680;
        bh=YGW0gg01jtKnXbnK1Ap0mVZ9GqJOY8DcvskWgXT4tQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCn02M/+Zs1tTrnfj5kcK/rIXu8Qjzpou6KA7O8+YMQxaTRIOmJiYSdn1yiI2naKt
         MOHV0re8MJvGrURubZ52FRJWYB8BKJDCHdtm0+gi/mtbUq5QKLWZPGOju5xSwUZcWl
         v62g+gXthE8J+NAD4NPy45+MxSmZ7tonTDzlWDzHGQzYMmZaYvOa54z3WQuT8Zuufn
         RRLTWAFT4J9sYGariQ0SfM01A/+8PRgOu0jsL4gPe489CoMR6D8YJvBgVXCuHjnXp7
         ss+JT31y4kchSzLW7k/zDncSQUjZSSKhKjjg3CKu47It7stLcp72/4twqXDWyaFFPZ
         vwoBCpY9sZvjQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 10/10] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Date:   Tue, 23 Apr 2019 12:21:06 +0900
Message-Id: <20190423032106.11960-11-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423032106.11960-1-yamada.masahiro@socionext.com>
References: <20190423032106.11960-1-yamada.masahiro@socionext.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.

The idea is obviously arch-agnostic. This commit moves the config
entry from arch/x86/Kconfig.debug to lib/Kconfig.debug so that all
architectures can benefit from it.

This can make a huge difference in kernel image size especially when
CONFIG_OPTIMIZE_FOR_SIZE is enabled.

For example, I got 3.5% smaller arm64 kernel for v5.1-rc1.

  dec       file
  18983424  arch/arm64/boot/Image.before
  18321920  arch/arm64/boot/Image.after

This also slightly improves the "Kernel hacking" Kconfig menu as
e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen') suggested;
this config option would be a good fit in the "compiler option" menu.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Borislav Petkov <bp@suse.de>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/x86/Kconfig               |  3 ---
 arch/x86/Kconfig.debug         | 14 --------------
 include/linux/compiler_types.h |  3 +--
 lib/Kconfig.debug              | 14 ++++++++++++++
 4 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 62fc3fda1a05..f214bb5d60d8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -310,9 +310,6 @@ config ZONE_DMA32
 config AUDIT_ARCH
 	def_bool y if X86_64
 
-config ARCH_SUPPORTS_OPTIMIZED_INLINING
-	def_bool y
-
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y
 
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 15d0fbe27872..f730680dc818 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -266,20 +266,6 @@ config CPA_DEBUG
 	---help---
 	  Do change_page_attr() self-tests every 30 seconds.
 
-config OPTIMIZE_INLINING
-	bool "Allow gcc to uninline functions marked 'inline'"
-	---help---
-	  This option determines if the kernel forces gcc to inline the functions
-	  developers have marked 'inline'. Doing so takes away freedom from gcc to
-	  do what it thinks is best, which is desirable for the gcc 3.x series of
-	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
-	  enabling this option will generate a smaller kernel there. Hopefully
-	  this algorithm is so good that allowing gcc 4.x and above to make the
-	  decision will become the default in the future. Until then this option
-	  is there to test gcc for this.
-
-	  If unsure, say N.
-
 config DEBUG_ENTRY
 	bool "Debug low-level entry code"
 	depends on DEBUG_KERNEL
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index ba814f18cb4c..19e58b9138a0 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -140,8 +140,7 @@ struct ftrace_likely_data {
  * Do not use __always_inline here, since currently it expands to inline again
  * (which would break users of __always_inline).
  */
-#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
-	!defined(CONFIG_OPTIMIZE_INLINING)
+#if !defined(CONFIG_OPTIMIZE_INLINING)
 #define inline inline __attribute__((__always_inline__)) __gnu_inline \
 	__maybe_unused notrace
 #else
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 00dbcdbc9a0d..37402f210115 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -310,6 +310,20 @@ config HEADERS_CHECK
 	  exported to $(INSTALL_HDR_PATH) (usually 'usr/include' in
 	  your build tree), to make sure they're suitable.
 
+config OPTIMIZE_INLINING
+	bool "Allow compiler to uninline functions marked 'inline'"
+	help
+	  This option determines if the kernel forces gcc to inline the functions
+	  developers have marked 'inline'. Doing so takes away freedom from gcc to
+	  do what it thinks is best, which is desirable for the gcc 3.x series of
+	  compilers. The gcc 4.x series have a rewritten inlining algorithm and
+	  enabling this option will generate a smaller kernel there. Hopefully
+	  this algorithm is so good that allowing gcc 4.x and above to make the
+	  decision will become the default in the future. Until then this option
+	  is there to test gcc for this.
+
+	  If unsure, say N.
+
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	help
-- 
2.17.1

