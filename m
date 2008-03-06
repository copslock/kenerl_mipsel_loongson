Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 10:02:17 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:9607 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603259AbYCFJ5t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:57:49 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id C0802341DA;
	Thu,  6 Mar 2008 18:57:31 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id 6FEBD4F8FC; Thu,  6 Mar 2008 18:57:30 +0900 (JST)
Message-Id: <20080306094758.339979644@vergenet.net>
References: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:38 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>,
	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 01/12] kexec-tools: mipsel: mipsel port
Content-Disposition: inline; filename=kexec-mips.patch
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

From: Francesco Chiechi <francesco.chiechi@colibre.it>

Hello,

We developed a patch to port kexec-tools to mips arch and included support for 
command line passing through elf boot notes.
We did it for a customer of ours on a specific platform derived from toshiba 
tx4938 (so we think it should work at least for tx4938 evaluation board also).
We would like to contribute it in case somebody else needs it or wants to 
improve it.
This patch works for us but the assembler part in particular, should be 
considered as a starting point because my assembly knowledge is not too deep.

As this is the first time I submit a patch I tried to guess reading tpp.txt if 
this is the right way to submit. Please let me know about any mistakes I may 
have made.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

Wed, 27 Feb 2008 19:25:00 +0900
* Simon Horman <horms@verge.net.au>
- Upported to 20080227 release
- Note the #ifdef __MIPSEL__ stuff needs to be moved into kexec/arch/mipsel

Thu, 06 Mar 2008 18:19:22 +0900
* Simon Horman <horms@verge.net.au>
- Use tabs for indentation

 configure.ac                             |    2 
 kexec/arch/mipsel/Makefile               |    7 +
 kexec/arch/mipsel/include/arch/options.h |   11 +
 kexec/arch/mipsel/kexec-elf-mipsel.c     |  184 ++++++++++++++++++++++++++++++
 kexec/arch/mipsel/kexec-elf-rel-mipsel.c |   42 ++++++
 kexec/arch/mipsel/kexec-mipsel.c         |  167 +++++++++++++++++++++++++++
 kexec/arch/mipsel/kexec-mipsel.h         |   17 ++
 kexec/arch/mipsel/mipsel-setup-simple.S  |  110 +++++++++++++++++
 kexec/crashdump.c                        |    1 
 kexec/kexec-syscall.h                    |    3 
 kexec/kexec.c                            |  104 ++++++++++++++++
 purgatory/arch/mipsel/Makefile           |    7 +
 purgatory/arch/mipsel/console-mipsel.c   |    5 
 purgatory/arch/mipsel/include/limits.h   |   58 +++++++++
 purgatory/arch/mipsel/include/stdint.h   |   16 ++
 purgatory/arch/mipsel/purgatory-mipsel.c |    7 +
 purgatory/arch/mipsel/purgatory-mipsel.h |    6 
 17 files changed, 746 insertions(+), 1 deletion(-)

Index: kexec-tools-mips/configure.ac
===================================================================
--- kexec-tools-mips.orig/configure.ac	2008-02-27 18:05:46.000000000 +0900
+++ kexec-tools-mips/configure.ac	2008-02-27 18:05:49.000000000 +0900
@@ -38,7 +38,7 @@ case $target_cpu in
 	sh4|sh4a|sh3|sh )
 		ARCH="sh"
 		;;
-	ia64|x86_64|alpha )
+	ia64|x86_64|alpha|mipsel )
 		ARCH="$target_cpu"
 		;;
 	* )
