Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Mar 2009 22:13:14 +0000 (GMT)
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:46230 "EHLO
	gw01.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S21370128AbZCVWMl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Mar 2009 22:12:41 +0000
Received: from localhost.localdomain (a88-114-245-69.elisa-laajakaista.fi [88.114.245.69])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 4BE7C1514B2;
	Mon, 23 Mar 2009 00:12:38 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 1/3] [MIPS] Malta: make a needlessly global integer variable static
Date:	Mon, 23 Mar 2009 00:12:27 +0200
Message-Id: <1237759949-8223-2-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1237759949-8223-1-git-send-email-dmitri.vorobiev@movial.com>
References: <1237759949-8223-1-git-send-email-dmitri.vorobiev@movial.com>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

The variable `mips_revision_corid' is needlessly defined global in
arch/mips/mti-malta/malta-init.c, and this patch makes it static.

Build-tested with malta_defconfig.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/include/asm/mips-boards/generic.h |    2 --
 arch/mips/mti-malta/malta-init.c            |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index 7f0b034..c0da1a8 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -71,8 +71,6 @@
 
 #define MIPS_REVISION_CORID (((*(volatile u32 *)ioremap(MIPS_REVISION_REG, 4)) >> 10) & 0x3f)
 
-extern int mips_revision_corid;
-
 #define MIPS_REVISION_SCON_OTHER	   0
 #define MIPS_REVISION_SCON_SOCITSC	   1
 #define MIPS_REVISION_SCON_SOCITSCP	   2
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 4832af2..475038a 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -48,7 +48,7 @@ int *_prom_argv, *_prom_envp;
 
 int init_debug = 0;
 
-int mips_revision_corid;
+static int mips_revision_corid;
 int mips_revision_sconid;
 
 /* Bonito64 system controller register base. */
-- 
1.5.6.3
