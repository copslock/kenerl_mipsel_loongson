Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 22:43:38 +0200 (CEST)
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:59044 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493618AbZJMUnb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 22:43:31 +0200
Received: from localhost.localdomain (a88-114-232-190.elisa-laajakaista.fi [88.114.232.190])
	by gw03.mail.saunalahti.fi (Postfix) with ESMTP id 6A97A21676D;
	Tue, 13 Oct 2009 23:43:27 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH] [MIPS] Replace all usages of CL_SIZE by COMMAND_LINE_SIZE
Date:	Tue, 13 Oct 2009 23:43:24 +0300
Message-Id: <1255466604-23560-1-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

The MIPS-specific macro CL_SIZE is merely aliasing the macro
COMMAND_LINE_SIZE. Other architectures use the latter; also,
COMMAND_LINE_SIZE is documented in kernel-parameters.txt, so
let's use it, and remove the alias.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/bcm47xx/prom.c           |   10 +++++-----
 arch/mips/include/asm/bootinfo.h   |    4 +---
 arch/mips/kernel/setup.c           |    4 ++--
 arch/mips/lasat/prom.c             |    4 ++--
 arch/mips/mti-malta/malta-memory.c |    2 +-
 arch/mips/rb532/prom.c             |    4 ++--
 arch/mips/sibyte/common/cfe.c      |    4 ++--
 arch/mips/txx9/generic/setup.c     |    4 ++--
 8 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 079e33d..a06b1a6 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -100,11 +100,11 @@ static __init void prom_init_console(void)
 
 static __init void prom_init_cmdline(void)
 {
-	char buf[CL_SIZE];
+	char buf[COMMAND_LINE_SIZE];
 
 	/* Get the kernel command line from CFE */
-	if (cfe_getenv("LINUX_CMDLINE", buf, CL_SIZE) >= 0) {
-		buf[CL_SIZE-1] = 0;
+	if (cfe_getenv("LINUX_CMDLINE", buf, COMMAND_LINE_SIZE) >= 0) {
+		buf[COMMAND_LINE_SIZE-1] = 0;
 		strcpy(arcs_cmdline, buf);
 	}
 
@@ -112,13 +112,13 @@ static __init void prom_init_cmdline(void)
 	 * as CFE is not available anymore later in the boot process. */
 	if ((strstr(arcs_cmdline, "console=")) == NULL) {
 		/* Try to read the default serial port used by CFE */
-		if ((cfe_getenv("BOOT_CONSOLE", buf, CL_SIZE) < 0)
+		if ((cfe_getenv("BOOT_CONSOLE", buf, COMMAND_LINE_SIZE) < 0)
 		    || (strncmp("uart", buf, 4)))
 			/* Default to uart0 */
 			strcpy(buf, "uart0");
 
 		/* Compute the new command line */
-		snprintf(arcs_cmdline, CL_SIZE, "%s console=ttyS%c,115200",
+		snprintf(arcs_cmdline, COMMAND_LINE_SIZE, "%s console=ttyS%c,115200",
 			 arcs_cmdline, buf[4]);
 	}
 }
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index f5dfaf6..07d4115 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -69,8 +69,6 @@
 #define MACH_DEXXON_GDIUM2F10  5
 #define MACH_LOONGSON_END      6
 
-#define CL_SIZE			COMMAND_LINE_SIZE
-
 extern char *system_type;
 const char *get_system_type(void);
 
@@ -107,7 +105,7 @@ extern void free_init_pages(const char *what,
 /*
  * Initial kernel command line, usually setup by prom_init()
  */
-extern char arcs_cmdline[CL_SIZE];
+extern char arcs_cmdline[COMMAND_LINE_SIZE];
 
 /*
  * Registers a0, a1, a3 and a4 as passed to the kernel entry by firmware
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2b290d7..fd138c9 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -58,8 +58,8 @@ EXPORT_SYMBOL(mips_machtype);
 
 struct boot_mem_map boot_mem_map;
 
-static char command_line[CL_SIZE];
-       char arcs_cmdline[CL_SIZE]=CONFIG_CMDLINE;
+static char command_line[COMMAND_LINE_SIZE];
+       char arcs_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
 
 /*
  * mips_io_port_base is the begin of the address space to which x86 style
diff --git a/arch/mips/lasat/prom.c b/arch/mips/lasat/prom.c
index 6acc6cb..20fde19 100644
--- a/arch/mips/lasat/prom.c
+++ b/arch/mips/lasat/prom.c
@@ -100,8 +100,8 @@ void __init prom_init(void)
 
 	/* Get the command line */
 	if (argc > 0) {
-		strncpy(arcs_cmdline, argv[0], CL_SIZE-1);
-		arcs_cmdline[CL_SIZE-1] = '\0';
+		strncpy(arcs_cmdline, argv[0], COMMAND_LINE_SIZE-1);
+		arcs_cmdline[COMMAND_LINE_SIZE-1] = '\0';
 	}
 
 	/* Set the I/O base address */
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 61888ff..eafea87 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -54,7 +54,7 @@ static struct prom_pmemblock * __init prom_getmdesc(void)
 {
 	char *memsize_str;
 	unsigned int memsize;
-	char cmdline[CL_SIZE], *ptr;
+	char cmdline[COMMAND_LINE_SIZE], *ptr;
 
 	/* otherwise look in the environment */
 	memsize_str = prom_getenv("memsize");
diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index 46ca24d..dd6798f 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -69,7 +69,7 @@ static inline unsigned long tag2ul(char *arg, const char *tag)
 
 void __init prom_setup_cmdline(void)
 {
-	char cmd_line[CL_SIZE];
+	char cmd_line[COMMAND_LINE_SIZE];
 	char *cp, *board;
 	int prom_argc;
 	char **prom_argv, **prom_envp;
@@ -115,7 +115,7 @@ void __init prom_setup_cmdline(void)
 		strcpy(cp, arcs_cmdline);
 		cp += strlen(arcs_cmdline);
 	}
-	cmd_line[CL_SIZE-1] = '\0';
+	cmd_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	strcpy(arcs_cmdline, cmd_line);
 }
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index eb5396c..6343011 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -287,7 +287,7 @@ void __init prom_init(void)
 	 * boot console
 	 */
 	cfe_cons_handle = cfe_getstdhandle(CFE_STDHANDLE_CONSOLE);
-	if (cfe_getenv("LINUX_CMDLINE", arcs_cmdline, CL_SIZE) < 0) {
+	if (cfe_getenv("LINUX_CMDLINE", arcs_cmdline, COMMAND_LINE_SIZE) < 0) {
 		if (argc >= 0) {
 			/* The loader should have set the command line */
 			/* too early for panic to do any good */
@@ -318,7 +318,7 @@ void __init prom_init(void)
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 	/* Not sure this is needed, but it's the safe way. */
-	arcs_cmdline[CL_SIZE-1] = 0;
+	arcs_cmdline[COMMAND_LINE_SIZE-1] = 0;
 
 	prom_meminit();
 
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index c860810..cb8f2b3 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -160,7 +160,7 @@ static void __init prom_init_cmdline(void)
 	int argc;
 	int *argv32;
 	int i;			/* Always ignore the "-c" at argv[0] */
-	char builtin[CL_SIZE];
+	char builtin[COMMAND_LINE_SIZE];
 
 	if (fw_arg0 >= CKSEG0 || fw_arg1 < CKSEG0) {
 		/*
@@ -315,7 +315,7 @@ static inline void txx9_cache_fixup(void)
 
 static void __init preprocess_cmdline(void)
 {
-	char cmdline[CL_SIZE];
+	char cmdline[COMMAND_LINE_SIZE];
 	char *s;
 
 	strcpy(cmdline, arcs_cmdline);
-- 
1.6.0.4
