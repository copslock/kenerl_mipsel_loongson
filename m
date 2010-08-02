Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2010 23:56:33 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:37911 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492134Ab0HBV43 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Aug 2010 23:56:29 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 57F2985E2;
        Mon,  2 Aug 2010 23:56:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fPW+vg8D379S; Mon,  2 Aug 2010 23:56:25 +0200 (CEST)
Received: from localhost.localdomain (host-091-096-211-123.ewe-ip-backbone.de [91.96.211.123])
        by hauke-m.de (Postfix) with ESMTPSA id 2607B85E1;
        Mon,  2 Aug 2010 23:56:25 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Waldemar Brodkorb <wbx@openadk.org>
Subject: [PATCH] MIPS: BCM47xx: nvram_getenv fix return value.
Date:   Mon,  2 Aug 2010 23:56:22 +0200
Message-Id: <1280786182-6100-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

nvram_getenv should behave like cfe_getenv. For now it is used like
cfe_getenv. cfe_getenv returns 0 on success and -9 if the value was
not found. If the input was wrong -8 will be returned by cfe_getenv.
Change nvram_getenv to do the same.
The code using nvram_getenv expects it to behave like cfe_getenv does.

CC: Waldemar Brodkorb <wbx@openadk.org>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c                  |    4 ++--
 arch/mips/include/asm/mach-bcm47xx/nvram.h |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 06e03b2..e5b6615 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -69,7 +69,7 @@ int nvram_getenv(char *name, char *val, size_t val_len)
 	char *var, *value, *end, *eq;
 
 	if (!name)
-		return 1;
+		return NVRAM_ERR_INV_PARAM;
 
 	if (!nvram_buf[0])
 		early_nvram_init();
@@ -89,6 +89,6 @@ int nvram_getenv(char *name, char *val, size_t val_len)
 			return 0;
 		}
 	}
-	return 1;
+	return NVRAM_ERR_ENVNOTFOUND;
 }
 EXPORT_SYMBOL(nvram_getenv);
diff --git a/arch/mips/include/asm/mach-bcm47xx/nvram.h b/arch/mips/include/asm/mach-bcm47xx/nvram.h
index 0d8cc14..c58ebd8 100644
--- a/arch/mips/include/asm/mach-bcm47xx/nvram.h
+++ b/arch/mips/include/asm/mach-bcm47xx/nvram.h
@@ -31,6 +31,9 @@ struct nvram_header {
 #define NVRAM_MAX_VALUE_LEN 255
 #define NVRAM_MAX_PARAM_LEN 64
 
+#define NVRAM_ERR_INV_PARAM	-8
+#define NVRAM_ERR_ENVNOTFOUND	-9
+
 extern int nvram_getenv(char *name, char *val, size_t val_len);
 
 #endif
-- 
1.7.0.4
