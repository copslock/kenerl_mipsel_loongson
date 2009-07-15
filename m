Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2009 15:04:10 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:57792 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492124AbZGONED (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Jul 2009 15:04:03 +0200
Received: from localhost.localdomain (p3002-ipad306funabasi.chiba.ocn.ne.jp [123.217.173.2])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3E5CA5F85; Wed, 15 Jul 2009 22:03:55 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rbtx4939: Fix IOC pin-enable register updating
Date:	Wed, 15 Jul 2009 22:03:56 +0900
Message-Id: <1247663036-4713-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The rbtx4939_update_ioc_pen() expects txx9_ce_res[] already
initialized.  Call it after tx4939_setup().

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/rbtx4939/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index c033ffe..b0c241e 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -512,10 +512,10 @@ static void __init rbtx4939_setup(void)
 	rbtx4939_ebusc_setup();
 	/* always enable ATA0 */
 	txx9_set64(&tx4939_ccfgptr->pcfg, TX4939_PCFG_ATA0MODE);
-	rbtx4939_update_ioc_pen();
 	if (txx9_master_clock == 0)
 		txx9_master_clock = 20000000;
 	tx4939_setup();
+	rbtx4939_update_ioc_pen();
 #ifdef HAVE_RBTX4939_IOSWAB
 	ioswabw = rbtx4939_ioswabw;
 	__mem_ioswabw = rbtx4939_mem_ioswabw;
-- 
1.5.6.5
