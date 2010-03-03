Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 12:06:38 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:60457 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491836Ab0CCLF5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 12:05:57 +0100
Received: by mail-bw0-f226.google.com with SMTP id 26so1188708bwz.27
        for <multiple recipients>; Wed, 03 Mar 2010 03:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:cc:from:subject:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=m0IyZWZTzercOFRXDrkf1WqgT4+BeLwlSi1bSdHdKI8=;
        b=riqcc9gK1tN08sEggj2ci68Y8hjBAlEfTESrN70yAVdTKh8mlYinYokcnJ5f6CLg7M
         sEeOMvh77aSYQpgXQz8MuHqVMX5KAL29YEfuOCwpaeWUDbb6NgzSVeskojVRj2YTRfG8
         +J5oQXZa/GJl+PmyIuimhivX+b8/RwupxbC2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:from:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=sfrIA5QPBooxVfYVQza524hw/PjTrNV5BQ/xOsv4CP/A7HhwqksazbYR048la5ViTm
         l2ms3VIQhj6Kg7rr9PW5d+9av5MaxCwnBmGV6TtDmFBSbCqy8YzB0EtcrbjugUu6RpnW
         cwMJV2obyLnbcR2R7Bpw7NbuYq04EpRFTBkJA=
Received: by 10.204.11.11 with SMTP id r11mr5965425bkr.12.1267614357078;
        Wed, 03 Mar 2010 03:05:57 -0800 (PST)
Received: from ?127.0.1.1? (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id 14sm3627184bwz.14.2010.03.03.03.05.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 03:05:56 -0800 (PST)
To:     linux-mips@linux-mips.org, kexec@lists.infradead.org
Cc:     horms@verge.net.au, ralf@linux-mips.org
From:   Maxim Uvarov <muvarov@gmail.com>
Subject: [PATCH] some kexec MIPS improvements
Date:   Wed, 03 Mar 2010 14:05:53 +0300
Message-ID: <20100303110553.11274.9038.stgit@muvarov>
User-Agent: StGIT/0.14.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <muvarov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muvarov@gmail.com
Precedence: bulk
X-list: linux-mips

Hello folks,

Please find here MIPS crash and kdump patches.
This is patch set of 3 patches:
1. generic MIPS changes (kernel);
2. MIPS Cavium Octeon board kexec/kdump code (kernel);
3. Kexec user space MIPS changes.

Patches were tested on the latest linux-mips@ git kernel and the latest
kexec-tools git on Cavium Octeon 50xx board.

I also made the same code working on RMI XLR/XLS boards for both
mips32 and mips64 kernels.

Best regards,
Maxim Uvarov.

From: Maxim Uvarov <muvarov@gmail.com>

Changes are:

-  using simple   mips* ) in configure.ac to make it compilable on mips2
	and mips64
