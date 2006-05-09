Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2006 04:13:26 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:52123 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8126481AbWEIDNK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 May 2006 04:13:10 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 9 May 2006 12:13:09 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 0AE38203F5;
	Tue,  9 May 2006 12:13:03 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E3446203DB;
	Tue,  9 May 2006 12:13:02 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k493D24D093120;
	Tue, 9 May 2006 12:13:02 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 09 May 2006 12:13:02 +0900 (JST)
Message-Id: <20060509.121302.78496215.nemoto@toshiba-tops.co.jp>
To:	sam@ravnborg.org
Cc:	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	chrisw@sous-sol.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, shemminger@osdl.org
Subject: Re: [git patches] kbuild fixes for -rc
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060508200153.GA3762@mars.ravnborg.org>
References: <20060508050809.GA2247@mars.ravnborg.org>
	<20060508190312.GB2697@moss.sous-sol.org>
	<20060508200153.GA3762@mars.ravnborg.org>
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
X-archive-position: 11366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 8 May 2006 22:01:53 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> Please revert this bogus commit:
> > > commit c8d8b837ebe4b4f11e1b0c4a2bdc358c697692ed
> 
> I was discussed on mips list but apparently the fix was bogus.
> I will not have time to look into it so mips can carry this local
> fix until we get a proper fix in mainline.

Here is a updated fix to avoid breakage on 32-bit build.


64bit mips has different r_info layout.  This patch fixes modpost
segfault for 64bit little endian mips kernel.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6d04504..692a83b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -709,10 +709,20 @@ static void check_sec_ref(struct module 
 		for (rela = start; rela < stop; rela++) {
 			Elf_Rela r;
 			const char *secname;
+			unsigned int r_sym;
 			r.r_offset = TO_NATIVE(rela->r_offset);
-			r.r_info   = TO_NATIVE(rela->r_info);
+#if KERNEL_ELFCLASS == ELFCLASS64
+			if (hdr->e_machine == EM_MIPS) {
+				r_sym = ELF64_MIPS_R_SYM(rela->r_info);
+				r_sym = TO_NATIVE(r_sym);
+			} else {
+				r_sym = ELF_R_SYM(TO_NATIVE(rela->r_info));
+			}
+#else
+			r_sym = ELF_R_SYM(TO_NATIVE(rela->r_info));
+#endif
 			r.r_addend = TO_NATIVE(rela->r_addend);
-			sym = elf->symtab_start + ELF_R_SYM(r.r_info);
+			sym = elf->symtab_start + r_sym;
 			/* Skip special sections */
 			if (sym->st_shndx >= SHN_LORESERVE)
 				continue;
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index b14255c..89b96c6 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -39,6 +39,25 @@ #define ELF_R_SYM   ELF64_R_SYM
 #define ELF_R_TYPE  ELF64_R_TYPE
 #endif
 
+/* The 64-bit MIPS ELF ABI uses an unusual reloc format. */
+typedef struct
+{
+  Elf32_Word    r_sym;		/* Symbol index */
+  unsigned char r_ssym;		/* Special symbol for 2nd relocation */
+  unsigned char r_type3;	/* 3rd relocation type */
+  unsigned char r_type2;	/* 2nd relocation type */
+  unsigned char r_type1;	/* 1st relocation type */
+} _Elf64_Mips_R_Info;
+
+typedef union
+{
+  Elf64_Xword	r_info_number;
+  _Elf64_Mips_R_Info r_info_fields;
+} _Elf64_Mips_R_Info_union;
+
+#define ELF64_MIPS_R_SYM(i) \
+  ((__extension__ (_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_sym)
+
 #if KERNEL_ELFDATA != HOST_ELFDATA
 
 static inline void __endian(const void *src, void *dest, unsigned int size)