Index: kexec-tools-mips/kexec/arch/mipsel/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/kexec/arch/mipsel/Makefile	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,7 @@
+#
+# kexec mipsel (linux booting linux)
+#
+KEXEC_C_SRCS+= kexec/arch/mipsel/kexec-mipsel.c
+KEXEC_C_SRCS+= kexec/arch/mipsel/kexec-elf-mipsel.c
+KEXEC_C_SRCS+= kexec/arch/mipsel/kexec-elf-rel-mipsel.c
+KEXEC_S_SRCS+= kexec/arch/mipsel/mipsel-setup-simple.S
Index: kexec-tools-mips/kexec/arch/mipsel/include/arch/options.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/kexec/arch/mipsel/include/arch/options.h	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,11 @@
+#ifndef KEXEC_ARCH_MIPS_OPTIONS_H
+#define KEXEC_ARCH_MIPS_OPTIONS_H
+
+#define OPT_ARCH_MAX   (OPT_MAX+0)
+
+#define KEXEC_ARCH_OPTIONS \
+	KEXEC_OPTIONS \
+
+#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
+
+#endif /* KEXEC_ARCH_MIPS_OPTIONS_H */
Index: kexec-tools-mips/kexec/arch/mipsel/kexec-elf-mipsel.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,184 @@
+/*
+ * kexec-elf-mipsel.c - kexec Elf loader for mips
+ * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
+ * Copyright (C) 2007 Tvblob s.r.l.
+ *
+ * derived from ../ppc/kexec-elf-ppc.c
+ * Copyright (C) 2004 Albert Herranz
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+*/
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <elf.h>
+#include <boot/elf_boot.h>
+#include <ip_checksum.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "kexec-mipsel.h"
+#include <arch/options.h>
+
+static const int probe_debug = 0;
+
+#define BOOTLOADER         "kexec"
+#define BOOTLOADER_VERSION VERSION
+#define MAX_COMMAND_LINE   256
+
+#define UPSZ(X) ((sizeof(X) + 3) & ~3)
+static struct boot_notes {
+	Elf_Bhdr hdr;
+	Elf_Nhdr bl_hdr;
+	unsigned char bl_desc[UPSZ(BOOTLOADER)];
+	Elf_Nhdr blv_hdr;
+	unsigned char blv_desc[UPSZ(BOOTLOADER_VERSION)];
+	Elf_Nhdr cmd_hdr;
+	unsigned char command_line[0];
+} elf_boot_notes = {
+	.hdr = {
+		.b_signature = 0x0E1FB007,
+		.b_size = sizeof(elf_boot_notes),
+		.b_checksum = 0,
+		.b_records = 3,
+	},
+	.bl_hdr = {
+		.n_namesz = 0,
+		.n_descsz = sizeof(BOOTLOADER),
+		.n_type = EBN_BOOTLOADER_NAME,
+	},
+	.bl_desc = BOOTLOADER,
+	.blv_hdr = {
+		.n_namesz = 0,
+		.n_descsz = sizeof(BOOTLOADER_VERSION),
+		.n_type = EBN_BOOTLOADER_VERSION,
+	},
+	.blv_desc = BOOTLOADER_VERSION,
+	.cmd_hdr = {
+		.n_namesz = 0,
+		.n_descsz = 0,
+		.n_type = EBN_COMMAND_LINE,
+	},
+};
+
+
+int elf_mipsel_probe(const char *buf, off_t len)
+{
+
+	struct mem_ehdr ehdr;
+	int result;
+	result = build_elf_exec_info(buf, len, &ehdr, 0);
+	if (result < 0) {
+		goto out;
+	}
+
+	/* Verify the architecuture specific bits */
+	if (ehdr.e_machine != EM_MIPS) {
+		/* for a different architecture */
+		if (probe_debug) {
+			fprintf(stderr, "Not for this architecture.\n");
+		}
+		result = -1;
+		goto out;
+	}
+	result = 0;
+ out:
+	free_elf_info(&ehdr);
+	return result;
+}
+
+void elf_mipsel_usage(void)
+{
+	printf
+	    (
+	     "    --command-line=STRING Set the kernel command line to STRING.  \n"
+	     "    --append=STRING       Set the kernel command line to STRING.  \n");
+}
+
+int elf_mipsel_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info)
+{
+	struct mem_ehdr ehdr;
+	char *arg_buf;
+	size_t arg_bytes;
+	unsigned long arg_base;
+	struct boot_notes *notes;
+	size_t note_bytes;
+	const char *command_line;
+	int command_line_len;
+	unsigned char *setup_start;
+	uint32_t setup_size;
+	int result;
+	int opt;
+	int i;
+#define OPT_APPEND     (OPT_ARCH_MAX+0)
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{"command-line", 1, 0, OPT_APPEND},
+		{"append",       1, 0, OPT_APPEND},
+		{0, 0, 0, 0},
+	};
+
+	static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
+
+	command_line = 0;
+	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
+		switch (opt) {
+		default:
+			/* Ignore core options */
+			if (opt < OPT_ARCH_MAX) {
+				break;
+			}
+		case '?':
+			usage();
+			return -1;
+		case OPT_APPEND:
+			command_line = optarg;
+			break;
+		}
+	}
+	command_line_len = 0;
+	setup_simple_regs.spr9 = 0;
+	if (command_line) {
+		command_line_len = strlen(command_line) + 1;
+		setup_simple_regs.spr9 = 2;
+	}
+
+	/* Load the ELF executable */
+	elf_exec_build_load(info, &ehdr, buf, len, 0);
+
+	setup_start = setup_simple_start;
+	setup_size = setup_simple_size;
+	setup_simple_regs.spr8 = ehdr.e_entry;
+
+	note_bytes = sizeof(elf_boot_notes) + ((command_line_len + 3) & ~3);
+	arg_bytes = note_bytes + ((setup_size + 3) & ~3);
+
+	arg_buf = xmalloc(arg_bytes);
+	arg_base = add_buffer_virt(info,
+		 arg_buf, arg_bytes, arg_bytes, 4, 0, elf_max_addr(&ehdr), 1);
+
+	notes = (struct boot_notes *)(arg_buf + ((setup_size + 3) & ~3));
+
+	memcpy(arg_buf, setup_start, setup_size);
+	memcpy(notes, &elf_boot_notes, sizeof(elf_boot_notes));
+	memcpy(notes->command_line, command_line, command_line_len);
+
+	notes->hdr.b_size = note_bytes;
+	notes->cmd_hdr.n_descsz = command_line_len;
+	notes->hdr.b_checksum = compute_ip_checksum(notes, note_bytes);
+
+	info->entry = (void *)arg_base;
+
+	return 0;
+}
+
Index: kexec-tools-mips/kexec/arch/mipsel/kexec-elf-rel-mipsel.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/kexec/arch/mipsel/kexec-elf-rel-mipsel.c	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,42 @@
+/*
+ * kexec-elf-rel-mipsel.c - kexec Elf relocation routines
+ * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
+ * Copyright (C) 2007 Tvblob s.r.l.
+ *
+ * derived from ../ppc/kexec-elf-rel-ppc.c
+ * Copyright (C) 2004 Albert Herranz
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+*/
+
+#include <stdio.h>
+#include <elf.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+
+int machine_verify_elf_rel(struct mem_ehdr *ehdr)
+{
+	if (ehdr->ei_data != ELFDATA2MSB) {
+		return 0;
+	}
+	if (ehdr->ei_class != ELFCLASS32) {
+		return 0;
+	}
+	if (ehdr->e_machine != EM_MIPS) {
+		return 0;
+	}
+	return 1;
+}
+
+void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
+	void *location, unsigned long address, unsigned long value)
+{
+	switch(r_type) {
+
+	default:
+		die("Unknown rela relocation: %lu\n", r_type);
+		break;
+	}
+	return;
+}
Index: kexec-tools-mips/kexec/arch/mipsel/kexec-mipsel.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/kexec/arch/mipsel/kexec-mipsel.c	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,167 @@
+/*
+ * kexec-mipsel.c - kexec for mips
+ * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
+ * Copyright (C) 2007 Tvblob s.r.l.
+ *
+ * derived from ../ppc/kexec-mipsel.c
+ * Copyright (C) 2004, 2005 Albert Herranz
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <stddef.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <getopt.h>
+#include <sys/utsname.h>
+#include "../../kexec.h"
+#include "../../kexec-syscall.h"
+#include "kexec-mipsel.h"
+#include <arch/options.h>
+
+#define MAX_MEMORY_RANGES  64
+#define MAX_LINE          160
+static struct memory_range memory_range[MAX_MEMORY_RANGES];
+
+/* Return a sorted list of memory ranges. */
+int get_memory_ranges(struct memory_range **range, int *ranges, unsigned long kexec_flags)
+{
+	int memory_ranges = 0;
+
+#if 1
+	/* this is valid for gemini2 platform based on tx4938
+	 * in our case, /proc/iomem doesn't report ram space
+	 */
+	 memory_range[memory_ranges].start = 0x00000000;
+	 memory_range[memory_ranges].end = 0x04000000;
+	 memory_range[memory_ranges].type = RANGE_RAM;
+	 memory_ranges++;
+#else
+#error Please, fix this for your platform
+	const char iomem[] = "/proc/iomem";
+	char line[MAX_LINE];
+	FILE *fp;
+	unsigned long long start, end;
+	char *str;
+	int type, consumed, count;
+
+	fp = fopen(iomem, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n", iomem, strerror(errno));
+		return -1;
+	}
+	while (fgets(line, sizeof(line), fp) != 0) {
+		if (memory_ranges >= MAX_MEMORY_RANGES)
+			break;
+		count = sscanf(line, "%Lx-%Lx : %n", &start, &end, &consumed);
+		if (count != 2)
+			continue;
+		str = line + consumed;
+		end = end + 1;
+#if 0
+		printf("%016Lx-%016Lx : %s\n", start, end, str);
+#endif
+		if (memcmp(str, "System RAM\n", 11) == 0) {
+			type = RANGE_RAM;
+		} else if (memcmp(str, "reserved\n", 9) == 0) {
+			type = RANGE_RESERVED;
+		} else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
+			type = RANGE_ACPI;
+		} else if (memcmp(str, "ACPI Non-volatile Storage\n", 26) == 0) {
+			type = RANGE_ACPI_NVS;
+		} else {
+			continue;
+		}
+		memory_range[memory_ranges].start = start;
+		memory_range[memory_ranges].end = end;
+		memory_range[memory_ranges].type = type;
+#if 0
+		printf("%016Lx-%016Lx : %x\n", start, end, type);
+#endif
+		memory_ranges++;
+	}
+	fclose(fp);
+#endif
+
+	*range = memory_range;
+	*ranges = memory_ranges;
+	return 0;
+}
+
+struct file_type file_type[] = {
+	{"elf-mipsel", elf_mipsel_probe, elf_mipsel_load, elf_mipsel_usage},
+};
+int file_types = sizeof(file_type) / sizeof(file_type[0]);
+
+void arch_usage(void)
+{
+}
+
+static struct {
+} arch_options = {
+};
+int arch_process_options(int argc, char **argv)
+{
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ 0,                    0, NULL, 0 },
+	};
+	static const char short_options[] = KEXEC_ARCH_OPT_STR;
+	int opt;
+	unsigned long value;
+	char *end;
+
+	opterr = 0; /* Don't complain about unrecognized options here */
+	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
+		switch(opt) {
+		default:
+			break;
+		}
+	}
+	/* Reset getopt for the next pass; called in other source modules */
+	opterr = 1;
+	optind = 1;
+	return 0;
+}
+
+int arch_compat_trampoline(struct kexec_info *info)
+{
+	int result;
+	struct utsname utsname;
+	result = uname(&utsname);
+	if (result < 0) {
+		fprintf(stderr, "uname failed: %s\n",
+			strerror(errno));
+		return -1;
+	}
+	 if (strcmp(utsname.machine, "mips") == 0)
+	 {
+		 /* For compatibility with older patches
+		  * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_MIPS here.
+		  */
+		info->kexec_flags |= KEXEC_ARCH_DEFAULT;
+	 }
+	else {
+		fprintf(stderr, "Unsupported machine type: %s\n",
+			utsname.machine);
+		return -1;
+	}
+	return 0;
+}
+
+void arch_update_purgatory(struct kexec_info *info)
+{
+}
+
+/*
+ * Adding a dummy function, so that build on mipsel will not break.
+ * Need to implement the actual checking code
+ */
+int is_crashkernel_mem_reserved(void)
+{
+	return 1;
+}
+
Index: kexec-tools-mips/kexec/arch/mipsel/kexec-mipsel.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/kexec/arch/mipsel/kexec-mipsel.h	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,17 @@
+#ifndef KEXEC_MIPS_H
+#define KEXEC_MIPS_H
+
+extern unsigned char setup_simple_start[];
+extern uint32_t setup_simple_size;
+
+extern struct {
+	uint32_t spr8;
+	uint32_t spr9;
+} setup_simple_regs;
+
+int elf_mipsel_probe(const char *buf, off_t len);
+int elf_mipsel_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info);
+void elf_mipsel_usage(void);
+
+#endif /* KEXEC_MIPS_H */
Index: kexec-tools-mips/kexec/arch/mipsel/mipsel-setup-simple.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/kexec/arch/mipsel/mipsel-setup-simple.S	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,110 @@
+/*
+ * mipsel-setup-simple.S - code to execute before kernel to handle command line
+ * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
+ * Copyright (C) 2007 Tvblob s.r.l.
+ *
+ * derived from Albert Herranz idea (ppc) adding command line support
+ * (boot_notes structure)
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+/*
+ * Only suitable for platforms booting with MMU turned off.
+ * -- Albert Herranz
+ */
+#include "regdef.h"
+
+/* returns  t0 = relocated address of sym */
+/* modifies t1 t2 */
+/* sym must not be global or this will not work (at least AFAIK up to now) */
+#define RELOC_SYM(sym)                                                 \
+	move    t0,ra;          /* save ra */                           \
+	bal 1f;                                                         \
+1:                                                                     \
+	move    t1,ra;          /* now t1 is 1b (where we are now) */   \
+	move    ra,t0;          /* restore ra */                        \
+	lui     t2,%hi(1b);                                             \
+	ori     t2,t2,%lo(1b);                                          \
+	lui     t0,%hi(sym);                                            \
+	ori     t0,t0,%lo(sym);                                         \
+	sub     t0,t0,t2;       /* t0 = offset between sym and 1b */    \
+	add     t0,t1,t0;       /* t0 = actual address in memory */
+
+	.data
+	.globl setup_simple_start
+setup_simple_start:
+
+	/* should perform here any required setup */
+
+	/* Initialize GOT pointer (verify if needed) */
+	bal     1f
+	nop
+	.word   _GLOBAL_OFFSET_TABLE_
+	1:
+	move    gp, ra
+	lw      t1, 0(ra)
+	move    gp, t1
+
+	/* spr8 relocation */
+	RELOC_SYM(spr8)
+
+	move    t4,t0           // save pointer to kernel start addr
+	lw      t3,0(t0)        // save kernel start address
+
+	/* spr9 relocation */
+	RELOC_SYM(spr9)
+	lw      a0,0(t0)        // load argc
+
+	// this code is to be changed if boot_notes struct changes
+	lw      t2,12(t4)       // t2 is size of boot_notes struct
+	addi    t2,t2,3
+	srl     t2,t2,2
+	sll     v1,t2,2         // v1 = size of boot_notes struct
+				// aligned to word boundary
+
+	addi    t0,t4,0x20      // t0 contains the address of "kexec" string
+	add     v0,t4,v1        // v0 points to last word of boot_notes
+	addi    v0,v0,8         // v0 points to address after boot_notes
+	sw      t0,0(v0)        // store pointer to "kexec" string there
+
+	lw      t2,-8(t0)       // t2 is size of "kexec" string in bytes
+	addi    t2,t2,3
+	srl     t2,t2,2
+	sll     v1,t2,2         // v1 = size of "kexec" string
+				// aligned to word boundary
+	add     t2,t0,v1
+	addi    t0,t2,4         // t0 points to size of version string
+
+	lw      t2,0(t0)        // t2 is size of version string in bytes
+	addi    t2,t2,3
+	srl     t2,t2,2
+	sll     v1,t2,2         // v1 = size of version string
+				// aligned to word boundary
+
+	addi    t0,t0,8         // t0 points to version string
+	add     t0,t0,v1        // t0 points to start of command_line record
+	addi    t0,t0,12        // t0 points command line
+
+	sw      t0,4(v0)        // store pointer to command line
+
+	move    a1,v0           // load argv
+	li      a2,0
+	li      a3,0
+
+	jr      t3
+	nop
+
+	.balign 4
+	.globl setup_simple_regs
+setup_simple_regs:
+spr8:	.long 0x00000000
+spr9:	.long 0x00000000
+
+setup_simple_end:
+
+	.globl setup_simple_size
+setup_simple_size:
+	.long setup_simple_end - setup_simple_start
+
Index: kexec-tools-mips/kexec/crashdump.c
===================================================================
--- kexec-tools-mips.orig/kexec/crashdump.c	2008-02-27 18:05:46.000000000 +0900
+++ kexec-tools-mips/kexec/crashdump.c	2008-02-27 18:05:49.000000000 +0900
@@ -22,6 +22,7 @@
 #include <string.h>
 #include <errno.h>
 #include <limits.h>
