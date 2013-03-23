Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 14:08:33 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:54719 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834827Ab3CWNHzW-8Jk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 14:07:55 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PgUCCHcEAX6z; Sat, 23 Mar 2013 14:07:21 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id AACDE280129;
        Sat, 23 Mar 2013 14:07:20 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mtd@lists.infradead.org
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH 2/3] MIPS: BCM63XX: export PSI size from nvram
Date:   Sat, 23 Mar 2013 14:07:48 +0100
Message-Id: <1364044070-10486-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
References: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
X-archive-position: 35947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/nvram.c                          |   11 +++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h |    2 ++
 2 files changed, 13 insertions(+)

diff --git a/arch/mips/bcm63xx/nvram.c b/arch/mips/bcm63xx/nvram.c
index 6206116..44af608 100644
--- a/arch/mips/bcm63xx/nvram.c
+++ b/arch/mips/bcm63xx/nvram.c
@@ -35,6 +35,8 @@ struct bcm963xx_nvram {
 	u32	checksum_high;
 };
 
+#define BCM63XX_DEFAULT_PSI_SIZE	64
+
 static struct bcm963xx_nvram nvram;
 static int mac_addr_used;
 
@@ -105,3 +107,12 @@ int bcm63xx_nvram_get_mac_address(u8 *mac)
 	return 0;
 }
 EXPORT_SYMBOL(bcm63xx_nvram_get_mac_address);
+
+int bcm63xx_nvram_get_psi_size(void)
+{
+	if (nvram.psi_size > 0)
+		return nvram.psi_size;
+
+	return BCM63XX_DEFAULT_PSI_SIZE;
+}
+EXPORT_SYMBOL(bcm63xx_nvram_get_psi_size);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
index 62d6a3b..d76a486 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
@@ -32,4 +32,6 @@ u8 *bcm63xx_nvram_get_name(void);
  */
 int bcm63xx_nvram_get_mac_address(u8 *mac);
 
+int bcm63xx_nvram_get_psi_size(void);
+
 #endif /* BCM63XX_NVRAM_H */
-- 
1.7.10.4
