Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 10:50:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5273 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993042AbcLBJtkFh9T0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 10:49:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1FA43534FDE12;
        Fri,  2 Dec 2016 09:49:30 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 09:49:32 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <kexec@lists.infradead.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 5/6] mips: add dtb loading support
Date:   Fri, 2 Dec 2016 10:49:10 +0100
Message-ID: <1480672151-18503-6-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Kexec for MIPS currently does not support loading devicetrees, unless
they are embedded in the kernel elf file.

Add an option to either pass a new dtb file or - if not specified - to
be generated from existing device tree on the device. As new generic
platforms require a dtb to be passed separately this is required for
such platforms and will be ignored by the kernel otherwise.

Generic kexec infrastructure for dtb support is used.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 kexec/arch/mips/Makefile               | 13 +++++++++++++
 kexec/arch/mips/crashdump-mips.c       |  3 +++
 kexec/arch/mips/include/arch/options.h |  5 ++++-
 kexec/arch/mips/kexec-elf-mips.c       | 34 +++++++++++++++++++++++++++++++---
 kexec/arch/mips/kexec-mips.c           |  8 ++++++++
 kexec/arch/mips/kexec-mips.h           |  9 +++++++++
 6 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/mips/Makefile b/kexec/arch/mips/Makefile
index 03bdb9a..1fe7886 100644
--- a/kexec/arch/mips/Makefile
+++ b/kexec/arch/mips/Makefile
@@ -6,6 +6,19 @@ mips_KEXEC_SRCS += kexec/arch/mips/kexec-elf-mips.c
 mips_KEXEC_SRCS += kexec/arch/mips/kexec-elf-rel-mips.c
 mips_KEXEC_SRCS += kexec/arch/mips/crashdump-mips.c
 
+mips_FS2DT = kexec/fs2dt.c
+mips_FS2DT_INCLUDE = \
+	-include $(srcdir)/kexec/arch/mips/crashdump-mips.h \
+	-include $(srcdir)/kexec/arch/mips/kexec-mips.h
+
+mips_DT_OPS += kexec/dt-ops.c
+
+include $(srcdir)/kexec/libfdt/Makefile.libfdt
+
+libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
+mips_CPPFLAGS += -I$(srcdir)/kexec/libfdt
+mips_KEXEC_SRCS += $(libfdt_SRCS)
+
 mips_ADD_BUFFER =
 mips_ADD_SEGMENT =
 mips_VIRT_TO_PHYS =
diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 278ee01..d6cff5a 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -39,6 +39,9 @@
  * A separate program header is created for backup region */
 static struct memory_range crash_memory_range[CRASH_MAX_MEMORY_RANGES];
 
+/* Not used currently but required by generic fs2dt code */
+struct memory_ranges usablemem_rgns;
+
 /* Memory region reserved for storing panic kernel and other data. */
 static struct memory_range crash_reserved_mem;
 
diff --git a/kexec/arch/mips/include/arch/options.h b/kexec/arch/mips/include/arch/options.h
index a18251b..86b620f 100644
--- a/kexec/arch/mips/include/arch/options.h
+++ b/kexec/arch/mips/include/arch/options.h
@@ -3,6 +3,7 @@
 
 #define OPT_ARCH_MAX	(OPT_MAX+0)
 #define OPT_APPEND	(OPT_ARCH_MAX+0)