- remove kexec/arch/mips/mips-setup-simple.S which prepares cmdline for
new kernel, it is better to move this work to kernel code. BTW this code was
compilable only on o32 because of t4 is not defined on 64-64 or n32 MIPS ABIs.
- simple put cmdline as string, kernel code should catch cmdline like this
int board_kexec_prepare(struct kimage *image)
{
    int i;
    char *bootloader = "kexec";
    board_boot_desc_ptr->argc = 0;
    for(i=0;i<image->nr_segments;i++)
    {
        printk("segment %d
        if (!strncmp(bootloader, (char*)image->segment[i].buf,
                strlen(bootloader)))
        {
            /*
             * convert command line string to array
             * of parameters (as bootloader does).
             */
            int argc = 0, offt;
            char *str = (char *)image->segment[i].buf;
            char *ptr = strchr(str, ' ');
            while (ptr && (ARGV_MAX_ARGS > argc)) {
                *ptr = '\0';
                if (ptr[1] != ' ') {
                    offt = (int)(ptr - str + 1);
                    boot_desc_ptr->argv[argc] =
                        image->segment[i].mem + offt;
                    argc++;
                }
                ptr = strchr(ptr + 1, ' ');
            }
            boot_desc_ptr->argc = argc;
            break;
        }
    }
   Keep it as string make code simple and more readable.
- add crashdump support
- do not redefine syscalls numbers if they defined in system
 remove fixups for /proc/iomem. If your board provides wrong /proc/iomem please
 fix kernel, or at least you local version of kexec. No need to support it in
 main line. At least add option --fake-iomem
- some minor fixes

Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
---

 configure.ac                        |    2 
 kexec/arch/mips/Makefile            |    4 
 kexec/arch/mips/crashdump-mips.c    |  377 +++++++++++++++++++++++++++++++++++
 kexec/arch/mips/crashdump-mips.h    |   27 +++
 kexec/arch/mips/kexec-elf-mips.c    |  141 +++++++------
 kexec/arch/mips/kexec-mips.c        |   51 +----
 kexec/arch/mips/kexec-mips.h        |    9 +
 kexec/arch/mips/mips-setup-simple.S |  110 ----------
 kexec/crashdump.h                   |    2 
 kexec/kexec-syscall.h               |    2 
 10 files changed, 510 insertions(+), 215 deletions(-)
 create mode 100644 kexec/arch/mips/crashdump-mips.c
 create mode 100644 kexec/arch/mips/crashdump-mips.h
 delete mode 100644 kexec/arch/mips/mips-setup-simple.S

diff --git a/configure.ac b/configure.ac
index a911f8a..88d2e0b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -39,7 +39,7 @@ case $target_cpu in
 	sh4|sh4a|sh3|sh )
 		ARCH="sh"
 		;;
-	mips|mipsel )
+	mips* )
 		ARCH="mips"
 		;;
 	cris|crisv32 )
diff --git a/kexec/arch/mips/Makefile b/kexec/arch/mips/Makefile
index f94bd89..831b263 100644
--- a/kexec/arch/mips/Makefile
+++ b/kexec/arch/mips/Makefile
@@ -4,7 +4,7 @@
 mips_KEXEC_SRCS =  kexec/arch/mips/kexec-mips.c
 mips_KEXEC_SRCS += kexec/arch/mips/kexec-elf-mips.c
 mips_KEXEC_SRCS += kexec/arch/mips/kexec-elf-rel-mips.c
-mips_KEXEC_SRCS += kexec/arch/mips/mips-setup-simple.S
+mips_KEXEC_SRCS += kexec/arch/mips/crashdump-mips.c
 
 mips_ADD_BUFFER =
 mips_ADD_SEGMENT =
@@ -12,5 +12,7 @@ mips_VIRT_TO_PHYS =
 
 dist += kexec/arch/mips/Makefile $(mips_KEXEC_SRCS)			\
 	kexec/arch/mips/kexec-mips.h					\
+	kexec/arch/mips/crashdump-mips.h				\
 	kexec/arch/mips/include/arch/options.h
 
