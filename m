Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 21:53:16 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52649 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823703Ab2LZUwHpZNku (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 21:52:07 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 808AD8E1C;
        Wed, 26 Dec 2012 21:52:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gGcc46Pk8s5I; Wed, 26 Dec 2012 21:52:04 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 049638F65;
        Wed, 26 Dec 2012 21:51:45 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/6] MIPS: BCM47XX: rename early_nvram_init to nvram_init
Date:   Wed, 26 Dec 2012 21:51:12 +0100
Message-Id: <1356555074-1230-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
References: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 42e5271..6cf3ef2 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -112,7 +112,7 @@ static int nvram_init_bcma(void)
 }
 #endif
 
-static int early_nvram_init(void)
+static int nvram_init(void)
 {
 	switch (bcm47xx_bus_type) {
 #ifdef CONFIG_BCM47XX_SSB
@@ -136,7 +136,7 @@ int nvram_getenv(char *name, char *val, size_t val_len)
 		return -EINVAL;
 
 	if (!nvram_buf[0]) {
-		err = early_nvram_init();
+		err = nvram_init();
 		if (err)
 			return err;
 	}
-- 
1.7.10.4
