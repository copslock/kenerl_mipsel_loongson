Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 01:26:04 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:4243 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28599168AbYCQB0B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2008 01:26:01 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id 1D94A341B6;
	Mon, 17 Mar 2008 10:25:50 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id 3A1D34FA83; Mon, 17 Mar 2008 10:25:49 +0900 (JST)
Subject: [patch] kexec-tools: mips: support big-endian mips (repost)
Date:	Mon, 17 Mar 2008 10:25:43 +0900
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>
From:	Simon Horman <horms@verge.net.au>
Message-Id: <20080317012550.3A1D34FA83@tabatha.lab.ultramonkey.org>
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

[ Reposted with correct linux-mips address ]

Hi,

this patch switches the mips support in kexec-tools around a little bit.
All the files and directories containing "mipsel" have been renamed
to contain "mips" instead.

This is kind of consistent with the way that ARCH=mips in the kernel
works for both big and little endian.

After a small amount of tweaking, which is also included in this patch, the
code compiles and works fine for big endian mips as well as small endian
mips. All you need to do is compile using an appropriate compiler.

That is to say, kexec-tools's build system doesn't need to
be told about which endienness the code is being compiled for.

I have added kept mipsel as a supported "architecture" via ./configure,
though its just an alias for mips now. This is consistent with how
other architectures such as sh are treated. But I'm happy to remove
mipsel from ./configure if the mips people want that.

I tested this patch using qemu and the 2.6.24.3 tag of the mips-2.6 git
tree compiled for the qemu machine type for both big and little endian.
The qemu machine type has subsequently been removed, and kexec-tools
needs some work in order to function with qemu - as far as I understand
the way the boot parameters are passed needs to be fixed, likely
in purgatory. However, this is not related to the changes
introduced in this patch.

I intend to merge this patch into kexec-tools-testing if
no alarm bells are sounded.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

 configure.ac                             |    5 
 kexec/Makefile                           |    2 
 kexec/arch/mips/Makefile                 |   12 +
 kexec/arch/mips/include/arch/options.h   |   11 +
 kexec/arch/mips/kexec-elf-mips.c         |  183 +++++++++++++++++++++++++++++
 kexec/arch/mips/kexec-elf-rel-mips.c     |   42 ++++++
 kexec/arch/mips/kexec-mips.c             |  188 ++++++++++++++++++++++++++++++
 kexec/arch/mips/kexec-mips.h             |   17 ++
 kexec/arch/mips/mips-setup-simple.S      |  110 +++++++++++++++++
 kexec/arch/mipsel/Makefile               |   12 -
 kexec/arch/mipsel/include/arch/options.h |   11 -
 kexec/arch/mipsel/kexec-elf-mipsel.c     |  183 -----------------------------
 kexec/arch/mipsel/kexec-elf-rel-mipsel.c |   42 ------
 kexec/arch/mipsel/kexec-mipsel.c         |  188 ------------------------------
 kexec/arch/mipsel/kexec-mipsel.h         |   17 --
 kexec/arch/mipsel/mipsel-setup-simple.S  |  110 -----------------
 kexec/kexec-syscall.h                    |    2 
 purgatory/Makefile                       |    2 
 purgatory/arch/mips/Makefile             |   11 +
 purgatory/arch/mips/console-mips.c       |    5 
 purgatory/arch/mips/purgatory-mips.c     |    7 +
 purgatory/arch/mips/purgatory-mips.h     |    6 
 purgatory/arch/mipsel/Makefile           |   11 -
 purgatory/arch/mipsel/console-mipsel.c   |    5 
 purgatory/arch/mipsel/purgatory-mipsel.c |    7 -
 purgatory/arch/mipsel/purgatory-mipsel.h |    6 
 26 files changed, 599 insertions(+), 596 deletions(-)
Index: kexec-tools-testing-mips/configure.ac
===================================================================
--- kexec-tools-testing-mips.orig/configure.ac	2008-03-12 16:03:32.000000000 +0900
+++ kexec-tools-testing-mips/configure.ac	2008-03-12 16:03:40.000000000 +0900
@@ -38,7 +38,10 @@ case $target_cpu in
 	sh4|sh4a|sh3|sh )
 		ARCH="sh"
 		;;
-	ia64|x86_64|alpha|mipsel )
+	mips|mipsel )
+		ARCH="mips"
+		;;
+	ia64|x86_64|alpha )
 		ARCH="$target_cpu"
 		;;
 	* )
