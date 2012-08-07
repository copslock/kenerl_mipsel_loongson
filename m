Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2012 11:44:13 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:42962 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903480Ab2HGJoI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2012 11:44:08 +0200
Received: by bkcji2 with SMTP id ji2so1568421bkc.36
        for <multiple recipients>; Tue, 07 Aug 2012 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xSAW1qWcWKSLDqIrei0Jw7XHN08ya20FcyossrIFix4=;
        b=CGc+Tm2tepU0BqavorXgfFwgrMyuVgvR/XJqMqnkbbG/WshRvThH1gQeXLPj0X1BC4
         RHL2G9teDTd2bSBWXX8uFRs8KLCrWgALTgIs3oBhkchF9rlALg9cs8yCn3/nlI/rNaUm
         c0DODJgcd8eu5nKwXnV41p4AOjM/riPtjUqqQWCfZz5ZFGnsu3PcHrgmk977mLjPZDM2
         r5GSlFDVQrW6yjG8Nir9IwlKKtjLDH0xabQ7YPOJm2OKOZ3LtOSWkP7EJN+wT5VI/kyg
         Z1rOJaHJOIaeUvbbKD5yGT8vn1eRNswofJMjFFbHW1t9re9tJdDrlmCo1Ly15V0KgFzp
         SCJA==
Received: by 10.204.15.199 with SMTP id l7mr5555209bka.51.1344332642663;
        Tue, 07 Aug 2012 02:44:02 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-017-121.pools.arcor-ip.net. [88.73.17.121])
        by mx.google.com with ESMTPS id hg13sm8534076bkc.7.2012.08.07.02.44.00
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Aug 2012 02:44:01 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: fix module.c build for 32 bit
Date:   Tue,  7 Aug 2012 11:41:13 +0200
Message-Id: <1344332473-19842-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 34067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Fixes the following build failure introduced by "Make most arch
asm/module.h files use asm-generic/module.h".

  CC      arch/mips/kernel/module.o
arch/mips/kernel/module.c:250:14: error: 'reloc_handlers_rela' defined but not used [-Werror=unused-variable]
cc1: all warnings being treated as errors

make[6]: *** [arch/mips/kernel/module.o] Error 1

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

---
I don't mind this patch being squashed into the original patch. The
patch isn't in any stable git yet, so I assume any git id would be
outdated soon anyway.

Linus, I CC'd you because there already is a pending pull request for
this patch.

David, it would have been nice if the mentioned patch had made it to 
linux-mips. I just caught this more or less by accident by building
linux-next.

 arch/mips/kernel/module.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 1500c80..afbd717 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -65,12 +65,14 @@ static int apply_r_mips_32_rel(struct module *me, u32 *location, Elf_Addr v)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES_USE_ELF_RELA
 static int apply_r_mips_32_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	*location = v;
 
 	return 0;
 }
+#endif
 
 static int apply_r_mips_26_rel(struct module *me, u32 *location, Elf_Addr v)
 {
@@ -93,6 +95,7 @@ static int apply_r_mips_26_rel(struct module *me, u32 *location, Elf_Addr v)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES_USE_ELF_RELA
 static int apply_r_mips_26_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	if (v % 4) {
@@ -112,6 +115,7 @@ static int apply_r_mips_26_rela(struct module *me, u32 *location, Elf_Addr v)
 
 	return 0;
 }
+#endif
 
 static int apply_r_mips_hi16_rel(struct module *me, u32 *location, Elf_Addr v)
 {
@@ -134,6 +138,7 @@ static int apply_r_mips_hi16_rel(struct module *me, u32 *location, Elf_Addr v)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES_USE_ELF_RELA
 static int apply_r_mips_hi16_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	*location = (*location & 0xffff0000) |
@@ -141,6 +146,7 @@ static int apply_r_mips_hi16_rela(struct module *me, u32 *location, Elf_Addr v)
 
 	return 0;
 }
+#endif
 
 static int apply_r_mips_lo16_rel(struct module *me, u32 *location, Elf_Addr v)
 {
@@ -206,6 +212,7 @@ out_danger:
 	return -ENOEXEC;
 }
 
+#ifdef CONFIG_MODULES_USE_ELF_RELA
 static int apply_r_mips_lo16_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	*location = (*location & 0xffff0000) | (v & 0xffff);
@@ -237,6 +244,7 @@ static int apply_r_mips_highest_rela(struct module *me, u32 *location,
 
 	return 0;
 }
+#endif
 
 static int (*reloc_handlers_rel[]) (struct module *me, u32 *location,
 				Elf_Addr v) = {
@@ -247,6 +255,7 @@ static int (*reloc_handlers_rel[]) (struct module *me, u32 *location,
 	[R_MIPS_LO16]		= apply_r_mips_lo16_rel
 };
 
+#ifdef CONFIG_MODULES_USE_ELF_RELA
 static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 				Elf_Addr v) = {
 	[R_MIPS_NONE]		= apply_r_mips_none,
@@ -258,6 +267,7 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_MIPS_HIGHER]		= apply_r_mips_higher_rela,
 	[R_MIPS_HIGHEST]	= apply_r_mips_highest_rela
 };
+#endif
 
 int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 		   unsigned int symindex, unsigned int relsec,
-- 
1.7.2.5
