Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2010 13:00:48 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:54223 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491020Ab0J0K7m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Oct 2010 12:59:42 +0200
Received: by yxi11 with SMTP id 11so277081yxi.36
        for <multiple recipients>; Wed, 27 Oct 2010 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=r88Qf6iFq/22LlMdTcIr2KsKyDhPc241rfoEjVwkJpY=;
        b=Z54sU3tGn5Us+HCBIQe7w1PClp+RI7CCbvzgwE96i+uacv6lJ1LX+ZO0R9Bi3pfPux
         wjJ0AdGCTa5PyWUUOvAQ/S8YxUVbp3AHDXlR+IFgCMD4hdEdy8F4uxnTAV702/bVSsSb
         NDa2a+XEcZ/561gwGbW8oiggkBEer4y3EGv4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S1GSJ7MIP2U2uFNnSU+OyhL5uS63iWXNZUExRNXU5vPVEvDQ8JQIRrYQTW2uT+LfRi
         ztz5oMuC6FgD6Ef8n9fGdLqspLhLDsG2KypaH4/pi2syu34qvR9/wbyWVtruUzTF/bnw
         e+OSRixW3+gbVfaeShkTIwkfBHd5PCCSCuzcI=
Received: by 10.42.15.12 with SMTP id j12mr7477788ica.382.1288177175632;
        Wed, 27 Oct 2010 03:59:35 -0700 (PDT)
Received: from localhost.localdomain ([61.48.71.2])
        by mx.google.com with ESMTPS id u6sm10943197ibd.12.2010.10.27.03.59.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 03:59:34 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     John Reiser <jreiser@bitwagon.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/3] ftrace/MIPS: Add module support for C version of recordmcount
Date:   Wed, 27 Oct 2010 18:59:08 +0800
Message-Id: <b866f0138224340a132d31861fa3f9300dee30ac.1288176026.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1288176026.git.wuzhangjin@gmail.com>
References: <cover.1288176026.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1288176026.git.wuzhangjin@gmail.com>
References: <cover.1288176026.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Since MIPS modules' address space differs from the core kernel space, to access
the _mcount in the core kernel, the kernel functions in modules must use long
call (-mlong-calls): load the _mcount address into one register and jump to the
address stored by the register:

 c:  3c030000        lui     v1,0x0  <-------->  b label
           c: R_MIPS_HI16  _mcount
           c: R_MIPS_NONE  *ABS*
           c: R_MIPS_NONE  *ABS*
10:  64630000        daddiu  v1,v1,0
          10: R_MIPS_LO16 _mcount
          10: R_MIPS_NONE *ABS*
          10: R_MIPS_NONE *ABS*
14:	03e0082d 	move	at,ra
18:	0060f809 	jalr	v1
label:

In the old Perl version of recordmcount, we only need to record the position of
the 1st R_MIPS_HI16 type of _mcount, and later, in ftrace_make_nop(), replace
the instruction in this position by a "b label" and in ftrace_make_call(),
replace it back.

But, the default C version of recordmcount records all of the _mcount symbols,
so, we must filter the 2nd _mcount like the Perl version of recordmcount does.

The C version of recordmcount copes with the symbols before they are linked, So
It doesn't know the type of the symbols and therefore can not filter the
symbols as the Perl version of recordmcount does. But as we can see above, the
2nd _mcount symbols of the long call alawys follows the 1st _mcount symbol of
the same long call, which means the offset from the 1st to the 2nd is fixed, it
is 0x10-0xc = 4 here, 4 is the length of the 1st load instruciton, for MIPS has
fixed length of instructions, this offset is always 4.

And as we know, the _mcount is inserted into the entry of every kernel
function, the offset between the other _mcount's is expected to be always
bigger than 4. So, to filter the 2ns _mcount symbol of the long call, we can
simply check the offset between two _mcount symbols, If it is 4, then, filter
the 2nd _mcount symbol.

To avoid touching too much code, an 'empty' function fn_is_fake_mcount() is
added for all of the archs, and the specific archs can override it via chaning
the function pointer: is_fake_mcount in do_file() with the e_machine. e.g. This
patch adds MIPS_is_fake_mcount() to override the default fn_is_fake_mcount()
pointed by is_fake_mcount.

This fn_is_fake_mcount() checks if the _mcount symbol is fake, e.g. the 2nd
_mcount symbol of the long call is fake, for there are 2 _mcount symbols mapped
to one real mcount call, so, one of them is fake and must be filtered.

This fn_is_fake_mcount() is called in sift_rel_mcount() after finding the
_mcount symbols and before adding the _mcount symbol into mrelp, so, it can
prevent the fake mcount symbol going into the last __mcount_loc table.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 scripts/recordmcount.c |    5 +++-
 scripts/recordmcount.h |   56 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 2d32b9c..f2f32ee 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -325,8 +325,10 @@ do_file(char const *const fname)
 		}
 		if (EM_S390 == w2(ehdr->e_machine))
 			reltype = R_390_32;
