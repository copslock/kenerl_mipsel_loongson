Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 19:36:20 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35865 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903592Ab2BSSd5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2012 19:33:57 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 641268F73;
        Sun, 19 Feb 2012 19:33:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id epN5o04Ke8qu; Sun, 19 Feb 2012 19:33:43 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id E28468F68;
        Sun, 19 Feb 2012 19:32:49 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/11] MIPS: BCM47XX: return number of written bytes in nvram_getenv
Date:   Sun, 19 Feb 2012 19:32:22 +0100
Message-Id: <1329676345-15856-9-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index a84e3bb..d43ceff 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -107,8 +107,7 @@ int nvram_getenv(char *name, char *val, size_t val_len)
 		value = eq + 1;
 		if ((eq - var) == strlen(name) &&
 			strncmp(var, name, (eq - var)) == 0) {
-			snprintf(val, val_len, "%s", value);
-			return 0;
+			return snprintf(val, val_len, "%s", value);
 		}
 	}
 	return NVRAM_ERR_ENVNOTFOUND;
-- 
1.7.5.4
