Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 08:59:54 +0100 (CET)
Received: from mail-yw0-f203.google.com ([209.85.211.203]:32921 "EHLO
        mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491043AbZLHH7u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 08:59:50 +0100
Received: by ywh41 with SMTP id 41so7421637ywh.0
        for <multiple recipients>; Mon, 07 Dec 2009 23:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=zQJcHYoCGkxyRT2AyuPdySDebDEQSiladZ7f0pTL0tY=;
        b=TymEX+aCddqHVMF+DTTFQ5VLnIroD+/nGSdc2OnHhnqyIS/BxMDFOMwMhMtRnqYaiP
         LDVyjjkiR9Cp6jxdYI4TG6P6KqxIMSs1tGafHUYaTwqXXpchj5LXmRJ4cxD2NRX3cVCG
         x/Rj8P3X3VeG0t5XKn7zwxmFnADzp/ar9ZKa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=PNR9oC7XAc/InFf/GNzbDx3h9xO45Fz3i3hX+P3auwVImoGxFlDwzepYyxAwlipboK
         sfJEXKVX9CKr1V33Pmqquu1WalR+xxvNhz6ARXasSY5znrpQ/qIvgyG/mOHpx6DkOsGN
         id9ziGrO+xeJDIcEAuRxdJdcONrhw6qsFa9TM=
Received: by 10.150.235.5 with SMTP id i5mr13277742ybh.271.1260259183606;
        Mon, 07 Dec 2009 23:59:43 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm3312492gxk.12.2009.12.07.23.59.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 23:59:42 -0800 (PST)
Date:   Tue, 8 Dec 2009 16:58:44 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: more replace CL_SIZE by COMMAND_LINE_SIZE
Message-Id: <20091208165844.ddd9106f.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips


Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/powertv/asic/asic_devices.c |    4 ++--
 arch/mips/powertv/memory.c            |    2 +-
 arch/mips/rb532/prom.c                |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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
