Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2006 17:44:36 +0200 (CEST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:5335 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8134003AbWEVPoW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2006 17:44:22 +0200
Received: from localhost (p3247-ipad208funabasi.chiba.ocn.ne.jp [60.43.104.247])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F0F87A68B; Tue, 23 May 2006 00:44:17 +0900 (JST)
Date:	Tue, 23 May 2006 00:45:07 +0900 (JST)
Message-Id: <20060523.004507.70476427.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Ignore unresolved weak symbols in module.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 21 Apr 2006 23:33:35 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > > The problem is if you try to load oprofile as a module.  The kernel 
> > > module linker evidentially does not understand weak symbols and refuses 
> > > to load the module because they are undefined.
> > 
> > Actually it contains code to handle weak symbols so this is a bit
> > surprising not last because STB_WEAK handling happen in the generic
> > module loader code and is being used by other architectures as well.
> 
> This is still unresolved.  The "oprofile: Unknown symbol" message is
> printed in arch/mips/kernel/module.c file.  How about this patch?

ping.


[PATCH] Ignore unresolved weak symbols in module.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index e54a7f4..d7bf021 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -288,6 +288,9 @@ int apply_relocate(Elf_Shdr *sechdrs, co
 		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
 			+ ELF_MIPS_R_SYM(rel[i]);
 		if (!sym->st_value) {
+			/* Ignore unresolved weak symbol */
+			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
+				continue;
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
 			       me->name, strtab + sym->st_name);
 			return -ENOENT;
@@ -325,6 +328,9 @@ int apply_relocate_add(Elf_Shdr *sechdrs
 		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
 			+ ELF_MIPS_R_SYM(rel[i]);
 		if (!sym->st_value) {
+			/* Ignore unresolved weak symbol */
+			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
+				continue;
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
 			       me->name, strtab + sym->st_name);
 			return -ENOENT;
