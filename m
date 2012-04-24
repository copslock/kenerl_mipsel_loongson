Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2012 20:24:56 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:47450 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903768Ab2DXSXc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Apr 2012 20:23:32 +0200
Received: by pbbrq13 with SMTP id rq13so415051pbb.36
        for <multiple recipients>; Tue, 24 Apr 2012 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VRFc0TINu+ruYMQcNQgAFnJt9OX77qSt/oQKfwMTzwg=;
        b=qGsKJGi5ltUHIwh3Zs5atS9X+UykfplIjMzPdcv63/cUCWxT8/vBNmY1W/HpDjWqkd
         nap9grLh38vUP30J6/KxYZrW2ZPy4yB+tppe5IR0W/axaIQjJmbp2MN9nE3lH7cLzp+W
         +s8XedWCBve5tqTbE7Ak+jY72RkJeV++FJsLPwSSC8V7e2kcYEIU1HJDNfjxXWFM5nWS
         kN3KHs5n3ofsL51YYqWVtL5BsB2cGrXNGD5FtKdT+VII17/0cldJFBcBLcw5oRixQo7p
         5XgJPoGZ0wWGPlc31sTVEAEukLWoam0dq/5iQL1Y5/E3ISwt53jWxci9kT1ZTnP7utys
         GIdg==
Received: by 10.68.132.41 with SMTP id or9mr24135pbb.30.1335291805773;
        Tue, 24 Apr 2012 11:23:25 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id d4sm18045165pbr.32.2012.04.24.11.23.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 11:23:23 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3OINL2n026733;
        Tue, 24 Apr 2012 11:23:21 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3OINLcU026732;
        Tue, 24 Apr 2012 11:23:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] scripts/sortextable: Handle relative entries, and other cleanups.
Date:   Tue, 24 Apr 2012 11:23:14 -0700
Message-Id: <1335291795-26693-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1335291795-26693-1-git-send-email-ddaney.cavm@gmail.com>
References: <1335291795-26693-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

x86 is now using relative rather than absolute addresses in its
exception table, so we add a sorter for these.  If there are
relocations on the __ex_table section, they are redundant after the
sort, so they are zeroed out leaving them valid and consistent.

Also use the unaligned safe accessors from tools/{be,le}_byteshift.h

Signed-off-by: David Daney <david.daney@cavium.com>
---
 scripts/Makefile      |    2 +
 scripts/sortextable.c |  171 ++++++++++++++++++++++++++++++++-----------------
 scripts/sortextable.h |   79 +++++++++++++++--------
 3 files changed, 164 insertions(+), 88 deletions(-)

diff --git a/scripts/Makefile b/scripts/Makefile
index 43e19b9..9eace52 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -15,6 +15,8 @@ hostprogs-$(CONFIG_IKCONFIG)     += bin2c
 hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount
 hostprogs-$(CONFIG_BUILDTIME_EXTABLE_SORT) += sortextable
 
+HOSTCFLAGS_sortextable.o = -I$(srctree)/tools/include
+
 always		:= $(hostprogs-y) $(hostprogs-m)
 
 # The following hostprogs-y programs are only build on demand
diff --git a/scripts/sortextable.c b/scripts/sortextable.c
index f51f1d4..1ca9ceb 100644
--- a/scripts/sortextable.c
+++ b/scripts/sortextable.c
@@ -1,7 +1,7 @@
 /*
  * sortextable.c: Sort the kernel's exception table
  *
- * Copyright 2011 Cavium, Inc.
+ * Copyright 2011 - 2012 Cavium, Inc.
  *
  * Based on code taken from recortmcount.c which is:
  *
@@ -28,6 +28,9 @@
 #include <string.h>
 #include <unistd.h>
 
+#include <tools/be_byteshift.h>
+#include <tools/le_byteshift.h>
+
 static int fd_map;	/* File descriptor for file being modified. */
 static int mmap_failed; /* Boolean flag. */
 static void *ehdr_curr; /* current ElfXX_Ehdr *  for resource cleanup */
