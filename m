Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 17:15:35 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:38209 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903500Ab2IKPP2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2012 17:15:28 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 20E098F62;
        Tue, 11 Sep 2012 17:15:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l4Db6bGKhtG0; Tue, 11 Sep 2012 17:15:17 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id C0F7587B9;
        Tue, 11 Sep 2012 17:15:16 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, john@phrozen.org
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        florian@openwrt.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 0/3] MIPS: BCM47xx: use gpiolib
Date:   Tue, 11 Sep 2012 17:15:07 +0200
Message-Id: <1347376511-20953-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 34469
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The original code implemented the GPIO interface itself and this caused
some problems. With this patch gpiolib is used.

This is based on mips/master.

This should go through linux-mips, John W. Linville approved that 
for the bcma and ssb changes normally maintained in wireless-testing.

v4:
 - remove extra BCMA_DRIVER_GPIO option and inline the spinlocks in
   bcma/driver_chipcommon.c.

v3:
 - add missing break after setting bcm47xx_gpio_count in bcm47xx_gpio_init()

v2:
 - use use gpio_chip.to_irq() instead of directly declare gpio_to_irq

Hauke Mehrtens (3):
  ssb: add function to return number of gpio lines
  bcma: add GPIO driver for SoCs
  MIPS: BCM47xx: rewrite GPIO handling and use gpiolib

 arch/mips/Kconfig                            |    2 +-
 arch/mips/bcm47xx/gpio.c                     |  212 ++++++++++++++++++++------
 arch/mips/bcm47xx/setup.c                    |    2 +
 arch/mips/bcm47xx/wgt634u.c                  |    7 +
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    2 +
 arch/mips/include/asm/mach-bcm47xx/gpio.h    |  148 +++---------------
 drivers/bcma/driver_chipcommon.c             |   61 +++++++-
 drivers/ssb/embedded.c                       |   12 ++
 include/linux/bcma/bcma_driver_chipcommon.h  |   24 ++-
 include/linux/ssb/ssb_embedded.h             |    4 +
 10 files changed, 287 insertions(+), 187 deletions(-)

-- 
1.7.9.5
