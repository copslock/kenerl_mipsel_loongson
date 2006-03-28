Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 15:44:43 +0100 (BST)
Received: from fw01.bwg.de ([213.144.14.242]:34123 "EHLO fw01.bwg.de")
	by ftp.linux-mips.org with ESMTP id S8133536AbWC1Ooe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Mar 2006 15:44:34 +0100
Received: from fw01.bwg.de (localhost [127.0.0.1])
	by fw01.bwg.de (8.13.3/8.13.3) with ESMTP id k2SEt2wT023615
	for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 16:55:02 +0200 (CEST)
Received: from kundenmail (193.47.152.5) by fw01-4.bwg.de (smtprelay) with ESMTP Tue Mar 28 16:54:55 2006.
Received: from ximap.arbeitsgruppe (217.81.172.162)
          by kundenmail with MERCUR Mailserver (v4.03.15 MTI1LTI0MzctNDg3Nw==)
          for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 16:56:24 +0200
Received: from [192.168.178.44] (rr-2600 [192.168.178.44])
	by ximap.arbeitsgruppe (Postfix) with ESMTP id C5F8F174B2E
	for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 16:55:24 +0200 (CEST)
Message-ID: <44294E3C.8010602@rw-gmbh.de>
Date:	Tue, 28 Mar 2006 16:54:52 +0200
From:	=?ISO-8859-1?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] rtc.h: fixes to make genrtc.c compilable
References: <20060327074352.GC4781@dusktilldawn.nl> <4427A31F.9080801@ru.mvista.com>
In-Reply-To: <4427A31F.9080801@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------000600010901030809020408"
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000600010901030809020408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

patch below makes genrtc.c compilable again
--
Ralf Roesch


diff --git a/include/asm-mips/rtc.h b/include/asm-mips/rtc.h
index a2abc45..82ad401 100644
--- a/include/asm-mips/rtc.h
+++ b/include/asm-mips/rtc.h
@@ -32,7 +32,7 @@ static inline unsigned int get_rtc_time(
  {
         unsigned long nowtime;

-       nowtime = rtc_get_time();
+       nowtime = rtc_mips_get_time();
         to_tm(nowtime, time);
         time->tm_year -= 1900;

@@ -47,7 +47,7 @@ static inline int set_rtc_time(struct rt
         nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
                         time->tm_mday, time->tm_hour, time->tm_min,
                         time->tm_sec);
-       ret = rtc_set_time(nowtime);
+       ret = rtc_mips_set_time(nowtime);

         return ret;
  }


--------------000600010901030809020408
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




--------------000600010901030809020408--
