Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:11:17 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59597 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904018Ab2AaOLK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:11:10 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id A14BE3585DD;
        Tue, 31 Jan 2012 15:11:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oS4r-UVMSRiT; Tue, 31 Jan 2012 15:11:10 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id EFA19358975;
        Tue, 31 Jan 2012 15:11:09 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, grant.likely@secretlab.ca,
        spi-devel-general@lists.sourceforge.net,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/9 v3] MIPS: BCM63XX: add support for SPI
Date:   Tue, 31 Jan 2012 15:10:39 +0100
Message-Id: <1328019048-5892-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 32348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch set depend on the serie "MIPS: BCM63XX: misc cleanup" and
adds support for the SPI controller found in BCM63xx SoCs.

Grant, it probably makes sense to get this merged via the MIPS tree
since it mostly depends on it.

Florian Fainelli (9):
  MIPS: BCM63XX: add IRQ_SPI and CPU specific SPI IRQ values
  MIPS: BCM63XX: define BCM6358 SPI base address
  MIPS: BCM63XX: add BCM6368 SPI clock mask
  MIPS: BCM63XX: define SPI register sizes.
  MIPS: BCM63XX: remove SPI2 register
  MIPS: BCM63XX: define internal registers offsets of the SPI
    controller
  MIPS: BCM63XX: add stub to register the SPI platform driver
  MIPS: BCM63XX: make board setup code register the spi platform device
  spi: add Broadcom BCM63xx SPI controller driver

 arch/mips/bcm63xx/Makefile                         |    3 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    3 +
 arch/mips/bcm63xx/clk.c                            |    6 +-
 arch/mips/bcm63xx/dev-spi.c                        |  119 +++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |   23 +-
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |   89 ++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |  119 +++++
 drivers/spi/Kconfig                                |    6 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-bcm63xx.c                          |  486 ++++++++++++++++++++
 10 files changed, 842 insertions(+), 13 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-spi.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
 create mode 100644 drivers/spi/spi-bcm63xx.c

-- 
1.7.5.4
