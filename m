Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 19:34:22 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35808 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903562Ab2BSSdQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2012 19:33:16 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id DBD728F62;
        Sun, 19 Feb 2012 19:33:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i26xLR3f+F0t; Sun, 19 Feb 2012 19:33:02 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id B13108F63;
        Sun, 19 Feb 2012 19:32:47 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/11] ssb: fix per path sprom vars
Date:   Sun, 19 Feb 2012 19:32:17 +0100
Message-Id: <1329676345-15856-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On sprom version 4 and 5 there are 4 values for pa_2g, pa_5gl, pa_5g
and pa_5gh, for sprom version 8 and 9 there are only 3. Make the per
path sprom store also work for older sprom versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/ssb/ssb.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index 1de5675..4928419 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -19,7 +19,7 @@ struct ssb_driver;
 struct ssb_sprom_core_pwr_info {
 	u8 itssi_2g, itssi_5g;
 	u8 maxpwr_2g, maxpwr_5gl, maxpwr_5g, maxpwr_5gh;
-	u16 pa_2g[3], pa_5gl[3], pa_5g[3], pa_5gh[3];
+	u16 pa_2g[4], pa_5gl[4], pa_5g[4], pa_5gh[4];
 };
 
 struct ssb_sprom {
-- 
1.7.5.4
