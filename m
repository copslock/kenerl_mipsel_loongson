Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:46:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23247 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011472AbcBCDqU1-lMQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:46:20 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 48729DAC7E5D9;
        Wed,  3 Feb 2016 03:46:13 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:46:14 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:46:13 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Andrey Konovalov <adech.fo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/5] MIPS: Implement MIPSr6 R_MIPS_PC2x rel-style relocs
Date:   Wed, 3 Feb 2016 03:44:45 +0000
Message-ID: <1454471085-20963-6-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 51654
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

MIPS32r6 code makes use of rel-stye relocations & may contain the new
relocations R_MIPS_PC21_S2 or R_MIPS_PC26_S2 which were introduced with
MIPSr6. Implement support for those relocations such that we can load
MIPS32r6 kernel modules.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/kernel/module.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index f2de9b8..d62fd56 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -194,6 +194,56 @@ static int apply_r_mips_pc16_rel(struct module *me, u32 *location, Elf_Addr v)
 	return 0;
 }
 
+static int apply_r_mips_pc21_rel(struct module *me, u32 *location, Elf_Addr v)
+{
+	long offset;
+
+	if (v % 4) {
+		pr_err("module %s: dangerous R_MIPS_PC21 REL relocation\n",
+		       me->name);
+		return -ENOEXEC;
+	}
+
+	/* retrieve & sign extend implicit addend */
+	offset = *location & 0x1fffff;
+	offset |= (offset & BIT(20)) ? (~0l & ~0x1fffffl) : 0;
+
+	offset += ((long)v - (long)location) >> 2;
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
+static int apply_r_mips_pc26_rel(struct module *me, u32 *location, Elf_Addr v)
+{
+	long offset;
+
+	if (v % 4) {
+		pr_err("module %s: dangerous R_MIPS_PC26 REL relocation\n",
+		       me->name);
+		return -ENOEXEC;
+	}
+
+	/* retrieve & sign extend implicit addend */
+	offset = *location & 0x3ffffff;
+	offset |= (offset & BIT(25)) ? (~0l & ~0x3ffffffl) : 0;
+
+	offset += ((long)v - (long)location) >> 2;
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
 static int (*reloc_handlers_rel[]) (struct module *me, u32 *location,
 				Elf_Addr v) = {
 	[R_MIPS_NONE]		= apply_r_mips_none,
@@ -202,6 +252,8 @@ static int (*reloc_handlers_rel[]) (struct module *me, u32 *location,
 	[R_MIPS_HI16]		= apply_r_mips_hi16_rel,
 	[R_MIPS_LO16]		= apply_r_mips_lo16_rel,
 	[R_MIPS_PC16]		= apply_r_mips_pc16_rel,
+	[R_MIPS_PC21_S2]	= apply_r_mips_pc21_rel,
+	[R_MIPS_PC26_S2]	= apply_r_mips_pc26_rel,
 };
 
 int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.7.0
