Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 14:22:15 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:55461 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826613Ab2KKNWO6mXoI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 14:22:14 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2057282bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=QmNQL2q+PxhmROOPNot6D8+3obmeyjc1CUXusc8eybg=;
        b=zv3qaijy4s2iuFfuA1DJFgh746Fsrf0xeQFmfZljo2h46ix/mZznCqwlA7zQoMFho6
         bu8Dtl+XBjt1GWwYpWh1f844u8sC8Ll47xTmdIVcXOABr3VHF5bNLc/orLLkySesLf39
         Zs8HWZdDh0ge+7K+K+mucRMesift7yBEZrhQhPXgfks5vT0TxiD4zs2nwNSVR9gjG944
         Tlgg/VzGP6wHnJMLerpXIy2IpOpG6wWEgPQwMbWAzDc1xSwS42raJiIz9wddjktH+DvC
         UMgzB5wxgE4skmfYl3UTlnZWPLVWmwuiAf/aq/OtGhe155Y3dYyti5k1IjYX81bXH/Le
         SrBA==
Received: by 10.204.147.207 with SMTP id m15mr849229bkv.54.1352640129501;
        Sun, 11 Nov 2012 05:22:09 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id e3sm1458622bks.7.2012.11.11.05.22.07
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 05:22:08 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH] MIPS: BCM63XX: fix nvram checksum calculation
Date:   Sun, 11 Nov 2012 14:22:34 +0100
Message-Id: <1352640154-30179-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 34948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

The current checksum calculation code does nothing except checking that
the first byte of nvram is 0 without actually checking the checksum.

Implement the correct checksum calculation by calculating the crc32 with
the checksum field set to 0.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---

This patch depends on the previous nvram patch ("move nvram functions
into their own file").

 arch/mips/bcm63xx/nvram.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/mips/bcm63xx/nvram.c b/arch/mips/bcm63xx/nvram.c
index b57a10d..6206116 100644
--- a/arch/mips/bcm63xx/nvram.c
+++ b/arch/mips/bcm63xx/nvram.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) "bcm63xx_nvram: " fmt
 
 #include <linux/init.h>
+#include <linux/crc32.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/if_ether.h>
@@ -40,23 +41,25 @@ static int mac_addr_used;
 int __init bcm63xx_nvram_init(void *addr)
 {
 	unsigned int check_len;
-	u8 *p;
-	u32 val;
+	u32 crc, expected_crc;
 
 	/* extract nvram data */
 	memcpy(&nvram, addr, sizeof(nvram));
 
 	/* check checksum before using data */
-	if (nvram.version <= 4)
-		check_len = offsetof(struct bcm963xx_nvram, checksum_old);
-	else
+	if (nvram.version <= 4) {
+		check_len = offsetof(struct bcm963xx_nvram, reserved3);
+		expected_crc = nvram.checksum_old;
+		nvram.checksum_old = 0;
+	} else {
 		check_len = sizeof(nvram);
-	val = 0;
-	p = (u8 *)&nvram;
+		expected_crc = nvram.checksum_high;
+		nvram.checksum_high = 0;
+	}
+
+	crc = crc32_le(~0, (u8 *)&nvram, check_len);
 
-	while (check_len--)
-		val += *p;
-	if (val)
+	if (crc != expected_crc)
 		return -EINVAL;
 
 	return 0;
-- 
1.7.2.5
