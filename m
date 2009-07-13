Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2009 11:14:37 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:34477 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492569AbZGMJOa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2009 11:14:30 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
	by phoenix3.szarvasnet.hu (Postfix) with SMTP id 2BD273E4008;
	Mon, 13 Jul 2009 11:14:25 +0200 (CEST)
Received: from localhost.localdomain (catvpool-5d59a614.szarvasnet.hu [93.89.166.20])
	by phoenix3.szarvasnet.hu (Postfix) with ESMTP id BCE1C178002;
	Mon, 13 Jul 2009 11:14:24 +0200 (CEST)
From:	Gabor Juhos <juhosg@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: fix loading of modules with unresolved weak symbols
Date:	Mon, 13 Jul 2009 11:14:24 +0200
Message-Id: <1247476464-8961-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.5.3.2
X-Antivirus: avast! (VPS 090712-0, 2009.07.12), Outbound message
X-Antivirus-Status: Clean
X-VBMS:	A11E9508A97 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Loading of modules with unresolved weak symbols fails on MIPS
since '88173507e4fc1e7ecd111b0565e8cba0cb7dae6d'.

Modules: handle symbols that have a zero value

The module subsystem cannot handle symbols that are zero.  If symbols
are present that have a zero value then the module resolver prints out a
message that these symbols are unresolved.

We have to use IS_ERR_VALUE() to check that a symbol has been resolved
or not.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/kernel/module.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 3e9100d..e465851 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -301,7 +301,7 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 		/* This is the symbol it is referring to */
 		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
 			+ ELF_MIPS_R_SYM(rel[i]);
-		if (!sym->st_value) {
+		if (IS_ERR_VALUE(sym->st_value)) {
 			/* Ignore unresolved weak symbol */
 			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
 				continue;
@@ -341,7 +341,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		/* This is the symbol it is referring to */
 		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
 			+ ELF_MIPS_R_SYM(rel[i]);
-		if (!sym->st_value) {
+		if (IS_ERR_VALUE(sym->st_value)) {
 			/* Ignore unresolved weak symbol */
 			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
 				continue;
-- 
1.5.3.2
