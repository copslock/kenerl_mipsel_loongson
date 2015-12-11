Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 22:54:34 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:53990 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013650AbbLKVycD4arc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Dec 2015 22:54:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Cc:To:Subject:From; bh=hfIHqCXWfLh8dxXt6Z7LNAWlDwCBRR3P7wPhyHNYNPs=;
        b=j67B7IAOj0BJV98/v9UQfCGyf8tAFyk9QoxyjrYW7foR/z5CNCitKMjUriumzFddfqCVLD/dk6AsrCSnAum/7Zu3yWvpG5MiMgaD5ZhYTvXBYKYgJ8Ocp+ZFfwpjH+wlCnM2BMIYAS6cAUsdIxHLqKlHN+nXXoOs0uOgAzDofxeiG8nPKEhxfdvdIgfqtheS7rZ5Kkt4vkuwxihISjUAwldRf4WyrlMaH3dQ9bFC4m7GEllFrKEe1CHUYVUs7F/aTCscixOWDdAznB2zAceBPBPiRryY49tGt0ab7SZtk4KyjdbG6y6vMoDGsr2XgOYARmWE+f3esDU5EJSbjvKt5w==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:35156)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a7Vdx-00058O-A7 (Exim); Fri, 11 Dec 2015 21:54:26 +0000
From:   Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH linux-next (v3) 1/3] MIPS: bcm963xx: Add Broadcom BCM963xx
 board nvram data structure
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
Message-ID: <566B460F.1040603@simon.arlott.org.uk>
Date:   Fri, 11 Dec 2015 21:54:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50553
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

Broadcom BCM963xx boards have multiple nvram variants across different
SoCs with additional checksum fields added whenever the size of the
nvram was extended.

Add this structure as a header file so that multiple drivers and userspace
can use it.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v3: Fix includes/type names, add comments explaining the nvram struct.

v2: Use external struct bcm963xx_nvram definition for bcm963268part.

 MAINTAINERS                         |  1 +
 include/uapi/linux/bcm963xx_nvram.h | 53 +++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 include/uapi/linux/bcm963xx_nvram.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b6d4e2e..abf18b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2393,6 +2393,7 @@ F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
 F:	include/linux/bcm63xx_wdt.h
+F:	include/uapi/linux/bcm963xx_nvram.h
 
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Prashant Sreedharan <prashant@broadcom.com>
diff --git a/include/uapi/linux/bcm963xx_nvram.h b/include/uapi/linux/bcm963xx_nvram.h
new file mode 100644
index 0000000..2dcb307
--- /dev/null
+++ b/include/uapi/linux/bcm963xx_nvram.h
@@ -0,0 +1,53 @@
+#ifndef _UAPI__LINUX_BCM963XX_NVRAM_H__
+#define _UAPI__LINUX_BCM963XX_NVRAM_H__
+
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
+/*
+ * Broadcom BCM963xx SoC board nvram data structure.
+ *
+ * The nvram structure varies in size depending on the SoC board version. Use
+ * the appropriate minimum BCM963XX_NVRAM_*_SIZE define for the information
+ * you need instead of sizeof(struct bcm963xx_nvram) as this may change.
+ *
+ * The "version" field value maps directly to the size and checksum names, e.g.
+ * version 4 uses "checksum_v4" and the data is BCM963XX_NVRAM_V4_SIZE bytes.
+ *
+ * Do not use the __reserved fields, especially not as an offset for CRC
+ * calculations (use BCM963XX_NVRAM_*_SIZE instead). These may be removed or
+ * repositioned.
+ */
+
+#define BCM963XX_NVRAM_V4_SIZE		300
+#define BCM963XX_NVRAM_V5_SIZE		1024
+#define BCM963XX_NVRAM_V6_SIZE		BCM963XX_NVRAM_V5_SIZE
+#define BCM963XX_NVRAM_V7_SIZE		3072
+
+#define BCM963XX_NVRAM_NR_PARTS		5
+
+struct bcm963xx_nvram {
+	__u32	version;
+	char	bootline[256];
+	char	name[16];
+	__u32	main_tp_number;
+	__u32	psi_size;
+	__u32	mac_addr_count;
+	__u8	mac_addr_base[ETH_ALEN];
+	__u8	__reserved1[2];
+	__u32	checksum_v4;
+
+	__u8	__reserved2[292];
+	__u32	nand_part_offset[BCM963XX_NVRAM_NR_PARTS];
+	__u32	nand_part_size[BCM963XX_NVRAM_NR_PARTS];
+	__u8	__reserved3[388];
+	union {
+		__u32	checksum_v5;
+		__u32	checksum_v6;
+	};
+
+	__u8	__reserved4[2044];
+	__u32	checksum_v7;
+} __packed;
+
+#endif /* _UAPI__LINUX_BCM963XX_NVRAM_H__ */
-- 
2.1.4

-- 
Simon Arlott