+CFLAGS +=-Wall -Werror
diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
new file mode 100644
index 0000000..17cf52d
--- /dev/null
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -0,0 +1,377 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * 2005 (C) IBM Corporation.
+ * 2008 (C) MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <elf.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include "../../kexec.h"
+#include "../../kexec-elf.h"
+#include "../../kexec-syscall.h"
+#include "../../crashdump.h"
+#include "kexec-mips.h"
+#include "crashdump-mips.h"
+#include "unused.h"
+
+/* Stores a sorted list of RAM memory ranges for which to create elf headers.
+ * A separate program header is created for backup region */
+static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
+
+/* Memory region reserved for storing panic kernel and other data. */
+static struct memory_range crash_reserved_mem;
+
+/*
+ * To store the memory size of the first kernel and this value will be
+ * passed to the second kernel as command line (savemaxmem=xM).
+ * The second kernel will be calculated saved_max_pfn based on this
+ * variable.
+ */
+unsigned long long saved_max_mem;
+
+/* Removes crash reserve region from list of memory chunks for whom elf program
+ * headers have to be created. Assuming crash reserve region to be a single
+ * continuous area fully contained inside one of the memory chunks */
+static int exclude_crash_reserve_region(int *nr_ranges)
+{
+	int i, j, tidx = -1;
+	unsigned long long cstart, cend;
+	struct memory_range temp_region = {
+		.start = 0,
+		.end = 0
+	};
+
+	/* Crash reserved region. */
+	cstart = crash_reserved_mem.start;
+	cend = crash_reserved_mem.end;
+
+	for (i = 0; i < (*nr_ranges); i++) {
+		unsigned long long mstart, mend;
+		mstart = crash_memory_range[i].start;
+		mend = crash_memory_range[i].end;
+		if (cstart < mend && cend > mstart) {
+			if (cstart != mstart && cend != mend) {
+				/* Split memory region */
+				crash_memory_range[i].end = cstart - 1;
+				temp_region.start = cend + 1;
+				temp_region.end = mend;
+				temp_region.type = RANGE_RAM;
+				tidx = i+1;
+			} else if (cstart != mstart)
+				crash_memory_range[i].end = cstart - 1;
+			else
+				crash_memory_range[i].start = cend + 1;
+		}
+	}
+	/* Insert split memory region, if any. */
+	if (tidx >= 0) {
+		if (*nr_ranges == CRASH_MAX_MEMORY_RANGES) {
+			/* No space to insert another element. */
+			fprintf(stderr, "Error: Number of crash memory ranges"
+					" excedeed the max limit\n");
+			return -1;
+		}
+		for (j = (*nr_ranges - 1); j >= tidx; j--)
+			crash_memory_range[j+1] = crash_memory_range[j];
+		crash_memory_range[tidx].start = temp_region.start;
+		crash_memory_range[tidx].end = temp_region.end;
+		crash_memory_range[tidx].type = temp_region.type;
+		(*nr_ranges)++;
+	}
+	return 0;
+}
+/* Reads the appropriate file and retrieves the SYSTEM RAM regions for whom to
+ * create Elf headers. Keeping it separate from get_memory_ranges() as
+ * requirements are different in the case of normal kexec and crashdumps.
+ *
+ * Normal kexec needs to look at all of available physical memory irrespective
+ * of the fact how much of it is being used by currently running kernel.
+ * Crashdumps need to have access to memory regions actually being used by
+ * running  kernel. Expecting a different file/data structure than /proc/iomem
+ * to look into down the line. May be something like /proc/kernelmem or may
+ * be zone data structures exported from kernel.
+ */
+static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
+{
+	const char iomem[] = "/proc/iomem";
+	int i, memory_ranges = 0;
+	char line[MAX_LINE];
+	FILE *fp;
+	unsigned long long start, end;
+
+	fp = fopen(iomem, "r");
+	if (!fp) {
+		fprintf(stderr, "Cannot open %s: %s\n",
+			iomem, strerror(errno));
+		return -1;
+	}
+	/* Separate segment for backup region */
+	crash_memory_range[0].start = BACKUP_SRC_START;
+	crash_memory_range[0].end = BACKUP_SRC_END;
+	crash_memory_range[0].type = RANGE_RAM;
+	memory_ranges++;
+
+	while (fgets(line, sizeof(line), fp) != 0) {
+		char *str;
+		int type, consumed, count;
+		if (memory_ranges >= CRASH_MAX_MEMORY_RANGES)
+			break;
+		count = sscanf(line, "%Lx-%Lx : %n",
+			&start, &end, &consumed);
+		if (count != 2)
+			continue;
+		str = line + consumed;
+
+		/* Only Dumping memory of type System RAM. */
+		if (memcmp(str, "System RAM\n", 11) == 0) {
+			type = RANGE_RAM;
+		} else if (memcmp(str, "Crash kernel\n", 13) == 0) {
+				/* Reserved memory region. New kernel can
+				 * use this region to boot into. */
+				crash_reserved_mem.start = start;
+				crash_reserved_mem.end = end;
+				crash_reserved_mem.type = RANGE_RAM;
+				continue;
+		} else
+			continue;
+
+		if (start == BACKUP_SRC_START && end >= (BACKUP_SRC_END + 1))
+			start = BACKUP_SRC_END + 1;
+
+		crash_memory_range[memory_ranges].start = start;
+		crash_memory_range[memory_ranges].end = end;
+		crash_memory_range[memory_ranges].type = type;
+		memory_ranges++;
+
+		/* Segregate linearly mapped region. */
+		if ((MAXMEM - 1) >= start && (MAXMEM - 1) <= end) {
+			crash_memory_range[memory_ranges - 1].end = MAXMEM - 1;
+
+			/* Add segregated region. */
+			crash_memory_range[memory_ranges].start = MAXMEM;
+			crash_memory_range[memory_ranges].end = end;
+			crash_memory_range[memory_ranges].type = type;
+			memory_ranges++;
+		}
+	}
+	fclose(fp);
+
+	if (exclude_crash_reserve_region(&memory_ranges) < 0)
+		return -1;
+
+	for (i = 0; i < memory_ranges; i++)
+		if (saved_max_mem < crash_memory_range[i].end)
+			saved_max_mem = crash_memory_range[i].end + 1;
+
+	*range = crash_memory_range;
+	*ranges = memory_ranges;
+	return 0;
+}
+
+/* Converts unsigned long to ascii string. */
+static void ultoa(unsigned long i, char *str)
+{
+	int j = 0, k;
+	char tmp;
+
+	do {
+		str[j++] = i % 10 + '0';
+	} while ((i /= 10) > 0);
+	str[j] = '\0';
+
+	/* Reverse the string. */
+	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
+		tmp = str[k];
+		str[k] = str[j];
+		str[j] = tmp;
+	}
+}
+
+/* Adds the appropriate mem= options to command line, indicating the
+ * memory region the new kernel can use to boot into. */
+static int cmdline_add_mem(char *cmdline, unsigned long addr,
+		unsigned long size)
+{
+	int cmdlen, len;
+	char str[50], *ptr;
+
+	addr = addr/1024;
+	size = size/1024;
+	ptr = str;
+	strcpy(str, " mem=");
+	ptr += strlen(str);
+	ultoa(size, ptr);
+	strcat(str, "K@");
+	ptr = str + strlen(str);
+	ultoa(addr, ptr);
+	strcat(str, "K");
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+
+	return 0;
+}
+
+/* Adds the elfcorehdr= command line parameter to command line. */
+static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
+{
+	int cmdlen, len, align = 1024;
+	char str[30], *ptr;
+
+	/* Passing in elfcorehdr=xxxK format. Saves space required in cmdline.
+	 * Ensure 1K alignment*/
+	if (addr%align)
+		return -1;
+	addr = addr/align;
+	ptr = str;
+	strcpy(str, " elfcorehdr=");
+	ptr += strlen(str);
+	ultoa(addr, ptr);
+	strcat(str, "K");
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+	return 0;
+}
+
+/* Adds the savemaxmem= command line parameter to command line. */
+static int cmdline_add_savemaxmem(char *cmdline, unsigned long long addr)
+{
+	int cmdlen, len, align = 1024;
+	char str[30], *ptr;
+
+	/* Passing in savemaxmem=xxxM format. Saves space required in cmdline.*/
+	addr = addr/(align*align);
+	ptr = str;
+	strcpy(str, " savemaxmem=");
+	ptr += strlen(str);
+	ultoa(addr, ptr);
+	strcat(str, "M");
+	len = strlen(str);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str);
+	return 0;
+}
+
+#ifdef __mips64
+static struct crash_elf_info elf_info64 = {
+	class: ELFCLASS64,
+	data : ELFDATA2MSB,
+	machine : EM_MIPS,
+	backup_src_start : BACKUP_SRC_START,
+	backup_src_end : BACKUP_SRC_END,
+	page_offset : PAGE_OFFSET,
+	lowmem_limit : MAXMEM,
+};
+#endif
+static struct crash_elf_info elf_info32 = {
+	class: ELFCLASS32,
+	data : ELFDATA2MSB,
+	machine : EM_MIPS,
+	backup_src_start : BACKUP_SRC_START,
+	backup_src_end : BACKUP_SRC_END,
+	page_offset : PAGE_OFFSET,
+	lowmem_limit : MAXMEM,
+};
+
+/* Loads additional segments in case of a panic kernel is being loaded.
+ * One segment for backup region, another segment for storing elf headers
+ * for crash memory image.
+ */
+int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
+				unsigned long UNUSED(max_addr),
+				unsigned long UNUSED(min_base))
+{
+	void *tmp;
+	unsigned long sz, elfcorehdr;
+	int nr_ranges, align = 1024;
+	struct memory_range *mem_range;
+
+	if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0)
+		return -1;
+
+	/* Create a backup region segment to store backup data*/
+	sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
+	tmp = xmalloc(sz);
+	memset(tmp, 0, sz);
+	info->backup_start = add_buffer(info, tmp, sz, sz, align,
+				crash_reserved_mem.start,
+				crash_reserved_mem.end, -1);
+
+#ifdef __mips64
+	/* Create elf header segment and store crash image data. */
+	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
+		if (crash_create_elf64_headers(info, &elf_info64,
+			crash_memory_range, nr_ranges,
+			&tmp, &sz,
+			ELF_CORE_HEADER_ALIGN) < 0)
+			return -1;
+	} else {
+		if (crash_create_elf32_headers(info, &elf_info32,
+			crash_memory_range, nr_ranges,
+			&tmp, &sz,
+			ELF_CORE_HEADER_ALIGN) < 0)
+			return -1;
+	}
+#else
+	if (crash_create_elf32_headers(info, &elf_info32,
+		crash_memory_range, nr_ranges,
+		&tmp, &sz,
+		ELF_CORE_HEADER_ALIGN) < 0)
+		return -1;
+#endif
+	elfcorehdr = add_buffer(info, tmp, sz, sz, align,
+		crash_reserved_mem.start,
+		crash_reserved_mem.end, -1);
+
+	/*
+	 * backup segment is after elfcorehdr, so use elfcorehdr as top of
+	 * kernel's available memory
+	 */
+	cmdline_add_mem(mod_cmdline, crash_reserved_mem.start,
+		elfcorehdr - crash_reserved_mem.start);
+	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
+	cmdline_add_savemaxmem(mod_cmdline, saved_max_mem);
+
+#ifdef DEBUG
+	printf("CRASH MEMORY RANGES:\n");
+	printf("%016Lx-%016Lx\n", crash_reserved_mem.start,
+			crash_reserved_mem.end);
+#endif
+	return 0;
+}
+
+int is_crashkernel_mem_reserved(void)
+{
+	uint64_t start, end;
+
+	return parse_iomem_single("Crash kernel\n", &start, &end) == 0 ?
+		(start != end) : 0;
+}
+
diff --git a/kexec/arch/mips/crashdump-mips.h b/kexec/arch/mips/crashdump-mips.h
new file mode 100644
index 0000000..c986835
--- /dev/null
+++ b/kexec/arch/mips/crashdump-mips.h
@@ -0,0 +1,27 @@
+#ifndef CRASHDUMP_MIPS_H
+#define CRASHDUMP_MIPS_H
+
+struct kexec_info;
+int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
+				unsigned long max_addr, unsigned long min_base);
+#ifdef __mips64
+#define PAGE_OFFSET	0xa800000000000000ULL
+#else
+#define PAGE_OFFSET	0x80000000
+#endif
+#define __pa(x)		((unsigned long)(X) & 0x7fffffff)
+
+#define MAXMEM		0x80000000
+
+#define CRASH_MAX_MEMMAP_NR	(KEXEC_MAX_SEGMENTS + 1)
+#define CRASH_MAX_MEMORY_RANGES	(MAX_MEMORY_RANGES + 2)
+
+#define COMMAND_LINE_SIZE	512
+
+/* Backup Region, First 1M of System RAM. */
+#define BACKUP_SRC_START	0x00000000
+#define BACKUP_SRC_END		0x000fffff
+#define BACKUP_SRC_SIZE	(BACKUP_SRC_END - BACKUP_SRC_START + 1)
+
+extern struct arch_options_t arch_options;
+#endif /* CRASHDUMP_MIPS_H */
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index 95695b6..ce6bf0c 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -25,55 +25,21 @@
 #include <ip_checksum.h>
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
+#include "../../kexec-syscall.h"
 #include "kexec-mips.h"
