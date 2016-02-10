Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 10:22:02 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47676 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010846AbcBJJV0uRqp6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 10:21:26 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id 831DD5CD3D;
        Wed, 10 Feb 2016 10:04:25 +0100 (CET)
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v4 2/2] mips: Differentiate between 32 and 64 bit ELF header
Date:   Wed, 10 Feb 2016 10:21:21 +0100
Message-Id: <1455096081-7176-3-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1455096081-7176-1-git-send-email-daniel.wagner@bmw-carit.de>
References: <56BAD881.9000208@bmw-carit.de>
 <1455096081-7176-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51967
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
elf_check_arch() is defined. parse_crash_elf{32|64}_headers() does
some basic verification of the ELF header via
vmcore_elf{32|64}_check_arch() which happen to map to elf_check_arch().
Since the implementation 32 and 64 bit version of elf_check_arch()
differ, we use the wrong type:

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

Therefore, we rather define vmcore_elf{32|64}_check_arch() as a
basic machine check and use it also in binfm_elf?32.c as well.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Suggested-by: Maciej W. Rozycki <macro@imgtec.com>
Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
 arch/mips/include/asm/elf.h      | 9 +++++++--
 arch/mips/kernel/binfmt_elfn32.c | 2 +-
 arch/mips/kernel/binfmt_elfo32.c | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index cefb7a5..e090fc3 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -227,7 +227,7 @@ struct mips_elf_abiflags_v0 {
 	int __res = 1;							\
 	struct elfhdr *__h = (hdr);					\
 									\
-	if (__h->e_machine != EM_MIPS)					\
+	if (!mips_elf_check_machine(__h))				\
 		__res = 0;						\
 	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
 		__res = 0;						\
@@ -258,7 +258,7 @@ struct mips_elf_abiflags_v0 {
 	int __res = 1;							\
 	struct elfhdr *__h = (hdr);					\
 									\
-	if (__h->e_machine != EM_MIPS)					\
+	if (!mips_elf_check_machine(__h))				\
 		__res = 0;						\
 	if (__h->e_ident[EI_CLASS] != ELFCLASS64)			\
 		__res = 0;						\
@@ -285,6 +285,11 @@ struct mips_elf_abiflags_v0 {
 
 #endif /* !defined(ELF_ARCH) */
 
+#define mips_elf_check_machine(x) ((x)->e_machine == EM_MIPS)
+
+#define vmcore_elf32_check_arch mips_elf_check_machine
+#define vmcore_elf64_check_arch mips_elf_check_machine
+
 struct mips_abi;
 
 extern struct mips_abi mips_abi;
diff --git a/arch/mips/kernel/binfmt_elfn32.c b/arch/mips/kernel/binfmt_elfn32.c
index 1188e00..1b992c6 100644
--- a/arch/mips/kernel/binfmt_elfn32.c
+++ b/arch/mips/kernel/binfmt_elfn32.c
@@ -35,7 +35,7 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 	int __res = 1;							\
 	struct elfhdr *__h = (hdr);					\
 									\
-	if (__h->e_machine != EM_MIPS)					\
+	if (!mips_elf_check_machine(__h))				\
 		__res = 0;						\
 	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
 		__res = 0;						\
diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
index 9287678..abd3aff 100644
--- a/arch/mips/kernel/binfmt_elfo32.c
+++ b/arch/mips/kernel/binfmt_elfo32.c
@@ -47,7 +47,7 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 	int __res = 1;							\
 	struct elfhdr *__h = (hdr);					\
 									\
-	if (__h->e_machine != EM_MIPS)					\
+	if (!mips_elf_check_machine(__h))				\
 		__res = 0;						\
 	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
 		__res = 0;						\
-- 
2.5.0
