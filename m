Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2010 22:44:49 +0200 (CEST)
Received: from bitwagon.com ([74.82.39.175]:46735 "HELO bitwagon.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1491156Ab0JXUoq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Oct 2010 22:44:46 +0200
Received: from f11-64.local ([67.171.188.169]) by bitwagon.com for <linux-mips@linux-mips.org>; Sun, 24 Oct 2010 13:44:35 -0700
Message-ID: <4CC49A99.1080601@bitwagon.com>
Date:   Sun, 24 Oct 2010 13:44:09 -0700
From:   John Reiser <jreiser@bitwagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc11 Thunderbird/3.0.4
MIME-Version: 1.0
To:     wu zhangjin <wuzhangjin@gmail.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: patch: [RFC 2/2] ftrace/MIPS: Add support for C version of recordmcount
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
In-Reply-To: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jreiser@bitwagon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jreiser@bitwagon.com
Precedence: bulk
X-list: linux-mips

On 10/23/2010, wu zhangjin wrote:

>   CC      init/main.o
> /bin/sh: line 1: 21835 Segmentation fault     scripts/recordmcount "init/main.o"
> make[1]: *** [init/main.o] Error 139


64-bit EM_MIPS has weird ELF64_Rela.info.  Adjust recordmcount.[ch].

Signed-off-by: John Reiser <jreiser@BitWagon.com>

[I don't know where the git repository for recordmcount.h is,
so I have used a temporary one.]

--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -212,11 +212,26 @@ is_mcounted_section_name(char const *const txtname)
 		0 == strcmp(".text.unlikely", txtname);
 }
 +
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
 #include "recordmcount.h"
+/* 64-bit EM_MIPS has weird ELF64_Rela.r_info */
+static uint64_t MIPS64_r_sym(Elf64_Xword xword)
+{
+	/* Perhaps this should be 40 bits, but kernel isn't that big. */
+	return 0xffffffff & xword;
+}
+
+static uint64_t MIPS64_r_info(Elf64_Xword sym, unsigned type)
+{
+	/* Type2 and Type3 are assumed zero.  [See "readelf --relocs".] */
+	return (((uint64_t)type)<<56) | sym;
+}
+
+
 static void
 do_file(char const *const fname)
 {
@@ -268,6 +283,7 @@ do_file(char const *const fname)
 	case EM_386:	 reltype = R_386_32;                   break;
 	case EM_ARM:	 reltype = R_ARM_ABS32;                break;
 	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
+	case EM_MIPS:	 /* reltype: e_class    */ gpfx = '_'; break;
 	case EM_PPC:	 reltype = R_PPC_ADDR32;   gpfx = '_'; break;
 	case EM_PPC64:	 reltype = R_PPC64_ADDR64; gpfx = '_'; break;
 	case EM_S390:    /* reltype: e_class    */ gpfx = '_'; break;
@@ -291,6 +307,8 @@ do_file(char const *const fname)
 		}
 		if (EM_S390 == w2(ehdr->e_machine))
 			reltype = R_390_32;
+		if (EM_MIPS == w2(ehdr->e_machine))
+			reltype = R_MIPS_32;
 		do32(ehdr, fname, reltype);
 	} break;
 	case ELFCLASS64: {
@@ -303,6 +321,11 @@ do_file(char const *const fname)
 		}
 		if (EM_S390 == w2(ghdr->e_machine))
 			reltype = R_390_64;
+		if (EM_MIPS == w2(ghdr->e_machine)) {
+			reltype = R_MIPS_64;
+			Elf_r_sym = MIPS64_r_sym;
+			Elf_r_info = MIPS64_r_info;
+		}
 		do64(ghdr, fname, reltype);
 	} break;
 	}  /* end switch */
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
+static uint_t fn_ELF_R_SYM(uint_t info)
+{
+	return ELF_R_SYM(info);
+}
+static uint_t (*Elf_r_sym)(uint_t info) = fn_ELF_R_SYM;
+
+static uint_t fn_ELF_R_INFO(uint_t sym, unsigned type)
+{
+	return ELF_R_INFO(sym, type);
+}
+static uint_t (*Elf_r_info)(uint_t sym, unsigned type) = fn_ELF_R_INFO;
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
+				&sym0[Elf_r_sym(_w(relp->r_info))];
 			char const *symname = &str0[w(symp->st_name)];
  			if ('.' == symname[0])
 				++symname;  /* ppc64 hack */
 			if (0 == strcmp((('_' == gpfx) ? "_mcount" : "mcount"),
 					symname))
-				mcountsym = ELF_R_SYM(_w(relp->r_info));
+				mcountsym = Elf_r_sym(_w(relp->r_info));
 		}
-		if (mcountsym == ELF_R_SYM(_w(relp->r_info))) {
+		if (mcountsym == Elf_r_sym(_w(relp->r_info))) {
 			uint_t const addend = _w(_w(relp->r_offset) - recval);
  			mrelp->r_offset = _w(offbase
 				+ ((void *)mlocp - (void *)mloc0));
-			mrelp->r_info = _w(ELF_R_INFO(recsym, reltype));
+			mrelp->r_info = _w(Elf_r_info(recsym, reltype));
 			if (sizeof(Elf_Rela) == rel_entsize) {
 				((Elf_Rela *)mrelp)->r_addend = addend;
 				*mlocp++ = 0;

-- 
John Reiser, jreiser@BitWagon.com