Index: kexec-tools-testing-mips/kexec/kexec-syscall.h
===================================================================
--- kexec-tools-testing-mips.orig/kexec/kexec-syscall.h	2008-03-12 16:03:32.000000000 +0900
+++ kexec-tools-testing-mips/kexec/kexec-syscall.h	2008-03-12 16:03:40.000000000 +0900
@@ -49,7 +49,7 @@
 #ifdef __arm__
 #define __NR_kexec_load		__NR_SYSCALL_BASE + 347  
 #endif
-#ifdef __MIPSEL__
+#if defined(__mips__)
 #define __NR_kexec_load                4311
 #endif
 #ifndef __NR_kexec_load
Index: kexec-tools-testing-mips/kexec/Makefile
===================================================================
--- kexec-tools-testing-mips.orig/kexec/Makefile	2008-03-12 16:09:53.000000000 +0900
+++ kexec-tools-testing-mips/kexec/Makefile	2008-03-12 16:10:05.000000000 +0900
@@ -33,7 +33,7 @@ include $(srcdir)/kexec/arch/alpha/Makef
 include $(srcdir)/kexec/arch/arm/Makefile
 include $(srcdir)/kexec/arch/i386/Makefile
 include $(srcdir)/kexec/arch/ia64/Makefile
-include $(srcdir)/kexec/arch/mipsel/Makefile
+include $(srcdir)/kexec/arch/mips/Makefile
 include $(srcdir)/kexec/arch/ppc/Makefile
 include $(srcdir)/kexec/arch/ppc64/Makefile
 include $(srcdir)/kexec/arch/s390/Makefile