+#include <linux/limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
Index: kexec-tools-mips/kexec/kexec-syscall.h
===================================================================
--- kexec-tools-mips.orig/kexec/kexec-syscall.h	2008-02-27 18:05:46.000000000 +0900
+++ kexec-tools-mips/kexec/kexec-syscall.h	2008-02-27 18:05:49.000000000 +0900
@@ -49,6 +49,9 @@
 #ifdef __arm__
 #define __NR_kexec_load		__NR_SYSCALL_BASE + 347  
 #endif
+#ifdef __MIPSEL__
+#define __NR_kexec_load                4311
+#endif
 #ifndef __NR_kexec_load
 #error Unknown processor architecture.  Needs a kexec_load syscall number.
 #endif
Index: kexec-tools-mips/kexec/kexec.c
===================================================================
--- kexec-tools-mips.orig/kexec/kexec.c	2008-02-27 18:05:46.000000000 +0900
+++ kexec-tools-mips/kexec/kexec.c	2008-02-27 18:05:49.000000000 +0900
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2003-2005  Eric Biederman (ebiederm@xmission.com)
  *
+ * Modified (2007-05-15) by Francesco Chiechi to rudely handle mips platform
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation (version 2 of the License).
@@ -42,6 +44,10 @@
 #include "kexec-sha256.h"
 #include <arch/options.h>
 