+#include "crashdump-mips.h"
 #include <arch/options.h>
 
 static const int probe_debug = 0;
 
 #define BOOTLOADER         "kexec"
 #define MAX_COMMAND_LINE   256
-
 #define UPSZ(X) ((sizeof(X) + 3) & ~3)
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
 #define OPT_APPEND	(OPT_ARCH_MAX+0)
+static char cmdline_buf[256] = "kexec ";
 
 int elf_mips_probe(const char *buf, off_t len)
 {
-
 	struct mem_ehdr ehdr;
 	int result;
 	result = build_elf_exec_info(buf, len, &ehdr, 0);
@@ -108,16 +74,14 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
 	struct mem_ehdr ehdr;
-	char *arg_buf;
-	size_t arg_bytes;
-	unsigned long arg_base;
-	struct boot_notes *notes;
-	size_t note_bytes;
 	const char *command_line;
 	int command_line_len;
-	unsigned char *setup_start;
-	uint32_t setup_size;
+	char *crash_cmdline;
 	int opt;
+	int result;
+	unsigned long cmdline_addr;
+	size_t i;
+	unsigned long bss_start = 0, bss_size = 0;
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
 		{"command-line", 1, 0, OPT_APPEND},
@@ -144,38 +108,83 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 			break;
 		}
 	}
