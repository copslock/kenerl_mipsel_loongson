Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 12:48:32 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:47116 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133425AbWDQLsW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Apr 2006 12:48:22 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 17 Apr 2006 21:00:45 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 38BA620274;
	Mon, 17 Apr 2006 21:00:40 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2D0ED2019E;
	Mon, 17 Apr 2006 21:00:40 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k3HC0d4D087061;
	Mon, 17 Apr 2006 21:00:39 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 17 Apr 2006 21:00:39 +0900 (JST)
Message-Id: <20060417.210039.95063383.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sam@ravnborg.org
Subject: [PATCH] fix modpost segfault for 64bit mipsel kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

64bit mips has different r_info layout.  This patch fixes modpost
segfault for 64bit little endian mips kernel.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index cd00e9f..7846600 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -712,7 +712,13 @@ static void check_sec_ref(struct module 
 			r.r_offset = TO_NATIVE(rela->r_offset);
 			r.r_info   = TO_NATIVE(rela->r_info);
 			r.r_addend = TO_NATIVE(rela->r_addend);
+#if KERNEL_ELFCLASS == ELFCLASS64 && KERNEL_ELFDATA == ELFDATA2LSB
+			sym = elf->symtab_start +
+				(hdr->e_machine == EM_MIPS ?
+				 (Elf32_Word)r.r_info : ELF_R_SYM(r.r_info));
+#else
 			sym = elf->symtab_start + ELF_R_SYM(r.r_info);
+#endif
 			/* Skip special sections */
 			if (sym->st_shndx >= SHN_LORESERVE)
 				continue;