+#ifdef __MIPSEL__
+#define virt_to_phys(X) ((X) - 0x80000000)
+#endif
+
 unsigned long long mem_min = 0;
 unsigned long long mem_max = ULONG_MAX;
 
@@ -290,6 +296,74 @@ void add_segment(struct kexec_info *info
 	unsigned long last;
 	size_t size;
 	int pagesize;
+#ifdef __MIPSEL__
+	unsigned long base_phys;
+#endif
+
+	if (bufsz > memsz) {
+		bufsz = memsz;
+	}
+	/* Forget empty segments */
+	if (memsz == 0) {
+		return;
+	}
+
+	/* Round memsz up to a multiple of pagesize */
+	pagesize = getpagesize();
+	memsz = (memsz + (pagesize - 1)) & ~(pagesize - 1);
+
+#ifdef __MIPSEL__
+	base_phys=virt_to_phys(base);
+#endif
+	/* Verify base is pagesize aligned.
+	 * Finding a way to cope with this problem
+	 * is important but for now error so at least
+	 * we are not surprised by the code doing the wrong
+	 * thing.
+	 */
+	if (base & (pagesize -1)) {
+		die("Base address: %x is not page aligned\n", base);
+	}
+
+#ifdef __MIPSEL__
+	last = base_phys + memsz -1;
+	if (!valid_memory_range(info, base_phys, last)) {
+		die("Invalid memory segment %p - %p\n",
+			(void *)base_phys, (void *)last);
+	}
+#else
+	last = base + memsz -1;
+	if (!valid_memory_range(info, base, last)) {
+		die("Invalid memory segment %p - %p\n",
+			(void *)base, (void *)last);
+	}
+#endif
+
+	size = (info->nr_segments + 1) * sizeof(info->segment[0]);
+	info->segment = xrealloc(info->segment, size);
+	info->segment[info->nr_segments].buf   = buf;
+	info->segment[info->nr_segments].bufsz = bufsz;
+#ifdef __MIPSEL__
+	info->segment[info->nr_segments].mem   = (void *)base_phys;
+#else
+	info->segment[info->nr_segments].mem   = (void *)base;
+#endif
+	info->segment[info->nr_segments].memsz = memsz;
+	info->nr_segments++;
+	if (info->nr_segments > KEXEC_MAX_SEGMENTS) {
+		fprintf(stderr, "Warning: kernel segment limit reached. "
+			"This will likely fail\n");
+	}
+}
+
+#ifdef __MIPSEL__
+void add_segment_virt(struct kexec_info *info,
+	const void *buf, size_t bufsz,
+	unsigned long base, size_t memsz)
+{
+	unsigned long last;
+	size_t size;
+	int pagesize;
 
 	if (bufsz > memsz) {
 		bufsz = memsz;
@@ -331,6 +405,7 @@ void add_segment(struct kexec_info *info
 			"This will likely fail\n");
 	}
 }
