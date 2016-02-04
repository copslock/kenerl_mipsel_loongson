Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 14:06:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63606 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010543AbcBDNG1WgaUl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 14:06:27 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 7336151FFA817;
        Thu,  4 Feb 2016 13:06:18 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 4 Feb 2016 13:06:20 +0000
Received: from localhost (10.100.200.26) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Feb
 2016 13:06:20 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: [PATCH v2 4/4] MIPS: Support R_MIPS_PC{16,21,26} rel-style relocs
Date:   Thu, 4 Feb 2016 13:05:05 +0000
Message-ID: <1454591105-11841-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454591105-11841-1-git-send-email-paul.burton@imgtec.com>
References: <1454591105-11841-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.26]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51774
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

MIPS32 code uses rel-style relocs, and MIPS32r6 modules may include
R_MIPS_PC16, R_MIPS_PC21 & R_MIPS_PC26 relocations. We thus need to
support these relocations in order to load MIPS32r6 kernel modules. This
patch adds such support, which is similar to the rela-style support in
module-rela.c but making use of the implicit addend from the instruction
encoding.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- Unify PC{16,21,26} implementation.

 arch/mips/kernel/module.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index e16624f..ff5d97d 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -182,13 +182,62 @@ out_danger:
 	return -ENOEXEC;
 }
 
+static int apply_r_mips_pc_rel(struct module *me, u32 *location, Elf_Addr v,
+			       unsigned bits)
+{
+	unsigned long mask = GENMASK(bits - 1, 0);
+	unsigned long se_bits;
+	long offset;
+
+	if (v % 4) {
+		pr_err("module %s: dangerous R_MIPS_PC%u REL relocation\n",
+		       me->name, bits);
+		return -ENOEXEC;
+	}
+
+	/* retrieve & sign extend implicit addend */
+	offset = *location & mask;
+	offset |= (offset & BIT(bits - 1)) ? ~mask : 0;
+
+	offset += ((long)v - (long)location) >> 2;
+
+	/* check the sign bit onwards are identical - ie. we didn't overflow */
+	se_bits = (offset & BIT(bits - 1)) ? ~0ul : 0;
+	if ((offset & ~mask) != (se_bits & ~mask)) {
+		pr_err("module %s: relocation overflow\n", me->name);
+		return -ENOEXEC;
+	}
+
+	*location = (*location & ~mask) | (offset & mask);
+
+	return 0;
+}
+
+static int apply_r_mips_pc16_rel(struct module *me, u32 *location, Elf_Addr v)
+{
+	return apply_r_mips_pc_rel(me, location, v, 16);
+}
+
+static int apply_r_mips_pc21_rel(struct module *me, u32 *location, Elf_Addr v)
+{
+	return apply_r_mips_pc_rel(me, location, v, 21);
+}
+
+static int apply_r_mips_pc26_rel(struct module *me, u32 *location, Elf_Addr v)
+{
+	return apply_r_mips_pc_rel(me, location, v, 26);
+}
+
 static int (*reloc_handlers_rel[]) (struct module *me, u32 *location,
 				Elf_Addr v) = {
 	[R_MIPS_NONE]		= apply_r_mips_none,
 	[R_MIPS_32]		= apply_r_mips_32_rel,
 	[R_MIPS_26]		= apply_r_mips_26_rel,
 	[R_MIPS_HI16]		= apply_r_mips_hi16_rel,
-	[R_MIPS_LO16]		= apply_r_mips_lo16_rel
+	[R_MIPS_LO16]		= apply_r_mips_lo16_rel,
+	[R_MIPS_PC16]		= apply_r_mips_pc16_rel,
+	[R_MIPS_PC21_S2]	= apply_r_mips_pc21_rel,
+	[R_MIPS_PC26_S2]	= apply_r_mips_pc26_rel,
 };
 
 int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.7.0
