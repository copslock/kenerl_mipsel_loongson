Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2006 07:17:27 +0100 (BST)
Received: from deliver-2.mx.triera.net ([213.161.0.32]:14749 "EHLO
	deliver-2.mx.triera.net") by ftp.linux-mips.org with ESMTP
	id S8133446AbWGCGRR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Jul 2006 07:17:17 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-2.mx.triera.net (Postfix) with ESMTP id 63C9F1B5;
	Mon,  3 Jul 2006 08:17:07 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 014141BC081;
	Mon,  3 Jul 2006 08:17:07 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 0E3031A18AB;
	Mon,  3 Jul 2006 08:17:07 +0200 (CEST)
Date:	Mon, 3 Jul 2006 08:17:09 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [patch] au1xxx: support YAMON and U-Boot
Message-ID: <20060703061709.GL31105@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

After (too) many emails with Sergei Shtylyov, we came up with this
patch to support YAMON and U-Boot style environments.


Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

Index: linux-mailed/arch/mips/au1000/common/prom.c
===================================================================
--- linux-mailed.orig/arch/mips/au1000/common/prom.c
+++ linux-mailed/arch/mips/au1000/common/prom.c
@@ -1,7 +1,7 @@
 /*
  *
  * BRIEF MODULE DESCRIPTION
- *    PROM library initialisation code, assuming YAMON is the boot loader.
+ *    PROM library initialisation code, supports YAMON and U-Boot.
  *
  * Copyright 2000, 2001, 2006 MontaVista Software Inc.
  * Author: MontaVista Software, Inc.
@@ -46,12 +46,6 @@
 extern int prom_argc;
 extern char **prom_argv, **prom_envp;
 
-typedef struct
-{
-	char *name;
-	char *val;
-} t_env_var;
-
 
 char * prom_getcmdline(void)
 {
@@ -84,13 +78,21 @@ char *prom_getenv(char *envname)
 {
 	/*
 	 * Return a pointer to the given environment variable.
+	 * YAMON uses "name", "value" pairs, while U-Boot uses "name=value".
 	 */
 
-	t_env_var *env = (t_env_var *)prom_envp;
-
-	while (env->name) {
-		if (strcmp(envname, env->name) == 0)
-			return env->val;
+	char **env = prom_envp;
+	int i = strlen(envname);
+	int yamon = (*env && strchr(*env, '=') == NULL);
+
+	while (*env) {
+		if (yamon) {
+			if (strcmp(envname, *env++) == 0)
+				return *env;
+		} else {
+			if (strncmp(envname, *env, i) == 0 && (*env)[i] == '=')
+				return *env + i + 1;
+		}
 		env++;
 	}
 	return NULL;
