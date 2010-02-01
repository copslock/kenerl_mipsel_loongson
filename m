Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 14:08:17 +0100 (CET)
Received: from mail-yx0-f193.google.com ([209.85.210.193]:35124 "EHLO
        mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492354Ab0BANHw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 14:07:52 +0100
Received: by yxe31 with SMTP id 31so4014618yxe.21
        for <multiple recipients>; Mon, 01 Feb 2010 05:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=69CEM6EDYmDm+Dr0qFECBU2hdG47WLaz9hbQZjADxow=;
        b=fa1Bjooy30DntlWJkEiQPHC6M4VcJ1oQlMLYBdRex8hCbehuMzcKi/cp212vo4I2em
         slOUOGwIMPyiYTxlAyFGvsJsmEpTVpzJRd4BTap8HWw89q9wu10Ixr4d5qp4EKxGzGkB
         sEjSzw6u6ryMjKlOklb/GQcu5HgMwMIue0IyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=vby4EJgxc+y7c2plOmtoHrH0nyH6dD8xmnye7A+wwobTj9GG6Xbn1WdLfpzXOzeOSj
         QDMzytds/tmFiI0r5bxRoeQ4gnLHtkiwfSK/jHsgmUugPvcFi4ozWLLjCAKg8tkrb7Zz
         6v0OSSCJ0J5lY1o4V7wLzrGJm6+Md7fZduQM0=
Received: by 10.91.193.19 with SMTP id v19mr3909147agp.4.1265029665898;
        Mon, 01 Feb 2010 05:07:45 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm3254150gxk.13.2010.02.01.05.07.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 05:07:45 -0800 (PST)
Date:   Mon, 1 Feb 2010 22:06:56 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue 2/2] MIPS: Alchemy: use strlcat() for the command
 line arguments
Message-Id: <20100201220656.6aaee78c.yuasa@linux-mips.org>
In-Reply-To: <20100201220557.729e7061.yuasa@linux-mips.org>
References: <20100201220557.729e7061.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/alchemy/common/prom.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index 79e099f..c29511b 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -45,22 +45,13 @@ char **prom_envp;
 
 void prom_init_cmdline(void)
 {
-	char *cp;
-	int actr;
-
-	actr = 1; /* Always ignore argv[0] */
+	int i;
 
-	cp = &(arcs_cmdline[0]);
-	while (actr < prom_argc) {
-		strcpy(cp, prom_argv[actr]);
-		cp += strlen(prom_argv[actr]);
-		*cp++ = ' ';
-		actr++;
+	for (i = 1; i < prom_argc; i++) {
+		strlcat(arcs_cmdline, prom_argv[i], COMMAND_LINE_SIZE);
+		if (i < (prom_argc - 1))
+			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
 	}
-	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
-		--cp;
-	if (prom_argc > 1)
-		*cp = '\0';
 }
 
 char *prom_getenv(char *envname)
-- 
1.6.6.1
