Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:50:17 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35419 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013502AbbLMWuQcIVy9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:50:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=oVV8J2eo2lJLE8Tpnu+RH680DLQ8+HmFbIAS9mDmzRs=;
        b=mR5EyykL/G35JfJjvRLBfH7Y3KXbQd48Y1vET9fUc3VNBnmcoXocMWyP4yFRoibXjp4xIfBvdRrwFPDxylN6Lm5f3dG7bFK/U9sWXHLIUJPkwlQYonXkngK72RNO17JDcKmA6LwWb6/6BnruAXM2ZDKlKGswgCKnZf/4SyLTfBdrkf2FGu5DD/+0IJluauBKyz+HYYAiVc0OxUIdmmFSnrlXtv5XAaSS6HWvzTG/fH1HQADmpzBtfBDyrTVtVACsA8wyIkCtPQU2HLuJOanJrg4GEfcdeJ1SkMo/Nehe0Irmec4hM3BTPIoE4yW0HqGgN2Ft0wIpZzLnh6xOn2AFAA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44501 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FT5-00043s-2i (Exim); Sun, 13 Dec 2015 22:50:15 +0000
Subject: [PATCH linux-next v4 07/11] MIPS: bcm63xx: nvram: Remove unused
 bcm63xx_nvram_get_psi_size() function
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
Message-ID: <566DF625.3060801@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:50:13 +0000
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
X-archive-position: 50579
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

Remove bcm63xx_nvram_get_psi_size() as it now has no users.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v4: New patch.

 arch/mips/bcm63xx/nvram.c                          | 11 -----------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h |  2 --
 2 files changed, 13 deletions(-)

diff --git a/arch/mips/bcm63xx/nvram.c b/arch/mips/bcm63xx/nvram.c
index 05757ae..5f2bc1e 100644
--- a/arch/mips/bcm63xx/nvram.c
+++ b/arch/mips/bcm63xx/nvram.c
@@ -19,8 +19,6 @@
 
 #include <bcm63xx_nvram.h>
 
-#define BCM63XX_DEFAULT_PSI_SIZE	64
-
 static struct bcm963xx_nvram nvram;
 static int mac_addr_used;
 
@@ -87,12 +85,3 @@ int bcm63xx_nvram_get_mac_address(u8 *mac)
 	return 0;
 }
 EXPORT_SYMBOL(bcm63xx_nvram_get_mac_address);
-
-int bcm63xx_nvram_get_psi_size(void)
-{
-	if (nvram.psi_size > 0)
-		return nvram.psi_size;
-
-	return BCM63XX_DEFAULT_PSI_SIZE;
-}
-EXPORT_SYMBOL(bcm63xx_nvram_get_psi_size);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
index 348df49..4e0b6bc 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
@@ -30,6 +30,4 @@ u8 *bcm63xx_nvram_get_name(void);
  */
 int bcm63xx_nvram_get_mac_address(u8 *mac);
 
-int bcm63xx_nvram_get_psi_size(void);
-
 #endif /* BCM63XX_NVRAM_H */
-- 
2.1.4

-- 
Simon Arlott
