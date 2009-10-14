Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:03:51 +0200 (CEST)
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:38977 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493639AbZJNTCf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:02:35 +0200
Received: from localhost.localdomain (a88-114-232-190.elisa-laajakaista.fi [88.114.232.190])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id D1BEB1516EA;
	Wed, 14 Oct 2009 22:02:31 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 3/3] [MIPS] remove an unused header file
Date:	Wed, 14 Oct 2009 22:02:19 +0300
Message-Id: <1255546939-3302-4-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

Nobody includes arch/mips/include/asm/mach-au1x00/prom.h, so remove
this header file now.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/include/asm/mach-au1x00/prom.h |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-au1x00/prom.h

diff --git a/arch/mips/include/asm/mach-au1x00/prom.h b/arch/mips/include/asm/mach-au1x00/prom.h
deleted file mode 100644
index e387155..0000000
--- a/arch/mips/include/asm/mach-au1x00/prom.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __AU1X00_PROM_H
-#define __AU1X00_PROM_H
-
-extern int prom_argc;
-extern char **prom_argv;
-extern char **prom_envp;
-
-extern void prom_init_cmdline(void);
-extern char *prom_getcmdline(void);
-extern char *prom_getenv(char *envname);
-extern int prom_get_ethernet_addr(char *ethernet_addr);
-
-#endif
-- 
1.6.0.4
