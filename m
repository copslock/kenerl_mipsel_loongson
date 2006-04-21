Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2006 15:20:32 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:39385 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133618AbWDUOUW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Apr 2006 15:20:22 +0100
Received: from localhost (p2209-ipad34funabasi.chiba.ocn.ne.jp [124.85.59.209])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C27FC8626; Fri, 21 Apr 2006 23:33:05 +0900 (JST)
Date:	Fri, 21 Apr 2006 23:33:35 +0900 (JST)
Message-Id: <20060421.233335.59652249.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	ddaney@avtrex.com, linux-mips@linux-mips.org
Subject: Re: OProfile cannot be loaded as module...
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051013225520.GA3234@linux-mips.org>
References: <43470BCF.1070709@avtrex.com>
	<20051013225520.GA3234@linux-mips.org>
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
X-archive-position: 11171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 13 Oct 2005 23:55:21 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > The problem is if you try to load oprofile as a module.  The kernel 
> > module linker evidentially does not understand weak symbols and refuses 
> > to load the module because they are undefined.
> 
> Actually it contains code to handle weak symbols so this is a bit
> surprising not last because STB_WEAK handling happen in the generic
> module loader code and is being used by other architectures as well.

This is still unresolved.  The "oprofile: Unknown symbol" message is
printed in arch/mips/kernel/module.c file.  How about this patch?


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