+
 	command_line_len = 0;
-	setup_simple_regs.spr9 = 0;
-	if (command_line) {
-		command_line_len = strlen(command_line) + 1;
-		setup_simple_regs.spr9 = 2;
+
+	/* Need to append some command line parameters internally in case of
+	 * taking crash dumps.
+	 */
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
+		memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
+	} else
+		crash_cmdline = NULL;
+
+	result = build_elf_exec_info(buf, len, &ehdr, 0);
+	if (result < 0)
+		die("ELF exec parse failed\n");
+
+	/* Read in the PT_LOAD segments and remove CKSEG0 mask from address*/
+	for (i = 0; i < ehdr.e_phnum; i++) {
+		struct mem_phdr *phdr;
+		phdr = &ehdr.e_phdr[i];
+		if (phdr->p_type == PT_LOAD)
+			phdr->p_paddr = virt_to_phys(phdr->p_paddr);
 	}
 
-	/* Load the ELF executable */
-	elf_exec_build_load(info, &ehdr, buf, len, 0);
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		struct mem_shdr *shdr;
+		unsigned char *strtab;
+		strtab = (unsigned char *)ehdr.e_shdr[ehdr.e_shstrndx].sh_data;
+
+		shdr = &ehdr.e_shdr[i];
+		if (shdr->sh_size &&
+				strcmp((char *)&strtab[shdr->sh_name],
+					".bss") == 0) {
+			bss_start = virt_to_phys(shdr->sh_addr);
+			bss_size = shdr->sh_size;
+			break;
+		}
 
