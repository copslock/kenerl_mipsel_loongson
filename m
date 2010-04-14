Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 03:28:41 +0200 (CEST)
Received: from imr1.ericy.com ([198.24.6.9]:56952 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492299Ab0DNB2f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Apr 2010 03:28:35 +0200
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o3E1WfAQ005113;
        Tue, 13 Apr 2010 20:32:46 -0500
Received: from prattle.redback.com (147.117.20.212) by
 eusaamw0711.eamcs.ericsson.se (147.117.20.179) with Microsoft SMTP Server id
 8.1.375.2; Tue, 13 Apr 2010 21:28:21 -0400
Received: from localhost (localhost [127.0.0.1])        by prattle.redback.com
 (Postfix) with ESMTP id 9858AFEFFFE;   Tue, 13 Apr 2010 18:28:21 -0700 (PDT)
Received: from prattle.redback.com ([127.0.0.1]) by localhost (prattle
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 01449-09; Tue, 13 Apr
 2010 18:28:21 -0700 (PDT)
Received: from localhost (rbos-pc-13.lab.redback.com [10.12.11.133])    by
 prattle.redback.com (Postfix) with ESMTP id 87263FEFFFC;       Tue, 13 Apr 2010
 18:28:20 -0700 (PDT)
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
CC:     Guenter Roeck <guenter.roeck@ericsson.com>
Subject: [PATCH] Fix sibyte watchdog initialization
Date:   Tue, 13 Apr 2010 18:28:16 -0700
Message-ID: <1271208496-30878-1-git-send-email-guenter.roeck@ericsson.com>
X-Mailer: git-send-email 1.7.0.87.g0901d
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <groeck@redback.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

Watchdog configuration register and timer count register were interchanged,
causing wrong values to be written into both registers.
This caused watchdog triggered resets even if the watchdog was reset in time.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/watchdog/sb_wdog.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
index 9748eed..1407cfa 100644
--- a/drivers/watchdog/sb_wdog.c
+++ b/drivers/watchdog/sb_wdog.c
@@ -67,8 +67,8 @@ static DEFINE_SPINLOCK(sbwd_lock);
 void sbwdog_set(char __iomem *wdog, unsigned long t)
 {
 	spin_lock(&sbwd_lock);
-	__raw_writeb(0, wdog - 0x10);
-	__raw_writeq(t & 0x7fffffUL, wdog);
+	__raw_writeb(0, wdog);
+	__raw_writeq(t & 0x7fffffUL, wdog - 0x10);
 	spin_unlock(&sbwd_lock);
 }
 
-- 
1.7.0.87.g0901d
