Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:03:27 +0200 (CEST)
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:38974 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493617AbZJNTCe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:02:34 +0200
Received: from localhost.localdomain (a88-114-232-190.elisa-laajakaista.fi [88.114.232.190])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id AF82D15140B;
	Wed, 14 Oct 2009 22:02:28 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 2/3] [MIPS] msp71xx: remove unused function
Date:	Wed, 14 Oct 2009 22:02:18 +0300
Message-Id: <1255546939-3302-3-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

Nobody calls the board-specific prom_getcmdline(), so let's remove it.

Build-tested using msp71xx_defconfig.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |    1 -
 arch/mips/pmc-sierra/msp71xx/msp_prom.c            |    7 -------
 2 files changed, 0 insertions(+), 8 deletions(-)

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
index c317a36..614a20f 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
@@ -302,13 +302,6 @@ char *prom_getenv(char *env_name)
 	return NULL;
 }
 
-/* PROM commandline functions */
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
1.6.0.4
