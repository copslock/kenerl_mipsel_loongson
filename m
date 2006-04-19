Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Apr 2006 03:09:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:62456 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133553AbWDSCJd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Apr 2006 03:09:33 +0100
Received: from localhost (p8141-ipad204funabasi.chiba.ocn.ne.jp [222.146.95.141])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E2DD5A744; Wed, 19 Apr 2006 11:22:01 +0900 (JST)
Date:	Wed, 19 Apr 2006 11:22:28 +0900 (JST)
Message-Id: <20060419.112228.108306767.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060417162742.GD28935@networkno.de>
References: <20060417140735.GC28935@networkno.de>
	<20060418.004718.108120830.anemo@mba.ocn.ne.jp>
	<20060417162742.GD28935@networkno.de>
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
X-archive-position: 11156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 17 Apr 2006 17:27:42 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> So it is the
> 
>       r.r_info   = TO_NATIVE(rela->r_info);
> 
> in modpost.c which breaks both SYM and TYPE because it assumes a
> 64bit integer. The proper solution would be to add a Elf64_Mips_Rela
> structure (with lots of nearly identical duplicated code), the hack
> would be to cast r_info to a 32bit integer for mips, before feeding
> it to TO_NATIVE (which works until somebody asks for the TYPE, then
> a separate mips64 version becomes inevitable.)

I'd like to fix in _proper_ way.  Please review.  Thanks.


64bit mips has different r_info layout.  This patch fixes modpost
segfault for 64bit little endian mips kernel.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index cd00e9f..4ce95c6 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -710,7 +710,20 @@ static void check_sec_ref(struct module 
 			Elf_Rela r;
 			const char *secname;
 			r.r_offset = TO_NATIVE(rela->r_offset);
+#if KERNEL_ELFCLASS == ELFCLASS64
+			if (hdr->e_machine == EM_MIPS) {
+				unsigned int r_sym =
+					ELF64_MIPS_R_SYM(rela->r_info);
+				unsigned int r_type =
+					ELF64_MIPS_R_TYPE(rela->r_info);
+				r.r_info = ELF_R_INFO(TO_NATIVE(r_sym),
+						      TO_NATIVE(r_type));
+			} else {
+				r.r_info = TO_NATIVE(rela->r_info);
+			}
+#else
 			r.r_info   = TO_NATIVE(rela->r_info);
+#endif
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