@@ -94,109 +97,157 @@ static void *mmap_file(char const *fname)
 	return addr;
 }
 
-/* w8rev, w8nat, ...: Handle endianness. */
-
-static uint64_t w8rev(uint64_t const x)
+static uint64_t r8be(const uint64_t *x)
 {
-	return   ((0xff & (x >> (0 * 8))) << (7 * 8))
-	       | ((0xff & (x >> (1 * 8))) << (6 * 8))
-	       | ((0xff & (x >> (2 * 8))) << (5 * 8))
-	       | ((0xff & (x >> (3 * 8))) << (4 * 8))
-	       | ((0xff & (x >> (4 * 8))) << (3 * 8))
-	       | ((0xff & (x >> (5 * 8))) << (2 * 8))
-	       | ((0xff & (x >> (6 * 8))) << (1 * 8))
-	       | ((0xff & (x >> (7 * 8))) << (0 * 8));
+	return get_unaligned_be64(x);
 }
-
-static uint32_t w4rev(uint32_t const x)
+static uint32_t rbe(const uint32_t *x)
 {
-	return   ((0xff & (x >> (0 * 8))) << (3 * 8))
-	       | ((0xff & (x >> (1 * 8))) << (2 * 8))
-	       | ((0xff & (x >> (2 * 8))) << (1 * 8))
-	       | ((0xff & (x >> (3 * 8))) << (0 * 8));
+	return get_unaligned_be32(x);
 }
-
-static uint32_t w2rev(uint16_t const x)
+static uint16_t r2be(const uint16_t *x)
 {
-	return   ((0xff & (x >> (0 * 8))) << (1 * 8))
-	       | ((0xff & (x >> (1 * 8))) << (0 * 8));
+	return get_unaligned_be16(x);
 }
-
-static uint64_t w8nat(uint64_t const x)
+static uint64_t r8le(const uint64_t *x)
 {
-	return x;
+	return get_unaligned_le64(x);
 }
-
-static uint32_t w4nat(uint32_t const x)
+static uint32_t rle(const uint32_t *x)
+{
+	return get_unaligned_le32(x);
+}
+static uint16_t r2le(const uint16_t *x)
 {
-	return x;
+	return get_unaligned_le16(x);
 }
 
-static uint32_t w2nat(uint16_t const x)
+static void w8be(uint64_t val, uint64_t *x)
+{
+	put_unaligned_be64(val, x);
+}
+static void wbe(uint32_t val, uint32_t *x)
+{
+	put_unaligned_be32(val, x);
+}
+static void w2be(uint16_t val, uint16_t *x)
+{
+	put_unaligned_be16(val, x);
+}
+static void w8le(uint64_t val, uint64_t *x)
+{
+	put_unaligned_le64(val, x);
+}
+static void wle(uint32_t val, uint32_t *x)
+{
+	put_unaligned_le32(val, x);
+}
+static void w2le(uint16_t val, uint16_t *x)
 {
-	return x;
+	put_unaligned_le16(val, x);
 }
 
-static uint64_t (*w8)(uint64_t);
-static uint32_t (*w)(uint32_t);
-static uint32_t (*w2)(uint16_t);
+static uint64_t (*r8)(const uint64_t *);
+static uint32_t (*r)(const uint32_t *);
+static uint16_t (*r2)(const uint16_t *);
+static void (*w8)(uint64_t, uint64_t *);
+static void (*w)(uint32_t, uint32_t *);
+static void (*w2)(uint16_t, uint16_t *);
 
+typedef void (*table_sort_t)(char *, int);
 
 /* 32 bit and 64 bit are very similar */
 #include "sortextable.h"
 #define SORTEXTABLE_64
 #include "sortextable.h"
 
