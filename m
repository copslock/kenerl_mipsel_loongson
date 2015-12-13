Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:46:19 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35267 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008764AbbLMWqSfOpK9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:46:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=yaXBPGz02rz+lnhjt/Q6LDJwDOAVoYK9eql58J/hJj8=;
        b=YMVT4hOF19WCPRe9bixihJjIoj9fIWyCQj1+Ip6Nh80OdsVRQV1O7/3I3qgB7dhoCLag7ad6oN18rpswzN8cSG9IbynJf2p8xeu8HmnVqsd/q73KwBGNZLGrrst+tzNDk2A5HpAKjjApRx8tbNP72qhqV0Eq/EEfcfvnhrRspjpED2i0WJ2kfP/aB0BpRXSnGnq2/bKAgX+xUI+d8iTfraoXAVj2chq7iyGCiIsmWKpd5L2VIv22A2439XJZCd6AFitR1pH1UEGVBOixP+O7VZINXpZPq9bibDf30huBXrxXPYOHM2v3or7Y7EGYQ+WdcBzPAWiR0ROSgUPFH/J5nA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44494 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FPF-0003qA-3C (Exim); Sun, 13 Dec 2015 22:46:18 +0000
Subject: [PATCH linux-next v4 02/11] MIPS: bcm63xx: nvram: Use nvram structure
 definition from header file
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>
References: <566DF43B.5010400@simon.arlott.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <566DF537.4080602@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:46:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <566DF43B.5010400@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50574
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

Use the common definition of the nvram structure from the header file
include/linux/bcm963xx_nvram.h instead of maintaining a separate copy.

Read the version 5 size of nvram data from memory and then call the
new checksum verification function from the header file.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v4: Use checksum verification function from header file.

v3: No changes (reworded commit message).

v2: Use external struct bcm963xx_nvram definition for bcm963268part.

 arch/mips/bcm63xx/nvram.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/mips/bcm63xx/nvram.c b/arch/mips/bcm63xx/nvram.c
index 4b50d40..05757ae 100644
--- a/arch/mips/bcm63xx/nvram.c
+++ b/arch/mips/bcm63xx/nvram.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "bcm63xx_nvram: " fmt
 
+#include <linux/bcm963xx_nvram.h>
 #include <linux/init.h>
 #include <linux/crc32.h>
 #include <linux/export.h>
@@ -18,23 +19,6 @@
 
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
@@ -42,27 +26,14 @@ static int mac_addr_used;
 
 void __init bcm63xx_nvram_init(void *addr)
 {
-	unsigned int check_len;
 	u32 crc, expected_crc;
 	u8 hcs_mac_addr[ETH_ALEN] = { 0x00, 0x10, 0x18, 0xff, 0xff, 0xff };
 
 	/* extract nvram data */
-	memcpy(&nvram, addr, sizeof(nvram));
+	memcpy(&nvram, addr, BCM963XX_NVRAM_V5_SIZE);
 
 	/* check checksum before using data */
-	if (nvram.version <= 4) {
-		check_len = offsetof(struct bcm963xx_nvram, reserved3);
-		expected_crc = nvram.checksum_old;
-		nvram.checksum_old = 0;
-	} else {
-		check_len = sizeof(nvram);
-		expected_crc = nvram.checksum_high;
-		nvram.checksum_high = 0;
-	}
-
-	crc = crc32_le(~0, (u8 *)&nvram, check_len);
-
-	if (crc != expected_crc)
+	if (bcm963xx_nvram_checksum(&nvram, &expected_crc, &crc))
 		pr_warn("nvram checksum failed, contents may be invalid (expected %08x, got %08x)\n",
 			expected_crc, crc);
 
-- 
2.1.4

-- 
Simon Arlott