Index: kexec-tools-testing-mips/kexec/arch/mips/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/kexec/arch/mips/Makefile	2008-03-12 16:07:53.000000000 +0900
@@ -0,0 +1,12 @@
+#
+# kexec mips (linux booting linux)
+#
+mips_KEXEC_SRCS =  kexec/arch/mips/kexec-mips.c
+mips_KEXEC_SRCS += kexec/arch/mips/kexec-elf-mips.c
+mips_KEXEC_SRCS += kexec/arch/mips/kexec-elf-rel-mips.c
+mips_KEXEC_SRCS += kexec/arch/mips/mips-setup-simple.S
+
+dist += kexec/arch/mips/Makefile $(mips_KEXEC_SRCS)			\
+	kexec/arch/mips/kexec-mips.h					\
+	kexec/arch/mips/include/arch/options.h
+
Index: kexec-tools-testing-mips/kexec/arch/mips/include/arch/options.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/kexec/arch/mips/include/arch/options.h	2008-03-12 16:03:32.000000000 +0900
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
Index: kexec-tools-testing-mips/kexec/arch/mips/kexec-elf-mips.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/kexec/arch/mips/kexec-elf-mips.c	2008-03-12 16:08:22.000000000 +0900
@@ -0,0 +1,183 @@
+/*
+ * kexec-elf-mips.c - kexec Elf loader for mips
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
+#include "kexec-mips.h"
+#include <arch/options.h>
+
+static const int probe_debug = 0;
+
+#define BOOTLOADER         "kexec"
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
+#define OPT_APPEND	(OPT_ARCH_MAX+0)
+
+int elf_mips_probe(const char *buf, off_t len)
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
+void elf_mips_usage(void)
+{
+	printf("    --command-line=STRING Set the kernel command line to "
+			"STRING.\n"
+	       "    --append=STRING       Set the kernel command line to "
+			"STRING.\n");
+}
+
+int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
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
+	int opt;
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
+	while ((opt = getopt_long(argc, argv, short_options,
+				  options, 0)) != -1) {
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
Index: kexec-tools-testing-mips/kexec/arch/mips/kexec-elf-rel-mips.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/kexec/arch/mips/kexec-elf-rel-mips.c	2008-03-12 16:08:27.000000000 +0900
@@ -0,0 +1,42 @@
+/*
+ * kexec-elf-rel-mips.c - kexec Elf relocation routines
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
Index: kexec-tools-testing-mips/kexec/arch/mips/kexec-mips.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/kexec/arch/mips/kexec-mips.c	2008-03-12 16:08:47.000000000 +0900
@@ -0,0 +1,188 @@
+/*
+ * kexec-mips.c - kexec for mips
+ * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
+ * Copyright (C) 2007 Tvblob s.r.l.
+ *
+ * derived from ../ppc/kexec-mips.c
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
+#include "kexec-mips.h"
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
+	{"elf-mips", elf_mips_probe, elf_mips_load, elf_mips_usage},
+};
+int file_types = sizeof(file_type) / sizeof(file_type[0]);
+
+void arch_usage(void)
+{
+}
+
+int arch_process_options(int argc, char **argv)
+{
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ 0,                    0, NULL, 0 },
+	};
+	static const char short_options[] = KEXEC_ARCH_OPT_STR;
+	int opt;
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
+ * Adding a dummy function, so that build on mips will not break.
+ * Need to implement the actual checking code
+ */
+int is_crashkernel_mem_reserved(void)
+{
+	return 1;
+}
+
+unsigned long virt_to_phys(unsigned long addr)
+{
+	return addr - 0x80000000;
+}
+
+/*
+ * add_segment() should convert base to a physical address on mips,
+ * while the default is just to work with base as is */
+void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
+		 unsigned long base, size_t memsz)
+{
+	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
+}
+
+/*
+ * add_buffer() should convert base to a physical address on mips,
+ * while the default is just to work with base as is */
+unsigned long add_buffer(struct kexec_info *info, const void *buf,
+			 unsigned long bufsz, unsigned long memsz,
+			 unsigned long buf_align, unsigned long buf_min,
+			 unsigned long buf_max, int buf_end)
+{
+	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
+				    buf_min, buf_max, buf_end, 1);
+}
+
Index: kexec-tools-testing-mips/kexec/arch/mips/kexec-mips.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/kexec/arch/mips/kexec-mips.h	2008-03-12 16:08:52.000000000 +0900
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
+int elf_mips_probe(const char *buf, off_t len);
+int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info);
+void elf_mips_usage(void);
+
+#endif /* KEXEC_MIPS_H */
Index: kexec-tools-testing-mips/kexec/arch/mips/mips-setup-simple.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/kexec/arch/mips/mips-setup-simple.S	2008-03-12 16:09:09.000000000 +0900
@@ -0,0 +1,110 @@
+/*
+ * mips-setup-simple.S - code to execute before kernel to handle command line
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
Index: kexec-tools-testing-mips/kexec/arch/mipsel/Makefile
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/Makefile	2008-03-12 16:04:20.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,12 +0,0 @@
-#
-# kexec mipsel (linux booting linux)
-#
-mipsel_KEXEC_SRCS =  kexec/arch/mipsel/kexec-mipsel.c
-mipsel_KEXEC_SRCS += kexec/arch/mipsel/kexec-elf-mipsel.c
-mipsel_KEXEC_SRCS += kexec/arch/mipsel/kexec-elf-rel-mipsel.c
-mipsel_KEXEC_SRCS += kexec/arch/mipsel/mipsel-setup-simple.S
-
-dist += kexec/arch/mipsel/Makefile $(mipsel_KEXEC_SRCS)			\
-	kexec/arch/mipsel/kexec-mipsel.h				\
-	kexec/arch/mipsel/include/arch/options.h
-
Index: kexec-tools-testing-mips/kexec/arch/mipsel/include/arch/options.h
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/include/arch/options.h	2008-03-12 16:04:20.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,11 +0,0 @@
-#ifndef KEXEC_ARCH_MIPS_OPTIONS_H
-#define KEXEC_ARCH_MIPS_OPTIONS_H
-
-#define OPT_ARCH_MAX   (OPT_MAX+0)
-
-#define KEXEC_ARCH_OPTIONS \
-	KEXEC_OPTIONS \
-
-#define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
-
-#endif /* KEXEC_ARCH_MIPS_OPTIONS_H */
Index: kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-elf-mipsel.c	2008-03-12 16:04:20.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,183 +0,0 @@
-/*
- * kexec-elf-mipsel.c - kexec Elf loader for mips
- * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
- * Copyright (C) 2007 Tvblob s.r.l.
- *
- * derived from ../ppc/kexec-elf-ppc.c
- * Copyright (C) 2004 Albert Herranz
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2.  See the file COPYING for more details.
-*/
-
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <getopt.h>
-#include <elf.h>
-#include <boot/elf_boot.h>
-#include <ip_checksum.h>
-#include "../../kexec.h"
-#include "../../kexec-elf.h"
-#include "kexec-mipsel.h"
-#include <arch/options.h>
-
-static const int probe_debug = 0;
-
-#define BOOTLOADER         "kexec"
-#define MAX_COMMAND_LINE   256
-
-#define UPSZ(X) ((sizeof(X) + 3) & ~3)
-static struct boot_notes {
-	Elf_Bhdr hdr;
-	Elf_Nhdr bl_hdr;
-	unsigned char bl_desc[UPSZ(BOOTLOADER)];
-	Elf_Nhdr blv_hdr;
-	unsigned char blv_desc[UPSZ(BOOTLOADER_VERSION)];
-	Elf_Nhdr cmd_hdr;
-	unsigned char command_line[0];
-} elf_boot_notes = {
-	.hdr = {
-		.b_signature = 0x0E1FB007,
-		.b_size = sizeof(elf_boot_notes),
-		.b_checksum = 0,
-		.b_records = 3,
-	},
-	.bl_hdr = {
-		.n_namesz = 0,
-		.n_descsz = sizeof(BOOTLOADER),
-		.n_type = EBN_BOOTLOADER_NAME,
-	},
-	.bl_desc = BOOTLOADER,
-	.blv_hdr = {
-		.n_namesz = 0,
-		.n_descsz = sizeof(BOOTLOADER_VERSION),
-		.n_type = EBN_BOOTLOADER_VERSION,
-	},
-	.blv_desc = BOOTLOADER_VERSION,
-	.cmd_hdr = {
-		.n_namesz = 0,
-		.n_descsz = 0,
-		.n_type = EBN_COMMAND_LINE,
-	},
-};
-
-
-#define OPT_APPEND	(OPT_ARCH_MAX+0)
-
-int elf_mipsel_probe(const char *buf, off_t len)
-{
-
-	struct mem_ehdr ehdr;
-	int result;
-	result = build_elf_exec_info(buf, len, &ehdr, 0);
-	if (result < 0) {
-		goto out;
-	}
-
-	/* Verify the architecuture specific bits */
-	if (ehdr.e_machine != EM_MIPS) {
-		/* for a different architecture */
-		if (probe_debug) {
-			fprintf(stderr, "Not for this architecture.\n");
-		}
-		result = -1;
-		goto out;
-	}
-	result = 0;
- out:
-	free_elf_info(&ehdr);
-	return result;
-}
-
-void elf_mipsel_usage(void)
-{
-	printf("    --command-line=STRING Set the kernel command line to "
-			"STRING.\n"
-	       "    --append=STRING       Set the kernel command line to "
-			"STRING.\n");
-}
-
-int elf_mipsel_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info)
-{
-	struct mem_ehdr ehdr;
-	char *arg_buf;
-	size_t arg_bytes;
-	unsigned long arg_base;
-	struct boot_notes *notes;
-	size_t note_bytes;
-	const char *command_line;
-	int command_line_len;
-	unsigned char *setup_start;
-	uint32_t setup_size;
-	int opt;
-	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
-		{"command-line", 1, 0, OPT_APPEND},
-		{"append",       1, 0, OPT_APPEND},
-		{0, 0, 0, 0},
-	};
-
-	static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
-
-	command_line = 0;
-	while ((opt = getopt_long(argc, argv, short_options,
-				  options, 0)) != -1) {
-		switch (opt) {
-		default:
-			/* Ignore core options */
-			if (opt < OPT_ARCH_MAX) {
-				break;
-			}
-		case '?':
-			usage();
-			return -1;
-		case OPT_APPEND:
-			command_line = optarg;
-			break;
-		}
-	}
-	command_line_len = 0;
-	setup_simple_regs.spr9 = 0;
-	if (command_line) {
-		command_line_len = strlen(command_line) + 1;
-		setup_simple_regs.spr9 = 2;
-	}
-
-	/* Load the ELF executable */
-	elf_exec_build_load(info, &ehdr, buf, len, 0);
-
-	setup_start = setup_simple_start;
-	setup_size = setup_simple_size;
-	setup_simple_regs.spr8 = ehdr.e_entry;
-
-	note_bytes = sizeof(elf_boot_notes) + ((command_line_len + 3) & ~3);
-	arg_bytes = note_bytes + ((setup_size + 3) & ~3);
-
-	arg_buf = xmalloc(arg_bytes);
-	arg_base = add_buffer_virt(info,
-		 arg_buf, arg_bytes, arg_bytes, 4, 0, elf_max_addr(&ehdr), 1);
-
-	notes = (struct boot_notes *)(arg_buf + ((setup_size + 3) & ~3));
-
-	memcpy(arg_buf, setup_start, setup_size);
-	memcpy(notes, &elf_boot_notes, sizeof(elf_boot_notes));
-	memcpy(notes->command_line, command_line, command_line_len);
-
-	notes->hdr.b_size = note_bytes;
-	notes->cmd_hdr.n_descsz = command_line_len;
-	notes->hdr.b_checksum = compute_ip_checksum(notes, note_bytes);
-
-	info->entry = (void *)arg_base;
-
-	return 0;
-}
-
Index: kexec-tools-testing-mips/kexec/arch/mipsel/kexec-elf-rel-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-elf-rel-mipsel.c	2008-03-12 16:04:20.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,42 +0,0 @@
-/*
- * kexec-elf-rel-mipsel.c - kexec Elf relocation routines
- * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
- * Copyright (C) 2007 Tvblob s.r.l.
- *
- * derived from ../ppc/kexec-elf-rel-ppc.c
- * Copyright (C) 2004 Albert Herranz
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2.  See the file COPYING for more details.
-*/
-
-#include <stdio.h>
-#include <elf.h>
-#include "../../kexec.h"
-#include "../../kexec-elf.h"
-
-int machine_verify_elf_rel(struct mem_ehdr *ehdr)
-{
-	if (ehdr->ei_data != ELFDATA2MSB) {
-		return 0;
-	}
-	if (ehdr->ei_class != ELFCLASS32) {
-		return 0;
-	}
-	if (ehdr->e_machine != EM_MIPS) {
-		return 0;
-	}
-	return 1;
-}
-
-void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
-	void *location, unsigned long address, unsigned long value)
-{
-	switch(r_type) {
-
-	default:
-		die("Unknown rela relocation: %lu\n", r_type);
-		break;
-	}
-	return;
-}
Index: kexec-tools-testing-mips/kexec/arch/mipsel/kexec-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-mipsel.c	2008-03-12 16:04:20.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,188 +0,0 @@
-/*
- * kexec-mipsel.c - kexec for mips
- * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
- * Copyright (C) 2007 Tvblob s.r.l.
- *
- * derived from ../ppc/kexec-mipsel.c
- * Copyright (C) 2004, 2005 Albert Herranz
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2.  See the file COPYING for more details.
- */
-
-#include <stddef.h>
-#include <stdio.h>
-#include <errno.h>
-#include <stdint.h>
-#include <string.h>
-#include <getopt.h>
-#include <sys/utsname.h>
-#include "../../kexec.h"
-#include "../../kexec-syscall.h"
-#include "kexec-mipsel.h"
-#include <arch/options.h>
-
-#define MAX_MEMORY_RANGES  64
-#define MAX_LINE          160
-static struct memory_range memory_range[MAX_MEMORY_RANGES];
-
-/* Return a sorted list of memory ranges. */
-int get_memory_ranges(struct memory_range **range, int *ranges, unsigned long kexec_flags)
-{
-	int memory_ranges = 0;
-
-#if 1
-	/* this is valid for gemini2 platform based on tx4938
-	 * in our case, /proc/iomem doesn't report ram space
-	 */
-	 memory_range[memory_ranges].start = 0x00000000;
-	 memory_range[memory_ranges].end = 0x04000000;
-	 memory_range[memory_ranges].type = RANGE_RAM;
-	 memory_ranges++;
-#else
-#error Please, fix this for your platform
-	const char iomem[] = "/proc/iomem";
-	char line[MAX_LINE];
-	FILE *fp;
-	unsigned long long start, end;
-	char *str;
-	int type, consumed, count;
-
-	fp = fopen(iomem, "r");
-	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n", iomem, strerror(errno));
-		return -1;
-	}
-	while (fgets(line, sizeof(line), fp) != 0) {
-		if (memory_ranges >= MAX_MEMORY_RANGES)
-			break;
-		count = sscanf(line, "%Lx-%Lx : %n", &start, &end, &consumed);
-		if (count != 2)
-			continue;
-		str = line + consumed;
-		end = end + 1;
-#if 0
-		printf("%016Lx-%016Lx : %s\n", start, end, str);
-#endif
-		if (memcmp(str, "System RAM\n", 11) == 0) {
-			type = RANGE_RAM;
-		} else if (memcmp(str, "reserved\n", 9) == 0) {
-			type = RANGE_RESERVED;
-		} else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
-			type = RANGE_ACPI;
-		} else if (memcmp(str, "ACPI Non-volatile Storage\n", 26) == 0) {
-			type = RANGE_ACPI_NVS;
-		} else {
-			continue;
-		}
-		memory_range[memory_ranges].start = start;
-		memory_range[memory_ranges].end = end;
-		memory_range[memory_ranges].type = type;
-#if 0
-		printf("%016Lx-%016Lx : %x\n", start, end, type);
-#endif
-		memory_ranges++;
-	}
-	fclose(fp);
-#endif
-
-	*range = memory_range;
-	*ranges = memory_ranges;
-	return 0;
-}
-
-struct file_type file_type[] = {
-	{"elf-mipsel", elf_mipsel_probe, elf_mipsel_load, elf_mipsel_usage},
-};
-int file_types = sizeof(file_type) / sizeof(file_type[0]);
-
-void arch_usage(void)
-{
-}
-
-int arch_process_options(int argc, char **argv)
-{
-	static const struct option options[] = {
-		KEXEC_ARCH_OPTIONS
-		{ 0,                    0, NULL, 0 },
-	};
-	static const char short_options[] = KEXEC_ARCH_OPT_STR;
-	int opt;
-
-	opterr = 0; /* Don't complain about unrecognized options here */
-	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
-		switch(opt) {
-		default:
-			break;
-		}
-	}
-	/* Reset getopt for the next pass; called in other source modules */
-	opterr = 1;
-	optind = 1;
-	return 0;
-}
-
-int arch_compat_trampoline(struct kexec_info *info)
-{
-	int result;
-	struct utsname utsname;
-	result = uname(&utsname);
-	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
-		return -1;
-	}
-	 if (strcmp(utsname.machine, "mips") == 0)
-	 {
-		 /* For compatibility with older patches
-		  * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_MIPS here.
-		  */
-		info->kexec_flags |= KEXEC_ARCH_DEFAULT;
-	 }
-	else {
-		fprintf(stderr, "Unsupported machine type: %s\n",
-			utsname.machine);
-		return -1;
-	}
-	return 0;
-}
-
-void arch_update_purgatory(struct kexec_info *info)
-{
-}
-
-/*
- * Adding a dummy function, so that build on mipsel will not break.
- * Need to implement the actual checking code
- */
-int is_crashkernel_mem_reserved(void)
-{
-	return 1;
-}
-
-unsigned long virt_to_phys(unsigned long addr)
-{
-	return addr - 0x80000000;
-}
-
-/*
- * add_segment() should convert base to a physical address on mipsel,
- * while the default is just to work with base as is */
-void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
-		 unsigned long base, size_t memsz)
-{
-	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
-}
-
-/*
- * add_buffer() should convert base to a physical address on mipsel,
- * while the default is just to work with base as is */
-unsigned long add_buffer(struct kexec_info *info, const void *buf,
-			 unsigned long bufsz, unsigned long memsz,
-			 unsigned long buf_align, unsigned long buf_min,
-			 unsigned long buf_max, int buf_end)
-{
-	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
-				    buf_min, buf_max, buf_end, 1);
-}
-
Index: kexec-tools-testing-mips/kexec/arch/mipsel/kexec-mipsel.h
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/kexec-mipsel.h	2008-03-12 16:04:21.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,17 +0,0 @@
-#ifndef KEXEC_MIPS_H
-#define KEXEC_MIPS_H
-
-extern unsigned char setup_simple_start[];
-extern uint32_t setup_simple_size;
-
-extern struct {
-	uint32_t spr8;
-	uint32_t spr9;
-} setup_simple_regs;
-
-int elf_mipsel_probe(const char *buf, off_t len);
-int elf_mipsel_load(int argc, char **argv, const char *buf, off_t len,
-	struct kexec_info *info);
-void elf_mipsel_usage(void);
-
-#endif /* KEXEC_MIPS_H */
Index: kexec-tools-testing-mips/kexec/arch/mipsel/mipsel-setup-simple.S
===================================================================
--- kexec-tools-testing-mips.orig/kexec/arch/mipsel/mipsel-setup-simple.S	2008-03-12 16:04:21.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,110 +0,0 @@
-/*
- * mipsel-setup-simple.S - code to execute before kernel to handle command line
- * Copyright (C) 2007 Francesco Chiechi, Alessandro Rubini
- * Copyright (C) 2007 Tvblob s.r.l.
- *
- * derived from Albert Herranz idea (ppc) adding command line support
- * (boot_notes structure)
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2.  See the file COPYING for more details.
- */
-
-/*
- * Only suitable for platforms booting with MMU turned off.
- * -- Albert Herranz
- */
-#include "regdef.h"
-
-/* returns  t0 = relocated address of sym */
-/* modifies t1 t2 */
-/* sym must not be global or this will not work (at least AFAIK up to now) */
-#define RELOC_SYM(sym)                                                 \
-	move    t0,ra;          /* save ra */                           \
-	bal 1f;                                                         \
-1:                                                                     \
-	move    t1,ra;          /* now t1 is 1b (where we are now) */   \
-	move    ra,t0;          /* restore ra */                        \
-	lui     t2,%hi(1b);                                             \
-	ori     t2,t2,%lo(1b);                                          \
-	lui     t0,%hi(sym);                                            \
-	ori     t0,t0,%lo(sym);                                         \
-	sub     t0,t0,t2;       /* t0 = offset between sym and 1b */    \
-	add     t0,t1,t0;       /* t0 = actual address in memory */
-
-	.data
-	.globl setup_simple_start
-setup_simple_start:
-
-	/* should perform here any required setup */
-
-	/* Initialize GOT pointer (verify if needed) */
-	bal     1f
-	nop
-	.word   _GLOBAL_OFFSET_TABLE_
-	1:
-	move    gp, ra
-	lw      t1, 0(ra)
-	move    gp, t1
-
-	/* spr8 relocation */
-	RELOC_SYM(spr8)
-
-	move    t4,t0           // save pointer to kernel start addr
-	lw      t3,0(t0)        // save kernel start address
-
-	/* spr9 relocation */
-	RELOC_SYM(spr9)
-	lw      a0,0(t0)        // load argc
-
-	// this code is to be changed if boot_notes struct changes
-	lw      t2,12(t4)       // t2 is size of boot_notes struct
-	addi    t2,t2,3
-	srl     t2,t2,2
-	sll     v1,t2,2         // v1 = size of boot_notes struct
-				// aligned to word boundary
-
-	addi    t0,t4,0x20      // t0 contains the address of "kexec" string
-	add     v0,t4,v1        // v0 points to last word of boot_notes
-	addi    v0,v0,8         // v0 points to address after boot_notes
-	sw      t0,0(v0)        // store pointer to "kexec" string there
-
-	lw      t2,-8(t0)       // t2 is size of "kexec" string in bytes
-	addi    t2,t2,3
-	srl     t2,t2,2
-	sll     v1,t2,2         // v1 = size of "kexec" string
-				// aligned to word boundary
-	add     t2,t0,v1
-	addi    t0,t2,4         // t0 points to size of version string
-
-	lw      t2,0(t0)        // t2 is size of version string in bytes
-	addi    t2,t2,3
-	srl     t2,t2,2
-	sll     v1,t2,2         // v1 = size of version string
-				// aligned to word boundary
-
-	addi    t0,t0,8         // t0 points to version string
-	add     t0,t0,v1        // t0 points to start of command_line record
-	addi    t0,t0,12        // t0 points command line
-
-	sw      t0,4(v0)        // store pointer to command line
-
-	move    a1,v0           // load argv
-	li      a2,0
-	li      a3,0
-
-	jr      t3
-	nop
-
-	.balign 4
-	.globl setup_simple_regs
-setup_simple_regs:
-spr8:	.long 0x00000000
-spr9:	.long 0x00000000
-
-setup_simple_end:
-
-	.globl setup_simple_size
-setup_simple_size:
-	.long setup_simple_end - setup_simple_start
-
Index: kexec-tools-testing-mips/purgatory/Makefile
===================================================================
--- kexec-tools-testing-mips.orig/purgatory/Makefile	2008-03-12 16:25:28.000000000 +0900
+++ kexec-tools-testing-mips/purgatory/Makefile	2008-03-12 16:25:43.000000000 +0900
@@ -20,7 +20,7 @@ include $(srcdir)/purgatory/arch/alpha/M
 include $(srcdir)/purgatory/arch/arm/Makefile
 include $(srcdir)/purgatory/arch/i386/Makefile
 include $(srcdir)/purgatory/arch/ia64/Makefile