+static int compare_x86_table(const void *a, const void *b)
+{
+	int32_t av = (int32_t)r(a);
+	int32_t bv = (int32_t)r(b);
+
+	if (av < bv)
+		return -1;
+	if (av > bv)
+		return 1;
+	return 0;
+}
+
+static void sort_x86_table(char *extab_image, int image_size)
+{
+	int i;
+
+	/*
+	 * Do the same thing the runtime sort does, first normalize to
+	 * being relative to the start of the section.
+	 */
+	i = 0;
+	while (i < image_size) {
+		uint32_t *loc = (uint32_t *)(extab_image + i);
+		w(r(loc) + i, loc);
+		i += 4;
+	}
+
+	qsort(extab_image, image_size / 8, 8, compare_x86_table);
+
+	/* Now denormalize. */
+	i = 0;
+	while (i < image_size) {
+		uint32_t *loc = (uint32_t *)(extab_image + i);
+		w(r(loc) - i, loc);
+		i += 4;
+	}
+}
 
 static void
 do_file(char const *const fname)
 {
-	Elf32_Ehdr *const ehdr = mmap_file(fname);
+	table_sort_t custom_sort;
+	Elf32_Ehdr *ehdr = mmap_file(fname);
 
 	ehdr_curr = ehdr;
-	w = w4nat;
-	w2 = w2nat;
-	w8 = w8nat;
 	switch (ehdr->e_ident[EI_DATA]) {
-		static unsigned int const endian = 1;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
 			ehdr->e_ident[EI_DATA], fname);
 		fail_file();
 		break;
 	case ELFDATA2LSB:
-		if (*(unsigned char const *)&endian != 1) {
-			/* main() is big endian, file.o is little endian. */
-			w = w4rev;
-			w2 = w2rev;
-			w8 = w8rev;
-		}
+		r = rle;
+		r2 = r2le;
+		r8 = r8le;
+		w = wle;
+		w2 = w2le;
+		w8 = w8le;
 		break;
 	case ELFDATA2MSB:
-		if (*(unsigned char const *)&endian != 0) {
-			/* main() is little endian, file.o is big endian. */
-			w = w4rev;
-			w2 = w2rev;
-			w8 = w8rev;
-		}
+		r = rbe;
+		r2 = r2be;
+		r8 = r8be;
+		w = wbe;
+		w2 = w2be;
+		w8 = w8be;
 		break;
 	}  /* end switch */
 	if (memcmp(ELFMAG, ehdr->e_ident, SELFMAG) != 0
-	||  w2(ehdr->e_type) != ET_EXEC
+	||  r2(&ehdr->e_type) != ET_EXEC
 	||  ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
 		fprintf(stderr, "unrecognized ET_EXEC file %s\n", fname);
 		fail_file();
 	}
 
-	switch (w2(ehdr->e_machine)) {
+	custom_sort = NULL;
+	switch (r2(&ehdr->e_machine)) {
 	default:
 		fprintf(stderr, "unrecognized e_machine %d %s\n",
-			w2(ehdr->e_machine), fname);
+			r2(&ehdr->e_machine), fname);
 		fail_file();
 		break;
 	case EM_386:
-	case EM_MIPS:
 	case EM_X86_64:
+		custom_sort = sort_x86_table;
+		break;
+	case EM_MIPS:
 		break;
 	}  /* end switch */
 
@@ -207,23 +258,23 @@ do_file(char const *const fname)
 		fail_file();
 		break;
 	case ELFCLASS32:
