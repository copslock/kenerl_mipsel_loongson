Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2016 17:35:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20686 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042510AbcFPPfvx1CF9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jun 2016 17:35:51 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id CE05BA29414F;
        Thu, 16 Jun 2016 16:35:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 16 Jun 2016 16:35:45 +0100
Received: from hhunt-arch.le.imgtec.org (192.168.154.26) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 16 Jun 2016 16:35:44 +0100
From:   Harvey Hunt <harvey.hunt@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     Harvey Hunt <harvey.hunt@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: tools: Fix relocs tool compiler warnings
Date:   Thu, 16 Jun 2016 16:35:39 +0100
Message-ID: <20160616153539.10600-1-harvey.hunt@imgtec.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.26]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

When using clang as HOSTCC, the following warnings appear:

In file included from arch/mips/boot/tools/relocs_64.c:27:0:
arch/mips/boot/tools/relocs.c: In function ‘read_relocs’:
arch/mips/boot/tools/relocs.c:397:4: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
    ELF_R_SYM(rel->r_info) = elf32_to_cpu(ELF_R_SYM(rel->r_info));
    ^~~~~~~~~
arch/mips/boot/tools/relocs.c:397:4: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
arch/mips/boot/tools/relocs.c: In function ‘walk_relocs’:
arch/mips/boot/tools/relocs.c:491:4: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
    Elf_Sym *sym = &sh_symtab[ELF_R_SYM(rel->r_info)];
    ^~~~~~~
arch/mips/boot/tools/relocs.c: In function ‘do_reloc’:
arch/mips/boot/tools/relocs.c:502:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
  unsigned r_type = ELF_R_TYPE(rel->r_info);
  ^~~~~~~~
arch/mips/boot/tools/relocs.c: In function ‘do_reloc_info’:
arch/mips/boot/tools/relocs.c:641:3: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
   rel_type(ELF_R_TYPE(rel->r_info)),
   ^~~~~~~~

Fix them by making Elf64_Mips_Rela a union

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/boot/tools/relocs_64.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/mips/boot/tools/relocs_64.c b/arch/mips/boot/tools/relocs_64.c
index b671b5e..06066e6a 100644
--- a/arch/mips/boot/tools/relocs_64.c
+++ b/arch/mips/boot/tools/relocs_64.c
@@ -9,17 +9,20 @@
 
 typedef uint8_t Elf64_Byte;
 
-typedef struct {
-	Elf64_Word r_sym;	/* Symbol index.  */
-	Elf64_Byte r_ssym;	/* Special symbol.  */
-	Elf64_Byte r_type3;	/* Third relocation.  */
-	Elf64_Byte r_type2;	/* Second relocation.  */
-	Elf64_Byte r_type;	/* First relocation.  */
+typedef union {
+	struct {
+		Elf64_Word r_sym;	/* Symbol index.  */
+		Elf64_Byte r_ssym;	/* Special symbol.  */
+		Elf64_Byte r_type3;	/* Third relocation.  */
+		Elf64_Byte r_type2;	/* Second relocation.  */
+		Elf64_Byte r_type;	/* First relocation.  */
+	} fields;
+	Elf64_Xword unused;
 } Elf64_Mips_Rela;
 
 #define ELF_CLASS               ELFCLASS64
-#define ELF_R_SYM(val)          (((Elf64_Mips_Rela *)(&val))->r_sym)
-#define ELF_R_TYPE(val)         (((Elf64_Mips_Rela *)(&val))->r_type)
+#define ELF_R_SYM(val)          (((Elf64_Mips_Rela *)(&val))->fields.r_sym)
+#define ELF_R_TYPE(val)         (((Elf64_Mips_Rela *)(&val))->fields.r_type)
 #define ELF_ST_TYPE(o)          ELF64_ST_TYPE(o)
 #define ELF_ST_BIND(o)          ELF64_ST_BIND(o)
 #define ELF_ST_VISIBILITY(o)    ELF64_ST_VISIBILITY(o)
-- 
2.8.3