+#endif
 
 unsigned long add_buffer(struct kexec_info *info,
 	const void *buf, unsigned long bufsz, unsigned long memsz,
@@ -359,6 +434,35 @@ unsigned long add_buffer(struct kexec_in
 	return base;
 }
 
+#ifdef __MIPSEL__
+unsigned long add_buffer_virt(struct kexec_info *info,
+	const void *buf, unsigned long bufsz, unsigned long memsz,
+	unsigned long buf_align, unsigned long buf_min, unsigned long buf_max,
+	int buf_end)
+{
+	unsigned long base;
+	int result;
+	int pagesize;
+
+	result = sort_segments(info);
+	if (result < 0) {
+		die("sort_segments failed\n");
+	}
+
+	/* Round memsz up to a multiple of pagesize */
+	pagesize = getpagesize();
+	memsz = (memsz + (pagesize - 1)) & ~(pagesize - 1);
+
+	base = locate_hole(info, memsz, buf_align, buf_min, buf_max, buf_end);
+	if (base == ULONG_MAX) {
+		die("locate_hole failed\n");
+	}
+
+	add_segment_virt(info, buf, bufsz, base, memsz);
+	return base;
+}
+#endif
+
 char *slurp_file(const char *filename, off_t *r_size)
 {
 	int fd;
Index: kexec-tools-mips/purgatory/arch/mipsel/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/purgatory/arch/mipsel/Makefile	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,7 @@
+#
+# Purgatory mipsel
+#
+
+PURGATORY_C_SRCS+= purgatory/arch/mipsel/purgatory-mipsel.c
+PURGATORY_C_SRCS+= purgatory/arch/mipsel/console-mipsel.c
+
Index: kexec-tools-mips/purgatory/arch/mipsel/console-mipsel.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/purgatory/arch/mipsel/console-mipsel.c	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,5 @@
+#include <purgatory.h>
+void putchar(int ch)
+{
+	/* Nothing for now */
+}
Index: kexec-tools-mips/purgatory/arch/mipsel/include/limits.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/purgatory/arch/mipsel/include/limits.h	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,58 @@
+#ifndef LIMITS_H
+#define LIMITS_H       1
+
+
+/* Number of bits in a `char' */
+#define CHAR_BIT       8
+
+/* Minimum and maximum values a `signed char' can hold */
+#define SCHAR_MIN      (-128)
+#define SCHAR_MAX      127
+
+/* Maximum value an `unsigned char' can hold. (Minimum is 0.) */
+#define UCHAR_MAX      255
+
+/* Minimum and maximum values a `char' can hold */
+#define CHAR_MIN       SCHAR_MIN
+#define CHAR_MAX       SCHAR_MAX
+
+/* Minimum and maximum values a `signed short int' can hold */
+#define SHRT_MIN       (-32768)
+#define SHRT_MAX       32767
+
+/* Maximum value an `unsigned short' can hold. (Minimum is 0.) */
+#define USHRT_MAX      65535
+
+
+/* Minimum and maximum values a `signed int' can hold */
+#define INT_MIN                (-INT_MAX - 1)
+#define INT_MAX                2147483647
+
+/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
+#define UINT_MAX       4294967295U
+
+
+/* Minimum and maximum values a `signed int' can hold */
+#define INT_MIN                (-INT_MAX - 1)
+#define INT_MAX                2147483647
+
+/* Maximum value an `unsigned int' can hold. (Minimum is 0.) */
+#define UINT_MAX       4294967295U
+
+/* Minimum and maximum values a `signed long' can hold */
+#define LONG_MAX       2147483647L
+#define LONG_MIN       (-LONG_MAX - 1L)
+
+/* Maximum value an `unsigned long' can hold. (Minimum is 0.) */
+#define ULONG_MAX      4294967295UL
+
+/* Minimum and maximum values a `signed long long' can hold */
+#define LLONG_MAX      9223372036854775807LL
+#define LLONG_MIN      (-LONG_MAX - 1LL)
+
+
+/* Maximum value an `unsigned long long' can hold. (Minimum is 0.) */
+#define ULLONG_MAX     18446744073709551615ULL
+
+
+#endif /* LIMITS_H */
Index: kexec-tools-mips/purgatory/arch/mipsel/include/stdint.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/purgatory/arch/mipsel/include/stdint.h	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,16 @@
+#ifndef STDINT_H
+#define STDINT_H
+
+typedef unsigned long      size_t;
+
+typedef unsigned char      uint8_t;
+typedef unsigned short     uint16_t;
+typedef unsigned int       uint32_t;
+typedef unsigned long long uint64_t;
+
+typedef signed char        int8_t;
+typedef signed short       int16_t;
+typedef signed int         int32_t;
+typedef signed long long   int64_t;
+
+#endif /* STDINT_H */
Index: kexec-tools-mips/purgatory/arch/mipsel/purgatory-mipsel.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/purgatory/arch/mipsel/purgatory-mipsel.c	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,7 @@
+#include <purgatory.h>
+#include "purgatory-mipsel.h"
+
+void setup_arch(void)
+{
+	/* Nothing for now */
+}
Index: kexec-tools-mips/purgatory/arch/mipsel/purgatory-mipsel.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-mips/purgatory/arch/mipsel/purgatory-mipsel.h	2008-02-27 18:05:49.000000000 +0900
@@ -0,0 +1,6 @@
+#ifndef PURGATORY_MIPSEL_H
+#define PURGATORY_MIPSEL_H
+
+/* nothing yet */
+
+#endif /* PURGATORY_MIPSEL_H */

-- 

-- 
Horms
