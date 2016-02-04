Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 14:06:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55029 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010597AbcBDNF6dtksl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 14:05:58 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id D4B533242AAC2;
        Thu,  4 Feb 2016 13:05:49 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 4 Feb 2016 13:05:52 +0000
Received: from localhost (10.100.200.26) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Feb
 2016 13:05:50 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Andrey Konovalov" <adech.fo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/4] MIPS: module: Make consistent use of pr_*()
Date:   Thu, 4 Feb 2016 13:05:03 +0000
Message-ID: <1454591105-11841-3-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 51772
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

The module relocation handling code has inconsistent use of printk() and
pr_*() functions. Convert printk() calls to use pr_err() and pr_warn().

[paul.burton@imgtec.com: Do the same thing in module.c]

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- Do the same in module.c.

 arch/mips/kernel/module-rela.c | 8 +++-----
 arch/mips/kernel/module.c      | 7 +++----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/module-rela.c b/arch/mips/kernel/module-rela.c
index 9083d63..0570676 100644
--- a/arch/mips/kernel/module-rela.c
+++ b/arch/mips/kernel/module-rela.c
@@ -35,15 +35,13 @@ static int apply_r_mips_32_rela(struct module *me, u32 *location, Elf_Addr v)
 static int apply_r_mips_26_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	if (v % 4) {
-		pr_err("module %s: dangerous R_MIPS_26 RELArelocation\n",
+		pr_err("module %s: dangerous R_MIPS_26 RELA relocation\n",
 		       me->name);
 		return -ENOEXEC;
 	}
 
 	if ((v & 0xf0000000) != (((unsigned long)location + 4) & 0xf0000000)) {
-		printk(KERN_ERR
-		       "module %s: relocation overflow\n",
-		       me->name);
+		pr_err("module %s: relocation overflow\n", me->name);
 		return -ENOEXEC;
 	}
 
@@ -130,7 +128,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 			/* Ignore unresolved weak symbol */
 			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
 				continue;
-			printk(KERN_WARNING "%s: Unknown symbol %s\n",
+			pr_warn("%s: Unknown symbol %s\n",
 			       me->name, strtab + sym->st_name);
 			return -ENOENT;
 		}
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index f9b2936..e16624f 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -73,8 +73,7 @@ static int apply_r_mips_26_rel(struct module *me, u32 *location, Elf_Addr v)
 	}
 
 	if ((v & 0xf0000000) != (((unsigned long)location + 4) & 0xf0000000)) {
-		printk(KERN_ERR
-		       "module %s: relocation overflow\n",
+		pr_err("module %s: relocation overflow\n",
 		       me->name);
 		return -ENOEXEC;
 	}
@@ -219,8 +218,8 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 			/* Ignore unresolved weak symbol */
 			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
 				continue;
-			printk(KERN_WARNING "%s: Unknown symbol %s\n",
-			       me->name, strtab + sym->st_name);
+			pr_warn("%s: Unknown symbol %s\n",
+				me->name, strtab + sym->st_name);
 			return -ENOENT;
 		}
 
-- 
2.7.0