-		if (w2(ehdr->e_ehsize) != sizeof(Elf32_Ehdr)
-		||  w2(ehdr->e_shentsize) != sizeof(Elf32_Shdr)) {
+		if (r2(&ehdr->e_ehsize) != sizeof(Elf32_Ehdr)
+		||  r2(&ehdr->e_shentsize) != sizeof(Elf32_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_EXEC file: %s\n", fname);
 			fail_file();
 		}
-		do32(ehdr, fname);
+		do32(ehdr, fname, custom_sort);
 		break;
 	case ELFCLASS64: {
 		Elf64_Ehdr *const ghdr = (Elf64_Ehdr *)ehdr;
-		if (w2(ghdr->e_ehsize) != sizeof(Elf64_Ehdr)
-		||  w2(ghdr->e_shentsize) != sizeof(Elf64_Shdr)) {
+		if (r2(&ghdr->e_ehsize) != sizeof(Elf64_Ehdr)
+		||  r2(&ghdr->e_shentsize) != sizeof(Elf64_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_EXEC file: %s\n", fname);
 			fail_file();
 		}
-		do64(ghdr, fname);
+		do64(ghdr, fname, custom_sort);
 		break;
 	}
 	}  /* end switch */
diff --git a/scripts/sortextable.h b/scripts/sortextable.h
index bb6aaf1..e4fd45b 100644
--- a/scripts/sortextable.h
+++ b/scripts/sortextable.h
@@ -1,7 +1,7 @@
 /*
  * sortextable.h
  *
- * Copyright 2011 Cavium, Inc.
+ * Copyright 2011 - 2012 Cavium, Inc.
  *
  * Some of this code was taken out of recordmcount.h written by:
  *
@@ -30,6 +30,7 @@
 #undef fn_ELF_R_SYM
 #undef fn_ELF_R_INFO
 #undef uint_t
+#undef _r
 #undef _w
 
 #ifdef SORTEXTABLE_64
@@ -51,6 +52,7 @@
 # define fn_ELF_R_SYM		fn_ELF64_R_SYM
 # define fn_ELF_R_INFO		fn_ELF64_R_INFO
 # define uint_t			uint64_t
+# define _r			r8
 # define _w			w8
 #else
 # define extable_ent_size	8
@@ -71,23 +73,24 @@
 # define fn_ELF_R_SYM		fn_ELF32_R_SYM
 # define fn_ELF_R_INFO		fn_ELF32_R_INFO
 # define uint_t			uint32_t
+# define _r			r
 # define _w			w
 #endif
 
 static int compare_extable(const void *a, const void *b)
 {
-	const uint_t *aa = a;
-	const uint_t *bb = b;
+	Elf_Addr av = _r(a);
+	Elf_Addr bv = _r(b);
 
-	if (_w(*aa) < _w(*bb))
+	if (av < bv)
 		return -1;
-	if (_w(*aa) > _w(*bb))
+	if (av > bv)
 		return 1;
 	return 0;
 }
 
 static void
-do_func(Elf_Ehdr *const ehdr, char const *const fname)
+do_func(Elf_Ehdr *ehdr, char const *const fname, table_sort_t custom_sort)
 {
 	Elf_Shdr *shdr;
 	Elf_Shdr *shstrtab_sec;
@@ -97,19 +100,31 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname)
 	Elf_Sym *sym;
 	Elf_Sym *sort_needed_sym;
 	Elf_Shdr *sort_needed_sec;
+	Elf_Rel *relocs = NULL;
+	int relocs_size;
 	uint32_t *sort_done_location;
 	const char *secstrtab;
 	const char *strtab;
+	char *extab_image;
+	int extab_index = 0;
 	int i;
 	int idx;
 
-	shdr = (Elf_Shdr *)((void *)ehdr + _w(ehdr->e_shoff));
-	shstrtab_sec = shdr + w2(ehdr->e_shstrndx);
-	secstrtab = (const char *)ehdr + _w(shstrtab_sec->sh_offset);
-	for (i = 0; i < w2(ehdr->e_shnum); i++) {
-		idx = w(shdr[i].sh_name);
-		if (strcmp(secstrtab + idx, "__ex_table") == 0)
+	shdr = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->e_shoff));
+	shstrtab_sec = shdr + r2(&ehdr->e_shstrndx);
+	secstrtab = (const char *)ehdr + _r(&shstrtab_sec->sh_offset);
+	for (i = 0; i < r2(&ehdr->e_shnum); i++) {
+		idx = r(&shdr[i].sh_name);
+		if (strcmp(secstrtab + idx, "__ex_table") == 0) {
 			extab_sec = shdr + i;
+			extab_index = i;
+		}
+		if ((r(&shdr[i].sh_type) == SHT_REL ||
+		     r(&shdr[i].sh_type) == SHT_RELA) &&
+		    r(&shdr[i].sh_info) == extab_index) {
+			relocs = (void *)ehdr + _r(&shdr[i].sh_offset);
+			relocs_size = _r(&shdr[i].sh_size);
+		}
 		if (strcmp(secstrtab + idx, ".symtab") == 0)
 			symtab_sec = shdr + i;
 		if (strcmp(secstrtab + idx, ".strtab") == 0)
@@ -127,21 +142,29 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname)
 		fprintf(stderr,	"no __ex_table in  file: %s\n", fname);
 		fail_file();
 	}
-	strtab = (const char *)ehdr + _w(strtab_sec->sh_offset);
+	strtab = (const char *)ehdr + _r(&strtab_sec->sh_offset);
 
-	/* Sort the table in place */
-	qsort((void *)ehdr + _w(extab_sec->sh_offset),
-	      (_w(extab_sec->sh_size) / extable_ent_size),
-	      extable_ent_size, compare_extable);
+	extab_image = (void *)ehdr + _r(&extab_sec->sh_offset);
+
+	if (custom_sort) {
+		custom_sort(extab_image, _r(&extab_sec->sh_size));
+	} else {
+		int num_entries = _r(&extab_sec->sh_size) / extable_ent_size;
+		qsort(extab_image, num_entries,
+		      extable_ent_size, compare_extable);
+	}
+	/* If there were relocations, we no longer need them. */
+	if (relocs)
+		memset(relocs, 0, relocs_size);
 
 	/* find main_extable_sort_needed */
 	sort_needed_sym = NULL;
-	for (i = 0; i < _w(symtab_sec->sh_size) / sizeof(Elf_Sym); i++) {
-		sym = (void *)ehdr + _w(symtab_sec->sh_offset);
+	for (i = 0; i < _r(&symtab_sec->sh_size) / sizeof(Elf_Sym); i++) {
+		sym = (void *)ehdr + _r(&symtab_sec->sh_offset);
 		sym += i;
 		if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
 			continue;
-		idx = w(sym->st_name);
+		idx = r(&sym->st_name);
 		if (strcmp(strtab + idx, "main_extable_sort_needed") == 0) {
 			sort_needed_sym = sym;
 			break;
@@ -153,16 +176,16 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname)
 			fname);
 		fail_file();
 	}
-	sort_needed_sec = &shdr[w2(sort_needed_sym->st_shndx)];
+	sort_needed_sec = &shdr[r2(&sort_needed_sym->st_shndx)];
 	sort_done_location = (void *)ehdr +
-		_w(sort_needed_sec->sh_offset) +
-		_w(sort_needed_sym->st_value) -
-		_w(sort_needed_sec->sh_addr);
+		_r(&sort_needed_sec->sh_offset) +
+		_r(&sort_needed_sym->st_value) -
+		_r(&sort_needed_sec->sh_addr);
 
+#if 1
 	printf("sort done marker at %lx\n",
-		(unsigned long) (_w(sort_needed_sec->sh_offset) +
-				 _w(sort_needed_sym->st_value) -
-				 _w(sort_needed_sec->sh_addr)));
+	       (unsigned long)((char *)sort_done_location - (char *)ehdr));
+#endif
 	/* We sorted it, clear the flag. */
-	*sort_done_location = 0;
+	w(0, sort_done_location);
 }
-- 
1.7.7.6
