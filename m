Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 14:29:02 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47513 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009864AbcA2N3BAv3rr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 14:29:01 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id 5CE8259CE6;
        Fri, 29 Jan 2016 14:12:54 +0100 (CET)
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH] MIPS: Differentiate between 32 and 64 bit ELF header
Date:   Fri, 29 Jan 2016 14:28:57 +0100
Message-Id: <1454074137-16334-1-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1453992270-4688-1-git-send-email-daniel.wagner@bmw-carit.de>
References: <1453992270-4688-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

Depending on the configuration either the 32 or 64 bit version of
elf_check_arch() is defined. parse_crash_elf32_headers() does
some basic verification of the ELF header via elf_check_arch().
parse_crash_elf64_headers() does it via vmcore_elf64_check_arch()
which expands to the same elf_check_check().

   In file included from include/linux/elf.h:4:0,
                    from fs/proc/vmcore.c:13:
   fs/proc/vmcore.c: In function 'parse_crash_elf64_headers':
>> arch/mips/include/asm/elf.h:228:23: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     struct elfhdr *__h = (hdr);     \
                          ^
   include/linux/crash_dump.h:41:37: note: in expansion of macro 'elf_check_arch'
    #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
                                        ^
   fs/proc/vmcore.c:1015:4: note: in expansion of macro 'vmcore_elf64_check_arch'
      !vmcore_elf64_check_arch(&ehdr) ||
       ^

Since the MIPS ELF header for 32 bit and 64 bit differ we need
to check accordingly.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
Hi,

In the 'simple wait queue support' series is a patch
which turns on -Werror=incompatible-pointer-types which will
result in a compile error for MIPS.

https://lkml.org/lkml/2016/1/28/462

I am not completely sure if this is the right approach but I could
get rid of the errors by this.

I'll prepend this patch to the next version of the series in order
to see if I got rid of all incompatible pointer types errors caught
by the kbuild test robot.

cheers,
daniel


arch/mips/include/asm/elf.h | 68 ++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index cefb7a5..7ba0a47 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -205,27 +205,10 @@ struct mips_elf_abiflags_v0 {
 #define MIPS_ABI_FP_64		6	/* -mips32r2 -mfp64 */
 #define MIPS_ABI_FP_64A		7	/* -mips32r2 -mfp64 -mno-odd-spreg */
 
-#ifdef CONFIG_32BIT
-
-/*
- * In order to be sure that we don't attempt to execute an O32 binary which
- * requires 64 bit FP (FR=1) on a system which does not support it we refuse
- * to execute any binary which has bits specified by the following macro set
- * in its ELF header flags.
- */
-#ifdef CONFIG_MIPS_O32_FP64_SUPPORT
-# define __MIPS_O32_FP64_MUST_BE_ZERO	0
-#else
-# define __MIPS_O32_FP64_MUST_BE_ZERO	EF_MIPS_FP64
-#endif
-
-/*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(hdr)						\
+#define elf_check_arch_32(hdr)						\
 ({									\
 	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
+	Elf32_Ehdr *__h = (hdr);					\
 									\
 	if (__h->e_machine != EM_MIPS)					\
 		__res = 0;						\
@@ -242,6 +225,40 @@ struct mips_elf_abiflags_v0 {
 	__res;								\
 })
 
+#define elf_check_arch_64(hdr)						\
+({									\
+	int __res = 1;							\
+	Elf64_Ehdr *__h = (hdr);					\
+									\
+	if (__h->e_machine != EM_MIPS)					\
+		__res = 0;						\
+	if (__h->e_ident[EI_CLASS] != ELFCLASS64)			\
+		__res = 0;						\
+									\
+	__res;								\
+})
+
+#define vmcore_elf64_check_arch(x)	(elf_check_arch_64(x) || vmcore_elf_check_arch_cross(x))
+
+#ifdef CONFIG_32BIT
+
+/*
+ * In order to be sure that we don't attempt to execute an O32 binary which
+ * requires 64 bit FP (FR=1) on a system which does not support it we refuse
+ * to execute any binary which has bits specified by the following macro set
+ * in its ELF header flags.
+ */
+#ifdef CONFIG_MIPS_O32_FP64_SUPPORT
+# define __MIPS_O32_FP64_MUST_BE_ZERO	0
+#else
+# define __MIPS_O32_FP64_MUST_BE_ZERO	EF_MIPS_FP64
+#endif
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x)	elf_check_arch_32(x)
+
 /*
  * These are used to set parameters in the core dumps.
  */
@@ -253,18 +270,7 @@ struct mips_elf_abiflags_v0 {
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(hdr)						\
-({									\
-	int __res = 1;							\
-	struct elfhdr *__h = (hdr);					\
-									\
-	if (__h->e_machine != EM_MIPS)					\
-		__res = 0;						\
-	if (__h->e_ident[EI_CLASS] != ELFCLASS64)			\
-		__res = 0;						\
-									\
-	__res;								\
-})
+#define elf_check_arch(x)	elf_check_arch_64(x)
 
 /*
  * These are used to set parameters in the core dumps.
-- 
2.5.0
