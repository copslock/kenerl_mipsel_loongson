Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2009 09:09:20 +0100 (CET)
Received: from mail-yw0-f182.google.com ([209.85.211.182]:35666 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491793AbZLXIJR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Dec 2009 09:09:17 +0100
Received: by ywh12 with SMTP id 12so8644664ywh.21
        for <multiple recipients>; Thu, 24 Dec 2009 00:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=bCr2UgI2anTxs62+3GHXH/TtVzKBRwpZAlqJGJmBE00=;
        b=c+/8coFvVjQ9DulZ+v/9fj67vZbMjF8BdRnjfgCh2qhiunL9bLmKCygrO1Ud1lpvGM
         iJpLVymWpD3Brf7nS4VlMcd43v1cA1dmGFuDxqmp5kDWqQXpxJbmVxMYARKI/SKGTzEF
         oYMGVwD457++tm1swDDmnRecFZaY3qyyNyzvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=d9Isb4cnVuuunN3U62nXvEeVKaUHJdHh12NEfTAushLmMGPfpOa/sPNfSfRED+d1b+
         3Ck2X0r8WM/V/b/FlCyk3brwMyaU7DFaGFkxBPNvL+OQ/bCyVWGssHdmT6Ww7LQ+5Nqe
         VebHr9bxZy0FXib4fxyb006eVry/wGjDlthJY=
Received: by 10.90.134.20 with SMTP id h20mr4104745agd.30.1261642149116;
        Thu, 24 Dec 2009 00:09:09 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm3728706gxk.8.2009.12.24.00.09.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Dec 2009 00:09:07 -0800 (PST)
Date:   Thu, 24 Dec 2009 17:06:34 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Cobalt use strlcat() for the command line arguments
Message-Id: <20091224170634.6663f521.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Tested with CoLo v1.22

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/cobalt/setup.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index b516442..ec3b2c4 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -97,26 +97,18 @@ void __init plat_mem_setup(void)
 
 void __init prom_init(void)
 {
-	int narg, indx, posn, nchr;
 	unsigned long memsz;
+	int argc, i;
 	char **argv;
 
 	memsz = fw_arg0 & 0x7fff0000;
-	narg = fw_arg0 & 0x0000ffff;
-
-	if (narg) {
-		arcs_cmdline[0] = '\0';
-		argv = (char **) fw_arg1;
-		posn = 0;
-		for (indx = 1; indx < narg; ++indx) {
-			nchr = strlen(argv[indx]);
-			if (posn + 1 + nchr + 1 > sizeof(arcs_cmdline))
-				break;
-			if (posn)
-				arcs_cmdline[posn++] = ' ';
-			strcpy(arcs_cmdline + posn, argv[indx]);
-			posn += nchr;
-		}
+	argc = fw_arg0 & 0x0000ffff;
+	argv = (char **)fw_arg1;
+
+	for (i = 1; i < argc; i++) {
+		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
+		if (i < (argc - 1))
+			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
 	}
 
 	add_memory_region(0x0, memsz, BOOT_MEM_RAM);
-- 
1.6.5.7
