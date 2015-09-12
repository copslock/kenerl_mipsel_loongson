Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 18:07:51 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:52873 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008088AbbILQHucOazq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 18:07:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 7497428C127;
        Sat, 12 Sep 2015 18:06:28 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-016-160.088.073.pools.vodafone-ip.de [88.73.16.160])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 4510428C088;
        Sat, 12 Sep 2015 18:06:16 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, florian@openwrt.org
Subject: [PATCH V2 0/6] spi/bcm63xx: cleanup and decouple from arch code
Date:   Sat, 12 Sep 2015 18:06:57 +0200
Message-Id: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49165
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

This patchset decouples spi-bcm63xx from any arch code to allow building
it for more than MIPS/BCM63XX as well as allow compile testing it on any
arch/platform.

Since the main target of this patch is the spi driver, it should
probably go through the spi tree.

Changes v1 -> v2:

* Use device name instead of register size for identifying core
  version.
* Since we now touch arch/mips, drop the rest as well.
* Fix big endian detection.
* Reorder the patches so the move of the register definitions is the
  last step.

Jonas Gorski (6):
  spi/bcm63xx: remove unused rx_tail variable
  spi/bcm63xx: always use a fixed number of CS
  spi/bcm63xx: hardcode busnum to 0
  spi/bcm63xx: replace custom io accessors with standard ones
  spi/bcm63xx: move message control word description to register offsets
  spi/bcm63xx: move register definitions into the driver

 arch/mips/bcm63xx/dev-spi.c                        |  42 +----
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |  44 -----
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-bcm63xx.c                          | 210 ++++++++++++++++++---
 4 files changed, 188 insertions(+), 110 deletions(-)

-- 
2.1.4
