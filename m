Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6TE2FRw001914
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 29 Jul 2002 07:02:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6TE2Frq001913
	for linux-mips-outgoing; Mon, 29 Jul 2002 07:02:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6TE1qRw001904
	for <linux-mips@oss.sgi.com>; Mon, 29 Jul 2002 07:01:53 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA25873;
	Mon, 29 Jul 2002 16:03:31 +0200 (MET DST)
Date: Mon, 29 Jul 2002 16:03:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Carsten Langgaard <carstenl@mips.com>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] Fix elf_check_arch() for MIPS and MIPS64
Message-ID: <Pine.GSO.3.96.1020729153024.22288E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 I've found no problems with the patch.  This version differs from the
previous one by minor grammar updates in comments only.

 If any specification changes happen later, we may update the sources
accordingly.  For now the patch lets binaries be properly identified and
either handled or rejected.  The MIPS port handles (o)32 binaries only, so
binfmt_elf only accepts binaries either marked as such or unmarked at all
(for compatibility with old tools).  The MIPS64 port handles both
n32/(n)64 and (o)32 binaries.  The former ones are either ELF64 (64) or
are marked ABI2 (n32) and they are handled by binfmt_elf.  The latter ones
are handled by binfmt_elf32. 

 Please remember, we do not *create* these numbers, we only *interpret*
them in binaries created elsewhere, so we'd better agree with them.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020719-mips64-elf-3
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips64/kernel/binfmt_elf32.c linux-mips-2.4.19-rc1-20020719/arch/mips64/kernel/binfmt_elf32.c
--- linux-mips-2.4.19-rc1-20020719.macro/arch/mips64/kernel/binfmt_elf32.c	2002-06-29 03:01:44.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/arch/mips64/kernel/binfmt_elf32.c	2002-07-23 23:15:27.000000000 +0000
@@ -27,8 +27,26 @@ typedef elf_greg_t elf_gregset_t[ELF_NGR
 typedef double elf_fpreg_t;
 typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
-#define elf_check_arch(x)	\
-	((x)->e_machine == EM_MIPS)
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(hdr)						\
+({									\
+	int __res = 1;							\
+	struct elfhdr *__h = (hdr);					\
+									\
+	if (__h->e_machine != EM_MIPS)					\
+		__res = 0;						\
+	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
+		__res = 0;						\
+	if ((__h->e_flags & EF_MIPS_ABI2) != 0)				\
+		__res = 0;						\
+	if (((__h->e_flags & EF_MIPS_ABI) != 0) &&			\
+	    ((__h->e_flags & EF_MIPS_ABI) != EF_MIPS_ABI_O32))		\
+		__res = 0;						\
+									\
+	__res;								\
+})
 
 #define TASK32_SIZE		0x80000000UL
 #undef ELF_ET_DYN_BASE
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/include/asm-mips/elf.h linux-mips-2.4.19-rc1-20020719/include/asm-mips/elf.h
--- linux-mips-2.4.19-rc1-20020719.macro/include/asm-mips/elf.h	2002-04-25 02:57:43.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/include/asm-mips/elf.h	2002-07-23 22:50:48.000000000 +0000
@@ -16,10 +16,11 @@
 #define EF_MIPS_ARCH_3      0x20000000  /* -mips3 code.  */
 #define EF_MIPS_ARCH_4      0x30000000  /* -mips4 code.  */
 #define EF_MIPS_ARCH_5      0x40000000  /* -mips5 code.  */
-#define EF_MIPS_ARCH_32     0x60000000  /* MIPS32 code.  */
-#define EF_MIPS_ARCH_64     0x70000000  /* MIPS64 code.  */
-#define EF_MIPS_ARCH_32R2   0x80000000  /* MIPS32 code.  */
-#define EF_MIPS_ARCH_64R2   0x90000000  /* MIPS64 code.  */
+#define EF_MIPS_ARCH_32     0x50000000  /* MIPS32 code.  */
+#define EF_MIPS_ARCH_64     0x60000000  /* MIPS64 code.  */
+/* The ABI of a file. */
+#define EF_MIPS_ABI_O32     0x00001000  /* O32 ABI.  */
+#define EF_MIPS_ABI_O64     0x00002000  /* O32 extended for 64 bit.  */
 
 typedef unsigned long elf_greg_t;
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
@@ -37,10 +38,12 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
 									\
 	if (__h->e_machine != EM_MIPS)					\
 		__res = 0;						\
-	if (((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_1) &&       	\
-	    ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_2) &&       	\
-	    ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_32) &&      	\
-	    ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_32R2))      	\
+	if (__h->e_ident[EI_CLASS] != ELFCLASS32)			\
+		__res = 0;						\
+	if ((__h->e_flags & EF_MIPS_ABI2) != 0)				\
+		__res = 0;						\
+	if (((__h->e_flags & EF_MIPS_ABI) != 0) &&			\
+	    ((__h->e_flags & EF_MIPS_ABI) != EF_MIPS_ABI_O32))		\
 		__res = 0;						\
 									\
 	__res;								\
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/include/asm-mips64/elf.h linux-mips-2.4.19-rc1-20020719/include/asm-mips64/elf.h
--- linux-mips-2.4.19-rc1-20020719.macro/include/asm-mips64/elf.h	2002-07-22 08:49:30.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/include/asm-mips64/elf.h	2002-07-23 23:12:28.000000000 +0000
@@ -9,21 +9,23 @@
 #include <asm/ptrace.h>
 #include <asm/user.h>
 
