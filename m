Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 09:25:53 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:46297 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491922AbZLHIZt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 09:25:49 +0100
Received: by yxe42 with SMTP id 42so5211467yxe.22
        for <multiple recipients>; Tue, 08 Dec 2009 00:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=dHDDc/7z2Aame5bdsWdPYbhgDBPEuJ9cIUhpgXM06yE=;
        b=a5erPesJ5Q2gLz6/c1Orhj2kdViC8SRPR+BiKUmjFC/gcWirj4gfA4MEHJV6ljkZBX
         W9AWy8aaxY52wuV6yZAIqP4wUq4RI6poeG7iSGIAUc/I9NT2E600LlWHeqsZpkwxXAEg
         LKC/7grRvTTvkJNCjWPDciwhhaJkzfICr4zts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=UNoSlut25XQqP6/qB8mt6pZ23apC5RFyic7un4AohmIGhCS11VSZs6uLmbM+Uq+8SO
         yAOScrDFJ9wD//ZHDtnXaRu42QQ/4BLWCNGV1+0Dp0nIWjOCFdmZ2vVNDKDCadKUZkRo
         JX82DYxWdgAF7ZpLLItbeqhbjyWOh2HVDSHFA=
Received: by 10.150.24.2 with SMTP id 2mr13387819ybx.172.1260260742829;
        Tue, 08 Dec 2009 00:25:42 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm3320252gxk.12.2009.12.08.00.25.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 00:25:41 -0800 (PST)
Date:   Tue, 8 Dec 2009 17:24:44 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH resend] MIPS: more replace CL_SIZE by COMMAND_LINE_SIZE
Message-Id: <20091208172444.9e48afe7.yuasa@linux-mips.org>
In-Reply-To: <20091208165844.ddd9106f.yuasa@linux-mips.org>
References: <20091208165844.ddd9106f.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Sorry, I forgot one more CL_SIZE.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/powertv/asic/asic_devices.c |    4 ++--
 arch/mips/powertv/cmdline.c           |    2 +-
 arch/mips/powertv/memory.c            |    2 +-
 arch/mips/rb532/prom.c                |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index 5f20cee..bae8288 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -187,7 +187,7 @@ static void __init fs_update(int pe, int md, int sdiv, int disable_div_by_3)
 /*
  * Allow override of bootloader-specified model
  */
-static char __initdata cmdline[CL_SIZE];
+static char __initdata cmdline[COMMAND_LINE_SIZE];
 
 #define	FORCEFAMILY_PARAM	"forcefamily"
 
@@ -199,7 +199,7 @@ static __init int check_forcefamily(unsigned char forced_family[2])
 	forced_family[1] = '\0';
 
 	/* Check the command line for a forcefamily directive */
-	strncpy(cmdline, arcs_cmdline, CL_SIZE - 1);
+	strncpy(cmdline, arcs_cmdline, COMMAND_LINE_SIZE - 1);
 	p = strstr(cmdline, FORCEFAMILY_PARAM);
 	if (p && (p != cmdline) && (*(p - 1) != ' '))
 		p = strstr(p, " " FORCEFAMILY_PARAM "=");
diff --git a/arch/mips/powertv/cmdline.c b/arch/mips/powertv/cmdline.c
index 3bc4334..98d73cb 100644
--- a/arch/mips/powertv/cmdline.c
+++ b/arch/mips/powertv/cmdline.c
@@ -48,5 +48,5 @@ void  __init prom_init_cmdline(void)
 	arcs_cmdline[len] = ' ';
 
 	strlcpy(arcs_cmdline + len + 1, (char *)_prom_argv,
-		CL_SIZE - len - 1);
+		COMMAND_LINE_SIZE - len - 1);
 }
diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
index c63620a..28d0660 100644
--- a/arch/mips/powertv/memory.c
+++ b/arch/mips/powertv/memory.c
@@ -44,7 +44,7 @@
 
 unsigned long ptv_memsize;
 
-char __initdata cmdline[CL_SIZE];
+char __initdata cmdline[COMMAND_LINE_SIZE];
 
 void __init prom_meminit(void)
 {
diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index f4f3f2e..13f350c 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -69,7 +69,7 @@ static inline unsigned long tag2ul(char *arg, const char *tag)
 
 void __init prom_setup_cmdline(void)
 {
-	static char cmd_line[CL_SIZE] __initdata;
+	static char cmd_line[COMMAND_LINE_SIZE] __initdata;
 	char *cp, *board;
 	int prom_argc;
 	char **prom_argv, **prom_envp;
-- 
1.6.5.4
