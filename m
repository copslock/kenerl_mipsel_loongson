Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Nov 2009 18:20:49 +0100 (CET)
Received: from mba.ocn.ne.jp ([122.28.14.163]:56616 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492878AbZKGRUm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Nov 2009 18:20:42 +0100
Received: from localhost.localdomain (p6079-ipad307funabasi.chiba.ocn.ne.jp [123.217.184.79])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 94FFE71C9; Sun,  8 Nov 2009 02:20:38 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] MIPS: Make local arrays with CL_SIZE static __initdata
Date:	Sun,  8 Nov 2009 02:20:37 +0900
Message-Id: <1257614437-8632-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Since commit 22242681 ("MIPS: Extend COMMAND_LINE_SIZE"), CL_SIZE is
4096 and local array variables with this size will cause an build
failure with default CONFIG_FRAME_WARN settings.

Although current users of such array variables are all early bootstrap
code and might not cause real stack overflow (thread_info corruption),
it would be safe to declare these arrays static with __initdata.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/bcm47xx/prom.c           |    2 +-
 arch/mips/mti-malta/malta-memory.c |    3 ++-
 arch/mips/rb532/prom.c             |    2 +-
 arch/mips/txx9/generic/setup.c     |    4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 079e33d..fb284c3 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -100,7 +100,7 @@ static __init void prom_init_console(void)
 
 static __init void prom_init_cmdline(void)
 {
-	char buf[CL_SIZE];
+	static char buf[CL_SIZE] __initdata;
 
 	/* Get the kernel command line from CFE */
 	if (cfe_getenv("LINUX_CMDLINE", buf, CL_SIZE) >= 0) {
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 61888ff..9035c64 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -54,7 +54,8 @@ static struct prom_pmemblock * __init prom_getmdesc(void)
 {
 	char *memsize_str;
 	unsigned int memsize;
-	char cmdline[CL_SIZE], *ptr;
+	char *ptr;
+	static char cmdline[CL_SIZE] __initdata;
 
 	/* otherwise look in the environment */
 	memsize_str = prom_getenv("memsize");
diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index 46ca24d..ad5bd10 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -69,7 +69,7 @@ static inline unsigned long tag2ul(char *arg, const char *tag)
 
 void __init prom_setup_cmdline(void)
 {
-	char cmd_line[CL_SIZE];
+	static char cmd_line[CL_SIZE] __initdata;
 	char *cp, *board;
 	int prom_argc;
 	char **prom_argv, **prom_envp;
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index e10184c..d66802e 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -160,7 +160,7 @@ static void __init prom_init_cmdline(void)
 	int argc;
 	int *argv32;
 	int i;			/* Always ignore the "-c" at argv[0] */
-	char builtin[CL_SIZE];
+	static char builtin[CL_SIZE] __initdata;
 
 	if (fw_arg0 >= CKSEG0 || fw_arg1 < CKSEG0) {
 		/*
@@ -315,7 +315,7 @@ static inline void txx9_cache_fixup(void)
 
 static void __init preprocess_cmdline(void)
 {
-	char cmdline[CL_SIZE];
+	static char cmdline[CL_SIZE] __initdata;
 	char *s;
 
 	strcpy(cmdline, arcs_cmdline);
-- 
1.5.6.5
