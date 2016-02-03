Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:45:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51782 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011471AbcBCDpvmD6YQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:45:51 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 551FF5780E60D;
        Wed,  3 Feb 2016 03:45:44 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:45:45 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:45:44 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/5] MIPS: Add support for 64-bit R6 ELF relocations
Date:   Wed, 3 Feb 2016 03:44:43 +0000
Message-ID: <1454471085-20963-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com>
References: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51652
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

This patch fixes MIPS64r6 kernel modules by adding new ELF
relocations. Toolchains that compile 64-bit R6 binaries emit
two new ELF relocations R_MIPS_PC21_S2 and R_MIPS_PC26_S2.
The pre-existing R_MIPS_PC16 ELF relocation is also emitted.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/elf.h    |  5 +++
 arch/mips/kernel/module-rela.c | 69 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index cefb7a5..7cec234 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -111,6 +111,11 @@
 #define R_MIPS_CALLHI16		30
 #define R_MIPS_CALLLO16		31
 /*
+ * Introduced for MIPSr6.
+ */
+#define R_MIPS_PC21_S2		60
+#define R_MIPS_PC26_S2		61
+/*
  * This range is reserved for vendor specific relocations.
  */
 #define R_MIPS_LOVENDOR		100
diff --git a/arch/mips/kernel/module-rela.c b/arch/mips/kernel/module-rela.c
index f1ff64b..2dbe1b0 100644
--- a/arch/mips/kernel/module-rela.c
+++ b/arch/mips/kernel/module-rela.c
@@ -16,6 +16,7 @@
  *  Copyright (C) 2001 Rusty Russell.
  *  Copyright (C) 2003, 2004 Ralf Baechle (ralf@linux-mips.org)
  *  Copyright (C) 2005 Thiemo Seufer
+ *  Copyright (C) 2015 Imagination Technologies Ltd.
  */
 
 #include <linux/elf.h>
@@ -65,6 +66,27 @@ static int apply_r_mips_lo16_rela(struct module *me, u32 *location, Elf_Addr v)
 	return 0;
 }
 
+static int apply_r_mips_pc16_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	long offset;
+
+	if (v % 4) {
+		pr_err("module %s: dangerous R_MIPS_PC16 RELA relocation\n",
+		       me->name);
+		return -ENOEXEC;
+	}
+
+	offset = ((long)v - (long)location) >> 2;
+	if (offset != (int16_t)offset) {
+		pr_err("module %s: relocation overflow\n", me->name);
+		return -ENOEXEC;
+	}
+
+	*location = (*location & ~0xffff) | (offset & 0xffff);
+
+	return 0;
+}
+
 static int apply_r_mips_64_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	*(Elf_Addr *)location = v;
@@ -90,6 +112,48 @@ static int apply_r_mips_highest_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_mips_pc21_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	long offset;
+
+	if (v % 4) {
+		pr_err("module %s: dangerous R_MIPS_PC21 RELA relocation\n",
+		       me->name);
+		return -ENOEXEC;
+	}
+
+	offset = ((long)v - (long)location) >> 2;
+	if ((offset >> 20) > 0 || (offset >> 20) < -1) {
+		pr_err("module %s: relocation overflow\n", me->name);
+		return -ENOEXEC;
+	}
+
+	*location = (*location & ~0x001fffff) | (offset & 0x001fffff);
+
+	return 0;
+}
+
+static int apply_r_mips_pc26_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	long offset;
+
+	if (v % 4) {
+		pr_err("module %s: dangerous R_MIPS_PC26 RELA relocation\n",
+		       me->name);
+		return -ENOEXEC;
+	}
+
+	offset = ((long)v - (long)location) >> 2;
+	if ((offset >> 25) > 0 || (offset >> 25) < -1) {
+		pr_err("module %s: relocation overflow\n", me->name);
+		return -ENOEXEC;
+	}
+
+	*location = (*location & ~0x03ffffff) | (offset & 0x03ffffff);
+
+	return 0;
+}
+
 static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 				Elf_Addr v) = {
 	[R_MIPS_NONE]		= apply_r_mips_none,
@@ -97,9 +161,12 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_MIPS_26]		= apply_r_mips_26_rela,
 	[R_MIPS_HI16]		= apply_r_mips_hi16_rela,
 	[R_MIPS_LO16]		= apply_r_mips_lo16_rela,
+	[R_MIPS_PC16]		= apply_r_mips_pc16_rela,
 	[R_MIPS_64]		= apply_r_mips_64_rela,
 	[R_MIPS_HIGHER]		= apply_r_mips_higher_rela,
-	[R_MIPS_HIGHEST]	= apply_r_mips_highest_rela
+	[R_MIPS_HIGHEST]	= apply_r_mips_highest_rela,
+	[R_MIPS_PC21_S2]	= apply_r_mips_pc21_rela,
+	[R_MIPS_PC26_S2]	= apply_r_mips_pc26_rela,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.7.0
