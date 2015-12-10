Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 00:06:20 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:52027 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008407AbbLJXGRKzVdl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Dec 2015 00:06:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=pF34OjGhm6Yx6KAGKoy2O5o/QR8iRFQCfvD8hyEI/w4=;
        b=CedEpS2vqLc7way5XWiHA8KLl+1GeQY4a29vpUjsbVO8+7aexxrgmE86kbXVxWpfZqfwmABdbGx3uPlFGMOHp0G+oKB6iRuSZoDUWk9DuBKCjXQAfsl+M1Co2lxY35x2Ecc8tBxLOfmvBNy3IgjeIRUhUIFVe48ljZxysqayE62T1JRTkfOnVzieYzhYYzpsoWhtkdr50h7Vqyy0N+N7opTMxIhGyBY1Av8ClMG6urHbnU7qlTOae59Bcs2fqTR4QpnhAg2p+iq1FaUMOtzxuSnK8RnHR8KKaCEViVUzFIzhsnzeIpH3iCOqYydTnrmSMfY31VhfrgGa2QgPH3wFqw==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:60949 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a7AHw-0004O2-1X (Exim); Thu, 10 Dec 2015 23:06:16 +0000
Subject: [PATCH linux-next (v2) 2/3] MIPS: bcm63xx: Use common nvram structure
 definition
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>
References: <566A04FB.7000104@simon.arlott.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Jonas Gorski <jogo@openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-api@vger.kernel.org
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <566A0563.7040209@simon.arlott.org.uk>
Date:   Thu, 10 Dec 2015 23:06:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <566A04FB.7000104@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50536
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

Use an external common definition of the nvram structure.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
Compile tested only (there is no support for brcmnand on mach-bcm63xx).

v2: Use external struct bcm963xx_nvram definition for bcm963268part.

 arch/mips/bcm63xx/nvram.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/mips/bcm63xx/nvram.c b/arch/mips/bcm63xx/nvram.c
index 4b50d40..36e74f9 100644
--- a/arch/mips/bcm63xx/nvram.c
+++ b/arch/mips/bcm63xx/nvram.c
@@ -16,25 +16,9 @@
 #include <linux/kernel.h>
 #include <linux/if_ether.h>
 
+#include <uapi/linux/bcm963xx_nvram.h>
 #include <bcm63xx_nvram.h>
 
-/*
- * nvram structure
- */
-struct bcm963xx_nvram {
-	u32	version;
-	u8	reserved1[256];
-	u8	name[16];
-	u32	main_tp_number;
-	u32	psi_size;
-	u32	mac_addr_count;
-	u8	mac_addr_base[ETH_ALEN];
-	u8	reserved2[2];
-	u32	checksum_old;
-	u8	reserved3[720];
-	u32	checksum_high;
-};
-
 #define BCM63XX_DEFAULT_PSI_SIZE	64
 
 static struct bcm963xx_nvram nvram;
@@ -47,17 +31,17 @@ void __init bcm63xx_nvram_init(void *addr)
 	u8 hcs_mac_addr[ETH_ALEN] = { 0x00, 0x10, 0x18, 0xff, 0xff, 0xff };
 
 	/* extract nvram data */
-	memcpy(&nvram, addr, sizeof(nvram));
+	memcpy(&nvram, addr, BCM963XX_NVRAM_V5_SIZE);
 
 	/* check checksum before using data */
 	if (nvram.version <= 4) {
-		check_len = offsetof(struct bcm963xx_nvram, reserved3);
-		expected_crc = nvram.checksum_old;
-		nvram.checksum_old = 0;
+		check_len = BCM963XX_NVRAM_V4_SIZE;
+		expected_crc = nvram.checksum_v4;
+		nvram.checksum_v4 = 0;
 	} else {
-		check_len = sizeof(nvram);
-		expected_crc = nvram.checksum_high;
-		nvram.checksum_high = 0;
+		check_len = BCM963XX_NVRAM_V5_SIZE;
+		expected_crc = nvram.checksum_v5;
+		nvram.checksum_v5 = 0;
 	}
 
 	crc = crc32_le(~0, (u8 *)&nvram, check_len);
-- 
2.1.4

-- 
Simon Arlott