-	setup_start = setup_simple_start;
-	setup_size = setup_simple_size;
-	setup_simple_regs.spr8 = ehdr.e_entry;
+	}
 
-	note_bytes = sizeof(elf_boot_notes) + ((command_line_len + 3) & ~3);
-	arg_bytes = note_bytes + ((setup_size + 3) & ~3);
+	/* Load the Elf data */
+	result = elf_exec_load(&ehdr, info);
+	if (result < 0)
+		die("ELF exec load failed\n");
 
-	arg_buf = xmalloc(arg_bytes);
-	arg_base = add_buffer_virt(info,
-		 arg_buf, arg_bytes, arg_bytes, 4, 0, elf_max_addr(&ehdr), 1);
+	info->entry = (void *)virt_to_phys(ehdr.e_entry);
 
-	notes = (struct boot_notes *)(arg_buf + ((setup_size + 3) & ~3));
+	/* Put cmdline right after bss for crash*/
+	if (info->kexec_flags & KEXEC_ON_CRASH)
+		cmdline_addr = bss_start + bss_size;
+	else
+		cmdline_addr = 0;
 
-	memcpy(arg_buf, setup_start, setup_size);
-	memcpy(notes, &elf_boot_notes, sizeof(elf_boot_notes));
-	memcpy(notes->command_line, command_line, command_line_len);
+	if (!bss_size)
+		die("No .bss segment present\n");
 
