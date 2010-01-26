Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 10:57:19 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:45584 "EHLO
        mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491804Ab0AZJ5P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 10:57:15 +0100
Received: by gxk2 with SMTP id 2so1865359gxk.4
        for <multiple recipients>; Tue, 26 Jan 2010 01:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=8HlYlnVxSmU7qCwYUZov9SKMyI/Wki4UCqXqCIM3QFs=;
        b=bKv9hg97ikzHl3ZgHHlbIPpf8u3zkPlkjenG4FbkNWNiISEjhx8EZ03/UkE7XzgpbJ
         NZGSNmG+dYJ7TVSrtNd2Ms2K8t0OPOgpUMse25Wek9WmHIJ6f+m15Sg9S1L7m1MKIS4b
         8CsMH04Pew4po7uo3h9s7S0P4Z9Ux6HRzyODA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Otjora0Ibyfex22eeT3YzZD3H0f8AF2qv5yDXiuctFULZdMiISV5ItabaEEQ59rP0f
         OAPHM8Hdm/WIrychfQ0kEK2vguY9Fw0xYaQujiQw6YgmYoA2SvXQIWuw7Reelk1qA2KD
         fDKypMXcIpcww0kgCjoKW9aV70x7LVaAcxT3s=
Received: by 10.91.51.1 with SMTP id d1mr5571422agk.41.1264499828068;
        Tue, 26 Jan 2010 01:57:08 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 16sm3461919gxk.7.2010.01.26.01.57.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 01:57:07 -0800 (PST)
Date:   Tue, 26 Jan 2010 18:07:02 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: AR7: use strlcat() for the command line arguments
Message-Id: <20100126180702.d47afbcf.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16565

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/ar7/prom.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index c1fdd36..43b21c0 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -56,22 +56,12 @@ char * __init prom_getcmdline(void)
 
 static void  __init ar7_init_cmdline(int argc, char *argv[])
 {
-	char *cp;
-	int actr;
-
-	actr = 1; /* Always ignore argv[0] */
+	int i;
 
-	cp = &(arcs_cmdline[0]);
-	while (actr < argc) {
-		strcpy(cp, argv[actr]);
-		cp += strlen(argv[actr]);
-		*cp++ = ' ';
-		actr++;
-	}
-	if (cp != &(arcs_cmdline[0])) {
-		/* get rid of trailing space */
-		--cp;
-		*cp = '\0';
+	for (i = 1; i < argc; i++) {
+		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
+		if (i < (argc - 1))
+			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
 	}
 }
 
@@ -250,7 +240,7 @@ static void __init console_config(void)
 	else
 		sprintf(console_string, " console=ttyS0,%d%c%c", baud, parity,
 			bits);
-	strcat(prom_getcmdline(), console_string);
+	strlcat(arcs_cmdline, console_string, COMMAND_LINE_SIZE);
 #endif
 }
 
-- 
1.6.6.1