-#ifndef ELF_ARCH
-/* ELF register definitions */
-#define ELF_NGREG	45
-#define ELF_NFPREG	33
-
-/* ELF header e_flags defines. MIPS architecture level. */
+/* ELF header e_flags defines. */
+/* MIPS architecture level. */
 #define EF_MIPS_ARCH_1      0x00000000  /* -mips1 code.  */
 #define EF_MIPS_ARCH_2      0x10000000  /* -mips2 code.  */
 #define EF_MIPS_ARCH_3      0x20000000  /* -mips3 code.  */
 #define EF_MIPS_ARCH_4      0x30000000  /* -mips4 code.  */
 #define EF_MIPS_ARCH_5      0x40000000  /* -mips5 code.  */
-#define EF_MIPS_ARCH_32     0x60000000  /* MIPS32 code.  */
-#define EF_MIPS_ARCH_64     0x70000000  /* MIPS64 code.  */
-#define EF_MIPS_ARCH_32R2   0x80000000  /* MIPS32 code.  */
-#define EF_MIPS_ARCH_64R2   0x90000000  /* MIPS64 code.  */
+#define EF_MIPS_ARCH_32     0x50000000  /* MIPS32 code.  */
+#define EF_MIPS_ARCH_64     0x60000000  /* MIPS64 code.  */
+/* The ABI of a file. */
+#define EF_MIPS_ABI_O32     0x00001000  /* O32 ABI.  */
+#define EF_MIPS_ABI_O64     0x00002000  /* O32 extended for 64 bit.  */
+
+#ifndef ELF_ARCH
+/* ELF register definitions */
+#define ELF_NGREG	45
+#define ELF_NFPREG	33
 
 typedef unsigned long elf_greg_t;
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
@@ -41,14 +43,9 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
 									\
 	if (__h->e_machine != EM_MIPS)					\
 		__res = 0;						\
-	if (sizeof(elf_caddr_t) == 8 &&					\
-	    __h->e_ident[EI_CLASS] == ELFCLASS32)			\
-	        __res = 0;						\
-	if (((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_1) &&	\
-	    ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_2) &&	\
-	    ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_32) &&	\
-	    ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_32R2))	\
-                __res = 0;						\
+	if ((__h->e_ident[EI_CLASS] == ELFCLASS32) &&			\
+	    ((__h->e_flags & EF_MIPS_ABI2) == 0))			\
+		__res = 0;						\
 									\
 	__res;								\
 })
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/include/linux/elf.h linux-mips-2.4.19-rc1-20020719/include/linux/elf.h
--- linux-mips-2.4.19-rc1-20020719.macro/include/linux/elf.h	2002-07-22 08:49:30.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020719/include/linux/elf.h	2002-07-23 22:18:54.000000000 +0000
@@ -37,6 +37,9 @@ typedef __s64	Elf64_Sxword;
 #define EF_MIPS_NOREORDER 0x00000001
 #define EF_MIPS_PIC       0x00000002
 #define EF_MIPS_CPIC      0x00000004
+#define EF_MIPS_ABI2      0x00000020
+#define EF_MIPS_32BITMODE 0x00000100
+#define EF_MIPS_ABI       0x0000f000
 #define EF_MIPS_ARCH      0xf0000000
 
 /* These constants define the different elf file types */
