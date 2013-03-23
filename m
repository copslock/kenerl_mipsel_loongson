Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 14:08:52 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:54726 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834828Ab3CWNHz7W68j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 14:07:55 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U2sEngkzpjpS; Sat, 23 Mar 2013 14:07:22 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id AD009280129;
        Sat, 23 Mar 2013 14:07:21 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mtd@lists.infradead.org
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Subject: =?UTF-8?q?=5BPATCH=203/3=5D=20MTD=3A=20bcm63xxpart=3A=20use=20nvram=20for=20PSI=20size?=
Date:   Sat, 23 Mar 2013 14:07:49 +0100
Message-Id: <1364044070-10486-4-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
References: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35948
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

Read out the SPI size from nvram instead of defaulting to 64K - some
vendors actually use values larger than the "max" value of 64.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 drivers/mtd/bcm63xxpart.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index fc3d7d0..5c81390 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -4,7 +4,7 @@
  * Copyright © 2006-2008  Florian Fainelli <florian@openwrt.org>
  *			  Mike Albon <malbon@openwrt.org>
  * Copyright © 2009-2010  Daniel Dickinson <openwrt@cshore.neomailbox.net>
- * Copyright © 2011-2012  Jonas Gorski <jonas.gorski@gmail.com>
+ * Copyright © 2011-2013  Jonas Gorski <jonas.gorski@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -33,6 +33,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
+#include <asm/mach-bcm63xx/bcm63xx_nvram.h>
 #include <asm/mach-bcm63xx/bcm963xx_tag.h>
 #include <asm/mach-bcm63xx/board_bcm963xx.h>
 
@@ -91,7 +92,8 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 			      BCM63XX_CFE_BLOCK_SIZE);
 
 	cfelen = cfe_erasesize;
-	nvramlen = cfe_erasesize;
+	nvramlen = bcm63xx_nvram_get_psi_size() * SZ_1K;
+	nvramlen = roundup(nvramlen, cfe_erasesize);
 
 	/* Allocate memory for buffer */
 	buf = vmalloc(sizeof(struct bcm_tag));
-- 
1.7.10.4
