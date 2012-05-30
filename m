Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2012 00:12:05 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43483 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903646Ab2E3WLJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2012 00:11:09 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SZr6d-00012l-DP; Wed, 30 May 2012 17:11:03 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 2/5] MIPS: Clean up YAMON support for Alchemy platforms.
Date:   Wed, 30 May 2012 17:10:52 -0500
Message-Id: <1338415855-11401-3-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1338415855-11401-1-git-send-email-sjhill@mips.com>
References: <1338415855-11401-1-git-send-email-sjhill@mips.com>
X-archive-position: 33494
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
 arch/mips/alchemy/board-gpr.c            |    2 +-
 arch/mips/alchemy/board-mtx1.c           |    2 +-
 arch/mips/alchemy/board-xxs1500.c        |    2 +-
 arch/mips/alchemy/common/prom.c          |   39 ------------------------------
 arch/mips/alchemy/devboards/prom.c       |    2 +-
 arch/mips/include/asm/mach-au1x00/prom.h |   12 ---------
 6 files changed, 4 insertions(+), 55 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-au1x00/prom.h

diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index ba32590..942206d 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -47,7 +47,7 @@ void __init prom_init(void)
 
 	prom_argc = fw_arg0;
 	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	_prom_envp = (int *)fw_arg2;
 
 	prom_init_cmdline();
 
diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 295f1a9..40bc647 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -47,7 +47,7 @@ void __init prom_init(void)
 
 	prom_argc = fw_arg0;
 	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	_prom_envp = (int *)fw_arg2;
 
 	prom_init_cmdline();
 
diff --git a/arch/mips/alchemy/board-xxs1500.c b/arch/mips/alchemy/board-xxs1500.c
index bd55136..52a651d 100644
--- a/arch/mips/alchemy/board-xxs1500.c
+++ b/arch/mips/alchemy/board-xxs1500.c
@@ -44,7 +44,7 @@ void __init prom_init(void)
 
 	prom_argc = fw_arg0;
 	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	_prom_envp = (int *)fw_arg2;
 
 	prom_init_cmdline();
 
diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index 5340210..eeefd97 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -36,47 +36,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
-
 #include <asm/bootinfo.h>
 
-int prom_argc;
-char **prom_argv;
-char **prom_envp;
-
-void __init prom_init_cmdline(void)
-{
-	int i;
-
-	for (i = 1; i < prom_argc; i++) {
-		strlcat(arcs_cmdline, prom_argv[i], COMMAND_LINE_SIZE);
-		if (i < (prom_argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
-	}
-}
-
-char *prom_getenv(char *envname)
-{
-	/*
-	 * Return a pointer to the given environment variable.
-	 * YAMON uses "name", "value" pairs, while U-Boot uses "name=value".
-	 */
-
-	char **env = prom_envp;
-	int i = strlen(envname);
-	int yamon = (*env && strchr(*env, '=') == NULL);
-
-	while (*env) {
-		if (yamon) {
-			if (strcmp(envname, *env++) == 0)
-				return *env;
-		} else if (strncmp(envname, *env, i) == 0 && (*env)[i] == '=')
-			return *env + i + 1;
-		env++;
-	}
-
-	return NULL;
-}
-
 static inline unsigned char str2hexnum(unsigned char c)
 {
 	if (c >= '0' && c <= '9')
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index 93a2210..b6e9e02 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -49,7 +49,7 @@ void __init prom_init(void)
 
 	prom_argc = (int)fw_arg0;
 	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	_prom_envp = (int *)fw_arg2;
 
 	prom_init_cmdline();
 	memsize_str = prom_getenv("memsize");
diff --git a/arch/mips/include/asm/mach-au1x00/prom.h b/arch/mips/include/asm/mach-au1x00/prom.h
deleted file mode 100644
index 4c0e09c..0000000
--- a/arch/mips/include/asm/mach-au1x00/prom.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef __AU1X00_PROM_H
-#define __AU1X00_PROM_H
-
-extern int prom_argc;
-extern char **prom_argv;
-extern char **prom_envp;
-
-extern void prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
-extern int prom_get_ethernet_addr(char *ethernet_addr);
-
-#endif
-- 
1.7.10
