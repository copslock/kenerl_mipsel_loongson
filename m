Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 19:35:31 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35842 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903555Ab2BSSdn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2012 19:33:43 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 4C8328F6E;
        Sun, 19 Feb 2012 19:33:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mdINB5Misq8k; Sun, 19 Feb 2012 19:33:29 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 0AFDB8F66;
        Sun, 19 Feb 2012 19:32:49 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/11] bcma: export bcma_find_core
Date:   Sun, 19 Feb 2012 19:32:20 +0100
Message-Id: <1329676345-15856-7-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This function is needed by the bcm47xx arch code to get the number of
the ieee80211 core.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/main.c       |    3 ++-
 include/linux/bcma/bcma.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index b8379b9..7e138ec 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -61,7 +61,7 @@ static struct bus_type bcma_bus_type = {
 	.dev_attrs	= bcma_device_attrs,
 };
 
-static struct bcma_device *bcma_find_core(struct bcma_bus *bus, u16 coreid)
+struct bcma_device *bcma_find_core(struct bcma_bus *bus, u16 coreid)
 {
 	struct bcma_device *core;
 
@@ -71,6 +71,7 @@ static struct bcma_device *bcma_find_core(struct bcma_bus *bus, u16 coreid)
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(bcma_find_core);
 
 static void bcma_release_core_dev(struct device *dev)
 {
diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
index b9f65fb..46bbd08 100644
--- a/include/linux/bcma/bcma.h
+++ b/include/linux/bcma/bcma.h
@@ -284,6 +284,7 @@ static inline void bcma_maskset16(struct bcma_device *cc,
 	bcma_write16(cc, offset, (bcma_read16(cc, offset) & mask) | set);
 }
 
+extern struct bcma_device *bcma_find_core(struct bcma_bus *bus, u16 coreid);
 extern bool bcma_core_is_enabled(struct bcma_device *core);
 extern void bcma_core_disable(struct bcma_device *core, u32 flags);
 extern int bcma_core_enable(struct bcma_device *core, u32 flags);
-- 
1.7.5.4