-	notes->hdr.b_size = note_bytes;
-	notes->cmd_hdr.n_descsz = command_line_len;
-	notes->hdr.b_checksum = compute_ip_checksum(notes, note_bytes);
+	if (command_line)
+		command_line_len = strlen(command_line) + 1;
+
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		result = load_crashdump_segments(info, crash_cmdline,
+				0, 0);
+		if (result < 0) {
+			free(crash_cmdline);
+			return -1;
+		}
+	}
 
-	info->entry = (void *)arg_base;
+	if (command_line)
+		strncat(cmdline_buf, command_line, command_line_len);
+	if (crash_cmdline)
+		strncat(cmdline_buf, crash_cmdline,
+				sizeof(crash_cmdline) -
+				strlen(crash_cmdline) - 1);
+	add_buffer(info, cmdline_buf, sizeof(cmdline_buf),
+			sizeof(cmdline_buf), sizeof(void *),
+			cmdline_addr, 0x0fffffff, 1);
 
 	return 0;
 }
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index cb75a2d..bd12bb3 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -21,8 +21,6 @@
 #include "kexec-mips.h"
 #include <arch/options.h>
 
-#define MAX_MEMORY_RANGES  64
-#define MAX_LINE          160
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /* Return a sorted list of memory ranges. */
@@ -31,16 +29,6 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 {
 	int memory_ranges = 0;
 
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
 	const char iomem[] = "/proc/iomem";
 	char line[MAX_LINE];
 	FILE *fp;
@@ -61,31 +49,19 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 			continue;
 		str = line + consumed;
 		end = end + 1;
-#if 0
-		printf("%016Lx-%016Lx : %s\n", start, end, str);
-#endif
 		if (memcmp(str, "System RAM\n", 11) == 0) {
 			type = RANGE_RAM;
 		} else if (memcmp(str, "reserved\n", 9) == 0) {
 			type = RANGE_RESERVED;
-		} else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
-			type = RANGE_ACPI;
-		} else if (memcmp(str, "ACPI Non-volatile Storage\n", 26) == 0) {
-			type = RANGE_ACPI_NVS;
 		} else {
 			continue;
 		}
 		memory_range[memory_ranges].start = start;
 		memory_range[memory_ranges].end = end;
 		memory_range[memory_ranges].type = type;
-#if 0
-		printf("%016Lx-%016Lx : %x\n", start, end, type);
-#endif
 		memory_ranges++;
 	}
 	fclose(fp);
