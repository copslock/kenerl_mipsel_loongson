Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 19:36:16 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:2222 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133653AbWC0SgH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Mar 2006 19:36:07 +0100
Received: (qmail 19118 invoked from network); 27 Mar 2006 22:46:28 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 27 Mar 2006 22:46:28 -0000
Message-ID: <44283299.1080308@ru.mvista.com>
Date:	Mon, 27 Mar 2006 22:44:41 +0400
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Freddy Spierenburg <freddy@dusktilldawn.nl>,
	Jordan Crouse <jordan.crouse@amd.com>,
	Manish Lachwani <mlachwani@mvista.com>
Subject: [PATCH] Au1xx0: fix prom_getenv() to handle YAMON style environment
References: <20060327074352.GC4781@dusktilldawn.nl> <4427A31F.9080801@ru.mvista.com>
In-Reply-To: <4427A31F.9080801@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------090307050401070306010703"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090307050401070306010703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     Alchemy boards use YAMON which passes the environment variables as the
tuples of strings (the name followed by the value) unlike PMON which passes
"name=<val>" strings.

WBR, Sergei



--------------090307050401070306010703
Content-Type: text/plain;
 name="Au1xx0-fix-prom_getenv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1xx0-fix-prom_getenv.patch"

diff --git a/arch/mips/au1000/common/prom.c b/arch/mips/au1000/common/prom.c
index 9c171af..ae7d8c5 100644
--- a/arch/mips/au1000/common/prom.c
+++ b/arch/mips/au1000/common/prom.c
@@ -1,10 +1,9 @@
 /*
  *
  * BRIEF MODULE DESCRIPTION
- *    PROM library initialisation code, assuming a version of
- *    pmon is the boot code.
+ *    PROM library initialisation code, assuming YAMON is the boot loader.
  *
- * Copyright 2000,2001 MontaVista Software Inc.
+ * Copyright 2000, 2001, 2006 MontaVista Software Inc.
  * Author: MontaVista Software, Inc.
  *         	ppopov@mvista.com or source@mvista.com
  *
@@ -49,9 +48,9 @@ extern char **prom_argv, **prom_envp;
 
 typedef struct
 {
-    char *name;
-/*    char *val; */
-}t_env_var;
+	char *name;
+	char *val;
+} t_env_var;
 
 
 char * prom_getcmdline(void)
@@ -85,21 +84,16 @@ char *prom_getenv(char *envname)
 {
 	/*
 	 * Return a pointer to the given environment variable.
-	 * Environment variables are stored in the form of "memsize=64".
 	 */
 
 	t_env_var *env = (t_env_var *)prom_envp;
-	int i;
-
-	i = strlen(envname);
 
-	while(env->name) {
-		if(strncmp(envname, env->name, i) == 0) {
-			return(env->name + strlen(envname) + 1);
-		}
+	while (env->name) {
+		if (strcmp(envname, env->name) == 0)
+			return env->val;
 		env++;
 	}
-	return(NULL);
+	return NULL;
 }
 
 inline unsigned char str2hexnum(unsigned char c)



--------------090307050401070306010703--
