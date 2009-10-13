Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 21:37:14 +0200 (CEST)
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:44908 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492520AbZJMThI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 21:37:08 +0200
Received: from localhost.localdomain (a88-114-232-190.elisa-laajakaista.fi [88.114.232.190])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 3FC70139BBF;
	Tue, 13 Oct 2009 22:37:03 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH] [MIPS] ip22: remove an unused function
Date:	Tue, 13 Oct 2009 22:37:01 +0300
Message-Id: <1255462621-20290-1-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

Nobody is using the ARCS-specific prom_getcmdline(), so let's remove it.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/fw/arc/cmdline.c      |    5 -----
 arch/mips/include/asm/sgialib.h |    3 +--
 2 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/mips/fw/arc/cmdline.c b/arch/mips/fw/arc/cmdline.c
index 4ca4eef..5c8603c 100644
--- a/arch/mips/fw/arc/cmdline.c
+++ b/arch/mips/fw/arc/cmdline.c
@@ -16,11 +16,6 @@
 
 #undef DEBUG_CMDLINE
 
-char * __init prom_getcmdline(void)
-{
-	return arcs_cmdline;
-}
-
 static char *ignored[] = {
 	"ConsoleIn=",
 	"ConsoleOut=",
diff --git a/arch/mips/include/asm/sgialib.h b/arch/mips/include/asm/sgialib.h
index bfce5c7..63741ca 100644
--- a/arch/mips/include/asm/sgialib.h
+++ b/arch/mips/include/asm/sgialib.h
@@ -85,8 +85,7 @@ extern void prom_identify_arch(void);
 extern PCHAR ArcGetEnvironmentVariable(PCHAR name);
 extern LONG ArcSetEnvironmentVariable(PCHAR name, PCHAR value);
 
-/* ARCS command line acquisition and parsing. */
-extern char *prom_getcmdline(void);
+/* ARCS command line parsing. */
 extern void prom_init_cmdline(void);
 
 /* Acquiring info about the current time, etc. */
-- 
1.6.0.4
