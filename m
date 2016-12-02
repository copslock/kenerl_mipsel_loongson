Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 10:50:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63826 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993048AbcLBJtkRzuR0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 10:49:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0C987A8D0A242;
        Fri,  2 Dec 2016 09:49:31 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 09:49:33 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <kexec@lists.infradead.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 6/6] mips: add option to load initrd from a specified file
Date:   Fri, 2 Dec 2016 10:49:11 +0100
Message-ID: <1480672151-18503-7-git-send-email-marcin.nowakowski@imgtec.com>
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
X-archive-position: 55924
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

Use kexec's existing infrastrucutre for supporting initrd loading.
The initrd image is loaded into a buffer after the dtb and its details
passed through the device tree, so it's supported on newer platforms
that make use of the device tree passed from kexec.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 kexec/arch/mips/include/arch/options.h |  4 +++-
 kexec/arch/mips/kexec-elf-mips.c       | 19 +++++++++++++++++++
 kexec/arch/mips/kexec-mips.c           |  4 ++++
 kexec/arch/mips/kexec-mips.h           |  1 +
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/mips/include/arch/options.h b/kexec/arch/mips/include/arch/options.h
index 86b620f..416e224 100644
--- a/kexec/arch/mips/include/arch/options.h
+++ b/kexec/arch/mips/include/arch/options.h
@@ -4,6 +4,7 @@
 #define OPT_ARCH_MAX	(OPT_MAX+0)
 #define OPT_APPEND	(OPT_ARCH_MAX+0)
 #define OPT_DTB		(OPT_ARCH_MAX+1)
+#define OPT_RAMDISK	(OPT_ARCH_MAX+2)
 
 /* Options relevant to the architecture (excluding loader-specific ones),
  * in this case none:
@@ -12,7 +13,8 @@
 	KEXEC_OPTIONS \
 	{"command-line", 1, 0, OPT_APPEND}, \
 	{"append",	 1, 0, OPT_APPEND}, \
-	{"dtb",		1, 0, OPT_DTB },
+	{"dtb",		1, 0, OPT_DTB }, \
+	{"initrd",	1, 0, OPT_RAMDISK },
 
 
 #define KEXEC_ARCH_OPT_STR KEXEC_OPT_STR ""
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index 6ca7ca0..849a7ba 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -79,6 +79,7 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 	size_t i;
 	off_t dtb_length;
 	char *dtb_buf;
+	char *initrd_buf = NULL;
 	unsigned long long kernel_addr = 0, kernel_size = 0;
 	unsigned long pagesize = getpagesize();
 
@@ -152,6 +153,24 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
 		create_flatten_tree(&dtb_buf, &dtb_length, cmdline_buf + strlen(CMDLINE_PREFIX));
 	}
 
+	if (arch_options.initrd_file) {
+		initrd_buf = slurp_file(arch_options.initrd_file, &initrd_size);
+
+		/* Create initrd entries in dtb - although at this time
+		 * they would not point to the correct location */
+		dtb_set_initrd(&dtb_buf, &dtb_length, initrd_buf, initrd_buf + initrd_size);
+
+		initrd_base = add_buffer(info, initrd_buf, initrd_size,
+					initrd_size, sizeof(void *),
+					_ALIGN_UP(kernel_addr + kernel_size + dtb_length,
+						pagesize), 0x0fffffff, 1);
+
+		/* Now that the buffer for initrd is prepared, update the dtb
+		 * with an appropriate location */
+		dtb_set_initrd(&dtb_buf, &dtb_length, initrd_base, initrd_base + initrd_size);
+	}
+
+
 	/* This is a legacy method for commandline passing used
 	 * currently by Octeon CPUs only */
 	add_buffer(info, cmdline_buf, sizeof(cmdline_buf),
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index 2605c17..ee3cd3a 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -82,6 +82,7 @@ void arch_usage(void)
 	"    --command-line=STRING Set the kernel command line to STRING.\n"
 	"    --append=STRING       Set the kernel command line to STRING.\n"
 	"    --dtb=FILE            Use FILE as the device tree blob.\n"
+	"    --initrd=FILE         Use FILE as initial ramdisk.\n"
 	);
 }
 
@@ -111,6 +112,9 @@ int arch_process_options(int argc, char **argv)
 		case OPT_DTB:
 			arch_options.dtb_file = optarg;
 			break;
+		case OPT_RAMDISK:
+			arch_options.initrd_file = optarg;
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/arch/mips/kexec-mips.h b/kexec/arch/mips/kexec-mips.h
index a609fb5..222c815 100644
--- a/kexec/arch/mips/kexec-mips.h
+++ b/kexec/arch/mips/kexec-mips.h
@@ -20,6 +20,7 @@ void elf_mips_usage(void);
 struct arch_options_t {
 	char *command_line;
 	char *dtb_file;
+	char *initrd_file;
 	int core_header_type;
 };
 
-- 
2.7.4
