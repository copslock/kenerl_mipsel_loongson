Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Nov 2013 12:45:41 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35083 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825471Ab3K3LpiQ7Z7B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Nov 2013 12:45:38 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 4D6492803CD;
        Sat, 30 Nov 2013 12:43:35 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 4844C280153;
        Sat, 30 Nov 2013 12:43:34 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org, linux-spi@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 0/5] add support for bcm63xx HSSPI controller
Date:   Sat, 30 Nov 2013 12:42:01 +0100
Message-Id: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.4.rc3
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38614
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

This patch set adds support for the high speed SPI controller found in
newer BCM63XX SoCs.

Patches 1 to 4 add the required platform data to bcm63xx, while Patch 5
adds the actual driver.

Since all the driver needs are the register block offset, an interrupt 
and a clock with a rate, it does not need any extra platform data.
Therefore there is no compile time dependency, and patches 1 to 4, and
patch 5 can go through different trees (these patches are based on
spi/for-next).

While the controller itself has the same limitations as the old SPI
controller, that is automatic deactivation of the CS line after flushing
its hardware buffer.
But in contrast to the old one it supports CS polarity configuration,
which allows us to work around it and manually control the CS lines.
In addition to that it also supports dual mode (both read and write) and
3-wire, but both of them are not supported by the driver yet.

This driver was run tested on BCM63281, BCM63283 and BCM6361, and build
tested for x86 to ensure COMPILE_TEST works.

Jonas Gorski (5):
  MIPS: BCM63XX: expose the HSSPI clock
  MIPS: BCM63XX: setup the HSSPI clock rate
  MIPS: BCM63XX: add HSSPI IRQ and register offsets
  MIPS: BCM63XX: add HSSPI platform device and register it
  spi: add bcm63xx HSSPI driver

 arch/mips/bcm63xx/Makefile                         |   4 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |   3 +
 arch/mips/bcm63xx/clk.c                            |  42 ++
 arch/mips/bcm63xx/dev-hsspi.c                      |  47 ++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |  18 +
 .../include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h   |   8 +
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-bcm63xx-hsspi.c                    | 484 +++++++++++++++++++++
 9 files changed, 612 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-hsspi.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h
 create mode 100644 drivers/spi/spi-bcm63xx-hsspi.c

-- 
1.8.4.rc3
