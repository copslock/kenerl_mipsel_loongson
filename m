Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 00:04:38 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:52007 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008407AbbLJXEgA1s6l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Dec 2015 00:04:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Cc:To:Subject:From; bh=5LrGbl8Q4VSOeiGpBqEDktZmSvqkSbF+S5xkoVDgSHA=;
        b=nojgXnlyCP3RE3qLLLMu8W3Oy07yKU1umCElHsloViP1dfEMpRC3CsMv7ltA5l36K5edAf2yL6VLJL1blooPS6jVf5btlI5T2B+2i5AD6U7AD5YQ6Z3Pj5F/keXqfOd6QPqgbIKeNMoED2IGNbRqlka0L8CoLyol+gi80SX3TKGztiRhCcZV3Q/S16hKMtLAa7ZGvUHY77K2D6X9IB/P9DdKAzNntEnI/iUv9d8Tfd9lkUWq1CZZ/b+vV43x3Zi+B9pk+vK1M3ZR0yfbFXAw1s2PTWLT/28/aOQF2DcVmBcQyrJ/OmBazSgioK0hX3p/6zQbGjH55b7d8GUmnyDPdw==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:60947)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a7AGD-0004KK-G4 (Exim); Thu, 10 Dec 2015 23:04:30 +0000
From:   Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH linux-next (v2) 1/3] MIPS: bcm963xx: Add nvram structure
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Jonas Gorski <jogo@openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-api@vger.kernel.org
Message-ID: <566A04FB.7000104@simon.arlott.org.uk>
Date:   Thu, 10 Dec 2015 23:04:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

The BCM963xx has multiple nvram variants across different SoCs with
additional checksum fields added whenever the size of the nvram was
extended.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v2: Use external struct bcm963xx_nvram definition for bcm963268part.

 MAINTAINERS                         |  1 +
 include/uapi/linux/bcm963xx_nvram.h | 39 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/uapi/linux/bcm963xx_nvram.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1354720..5d2272c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2396,6 +2396,7 @@ F:	drivers/irqchip/irq-brcmstb*
 F:	drivers/power/bcm6358*
 F:	drivers/reset/bcm/reset-bcm6345*
 F:	include/linux/bcm63xx_wdt.h
+F:	include/uapi/linux/bcm963xx_nvram.h
 
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Prashant Sreedharan <prashant@broadcom.com>
diff --git a/include/uapi/linux/bcm963xx_nvram.h b/include/uapi/linux/bcm963xx_nvram.h
new file mode 100644
index 0000000..470a4b9
--- /dev/null
+++ b/include/uapi/linux/bcm963xx_nvram.h
@@ -0,0 +1,39 @@
+#ifndef _UAPI__LINUX_BCM963XX_NVRAM_H__
+#define _UAPI__LINUX_BCM963XX_NVRAM_H__
+
+#include <linux/sizes.h>
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
+#define BCM963XX_NVRAM_V4_SIZE		300
+#define BCM963XX_NVRAM_V5_SIZE		(1 * SZ_1K)
+#define BCM963XX_NVRAM_V6_SIZE		BCM963XX_NVRAM_V5_SIZE
+#define BCM963XX_NVRAM_V7_SIZE		(3 * SZ_1K)
+
+#define BCM963XX_NVRAM_NR_PARTS		5
+
+struct bcm963xx_nvram {
+	u32	version;
+	char	bootline[256];
+	char	name[16];
+	u32	main_tp_number;
+	u32	psi_size;
+	u32	mac_addr_count;
+	u8	mac_addr_base[ETH_ALEN];
+	u8	__reserved1[2];
+	u32	checksum_v4;
+
+	u8	__reserved2[292];
+	u32	nand_part_offset[BCM963XX_NVRAM_NR_PARTS];
+	u32	nand_part_size[BCM963XX_NVRAM_NR_PARTS];
+	u8	__reserved3[388];
+	union {
+		u32	checksum_v5;
+		u32	checksum_v6;
+	};
+
+	u8	__reserved4[2044];
+	u32	checksum_v7;
+} __packed;
+
+#endif /* _UAPI__LINUX_BCM963XX_NVRAM_H__ */
-- 
2.1.4

-- 
Simon Arlott
