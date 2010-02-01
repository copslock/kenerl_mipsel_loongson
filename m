Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 14:07:52 +0100 (CET)
Received: from mail-yx0-f193.google.com ([209.85.210.193]:60393 "EHLO
        mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492317Ab0BANHr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 14:07:47 +0100
Received: by yxe31 with SMTP id 31so4014536yxe.21
        for <multiple recipients>; Mon, 01 Feb 2010 05:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=qQNYuBD/iBjcpdnpnWq6cPRBFMcZFW2wXvqamsPswoc=;
        b=AjlKUq7CnDRBcB9roAC95xMlFDrvyBHNDQMUBQCCsYS5uI5wsux106/Y0ND15PQfQg
         +vtCWT5RYHx9ECjlEOZdTfc0zuzZNsY0iG9+VaF/nSE7+eGjRi+5HVJWWIkKgFIjSkWa
         50LaZEp0T8+UnRV/YhZzFrMoiVco4BT8FVcaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=o17LKNBhrfOWSX2M0jmj1fHtFV2ylXqTmCFJTBL4jY+pxVKZmfRqOrepxAApU83Sk8
         Bsb+bI7s+8hhMj/r6xeEYWTRy/PVPbnso8NbM0JPo6hVeRwvUvzweEkQO00+qS/BD0EL
         R8QdJWLqbDDf6+5sQ/4ikI6XrmIu+Nyc2bHwY=
Received: by 10.100.245.11 with SMTP id s11mr5255670anh.2.1265029661295;
        Mon, 01 Feb 2010 05:07:41 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm3270986gxk.1.2010.02.01.05.07.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 05:07:40 -0800 (PST)
Date:   Mon, 1 Feb 2010 22:05:57 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue 1/2] MIPS: Alchemy: remove prom_getcmdline()
Message-Id: <20100201220557.729e7061.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/alchemy/common/prom.c          |    9 +--------
 arch/mips/include/asm/mach-au1x00/prom.h |    1 -
 2 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index 18b310b..79e099f 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -43,11 +43,6 @@ int prom_argc;
 char **prom_argv;
 char **prom_envp;
 
-char * __init_or_module prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
-
 void prom_init_cmdline(void)
 {
 	char *cp;
@@ -121,14 +116,12 @@ static inline void str2eaddr(unsigned char *ea, unsigned char *str)
 int prom_get_ethernet_addr(char *ethernet_addr)
 {
 	char *ethaddr_str;
-	char *argptr;
 
 	/* Check the environment variables first */
 	ethaddr_str = prom_getenv("ethaddr");
 	if (!ethaddr_str) {
 		/* Check command line */
-		argptr = prom_getcmdline();
-		ethaddr_str = strstr(argptr, "ethaddr=");
+		ethaddr_str = strstr(arcs_cmdline, "ethaddr=");
 		if (!ethaddr_str)
 			return -1;
 
diff --git a/arch/mips/include/asm/mach-au1x00/prom.h b/arch/mips/include/asm/mach-au1x00/prom.h
index e387155..4c0e09c 100644
--- a/arch/mips/include/asm/mach-au1x00/prom.h
+++ b/arch/mips/include/asm/mach-au1x00/prom.h
@@ -6,7 +6,6 @@ extern char **prom_argv;
 extern char **prom_envp;
 
 extern void prom_init_cmdline(void);
-extern char *prom_getcmdline(void);
 extern char *prom_getenv(char *envname);
 extern int prom_get_ethernet_addr(char *ethernet_addr);
 
-- 
1.6.6.1
