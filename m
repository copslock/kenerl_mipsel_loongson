Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2009 18:22:31 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:43202 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20028894AbZDORWW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Apr 2009 18:22:22 +0100
Received: from localhost.localdomain (p3165-ipad313funabasi.chiba.ocn.ne.jp [123.217.229.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 495C3A48C; Thu, 16 Apr 2009 02:22:15 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, ralf.roesch@rw-gmbh.de
Subject: [PATCH] rbtx4939: Fix typo in system name
Date:	Thu, 16 Apr 2009 02:22:21 +0900
Message-Id: <1239816141-8139-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/rbtx4939/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index d5ef662..91f2ec8 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -537,7 +537,7 @@ static void __init rbtx4939_setup(void)
 }
 
 struct txx9_board_vec rbtx4939_vec __initdata = {
-	.system = "Tothiba RBTX4939",
+	.system = "Toshiba RBTX4939",
 	.prom_init = rbtx4939_prom_init,
 	.mem_setup = rbtx4939_setup,
 	.irq_setup = rbtx4939_irq_setup,
-- 
1.5.6.3