-#endif
-
 	*range = memory_range;
 	*ranges = memory_ranges;
 	return 0;
@@ -98,8 +74,18 @@ int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
 void arch_usage(void)
 {
+#ifdef __mips64
+	fprintf(stderr, "     --elf32-core-headers Prepare core headers in "
+			"ELF32 format\n");
+#endif
 }
 
+#ifdef __mips64
+struct arch_options_t arch_options = {
+	.core_header_type = CORE_TYPE_ELF64
+};
+#endif
+
 int arch_process_options(int argc, char **argv)
 {
 	static const struct option options[] = {
@@ -126,12 +112,14 @@ const struct arch_map_entry arches[] = {
 	/* For compatibility with older patches
 	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_MIPS here.
 	 */
-	{ "mips", KEXEC_ARCH_DEFAULT },
+	{ "mips", KEXEC_ARCH_MIPS },
+	{ "mips64", KEXEC_ARCH_MIPS },
 	{ NULL, 0 },
 };
 
 int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 {
+
 	return 0;
 }
 
@@ -139,18 +127,9 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
-/*
- * Adding a dummy function, so that build on mips will not break.
- * Need to implement the actual checking code
- */
-int is_crashkernel_mem_reserved(void)
-{
-	return 1;
-}
-
 unsigned long virt_to_phys(unsigned long addr)
 {
-	return addr - 0x80000000;
+	return addr & 0x7fffffff;
 }
 
 /*
@@ -159,7 +138,7 @@ unsigned long virt_to_phys(unsigned long addr)
 void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
 		 unsigned long base, size_t memsz)
 {
-	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
+	add_segment_phys_virt(info, buf, bufsz, virt_to_phys(base), memsz, 1);
 }
 
 /*
diff --git a/kexec/arch/mips/kexec-mips.h b/kexec/arch/mips/kexec-mips.h
index 13f82be..6d062fc 100644
--- a/kexec/arch/mips/kexec-mips.h
+++ b/kexec/arch/mips/kexec-mips.h
@@ -1,6 +1,11 @@
 #ifndef KEXEC_MIPS_H
 #define KEXEC_MIPS_H
 
+#define MAX_MEMORY_RANGES  64
+#define MAX_LINE          160
+
+#define CORE_TYPE_ELF32 1
+#define CORE_TYPE_ELF64 2
 extern unsigned char setup_simple_start[];
 extern uint32_t setup_simple_size;
 
@@ -14,4 +19,8 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
 void elf_mips_usage(void);
 
+struct arch_options_t {
+	int      core_header_type;
+};
+
 #endif /* KEXEC_MIPS_H */
diff --git a/kexec/arch/mips/mips-setup-simple.S b/kexec/arch/mips/mips-setup-simple.S
deleted file mode 100644
index 1acdee3..0000000
--- a/kexec/arch/mips/mips-setup-simple.S
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * mips-setup-simple.S - code to execute before kernel to handle command line
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
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 1789b53..30d6f29 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -26,7 +26,7 @@ struct crash_elf_info {
 	unsigned long backup_src_start;
 	unsigned long backup_src_end;
 
-	unsigned long page_offset;
+	unsigned long long page_offset;
 	unsigned long lowmem_limit;
 
 	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 69c9686..7f41a1b 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -22,6 +22,7 @@
 #define LINUX_REBOOT_CMD_KEXEC_OLD2	0x18263645
 #define LINUX_REBOOT_CMD_KEXEC		0x45584543
 
+#ifndef __NR_kexec_load
 #ifdef __i386__
 #define __NR_kexec_load		283
 #endif
@@ -60,6 +61,7 @@
 #ifndef __NR_kexec_load
 #error Unknown processor architecture.  Needs a kexec_load syscall number.
 #endif
+#endif /*ifndef __NR_kexec_load*/
 
 struct kexec_segment;
 


Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
