Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 21:52:18 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52630 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823142Ab2LZUwALl4Iv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 21:52:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id D5D738E1C;
        Wed, 26 Dec 2012 21:51:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yl96zYL5Y4vX; Wed, 26 Dec 2012 21:51:56 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 3D9108F61;
        Wed, 26 Dec 2012 21:51:39 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/6] MIPS: BCM47XX: use common error codes in nvram reads
Date:   Wed, 26 Dec 2012 21:51:09 +0100
Message-Id: <1356555074-1230-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
References: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35325
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

Instead of using our own error codes use some common codes.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c                  |    4 ++--
 arch/mips/bcm47xx/sprom.c                  |    2 +-
 arch/mips/include/asm/mach-bcm47xx/nvram.h |    3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 6461367..e19fc26 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -124,7 +124,7 @@ int nvram_getenv(char *name, char *val, size_t val_len)
 	char *var, *value, *end, *eq;
 
 	if (!name)
-		return NVRAM_ERR_INV_PARAM;
+		return -EINVAL;
 
 	if (!nvram_buf[0])
 		early_nvram_init();
@@ -143,6 +143,6 @@ int nvram_getenv(char *name, char *val, size_t val_len)
 			return snprintf(val, val_len, "%s", value);
 		}
 	}
-	return NVRAM_ERR_ENVNOTFOUND;
+	return -ENOENT;
 }
 EXPORT_SYMBOL(nvram_getenv);
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 289cc0a..66b71c3 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -51,7 +51,7 @@ static int get_nvram_var(const char *prefix, const char *postfix,
 	create_key(prefix, postfix, name, key, sizeof(key));
 
 	err = nvram_getenv(key, buf, len);
-	if (fallback && err == NVRAM_ERR_ENVNOTFOUND && prefix) {
+	if (fallback && err == -ENOENT && prefix) {
 		create_key(NULL, postfix, name, key, sizeof(key));
 		err = nvram_getenv(key, buf, len);
 	}
diff --git a/arch/mips/include/asm/mach-bcm47xx/nvram.h b/arch/mips/include/asm/mach-bcm47xx/nvram.h
index 69ef3ef..550a7fc 100644
--- a/arch/mips/include/asm/mach-bcm47xx/nvram.h
+++ b/arch/mips/include/asm/mach-bcm47xx/nvram.h
@@ -32,9 +32,6 @@ struct nvram_header {
 #define NVRAM_MAX_VALUE_LEN 255
 #define NVRAM_MAX_PARAM_LEN 64
 
-#define NVRAM_ERR_INV_PARAM	-8
-#define NVRAM_ERR_ENVNOTFOUND	-9
-
 extern int nvram_getenv(char *name, char *val, size_t val_len);
 
 static inline void nvram_parse_macaddr(char *buf, u8 macaddr[6])
-- 
1.7.10.4
