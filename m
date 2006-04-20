Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2006 17:52:20 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:9668 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133570AbWDTQwF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2006 17:52:05 +0100
Received: from localhost (p1086-ipad27funabasi.chiba.ocn.ne.jp [220.107.192.86])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 602B8959F; Fri, 21 Apr 2006 02:04:45 +0900 (JST)
Date:	Fri, 21 Apr 2006 02:05:14 +0900 (JST)
Message-Id: <20060421.020514.96686583.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060420162319.GD10665@networkno.de>
References: <20060420001900.GC30806@networkno.de>
	<20060421.010237.25910405.anemo@mba.ocn.ne.jp>
	<20060420162319.GD10665@networkno.de>
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
X-archive-position: 11168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 20 Apr 2006 17:23:19 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > Well, I just take ELF64_MIPS_R_TYPE() from glibc source.
> 
> It is not more useful in glibc. :-)  Any use of the TYPE data will have
> to take the MIPS64 specifics in account, and thus split it up again
> into single characters.

OK, then I drop TYPE data and simplify the patch.  Take 4.


64bit mips has different r_info layout.  This patch fixes modpost
segfault for 64bit little endian mips kernel.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index cd00e9f..fcd4306 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -709,10 +709,17 @@ static void check_sec_ref(struct module 
 		for (rela = start; rela < stop; rela++) {
 			Elf_Rela r;
 			const char *secname;
+			unsigned int r_sym;
 			r.r_offset = TO_NATIVE(rela->r_offset);
-			r.r_info   = TO_NATIVE(rela->r_info);
+			if (hdr->e_ident[EI_CLASS] == ELFCLASS64 &&
+			    hdr->e_machine == EM_MIPS) {
+				r_sym = ELF64_MIPS_R_SYM(rela->r_info);
+				r_sym = TO_NATIVE(r_sym);
+			} else {
+				r_sym = ELF_R_SYM(TO_NATIVE(rela->r_info));
+			}
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
@@ -39,6 +39,25 @@
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
