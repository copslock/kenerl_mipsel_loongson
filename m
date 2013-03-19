Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Mar 2013 15:20:09 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:47927 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834882Ab3CSOUFJwNn8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Mar 2013 15:20:05 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6p5yhrkI7qbj; Tue, 19 Mar 2013 15:19:33 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-009-103.pools.arcor-ip.net [88.73.9.103])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 497E528043A;
        Tue, 19 Mar 2013 15:19:33 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH] Revert "MIPS: BCM63XX: Call board_register_device from device_initcall()"
Date:   Tue, 19 Mar 2013 15:20:19 +0100
Message-Id: <1363702819-1238-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35911
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

This commit causes a race between PCI scan and SSB fallback SPROM handler
registration, causing the wifi to not work on slower systems. The only
subsystem touched from board_register_devices is platform device
registration, which is safe as an arch init call.

This reverts commit d64ed7ada2f689d2c62af1892ca55e47d3653e36.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---

This patch is in OpenWrt since ages, and we never encountered any issues
from this revert.

 arch/mips/bcm63xx/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 314231b..35e18e9 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -157,4 +157,4 @@ int __init bcm63xx_register_devices(void)
 	return board_register_devices();
 }
 
-device_initcall(bcm63xx_register_devices);
+arch_initcall(bcm63xx_register_devices);
-- 
1.7.10.4
