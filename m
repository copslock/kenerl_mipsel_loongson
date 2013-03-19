Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Mar 2013 15:09:30 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:45655 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834879Ab3CSOJ3jgvJI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Mar 2013 15:09:29 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hi0yAgl8K17n; Tue, 19 Mar 2013 15:08:57 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-009-103.pools.arcor-ip.net [88.73.9.103])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D82B3284479;
        Tue, 19 Mar 2013 15:08:56 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH] MIPS: BCM63XX: make nvram checksum failure non fatal
Date:   Tue, 19 Mar 2013 15:08:27 +0100
Message-Id: <1363702108-1013-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35910
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

Some vendors modify the nvram layout moving the checksum to a different
place or dropping entirely, so reduce the checksum failure to a warning.

Reported-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---

I'm not sure if it should be that "loud" (pr_warn) because users can't
actually do anything to fix it, so maybe pr_debug would be fine, too.

 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    5 +----
 arch/mips/bcm63xx/nvram.c                          |    7 +++----
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h |    4 +---
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index ed1949c..9aa7d44 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -745,10 +745,7 @@ void __init board_prom_init(void)
 		strcpy(cfe_version, "unknown");
 	printk(KERN_INFO PFX "CFE version: %s\n", cfe_version);
 
-	if (bcm63xx_nvram_init(boot_addr + BCM963XX_NVRAM_OFFSET)) {
-		printk(KERN_ERR PFX "invalid nvram checksum\n");
-		return;
-	}
+	bcm63xx_nvram_init(boot_addr + BCM963XX_NVRAM_OFFSET);
 
 	board_name = bcm63xx_nvram_get_name();
 	/* find board by name */
diff --git a/arch/mips/bcm63xx/nvram.c b/arch/mips/bcm63xx/nvram.c
index 6206116..a4b8864 100644
--- a/arch/mips/bcm63xx/nvram.c
+++ b/arch/mips/bcm63xx/nvram.c
@@ -38,7 +38,7 @@ struct bcm963xx_nvram {
 static struct bcm963xx_nvram nvram;
 static int mac_addr_used;
 
-int __init bcm63xx_nvram_init(void *addr)
+void __init bcm63xx_nvram_init(void *addr)
 {
 	unsigned int check_len;
 	u32 crc, expected_crc;
@@ -60,9 +60,8 @@ int __init bcm63xx_nvram_init(void *addr)
 	crc = crc32_le(~0, (u8 *)&nvram, check_len);
 
 	if (crc != expected_crc)
-		return -EINVAL;
-
-	return 0;
+		pr_warn("nvram checksum failed, contents may be invalid (expected %08x, got %08x)\n",
+			expected_crc, crc);
 }
 
 u8 *bcm63xx_nvram_get_name(void)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
index 62d6a3b..4e0b6bc 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
@@ -9,10 +9,8 @@
  *
  * Initialized the local nvram copy from the target address and checks
  * its checksum.
- *
- * Returns 0 on success.
  */
-int __init bcm63xx_nvram_init(void *nvram);
+void bcm63xx_nvram_init(void *nvram);
 
 /**
  * bcm63xx_nvram_get_name() - returns the board name according to nvram
-- 
1.7.10.4
