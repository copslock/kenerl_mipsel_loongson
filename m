Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2006 16:49:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:45545 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133547AbWDTPtc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2006 16:49:32 +0100
Received: from localhost (p1086-ipad27funabasi.chiba.ocn.ne.jp [220.107.192.86])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 592CBA6A4; Fri, 21 Apr 2006 01:02:08 +0900 (JST)
Date:	Fri, 21 Apr 2006 01:02:37 +0900 (JST)
Message-Id: <20060421.010237.25910405.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060420001900.GC30806@networkno.de>
References: <20060417162742.GD28935@networkno.de>
	<20060419.112228.108306767.anemo@mba.ocn.ne.jp>
	<20060420001900.GC30806@networkno.de>
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
X-archive-position: 11166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 20 Apr 2006 01:19:00 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > +#define ELF64_MIPS_R_TYPE(i) \
> > +  (((_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_type1 \
> > +   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
> > +		   ).r_info_fields.r_type2 << 8) \
> > +   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
> > +		   ).r_info_fields.r_type3 << 16) \
> > +   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
> > +		   ).r_info_fields.r_ssym << 24))
> 
> Why is it the right thing to combine the type info into a 32bit word?

Well, I just take ELF64_MIPS_R_TYPE() from glibc source.

> It will never get used as such for MIPS ELF64. I would have expected
> something like:
> 
> #define ELF64_MIPS_R_INFO(sym,ssym,t3,t2,t1)		\
> {(							\
> 	_Elf64_Mips_R_Info info = {			\
> 		.r_sym = sym,				\
> 		.r_ssym = ssym,				\
> 		.r_type3 = t3,				\
> 		.r_type2 = t2,				\
> 		.r_type1 = t1,				\
> 	}						\
> 	(Elf64_Xword)info;				\
> )}
> 
> without a corresponding ELF64_MIPS_R_TYPE, and then:
> 
> 	if (hdr->e_ident[EI_CLASS] == ELFCLASS64
> 	    && hdr->e_machine == EM_MIPS) {
> 		_Elf64_Mips_R_Info info = (_Elf64_Mips_R_Info)r.r_info;
> 		r.r_info = ELF64_MIPS_R_INFO(TO_NATIVE(info.r_sym),
> 					     info.r_ssym, info.r_type3,
> 					     info.r_type2, info.r_type1);
> 	}

Sorry, I can not see what you mean ... it just does byte-swap only
r_sym part, doesn't it?  It is not enough because a position of r_sym
in MIPS ELF64 r_info is different from standard ELF64 r_info.

And I found my previous patch does unnecessary byte-swap on r_type.
This is a take 3.  It also checks hdr->e_ident[EI_CLASS] instead of
KERNEL_ELFCLASS.


64bit mips has different r_info layout.  This patch fixes modpost
segfault for 64bit little endian mips kernel.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index cd00e9f..8f5e814 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -710,7 +710,17 @@ static void check_sec_ref(struct module 
 			Elf_Rela r;
 			const char *secname;
 			r.r_offset = TO_NATIVE(rela->r_offset);
-			r.r_info   = TO_NATIVE(rela->r_info);
+			if (hdr->e_ident[EI_CLASS] == ELFCLASS64 &&
+			    hdr->e_machine == EM_MIPS) {
+				unsigned int r_sym =
+					ELF64_MIPS_R_SYM(rela->r_info);
+				unsigned int r_type =
+					ELF64_MIPS_R_TYPE(rela->r_info);
+				r.r_info = ELF_R_INFO(TO_NATIVE(r_sym),
+						      r_type);
+			} else {
+				r.r_info = TO_NATIVE(rela->r_info);
+			}
 			r.r_addend = TO_NATIVE(rela->r_addend);
 			sym = elf->symtab_start + ELF_R_SYM(r.r_info);
 			/* Skip special sections */
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index b14255c..7d1c04d 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -24,6 +24,7 @@
 #define Elf_Rela    Elf32_Rela
 #define ELF_R_SYM   ELF32_R_SYM
 #define ELF_R_TYPE  ELF32_R_TYPE
+#define ELF_R_INFO  ELF32_R_INFO
 #else
 
 #define Elf_Ehdr    Elf64_Ehdr
@@ -37,8 +38,43 @@
 #define Elf_Rela    Elf64_Rela
 #define ELF_R_SYM   ELF64_R_SYM
 #define ELF_R_TYPE  ELF64_R_TYPE
+#define ELF_R_INFO  ELF64_R_INFO
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
+typedef struct
+{
+  Elf64_Addr	r_offset;		/* Address */
+  _Elf64_Mips_R_Info_union r_info;	/* Relocation type and symbol index */
+  Elf64_Sxword	r_addend;		/* Addend */
+} Elf64_Mips_Rela;
+
+#define ELF64_MIPS_R_SYM(i) \
+  ((__extension__ (_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_sym)
+#define ELF64_MIPS_R_TYPE(i) \
+  (((_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_type1 \
+   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
+		   ).r_info_fields.r_type2 << 8) \
+   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
+		   ).r_info_fields.r_type3 << 16) \
+   | ((Elf32_Word)(__extension__ (_Elf64_Mips_R_Info_union)(i) \
+		   ).r_info_fields.r_ssym << 24))
+
 #if KERNEL_ELFDATA != HOST_ELFDATA
 
 static inline void __endian(const void *src, void *dest, unsigned int size)
