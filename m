Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:45:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2308 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011406AbcBCDpWovYyQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:45:22 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 65FBAAEF5B36C;
        Wed,  3 Feb 2016 03:45:15 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:45:16 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:45:15 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Andrey Konovalov <adech.fo@gmail.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/5] MIPS: Bail on unsupported module relocs
Date:   Wed, 3 Feb 2016 03:44:41 +0000
Message-ID: <1454471085-20963-2-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 51650
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

When an unsupported reloc is encountered in a module, we currently
blindly branch to whatever would be at its entry in the reloc handler
function pointer arrays. This may be NULL, or if the unsupported reloc
has a type greater than that of the supported reloc with the highest
type then we'll dereference some value after the function pointer array
& branch to that. The result is at best a kernel oops.

Fix this by checking that the reloc type has an entry in the function
pointer array (ie. is less than the number of items in the array) and
that the handler is non-NULL, returning an error code to fail the module
load if no handler is found.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
---

 arch/mips/kernel/module-rela.c | 19 ++++++++++++++++---
 arch/mips/kernel/module.c      | 19 ++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/module-rela.c b/arch/mips/kernel/module-rela.c
index 2b70723..769e316 100644
--- a/arch/mips/kernel/module-rela.c
+++ b/arch/mips/kernel/module-rela.c
@@ -109,9 +109,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		       struct module *me)
 {
 	Elf_Mips_Rela *rel = (void *) sechdrs[relsec].sh_addr;
+	int (*handler)(struct module *me, u32 *location, Elf_Addr v);
 	Elf_Sym *sym;
 	u32 *location;
-	unsigned int i;
+	unsigned int i, type;
 	Elf_Addr v;
 	int res;
 
@@ -134,9 +135,21 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 			return -ENOENT;
 		}
 
-		v = sym->st_value + rel[i].r_addend;
+		type = ELF_MIPS_R_TYPE(rel[i]);
+
+		if (type < ARRAY_SIZE(reloc_handlers_rela))
+			handler = reloc_handlers_rela[type];
+		else
+			handler = NULL;
 
-		res = reloc_handlers_rela[ELF_MIPS_R_TYPE(rel[i])](me, location, v);
+		if (!handler) {
+			pr_warn("%s: Unknown relocation type %u\n",
+				me->name, type);
+			return -EINVAL;
+		}
+
+		v = sym->st_value + rel[i].r_addend;
+		res = handler(me, location, v);
 		if (res)
 			return res;
 	}
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 1833f51..2adf572 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -197,9 +197,10 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 		   struct module *me)
 {
 	Elf_Mips_Rel *rel = (void *) sechdrs[relsec].sh_addr;
+	int (*handler)(struct module *me, u32 *location, Elf_Addr v);
 	Elf_Sym *sym;
 	u32 *location;
-	unsigned int i;
+	unsigned int i, type;
 	Elf_Addr v;
 	int res;
 
@@ -223,9 +224,21 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 			return -ENOENT;
 		}
 
-		v = sym->st_value;
+		type = ELF_MIPS_R_TYPE(rel[i]);
+
+		if (type < ARRAY_SIZE(reloc_handlers_rel))
+			handler = reloc_handlers_rel[type];
+		else
+			handler = NULL;
 
-		res = reloc_handlers_rel[ELF_MIPS_R_TYPE(rel[i])](me, location, v);
+		if (!handler) {
+			pr_warn("%s: Unknown relocation type %u\n",
+				me->name, type);
+			return -EINVAL;
+		}
+
+		v = sym->st_value;
+		res = handler(me, location, v);
 		if (res)
 			return res;
 	}
-- 
2.7.0