-		if (EM_MIPS == w2(ehdr->e_machine))
+		if (EM_MIPS == w2(ehdr->e_machine)) {
 			reltype = R_MIPS_32;
+			is_fake_mcount32 = MIPS32_is_fake_mcount;
+		}
 		do32(ehdr, fname, reltype);
 	} break;
 	case ELFCLASS64: {
@@ -343,6 +345,7 @@ do_file(char const *const fname)
 			reltype = R_MIPS_64;
 			Elf64_r_sym = MIPS64_r_sym;
 			Elf64_r_info = MIPS64_r_info;
+			is_fake_mcount64 = MIPS64_is_fake_mcount;
 		}
 		do64(ghdr, fname, reltype);
 	} break;
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 190fd18..58e933a 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -19,12 +19,16 @@
  * Licensed under the GNU General Public License, version 2 (GPLv2).
  */
 #undef append_func
+#undef is_fake_mcount
+#undef fn_is_fake_mcount
+#undef MIPS_is_fake_mcount
 #undef sift_rel_mcount
 #undef find_secsym_ndx
 #undef __has_rel_mcount
 #undef has_rel_mcount
 #undef tot_relsize
 #undef do_func
+#undef Elf_Addr
 #undef Elf_Ehdr
 #undef Elf_Shdr
 #undef Elf_Rel
@@ -50,6 +54,10 @@
 # define has_rel_mcount		has64_rel_mcount
 # define tot_relsize		tot64_relsize
 # define do_func		do64
+# define is_fake_mcount		is_fake_mcount64
+# define fn_is_fake_mcount	fn_is_fake_mcount64
+# define MIPS_is_fake_mcount	MIPS64_is_fake_mcount
+# define Elf_Addr		Elf64_Addr
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
 # define Elf_Rel		Elf64_Rel
@@ -74,6 +82,10 @@
 # define has_rel_mcount		has32_rel_mcount
 # define tot_relsize		tot32_relsize
 # define do_func		do32
+# define is_fake_mcount		is_fake_mcount32
+# define fn_is_fake_mcount	fn_is_fake_mcount32
+# define MIPS_is_fake_mcount	MIPS32_is_fake_mcount
+# define Elf_Addr		Elf32_Addr
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
 # define Elf_Rel		Elf32_Rel
@@ -92,7 +104,13 @@
 # define _size			4
 #endif
 
-/* Functions and pointers that 64-bit EM_MIPS can override. */
+/* Functions and pointers that do_file() may override for specific e_machine. */
+static int fn_is_fake_mcount(Elf_Rel const *rp)
+{
+	return 0;
+}
+static int (*is_fake_mcount)(Elf_Rel const *rp) = fn_is_fake_mcount;
+
 static uint_t fn_ELF_R_SYM(Elf_Rel const *rp)
 {
 	return ELF_R_SYM(_w(rp->r_info));
@@ -105,6 +123,39 @@ static void fn_ELF_R_INFO(Elf_Rel *const rp, unsigned sym, unsigned type)
 }
 static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
 
+/*
+ * MIPS mcount long call has 2 _mcount symbols, only the position of the 1st
+ * _mcount symbol is needed for dynamic function tracer, with it, to disable
+ * tracing(ftrace_make_nop), the instruction in the position is replaced with
+ * the "b label" instruction, to enable tracing(ftrace_make_call), replace the
+ * instruction back. So, here, we set the 2nd one as fake and filter it.
+ *
+ * c:	3c030000	lui	v1,0x0		<-->	b	label
+ *		c: R_MIPS_HI16	_mcount
+ *		c: R_MIPS_NONE	*ABS*
+ *		c: R_MIPS_NONE	*ABS*
+ * 10:	64630000	daddiu	v1,v1,0
+ *		10: R_MIPS_LO16	_mcount
+ *		10: R_MIPS_NONE	*ABS*
+ *		10: R_MIPS_NONE	*ABS*
+ * 14:	03e0082d	move	at,ra
+ * 18:	0060f809	jalr	v1
+ * label:
+ */
+#define MIPS_FAKEMCOUNT_OFFSET	4
+
+static int MIPS_is_fake_mcount(Elf_Rel const *rp)
+{
+	static Elf_Addr old_r_offset;
+	Elf_Addr current_r_offset = _w(rp->r_offset);
+	int is_fake;
+
+	is_fake = old_r_offset &&
+		(current_r_offset - old_r_offset == MIPS_FAKEMCOUNT_OFFSET);
+	old_r_offset = current_r_offset;
+
+	return is_fake;
+}
 
 /* Append the new shstrtab, Elf_Shdr[], __mcount_loc and its relocations. */
 static void append_func(Elf_Ehdr *const ehdr,
@@ -183,7 +234,6 @@ static void append_func(Elf_Ehdr *const ehdr,
 	uwrite(fd_map, ehdr, sizeof(*ehdr));
 }
 
-
 /*
  * Look at the relocations in order to find the calls to mcount.
  * Accumulate the section offsets that are found, and their relocation info,
@@ -233,7 +283,7 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 				mcountsym = Elf_r_sym(relp);
 		}
 
-		if (mcountsym == Elf_r_sym(relp)) {
+		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
 			uint_t const addend = _w(_w(relp->r_offset) - recval);
 
 			mrelp->r_offset = _w(offbase
-- 
1.7.1
