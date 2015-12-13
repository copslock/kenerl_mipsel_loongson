Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:48:00 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35360 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008361AbbLMWr6nc8p9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:47:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=jdYlfGZQZaqPl9oHFsFLKue0e3ow6t1FRpxm9ckqxNU=;
        b=scaqjWl03oaaBh28jyPTzU84BerAvoY7/H0AK5ir67pXd/fhbHp6Tk0UO24jqP4LP2tDSqveamywKwGu3US07RvF9mxia4f8fBH8O9UHwDQf/IhNpbNFKhrhLZjdxknp5Na8A7W32XH5lpIJQUdA0mACqGsLrBTRkBCNN1Xe6WyPspp5P+zn25L9yorxuCwOebZyVRTCrUz/J5ruRF66tNZZJ48TcXbf4I0226V09ahazFv8PL61gmaJFj8XwkApsd8Oe0w1dCWpCVkUi6H+esd5rfu0K2F/S5geAJuOgks1nTe39DwQRW/CFsqaat5h3YvPdJdg47/FAbS5t/QRzA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44498 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FQr-0003vE-5Q (Exim); Sun, 13 Dec 2015 22:47:58 +0000
Subject: [PATCH linux-next v4 04/11] MIPS: bcm963xx: Move extended flash
 address to bcm_tag header file
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
Message-ID: <566DF59B.8000804@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:47:55 +0000
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
X-archive-position: 50576
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

The extended flash address needs to be subtracted from bcm_tag flash
image offsets. Move this value to the bcm_tag header file.

Renamed define name to consistently use bcm963xx for flash layout
which should be considered a property of the board and not the SoC
(i.e. bcm63xx could theoretically be used on a board without CFE
or any flash).

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v4: New patch.

 drivers/mtd/bcm63xxpart.c    | 6 ++----
 include/linux/bcm963xx_tag.h | 5 +++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index b5bad1f..cec3188 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -37,8 +37,6 @@
 #include <asm/mach-bcm63xx/bcm63xx_nvram.h>
 #include <asm/mach-bcm63xx/board_bcm963xx.h>
 
-#define BCM63XX_EXTENDED_SIZE	0xBFC00000	/* Extended flash address */
-
 #define BCM63XX_CFE_BLOCK_SIZE	SZ_64K		/* always at least 64KiB */
 
 #define BCM63XX_CFE_MAGIC_OFFSET 0x4e0
@@ -123,8 +121,8 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 		pr_info("CFE boot tag found with version %s and board type %s\n",
 			tagversion, boardid);
 
-		kerneladdr = kerneladdr - BCM63XX_EXTENDED_SIZE;
-		rootfsaddr = rootfsaddr - BCM63XX_EXTENDED_SIZE;
+		kerneladdr = kerneladdr - BCM963XX_EXTENDED_SIZE;
+		rootfsaddr = rootfsaddr - BCM963XX_EXTENDED_SIZE;
 		spareaddr = roundup(totallen, master->erasesize) + cfelen;
 
 		if (rootfsaddr < kerneladdr) {
diff --git a/include/linux/bcm963xx_tag.h b/include/linux/bcm963xx_tag.h
index f389dac..08e0133 100644
--- a/include/linux/bcm963xx_tag.h
+++ b/include/linux/bcm963xx_tag.h
@@ -28,6 +28,11 @@
 	"DWV-S0", \
 }
 
+/* Extended flash address, needs to be subtracted
+ * from bcm_tag flash image offsets.
+ */
+#define BCM963XX_EXTENDED_SIZE	0xBFC00000
+
 /*
  * The broadcom firmware assumes the rootfs starts the image,
  * therefore uses the rootfs start (flash_image_address)
-- 
2.1.4

-- 
Simon Arlott