+#define OPT_DTB		(OPT_ARCH_MAX+1)
 
 /* Options relevant to the architecture (excluding loader-specific ones),
  * in this case none:
@@ -10,7 +11,9 @@
 #define KEXEC_ARCH_OPTIONS \
 	KEXEC_OPTIONS \
 	{"command-line", 1, 0, OPT_APPEND}, \
-	{"append",	 1, 0, OPT_APPEND},
+	{"append",	 1, 0, OPT_APPEND}, \
+	{"dtb",		1, 0, OPT_DTB },
+
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
 
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index 7cb06f1..6ca7ca0 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -29,13 +29,16 @@
 #include "kexec-mips.h"
 #include "crashdump-mips.h"
 #include <arch/options.h>
+#include "../../fs2dt.h"
+#include "../../dt-ops.h"
 
 static const int probe_debug = 0;
 
 #define BOOTLOADER         "kexec"
-#define MAX_COMMAND_LINE   256
 #define UPSZ(X) _ALIGN_UP(sizeof(X), 4)
-static char cmdline_buf[256] = "kexec ";
+
+#define CMDLINE_PREFIX "kexec "
+static char cmdline_buf[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
 
 int elf_mips_probe(const char *buf, off_t len)
 {
@@ -74,6 +77,10 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	int result;
 	unsigned long cmdline_addr;
 	size_t i;
+	off_t dtb_length;
+	char *dtb_buf;
+	unsigned long long kernel_addr = 0, kernel_size = 0;
+	unsigned long pagesize = getpagesize();
 
 	/* Need to append some command line parameters internally in case of
 	 * taking crash dumps.
@@ -92,8 +99,11 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	for (i = 0; i < ehdr.e_phnum; i++) {
 		struct mem_phdr *phdr;
 		phdr = &ehdr.e_phdr[i];
-		if (phdr->p_type == PT_LOAD)
+		if (phdr->p_type == PT_LOAD) {
 			phdr->p_paddr = virt_to_phys(phdr->p_paddr);
+			kernel_addr = phdr->p_paddr;
+			kernel_size = phdr->p_memsz;
+		}
 	}
 
 	/* Load the Elf data */
@@ -130,10 +140,28 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	else
 		cmdline_addr = 0;
 
+	/* MIPS systems that have been converted to use device tree
+	 * passed through UHI will use commandline in the DTB and
+	 * the DTB passed as a separate buffer. Note that
+	 * CMDLINE_PREFIX is skipped here intentionally, as it is
+	 * used only in the legacy method */
+
+	if (arch_options.dtb_file) {
+		dtb_buf = slurp_file(arch_options.dtb_file, &dtb_length);
+	} else {
+		create_flatten_tree(&dtb_buf, &dtb_length, cmdline_buf + strlen(CMDLINE_PREFIX));
+	}
+
+	/* This is a legacy method for commandline passing used
+	 * currently by Octeon CPUs only */
 	add_buffer(info, cmdline_buf, sizeof(cmdline_buf),
 			sizeof(cmdline_buf), sizeof(void *),
 			cmdline_addr, 0x0fffffff, 1);
 
+	add_buffer(info, dtb_buf, dtb_length, dtb_length, 0,
+		_ALIGN_UP(kernel_addr + kernel_size, pagesize),
+		0x0fffffff, 1);
+
 	return 0;
 }
 
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index 867e9c3..2605c17 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -21,6 +21,10 @@
 #include "kexec-mips.h"
 #include <arch/options.h>
 
+/* Currently not used but required by top-level fs2dt code */
+off_t initrd_base = 0;
+off_t initrd_size = 0;
+
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /* Return a sorted list of memory ranges. */
@@ -77,6 +81,7 @@ void arch_usage(void)
 	printf(
 	"    --command-line=STRING Set the kernel command line to STRING.\n"
 	"    --append=STRING       Set the kernel command line to STRING.\n"
+	"    --dtb=FILE            Use FILE as the device tree blob.\n"
 	);
 }
 
@@ -103,6 +108,9 @@ int arch_process_options(int argc, char **argv)
 		case OPT_APPEND:
 			arch_options.command_line = optarg;
 			break;
+		case OPT_DTB:
+			arch_options.dtb_file = optarg;
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/arch/mips/kexec-mips.h b/kexec/arch/mips/kexec-mips.h
index 2991b2d..a609fb5 100644
--- a/kexec/arch/mips/kexec-mips.h
+++ b/kexec/arch/mips/kexec-mips.h
@@ -1,6 +1,11 @@
 #ifndef KEXEC_MIPS_H
 #define KEXEC_MIPS_H
 
+#include <sys/types.h>
+
+#define BOOT_BLOCK_VERSION 17
+#define BOOT_BLOCK_LAST_COMP_VERSION 16
+
 #define MAX_MEMORY_RANGES  64
 #define MAX_LINE          160
 
@@ -14,7 +19,11 @@ void elf_mips_usage(void);
 
 struct arch_options_t {
 	char *command_line;
+	char *dtb_file;
 	int core_header_type;
 };
 
+extern struct memory_ranges usablemem_rgns;
+extern off_t initrd_base, initrd_size;
+
 #endif /* KEXEC_MIPS_H */
-- 
2.7.4
