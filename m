Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 10:04:04 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:46667 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492651Ab0AZJD7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 10:03:59 +0100
Received: by yxe42 with SMTP id 42so2098313yxe.22
        for <multiple recipients>; Tue, 26 Jan 2010 01:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=U4r71kIRU/OcvCWz+5lUrg7FavOA/RYvyq5RKeZmX+g=;
        b=hmxiAX0em8NhrSUHwqXnFeYrvzVf29VEkbu35Iu/xpbTJFj+ZmbOyHTlTFtyb9S/sX
         pYcgZcAOrfG9z7ecaEq9nT7fzHCAtU/T4czBlJVsxaZrUYr3E/z8Sd5cN5TRTw2pxnGI
         K9Mtlw61ZZt3NA7WYGLISU2uGkJt+aUBYn/I8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=EXrIFstRAiHqL2QKbTSnDQOY8RIGVqZG5BNTQTJLx9JxhelGqlLzdB9HXJP9idukMg
         Knfnmh2+Ro43MB4N9HOZR9pt7Z7Yt2rJ/sbXzCdEMQk9BAjzeQyd26aQmI8pwI4OYXu8
         kVFzOMXw3crneYB6BHBAqsvzOjRW/A2XNkmnY=
Received: by 10.101.168.1 with SMTP id v1mr353550ano.34.1264496633658;
        Tue, 26 Jan 2010 01:03:53 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm3442081gxk.6.2010.01.26.01.03.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 01:03:52 -0800 (PST)
Date:   Tue, 26 Jan 2010 18:02:58 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: msp71xx: remove unused prom_getcmdline()
Message-Id: <20100126180258.13b21b6b.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16534

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |    1 -
 arch/mips/pmc-sierra/msp71xx/msp_prom.c            |    6 ------
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
index 14ca7dc..54ef1a9 100644
--- a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
+++ b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
@@ -118,7 +118,6 @@
 #define ZSP_DUET		'D'	/* one DUET zsp engine */
 #define ZSP_TRIAD		'T'	/* two TRIAD zsp engines */
 
-extern char *prom_getcmdline(void);
 extern char *prom_getenv(char *name);
 extern void prom_init_cmdline(void);
 extern void prom_meminit(void);
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
index c317a36..db98d87 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
@@ -303,12 +303,6 @@ char *prom_getenv(char *env_name)
 }
 
 /* PROM commandline functions */
-char *prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
-EXPORT_SYMBOL(prom_getcmdline);
-
 void  __init prom_init_cmdline(void)
 {
 	char *cp;
-- 
1.6.6.1
