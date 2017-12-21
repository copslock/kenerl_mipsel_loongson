Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 15:41:11 +0100 (CET)
Received: from mga03.intel.com ([134.134.136.65]:17806 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990437AbdLUOlDPCloN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Dec 2017 15:41:03 +0100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2017 06:40:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.45,436,1508828400"; 
   d="scan'208";a="13637716"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Dec 2017 06:40:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1751429B; Thu, 21 Dec 2017 16:40:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] FIRMWARE: bcm47xx_nvram: Replace mac address parsing
Date:   Thu, 21 Dec 2017 16:40:55 +0200
Message-Id: <20171221144055.3840-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <andriy.shevchenko@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andriy.shevchenko@linux.intel.com
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

Replace sscanf() with mac_pton().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- use negative condition to be consistent with the rest code
 drivers/firmware/broadcom/Kconfig         |  1 +
 drivers/firmware/broadcom/bcm47xx_sprom.c | 18 +++---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/broadcom/Kconfig b/drivers/firmware/broadcom/Kconfig
index 5e29f83e7b39..c041dcb7ea52 100644
--- a/drivers/firmware/broadcom/Kconfig
+++ b/drivers/firmware/broadcom/Kconfig
@@ -13,6 +13,7 @@ config BCM47XX_NVRAM
 config BCM47XX_SPROM
 	bool "Broadcom SPROM driver"
 	depends on BCM47XX_NVRAM
+	select GENERIC_NET_UTILS
 	help
 	  Broadcom devices store configuration data in SPROM. Accessing it is
 	  specific to the bus host type, e.g. PCI(e) devices have it mapped in
diff --git a/drivers/firmware/broadcom/bcm47xx_sprom.c b/drivers/firmware/broadcom/bcm47xx_sprom.c
index 62aa3cf09b4d..4787f86c8ac1 100644
--- a/drivers/firmware/broadcom/bcm47xx_sprom.c
+++ b/drivers/firmware/broadcom/bcm47xx_sprom.c
@@ -137,20 +137,6 @@ static void nvram_read_leddc(const char *prefix, const char *name,
 	*leddc_off_time = (val >> 16) & 0xff;
 }
 
-static void bcm47xx_nvram_parse_macaddr(char *buf, u8 macaddr[6])
-{
-	if (strchr(buf, ':'))
-		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0],
-			&macaddr[1], &macaddr[2], &macaddr[3], &macaddr[4],
-			&macaddr[5]);
-	else if (strchr(buf, '-'))
-		sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx", &macaddr[0],
-			&macaddr[1], &macaddr[2], &macaddr[3], &macaddr[4],
-			&macaddr[5]);
-	else
-		pr_warn("Can not parse mac address: %s\n", buf);
-}
-
 static void nvram_read_macaddr(const char *prefix, const char *name,
 			       u8 val[6], bool fallback)
 {
@@ -161,7 +147,9 @@ static void nvram_read_macaddr(const char *prefix, const char *name,
 	if (err < 0)
 		return;
 
-	bcm47xx_nvram_parse_macaddr(buf, val);
+	strreplace(buf, '-', ':');
+	if (!mac_pton(buf, val))
+		pr_warn("Can not parse mac address: %s\n", buf);
 }
 
 static void nvram_read_alpha2(const char *prefix, const char *name,
-- 
2.15.1
