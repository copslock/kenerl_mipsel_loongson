Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 14:54:16 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52272 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992641AbdJIMyACxkYY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2017 14:54:00 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQm-0004v6-1r; Mon, 09 Oct 2017 13:45:12 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQP-0001zV-JV; Mon, 09 Oct 2017 13:44:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Date:   Mon, 09 Oct 2017 13:44:24 +0100
Message-ID: <lsq.1507553064.271416989@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 055/192] MIPS: Bail on unsupported module relocs
In-Reply-To: <lsq.1507553063.449494954@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.49-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 04211a574641e29b529dcc84e75c03d7e9e368cf upstream.

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
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12432/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/module-rela.c | 19 ++++++++++++++++---
 arch/mips/kernel/module.c      | 19 ++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)

--- a/arch/mips/kernel/module-rela.c
+++ b/arch/mips/kernel/module-rela.c
@@ -109,9 +109,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs
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
 
@@ -134,9 +135,21 @@ int apply_relocate_add(Elf_Shdr *sechdrs
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
+			pr_err("%s: Unknown relocation type %u\n",
+			       me->name, type);
+			return -EINVAL;
+		}
+
+		v = sym->st_value + rel[i].r_addend;
+		res = handler(me, location, v);
 		if (res)
 			return res;
 	}
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -197,9 +197,10 @@ int apply_relocate(Elf_Shdr *sechdrs, co
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
 
@@ -223,9 +224,21 @@ int apply_relocate(Elf_Shdr *sechdrs, co
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
+			pr_err("%s: Unknown relocation type %u\n",
+			       me->name, type);
+			return -EINVAL;
+		}
+
+		v = sym->st_value;
+		res = handler(me, location, v);
 		if (res)
 			return res;
 	}
