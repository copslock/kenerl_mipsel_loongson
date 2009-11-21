Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2009 21:35:39 +0100 (CET)
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:45132 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493261AbZKUUfd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2009 21:35:33 +0100
Received: from localhost.localdomain (a88-114-232-190.elisa-laajakaista.fi [88.114.232.190])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 1BC8013959C;
	Sat, 21 Nov 2009 22:35:20 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH] [MIPS] Fix and enhance built-in kernel command line
Date:	Sat, 21 Nov 2009 22:34:41 +0200
Message-Id: <1258835681-32200-1-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.6.3.3
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

Currently, MIPS kernels silently overwrite kernel command-line
parameters hardcoded in CONFIG_CMDLINE by the ones received
from firmware.  Therefore, using firmware remains the only
reliable method to transfer the command-line parameters, which
is not always desirable or convenient, and the CONFIG_CMDLINE
option is thereby effectively rendered useless.

This patch fixes the problem described above and introduces
a more flexible scheme of handling the kernel command line,
in a manner identical to what is currently used for x86.
The default behavior, i.e. when CONFIG_CMDLINE_BOOL is not
defined, retains the existing semantics, and firmware
command-line arguments override the hardcoded ones.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/Kconfig.debug  |   45 +++++++++++++++++++++++++++++++++++++++++----
 arch/mips/kernel/setup.c |   24 ++++++++++++++++++++----
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 364ca89..9835030 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -6,15 +6,52 @@ config TRACE_IRQFLAGS_SUPPORT
 
 source "lib/Kconfig.debug"
 
+config CMDLINE_BOOL
+	bool "Built-in kernel command line"
+	default n
+	help
+	  For most systems, it is firmware or second stage bootloader that
+	  by default specifies the kernel command line options.  However,
+	  it might be necessary or advantageous to either override the
+	  default kernel command line or add a few extra options to it.
+	  For such cases, this option allows you to hardcode your own
+	  command line options directly into the kernel.  For that, you
+	  should choose 'Y' here, and fill in the extra boot arguments
+	  in CONFIG_CMDLINE.
+
+	  The built-in options will be concatenated to the default command
+	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
+	  command line will be ignored and replaced by the built-in string.
+
+	  Most MIPS systems will normally expect 'N' here and rely upon
+	  the command line from the firmware or the second-stage bootloader.
+
+config CMDLINE_OVERRIDE
+	bool "Built-in command line overrides firware arguments"
+	default n
+	depends on CMDLINE_BOOL
+	help
+	  By setting this option to 'Y' you will have your kernel ignore
+	  command line arguments from firmware or second stage bootloader.
+	  Instead, the built-in command line will be used exclusively.
+
+	  Normally, you will choose 'N' here.
+
 config CMDLINE
 	string "Default kernel command string"
+	depends on CMDLINE_BOOL
 	default ""
 	help
 	  On some platforms, there is currently no way for the boot loader to
-	  pass arguments to the kernel. For these platforms, you can supply
-	  some command-line options at build time by entering them here.  In
-	  other cases you can specify kernel args so that you don't have
-	  to set them up in board prom initialization routines.
+	  pass arguments to the kernel.  For these platforms, and for the cases
+	  when you want to add some extra options to the command line or ignore
+	  the default command line, you can supply some command-line options at
+	  build time by entering them here.  In other cases you can specify
+	  kernel args so that you don't have to set them up in board prom
+	  initialization routines.
+
+	  For more information, see the CMDLINE_BOOL and CMDLINE_OVERRIDE
+	  options.
 
 config DEBUG_STACK_USAGE
 	bool "Enable stack utilization instrumentation"
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bd55f71..f9513f9 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -58,8 +58,12 @@ EXPORT_SYMBOL(mips_machtype);
 
 struct boot_mem_map boot_mem_map;
 
-static char command_line[COMMAND_LINE_SIZE];
-       char arcs_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+static char __initdata command_line[COMMAND_LINE_SIZE];
+char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
+
+#ifdef CONFIG_CMDLINE_BOOL
+static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+#endif
 
 /*
  * mips_io_port_base is the begin of the address space to which x86 style
@@ -458,8 +462,20 @@ static void __init arch_mem_init(char **cmdline_p)
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
 
-	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
-	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+#ifdef CONFIG_CMDLINE_BOOL
+#ifdef CONFIG_CMDLINE_OVERRIDE
+	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+#else
+	if (builtin_cmdline[0]) {
+		strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+		strlcat(arcs_cmdline, builtin_cmdline, COMMAND_LINE_SIZE);
+	}
+	strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+#endif
+#else
+	strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+#endif
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
 
-- 
1.6.3.3
