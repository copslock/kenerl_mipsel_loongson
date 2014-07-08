Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 16:26:42 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:34523 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861327AbaGHO0bzibAZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 16:26:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 3F14828B952;
        Tue,  8 Jul 2014 16:24:27 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D6FC428B44E;
        Tue,  8 Jul 2014 16:24:21 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH] MIPS: BCM63XX: sync mips counters during cpu bringup
Date:   Tue,  8 Jul 2014 16:26:13 +0200
Message-Id: <1404829573-11570-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41074
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

We are using the mips counters as the clock source, so we need to ensure
they are synced, else e.g. gettimeofday will return different values
depending on which core it was run.

Observed difference was about 8 seconds, causing ~8 seconds ping or time
running backwards for some programs.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4e238e6..3f05b56 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -138,6 +138,7 @@ config BCM63XX
 	select BOOT_RAW
 	select CEVT_R4K
 	select CSRC_R4K
+	select SYNC_R4K
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select SYS_SUPPORTS_32BIT_KERNEL
-- 
2.0.0
