Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 16:02:04 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:36823 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823083Ab3CUPCDEQRD2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Mar 2013 16:02:03 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zdQxTusy2JiL; Thu, 21 Mar 2013 16:01:29 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 044B3283F12;
        Thu, 21 Mar 2013 16:01:28 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 0/7] add basic support for BCM6362
Date:   Thu, 21 Mar 2013 16:00:00 +0100
Message-Id: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35928
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

This patchset adds basic support for BCM6362. BCM6362 includes a 9 port
ethernet switch (4 FE PHYs, 2 RGMII ports), integrated wifi and one PCIe
port.

The first few patches do a bit of clean up first to allow the BCM6362
support code to be as small as possible.

Board definitions were left out as they are not really usable yet, and
adding DT support is planned in the future. Most code added here will
be also required with DT support.

Jonas Gorski (7):
  MIPS: BCM63XX: remove duplicate spi register definitions
  MIPS: BCM63XX: fix revision ID width
  MIPS: BCM63XX: rework chip detection
  MIPS: BCM63XX: add basic BCM6362 support
  MIPS: BCM63XX: enable SPI controller for BCM6362
  MIPS: BCM63XX: enable pcie for BCM6362
  MIPS: BCM63XX: add flash detection for BCM6362

 arch/mips/bcm63xx/Kconfig                          |    4 +
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    6 +-
 arch/mips/bcm63xx/clk.c                            |    2 +
 arch/mips/bcm63xx/cpu.c                            |  142 +++++++++++++-------
 arch/mips/bcm63xx/dev-flash.c                      |    6 +
 arch/mips/bcm63xx/dev-spi.c                        |   26 +---
 arch/mips/bcm63xx/irq.c                            |   22 +++
 arch/mips/bcm63xx/prom.c                           |    2 +
 arch/mips/bcm63xx/reset.c                          |   28 ++++
 arch/mips/bcm63xx/setup.c                          |    5 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |  141 ++++++++++++++++++-
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |   11 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h  |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |  105 +++++++++------
 arch/mips/include/asm/mach-bcm63xx/ioremap.h       |    1 +
 arch/mips/pci/pci-bcm63xx.c                        |   11 +-
 16 files changed, 392 insertions(+), 122 deletions(-)

-- 
1.7.10.4
