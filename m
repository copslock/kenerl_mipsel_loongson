Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2010 12:59:58 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:49473 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490995Ab0J0K7b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Oct 2010 12:59:31 +0200
Received: by mail-iw0-f177.google.com with SMTP id 8so689267iwn.36
        for <multiple recipients>; Wed, 27 Oct 2010 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=VROtGz49fSNIb4fTKkwDmwFCkb9rw9VFFISzwog2WGk=;
        b=LKlZFzRAr3avyBLoBmoe5+gjLrOMnlj4LCHVO+Fjdlh6JVH9MQCuZ5Rd5S2+iPuJHz
         mgQslu0fYCOodYe+7aarjh6+wCM9UtECB46j/e1e2Qu+cTD2Txk9wqc3nDuZBTOOdYAo
         TKKQFHXOFnJPnAfPI8Gc7t6l0rxSBUDaZReN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C12dikx7VVLPmj2k76lZaopmZsNVXMj3kPaEWDvgghzVnWPnHhFjRTXGRmVdXIi5Ch
         DXndp2d/yyUiZIqzJNutq4QaqCwA4eZSv7HcYoSlDaxFMwziPUrYMkLf0x7bbvpUeX8U
         4jz/Nis6ebLFKO9CmKkwkh7ZRXomkoSWqp3dk=
Received: by 10.231.11.66 with SMTP id s2mr8391679ibs.167.1288177170778;
        Wed, 27 Oct 2010 03:59:30 -0700 (PDT)
Received: from localhost.localdomain ([61.48.71.2])
        by mx.google.com with ESMTPS id u6sm10943197ibd.12.2010.10.27.03.59.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 03:59:30 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     John Reiser <jreiser@bitwagon.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        John Reiser <jreiser@BitWagon.com>
Subject: [PATCH 1/3] ftrace/MIPS: Add MIPS64 support for C version of recordmcount
Date:   Wed, 27 Oct 2010 18:59:07 +0800
Message-Id: <910dc2d5ae1ed042df4f96815fe4a433078d1c2a.1288176026.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1288176026.git.wuzhangjin@gmail.com>
References: <cover.1288176026.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1288176026.git.wuzhangjin@gmail.com>
References: <cover.1288176026.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

MIPS64 has 'weird' Elf64_Rel.r_info[1,2], which must be used instead of
the generic Elf64_Rel.r_info, otherwise, the C version of recordmcount
will not work for "segmentation fault".

----
[1] http://techpubs.sgi.com/library/manuals/4000/007-4658-001/pdf/007-4658-001.pdf
[2] arch/mips/include/asm/module.h

Signed-off-by: John Reiser <jreiser@BitWagon.com>
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Tested-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 scripts/recordmcount.c |   41 +++++++++++++++++++++++++++++++++++++++++
 scripts/recordmcount.h |   34 ++++++++++++++++++++++++++++++----
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 26e1271..2d32b9c 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -217,6 +217,39 @@ is_mcounted_section_name(char const *const txtname)
 #define RECORD_MCOUNT_64
 #include "recordmcount.h"
 
+/* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
+ * http://techpubs.sgi.com/library/manuals/4000/007-4658-001/pdf/007-4658-001.pdf
+ * We interpret Table 29 Relocation Operation (Elf64_Rel, Elf64_Rela) [p.40]
+ * to imply the order of the members; the spec does not say so.
+ *	typedef unsigned char Elf64_Byte;
+ * fails on MIPS64 because their <elf.h> already has it!
+ */
+
+typedef uint8_t myElf64_Byte;		/* Type for a 8-bit quantity.  */
+
+union mips_r_info {
+	Elf64_Xword r_info;
+	struct {
+		Elf64_Word r_sym;		/* Symbol index.  */
+		myElf64_Byte r_ssym;		/* Special symbol.  */
+		myElf64_Byte r_type3;		/* Third relocation.  */
+		myElf64_Byte r_type2;		/* Second relocation.  */
+		myElf64_Byte r_type;		/* First relocation.  */
+	} r_mips;
+};
+
+static uint64_t MIPS64_r_sym(Elf64_Rel const *rp)
+{
+	return w(((union mips_r_info){ .r_info = rp->r_info }).r_mips.r_sym);
+}
+
+static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
+{
+	rp->r_info = ((union mips_r_info){
+		.r_mips = { .r_sym = w(sym), .r_type = type }
+	}).r_info;
+}
+
 static void
 do_file(char const *const fname)
 {
@@ -268,6 +301,7 @@ do_file(char const *const fname)
 	case EM_386:	 reltype = R_386_32;                   break;
 	case EM_ARM:	 reltype = R_ARM_ABS32;                break;
 	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
+	case EM_MIPS:	 /* reltype: e_class    */ gpfx = '_'; break;
 	case EM_PPC:	 reltype = R_PPC_ADDR32;   gpfx = '_'; break;
 	case EM_PPC64:	 reltype = R_PPC64_ADDR64; gpfx = '_'; break;
 	case EM_S390:    /* reltype: e_class    */ gpfx = '_'; break;
@@ -291,6 +325,8 @@ do_file(char const *const fname)
 		}
 		if (EM_S390 == w2(ehdr->e_machine))
 			reltype = R_390_32;
