Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2012 18:13:53 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:59112 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901169Ab2AURN1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2012 18:13:27 +0100
Received: by eekb15 with SMTP id b15so594801eek.36
        for <multiple recipients>; Sat, 21 Jan 2012 09:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uyHfO1ir7FPcevJpabYYStNy0PQ1TDoqyB13jamPHdg=;
        b=t6f4pEY6QUe0jgsdrPaC6cwjPzPivuLtd2lTbN9voUFyCJD5v0do1J8WrXiH9sf8P1
         NeQ6Ke2XsfFM/gaN+/kLFc9eoCpHpd1eqMe0nbXcWH9mq3OI/nt+nD1d7mTqGYFq1EfL
         qd/jdEhm4C8CXzdEOyGGgpGilqcJTZ5KbQUoM=
Received: by 10.14.16.145 with SMTP id h17mr798991eeh.62.1327166001883;
        Sat, 21 Jan 2012 09:13:21 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-10-45.adsl.highway.telekom.at. [188.22.10.45])
        by mx.google.com with ESMTPS id x4sm28076665eeb.4.2012.01.21.09.13.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Jan 2012 09:13:21 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/3] MIPS: Alchemy: use 64MB RAM as minimum for devboards
Date:   Sat, 21 Jan 2012 18:13:13 +0100
Message-Id: <1327165995-27425-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1327165995-27425-1-git-send-email-manuel.lauss@googlemail.com>
References: <1327165995-27425-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 32296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

YAMON on all devboards provides the "memsize" envvar; in the unlikely
case that it can't be parsed just assume 64MB, which all boards have
at least.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/prom.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index 93a2210..57320f2 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -33,15 +33,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <prom.h>
 
-#if defined(CONFIG_MIPS_DB1000) || \
-    defined(CONFIG_MIPS_PB1100) || \
-    defined(CONFIG_MIPS_PB1500)
-#define ALCHEMY_BOARD_DEFAULT_MEMSIZE	0x04000000
-
-#else	/* Au1550/Au1200-based develboards */
-#define ALCHEMY_BOARD_DEFAULT_MEMSIZE	0x08000000
-#endif
-
 void __init prom_init(void)
 {
 	unsigned char *memsize_str;
@@ -54,7 +45,7 @@ void __init prom_init(void)
 	prom_init_cmdline();
 	memsize_str = prom_getenv("memsize");
 	if (!memsize_str || strict_strtoul(memsize_str, 0, &memsize))
-		memsize = ALCHEMY_BOARD_DEFAULT_MEMSIZE;
+		memsize = 64 << 20; /* all devboards have at least 64MB RAM */
 
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
-- 
1.7.8.4
