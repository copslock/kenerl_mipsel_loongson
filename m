Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 13:31:28 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:44759 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6826364Ab3IRLbYxImoy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 13:31:24 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 8979C8F61;
        Wed, 18 Sep 2013 13:31:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y3lvr1LH3d2D; Wed, 18 Sep 2013 13:31:18 +0200 (CEST)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id F2C15857F;
        Wed, 18 Sep 2013 13:31:17 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: BCM47XX: get GPIO pin from nvram configuration
Date:   Wed, 18 Sep 2013 13:31:15 +0200
Message-Id: <1379503875-9093-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37846
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

The nvram contains some gpio configuration for boards. It is stored in
a gpio<number>=name format e.g.
gpio8=wps_button
gpio4=robo_reset

This patches adds a function to parse these entries, so other driver
can use it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c                          |   20 ++++++++++++++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h |    2 ++
 2 files changed, 22 insertions(+)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index cc40b74..b4c585b 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -190,3 +190,23 @@ int bcm47xx_nvram_getenv(char *name, char *val, size_t val_len)
 	return -ENOENT;
 }
 EXPORT_SYMBOL(bcm47xx_nvram_getenv);
+
+int bcm47xx_nvram_gpio_pin(const char *name)
+{
+	int i, err;
+	char nvram_var[10];
+	char buf[30];
+
+	for (i = 0; i < 16; i++) {
+		err = snprintf(nvram_var, sizeof(nvram_var), "gpio%i", i);
+		if (err <= 0)
+			continue;
+		err = bcm47xx_nvram_getenv(nvram_var, buf, sizeof(buf));
+		if (err <= 0)
+			continue;
+		if (!strcmp(name, buf))
+			return i;
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL(bcm47xx_nvram_gpio_pin);
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
index b8e7be8..36a3fc1 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
@@ -48,4 +48,6 @@ static inline void bcm47xx_nvram_parse_macaddr(char *buf, u8 macaddr[6])
 		printk(KERN_WARNING "Can not parse mac address: %s\n", buf);
 }
 
+int bcm47xx_nvram_gpio_pin(const char *name);
+
 #endif /* __BCM47XX_NVRAM_H */
-- 
1.7.10.4