+		if (EM_MIPS == w2(ehdr->e_machine))
+			reltype = R_MIPS_32;
 		do32(ehdr, fname, reltype);
 	} break;
 	case ELFCLASS64: {
@@ -303,6 +339,11 @@ do_file(char const *const fname)
 		}
 		if (EM_S390 == w2(ghdr->e_machine))
 			reltype = R_390_64;
+		if (EM_MIPS == w2(ghdr->e_machine)) {
+			reltype = R_MIPS_64;
+			Elf64_r_sym = MIPS64_r_sym;
+			Elf64_r_info = MIPS64_r_info;
+		}
 		do64(ghdr, fname, reltype);
 	} break;
 	}  /* end switch */
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 7f39d09..190fd18 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -31,8 +31,12 @@
 #undef Elf_Rela
 #undef Elf_Sym
 #undef ELF_R_SYM
+#undef Elf_r_sym
 #undef ELF_R_INFO
+#undef Elf_r_info
 #undef ELF_ST_BIND
+#undef fn_ELF_R_SYM
+#undef fn_ELF_R_INFO
 #undef uint_t
 #undef _w
 #undef _align
@@ -52,8 +56,12 @@
 # define Elf_Rela		Elf64_Rela
 # define Elf_Sym		Elf64_Sym
 # define ELF_R_SYM		ELF64_R_SYM
+# define Elf_r_sym		Elf64_r_sym
 # define ELF_R_INFO		ELF64_R_INFO
+# define Elf_r_info		Elf64_r_info
 # define ELF_ST_BIND		ELF64_ST_BIND
+# define fn_ELF_R_SYM		fn_ELF64_R_SYM
+# define fn_ELF_R_INFO		fn_ELF64_R_INFO
 # define uint_t			uint64_t
 # define _w			w8
 # define _align			7u
@@ -72,14 +80,32 @@
 # define Elf_Rela		Elf32_Rela
 # define Elf_Sym		Elf32_Sym
 # define ELF_R_SYM		ELF32_R_SYM
+# define Elf_r_sym		Elf32_r_sym
 # define ELF_R_INFO		ELF32_R_INFO
+# define Elf_r_info		Elf32_r_info
 # define ELF_ST_BIND		ELF32_ST_BIND
+# define fn_ELF_R_SYM		fn_ELF32_R_SYM
+# define fn_ELF_R_INFO		fn_ELF32_R_INFO
 # define uint_t			uint32_t
 # define _w			w
 # define _align			3u
 # define _size			4
 #endif
 
+/* Functions and pointers that 64-bit EM_MIPS can override. */
+static uint_t fn_ELF_R_SYM(Elf_Rel const *rp)
+{
+	return ELF_R_SYM(_w(rp->r_info));
+}
+static uint_t (*Elf_r_sym)(Elf_Rel const *rp) = fn_ELF_R_SYM;
+
+static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
+{
+	rp->r_info = ELF_R_INFO(sym, type);
+}
+static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
+
+
 /* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations. */
 static void append_func(Elf_Ehdr *const ehdr,
 			Elf_Shdr *const shstr,
@@ -197,22 +223,22 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 	for (t = nrel; t; --t) {
 		if (!mcountsym) {
 			Elf_Sym const *const symp =
-				&sym0[ELF_R_SYM(_w(relp->r_info))];
+				&sym0[Elf_r_sym(relp)];
 			char const *symname = &str0[w(symp->st_name)];
 
 			if ('.' == symname[0])
 				++symname;  /* ppc64 hack */
 			if (0 == strcmp((('_' == gpfx) ? "_mcount" : "mcount"),
 					symname))
-				mcountsym = ELF_R_SYM(_w(relp->r_info));
+				mcountsym = Elf_r_sym(relp);
 		}
 
-		if (mcountsym == ELF_R_SYM(_w(relp->r_info))) {
+		if (mcountsym == Elf_r_sym(relp)) {
 			uint_t const addend = _w(_w(relp->r_offset) - recval);
 
 			mrelp->r_offset = _w(offbase
 				+ ((void *)mlocp - (void *)mloc0));
-			mrelp->r_info = _w(ELF_R_INFO(recsym, reltype));
+			Elf_r_info(mrelp, recsym, reltype);
 			if (sizeof(Elf_Rela) == rel_entsize) {
 				((Elf_Rela *)mrelp)->r_addend = addend;
 				*mlocp++ = 0;
-- 
1.7.1