-include $(srcdir)/purgatory/arch/mipsel/Makefile
+include $(srcdir)/purgatory/arch/mips/Makefile
 include $(srcdir)/purgatory/arch/ppc/Makefile
 include $(srcdir)/purgatory/arch/ppc64/Makefile
 include $(srcdir)/purgatory/arch/s390/Makefile
Index: kexec-tools-testing-mips/purgatory/arch/mips/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/purgatory/arch/mips/Makefile	2008-03-12 16:30:49.000000000 +0900
@@ -0,0 +1,11 @@
+#
+# Purgatory mips
+#
+
+mips_PURGATORY_SRCS+= purgatory/arch/mips/purgatory-mips.c
+mips_PURGATORY_SRCS+= purgatory/arch/mips/console-mips.c
+
+dist += purgatory/arch/mips/Makefile $(mips_PURGATORY_C_SRCS)		\
+	purgatory/arch/mips/include/limits.h				\
+	purgatory/arch/mips/purgatory-mips.h
+
Index: kexec-tools-testing-mips/purgatory/arch/mips/console-mips.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/purgatory/arch/mips/console-mips.c	2008-03-06 18:50:45.000000000 +0900
@@ -0,0 +1,5 @@
+#include <purgatory.h>
+void putchar(int ch)
+{
+	/* Nothing for now */
+}
Index: kexec-tools-testing-mips/purgatory/arch/mips/purgatory-mips.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/purgatory/arch/mips/purgatory-mips.c	2008-03-12 16:26:44.000000000 +0900
@@ -0,0 +1,7 @@
+#include <purgatory.h>
+#include "purgatory-mips.h"
+
+void setup_arch(void)
+{
+	/* Nothing for now */
+}
Index: kexec-tools-testing-mips/purgatory/arch/mips/purgatory-mips.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kexec-tools-testing-mips/purgatory/arch/mips/purgatory-mips.h	2008-03-06 18:50:45.000000000 +0900
@@ -0,0 +1,6 @@
+#ifndef PURGATORY_MIPSEL_H
+#define PURGATORY_MIPSEL_H
+
+/* nothing yet */
+
+#endif /* PURGATORY_MIPSEL_H */
Index: kexec-tools-testing-mips/purgatory/arch/mipsel/Makefile
===================================================================
--- kexec-tools-testing-mips.orig/purgatory/arch/mipsel/Makefile	2008-03-12 16:12:57.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,11 +0,0 @@
-#
-# Purgatory mipsel
-#
-
-mipsel_PURGATORY_C_SRCS+= purgatory/arch/mipsel/purgatory-mipsel.c
-mipsel_PURGATORY_C_SRCS+= purgatory/arch/mipsel/console-mipsel.c
-
-dist += purgatory/arch/mipsel/Makefile $(mipsel_PURGATORY_C_SRCS)	\
-	purgatory/arch/mipsel/include/limits.h				\
-	purgatory/arch/mipsel/purgatory-mipsel.h
-
Index: kexec-tools-testing-mips/purgatory/arch/mipsel/console-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/purgatory/arch/mipsel/console-mipsel.c	2008-03-12 16:12:56.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,5 +0,0 @@
-#include <purgatory.h>
-void putchar(int ch)
-{
-	/* Nothing for now */
-}
Index: kexec-tools-testing-mips/purgatory/arch/mipsel/purgatory-mipsel.c
===================================================================
--- kexec-tools-testing-mips.orig/purgatory/arch/mipsel/purgatory-mipsel.c	2008-03-12 16:12:58.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,7 +0,0 @@
-#include <purgatory.h>
-#include "purgatory-mipsel.h"
-
-void setup_arch(void)
-{
-	/* Nothing for now */
-}
Index: kexec-tools-testing-mips/purgatory/arch/mipsel/purgatory-mipsel.h
===================================================================
--- kexec-tools-testing-mips.orig/purgatory/arch/mipsel/purgatory-mipsel.h	2008-03-12 16:12:59.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,6 +0,0 @@
-#ifndef PURGATORY_MIPSEL_H
-#define PURGATORY_MIPSEL_H
-
-/* nothing yet */
-
-#endif /* PURGATORY_MIPSEL_H */
