Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:20:25 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43432 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903722Ab2FEVT4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:19:56 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AL-000824-Kz; Tue, 05 Jun 2012 16:19:49 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 01/35] MIPS: Add environment variable processing code to firmware library.
Date:   Tue,  5 Jun 2012 16:19:05 -0500
Message-Id: <1338931179-9611-2-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33514
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
 arch/mips/fw/lib/Makefile     |    2 +
 arch/mips/fw/lib/cmdline.c    |   86 +++++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/fw/fw.h |   47 ++++++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 arch/mips/fw/lib/cmdline.c
 create mode 100644 arch/mips/include/asm/fw/fw.h

diff --git a/arch/mips/fw/lib/Makefile b/arch/mips/fw/lib/Makefile
index 84befc9..5291505 100644
--- a/arch/mips/fw/lib/Makefile
+++ b/arch/mips/fw/lib/Makefile
@@ -2,4 +2,6 @@
 # Makefile for generic prom monitor library routines under Linux.
 #
 
+lib-y			+= cmdline.o
+
 lib-$(CONFIG_64BIT)	+= call_o32.o
diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
new file mode 100644
index 0000000..b05b8130
--- /dev/null
+++ b/arch/mips/fw/lib/cmdline.c
@@ -0,0 +1,86 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
+ */
+#include <linux/kernel.h>
+#include <asm/fw/fw.h>
+
+int fw_argc;
+int *_fw_argv;
+int *_fw_envp;
+
+void __init fw_init_cmdline(void)
+{
+	int i;
+
+	fw_argc = (fw_arg0 & 0x0000ffff);
+	_fw_argv = (int *)fw_arg1;
+	_fw_envp = (int *)fw_arg2;
+
+	for (i = 1; i < fw_argc; i++) {
+		strlcat(arcs_cmdline, fw_argv(i), COMMAND_LINE_SIZE);
+		if (i < (fw_argc - 1))
+			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+	}
+}
+
+char * __init fw_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+char *fw_getenv(char *envname)
+{
+	char *result = NULL;
+
+	if (_fw_envp != NULL) {
+		/*
+		 * Return a pointer to the given environment variable.
+		 * YAMON uses "name", "value" pairs, while U-Boot uses
+		 * "name=value".
+		 */
+		int i, yamon, index = 0;
+
+		yamon = (strchr(fw_envp(index), '=') == NULL);
+		i = strlen(envname);
+
+		while (fw_envp(index)) {
+			if (strncmp(envname, fw_envp(index), i) == 0) {
+				if (yamon) {
+					result = fw_envp(index + 1);
+					break;
+				} else if (fw_envp(index)[i] == '=') {
+					result = (fw_envp(index + 1) + i);
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
+
+unsigned long fw_getenvl(char *envname)
+{
+	unsigned long envl = 0UL;
+	char *str;
+	long val;
+	int tmp;
+
+	str = fw_getenv(envname);
+	if (str) {
+		tmp = kstrtol(str, 0, &val);
+		envl = (unsigned long)val;
+	}
+
+	return envl;
+}
diff --git a/arch/mips/include/asm/fw/fw.h b/arch/mips/include/asm/fw/fw.h
new file mode 100644
index 0000000..d6c50a7
--- /dev/null
+++ b/arch/mips/include/asm/fw/fw.h
@@ -0,0 +1,47 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.
+ */
+#ifndef __ASM_FW_H_
+#define __ASM_FW_H_
+
+#include <asm/bootinfo.h>	/* For cleaner code... */
+
+enum fw_memtypes {
+	fw_dontuse,
+	fw_code,
+	fw_free,
+};
+
+typedef struct {
+	unsigned long base;	/* Within KSEG0 */
+	unsigned int size;	/* bytes */
+	enum fw_memtypes type;	/* fw_memtypes */
+} fw_memblock_t;
+
+/* Maximum number of memory block descriptors. */
+#define FW_MAX_MEMBLOCKS	32
+
+extern int fw_argc;
+extern int *_fw_argv;
+extern int *_fw_envp;
+
+/*
+ * Most firmware like YAMON, PMON, etc. pass arguments and environment
+ * variables as 32-bit pointers. These take care of sign extension.
+ */
+#define fw_argv(index)		((char *)(long)_fw_argv[(index)])
+#define fw_envp(index)		((char *)(long)_fw_envp[(index)])
+
+extern void fw_init_cmdline(void);
+extern char *fw_getcmdline(void);
+extern fw_memblock_t *fw_getmdesc(void);
+extern void fw_meminit(void);
+extern char *fw_getenv(char *name);
+extern unsigned long fw_getenvl(char *name);
+extern void fw_init_early_console(char port);
+
+#endif /* __ASM_FW_H_ */
-- 
1.7.10.3
