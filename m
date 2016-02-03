Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:46:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12923 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011479AbcBCDqFqllNQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:46:05 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id CA163CD77BB72;
        Wed,  3 Feb 2016 03:45:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:46:00 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:45:59 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Andrey Konovalov <adech.fo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/5] MIPS: Support R_MIPS_PC16 rel-style reloc
Date:   Wed, 3 Feb 2016 03:44:44 +0000
Message-ID: <1454471085-20963-5-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 51653
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

MIPS32 code uses rel-style relocs, and MIPS32r6 modules may include the
R_MIPS_PC16 relocation. We thus need to support R_MIPS_PC16 rel-style
relocations in order to load MIPS32r6 kernel modules. This patch adds
such support, which is similar to the rela-style R_MIPS_PC16 support but
making use of the implicit addend from the instruction encoding.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/module.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 2adf572..f2de9b8 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -183,13 +183,25 @@ out_danger:
 	return -ENOEXEC;
 }
 
+static int apply_r_mips_pc16_rel(struct module *me, u32 *location, Elf_Addr v)
+{
+	u16 val;
+
+	val = *location;
+	val += (v - (Elf_Addr)location) >> 2;
+	*location = (*location & 0xffff0000) | val;
+
+	return 0;
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
 };
 
 int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.7.0
