Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2012 00:11:41 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43481 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903594Ab2E3WLI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2012 00:11:08 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SZr6c-00012l-JD; Wed, 30 May 2012 17:11:02 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 1/5] MIPS: Add initial support for YAMON firmware.
Date:   Wed, 30 May 2012 17:10:51 -0500
Message-Id: <1338415855-11401-2-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1338415855-11401-1-git-send-email-sjhill@mips.com>
References: <1338415855-11401-1-git-send-email-sjhill@mips.com>
X-archive-position: 33493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig                      |    8 ++++
 arch/mips/Makefile                     |    1 +
 arch/mips/fw/yamon/Makefile            |    5 +++
 arch/mips/fw/yamon/cmdline.c           |   68 ++++++++++++++++++++++++++++++++
 arch/mips/include/asm/fw/yamon/yamon.h |   53 +++++++++++++++++++++++++
 arch/mips/include/asm/mipsprom.h       |    2 -
 6 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/fw/yamon/Makefile
 create mode 100644 arch/mips/fw/yamon/cmdline.c
 create mode 100644 arch/mips/include/asm/fw/yamon/yamon.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index df08343..143add4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -58,6 +58,7 @@ config MIPS_ALCHEMY
 	select SYS_SUPPORTS_ZBOOT
 	select USB_ARCH_HAS_OHCI
 	select USB_ARCH_HAS_EHCI
+	select YAMON
 
 config AR7
 	bool "Texas Instruments AR7"
@@ -299,6 +300,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
 	select SYS_SUPPORTS_HIGHMEM
+	select YAMON
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
@@ -328,6 +330,7 @@ config MIPS_SEAD3
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select YAMON
 	help
 	  This enables support for the MIPS Technologies SEAD3 evaluation
 	  board.
@@ -404,6 +407,7 @@ config PMC_MSP
 	select IRQ_CPU
 	select SERIAL_8250
 	select SERIAL_8250_CONSOLE
+	select YAMON
 	help
 	  This adds support for the PMC-Sierra family of Multi-Service
 	  Processor System-On-A-Chips.  These parts include a number
@@ -446,6 +450,7 @@ config POWERTV
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select USB_OHCI_LITTLE_ENDIAN
+	select YAMON
 	help
 	  This enables support for the Cisco PowerTV Platform.
 
@@ -974,6 +979,9 @@ config GPIO_TXX9
 config CFE
 	bool
 
+config YAMON
+	bool
+
 config ARCH_DMA_ADDR_T_64BIT
 	def_bool (HIGHMEM && 64BIT_PHYS_ADDR) || 64BIT
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 363d8c8..0e468ad 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -177,6 +177,7 @@ endif
 libs-$(CONFIG_ARC)		+= arch/mips/fw/arc/
 libs-$(CONFIG_CFE)		+= arch/mips/fw/cfe/
 libs-$(CONFIG_SNIPROM)		+= arch/mips/fw/sni/
+libs-$(CONFIG_YAMON)		+= arch/mips/fw/yamon/
 libs-y				+= arch/mips/fw/lib/
 
 #
diff --git a/arch/mips/fw/yamon/Makefile b/arch/mips/fw/yamon/Makefile
new file mode 100644
index 0000000..bd934bd
--- /dev/null
+++ b/arch/mips/fw/yamon/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the YAMON prom monitor routines under Linux.
+#
+
+lib-$(CONFIG_MIPS_BOARDS_GEN)	+= cmdline.o
diff --git a/arch/mips/fw/yamon/cmdline.c b/arch/mips/fw/yamon/cmdline.c
new file mode 100644
index 0000000..6d62abf
--- /dev/null
+++ b/arch/mips/fw/yamon/cmdline.c
@@ -0,0 +1,68 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.
+ */
+#include <linux/init.h>
+#include <linux/string.h>
+#include <asm/bootinfo.h>
+#include <asm/fw/yamon/yamon.h>
+
+int prom_argc;
+int *_prom_argv;
+int *_prom_envp;
+
+void __init prom_init_cmdline(void)
+{
+	int i;
+
+	for (i = 1; i < prom_argc; i++) {
+		strlcat(arcs_cmdline, prom_argv(i), COMMAND_LINE_SIZE);
+		if (i < (prom_argc - 1))
+			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+	}
+}
+
+char * __init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+char *prom_getenv(char *envname)
+{
+	char *result = NULL;
+
+	if (_prom_envp != NULL) {
+		/*
+		 * Return a pointer to the given environment variable.
+		 * YAMON uses "name", "value" pairs, while U-Boot uses
+		 * "name=value".
+		 */
+		int i, yamon, index = 0;
+
+		yamon = (strchr(prom_envp(index), '=') == NULL);
+		i = strlen(envname);
+
+		while (prom_envp(index)) {
+			if (strncmp(envname, prom_envp(index), i) == 0) {
+				if (yamon) {
+					result = prom_envp(index + 1);
+					break;
+				} else if (prom_envp(index)[i] == '=') {
+					result = (prom_envp(index + 1) + i);
+					break;
+				}
+			}
+
+			/* Increment array index. */
+			if (yamon)
+				index += 2;
+			else
+				index += 1;
+		}
+	}
+
+	return result;
+}
diff --git a/arch/mips/include/asm/fw/yamon/yamon.h b/arch/mips/include/asm/fw/yamon/yamon.h
new file mode 100644
index 0000000..f15d157
--- /dev/null
+++ b/arch/mips/include/asm/fw/yamon/yamon.h
@@ -0,0 +1,53 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.
+ */
+#ifndef _MIPS_YAMON_H_
+#define _MIPS_YAMON_H_
+
+enum yamon_memtypes {
+	yamon_dontuse,
+	yamon_prom,
+	yamon_free,
+};
+
+struct prom_pmemblock {
+	unsigned long base;	/* Within KSEG0 */
+	unsigned int size;	/* Bytes */
+	unsigned int type;	/* yamon_memtypes */
+};
+
+/*
+ * YAMON print address.
+ */
+#define YAMON_PROM_PRINT_ADDR	0x1fc00504
+
+/* Memory descriptor management. */
+#ifdef CONFIG_PMC_MSP
+#define PROM_MAX_PMEMBLOCKS	7	/* Only 6 are actually used */
+#else
+#define PROM_MAX_PMEMBLOCKS	32	/* Default */
+#endif
+
+extern int prom_argc;
+extern int *_prom_argv;
+extern int *_prom_envp;
+
+/*
+ * YAMON (32-bit PROM) passes arguments and environment as a
+ * 32-bit pointer. This macro takes care of sign extension.
+ */
+#define prom_argv(index)	((char *)(long)_prom_argv[(index)])
+#define prom_envp(index)	((char *)(long)_prom_envp[(index)])
+
+extern void prom_init_cmdline(void);
+extern char *prom_getcmdline(void);
+extern struct prom_pmemblock *prom_getmdesc(void);
+extern void prom_meminit(void);
+extern void prom_init_early_console(char port);
+extern char *prom_getenv(char *name);
+
+#endif /* _MIPS_YAMON_H_ */
diff --git a/arch/mips/include/asm/mipsprom.h b/arch/mips/include/asm/mipsprom.h
index e93943f..406a866 100644
--- a/arch/mips/include/asm/mipsprom.h
+++ b/arch/mips/include/asm/mipsprom.h
@@ -71,6 +71,4 @@
 #define PROM_NV_GET		53	/* XXX */
 #define PROM_NV_SET		54	/* XXX */
 
-extern char *prom_getenv(char *);
-
 #endif /* __ASM_MIPSPROM_H */
-- 
1.7.10
