Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 14:08:12 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:54708 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831903Ab3CWNHyg4rex (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 14:07:54 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id POFOqvqglkm5; Sat, 23 Mar 2013 14:07:20 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9AB6D280129;
        Sat, 23 Mar 2013 14:07:19 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mtd@lists.infradead.org
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH 1/3] MTD: bcm63xxpart: use size macro for CFE block size
Date:   Sat, 23 Mar 2013 14:07:47 +0100
Message-Id: <1364044070-10486-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
References: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
X-archive-position: 35946
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
 drivers/mtd/bcm63xxpart.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index 6eeb84c..fc3d7d0 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -27,6 +27,7 @@
 #include <linux/crc32.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mtd/mtd.h>
@@ -37,7 +38,7 @@
 
 #define BCM63XX_EXTENDED_SIZE	0xBFC00000	/* Extended flash address */
 
-#define BCM63XX_CFE_BLOCK_SIZE	0x10000		/* always at least 64KiB */
+#define BCM63XX_CFE_BLOCK_SIZE	SZ_64K		/* always at least 64KiB */
 
 #define BCM63XX_CFE_MAGIC_OFFSET 0x4e0
 
-- 
1.7.10.4
