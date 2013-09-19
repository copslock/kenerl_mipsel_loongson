Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 23:40:24 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:53583 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832655Ab3ISVkT3Dd8Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Sep 2013 23:40:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 941C1857F;
        Thu, 19 Sep 2013 23:40:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mGNHcgzxz4x2; Thu, 19 Sep 2013 23:40:15 +0200 (CEST)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 755AE8F61;
        Thu, 19 Sep 2013 23:40:15 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] MIPS: BCM47XX: print board name in machine entry in cpuinfo
Date:   Thu, 19 Sep 2013 23:40:10 +0200
Message-Id: <1379626810-30103-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1379626810-30103-1-git-send-email-hauke@hauke-m.de>
References: <1379626810-30103-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This will add the board name to the machine entry in /proc/cpuinfo.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/setup.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index de08ba9..71e5c7c 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -32,6 +32,7 @@
 #include <linux/ssb/ssb_embedded.h>
 #include <linux/bcma/bcma_soc.h>
 #include <asm/bootinfo.h>
+#include <asm/prom.h>
 #include <asm/reboot.h>
 #include <asm/time.h>
 #include <bcm47xx.h>
@@ -225,6 +226,7 @@ void __init plat_mem_setup(void)
 	_machine_halt = bcm47xx_machine_halt;
 	pm_power_off = bcm47xx_machine_halt;
 	bcm47xx_board_detect();
+	mips_set_machine_name(bcm47xx_board_get_name());
 }
 
 static int __init bcm47xx_register_bus_complete(void)
-- 
1.7.10.4
