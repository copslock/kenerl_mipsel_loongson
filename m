Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 10:15:54 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:51146 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903700Ab1KUJOy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 10:14:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id EA5903B1D1B;
        Mon, 21 Nov 2011 10:14:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UE3xgOPfkjxa; Mon, 21 Nov 2011 10:14:53 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 945F43B1AF0;
        Mon, 21 Nov 2011 10:14:53 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/9] MIPS: BCM63XX prepare for SPI support
Date:   Mon, 21 Nov 2011 10:14:12 +0100
Message-Id: <1321866861-14340-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 31842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17032

This patchset adds the required infrastructure to register a Broadcom
BCM63XX SPI controller platform device and driver.

Florian Fainelli (9):
  MIPS: BCM63XX: add IRQ_SPI and CPU specific SPI IRQ values
  MIPS: BCM63XX: define BCM6358 SPI base address
  MIPS: BCM63XX: add BCM6368 SPI clock mask
  MIPS: BCM63XX: define RSET_SPI_SIZE
  MIPS: BCM63XX: remove SPI2 register
  MIPS: BCM63XX: define internal registers offsets of the SPI
    controller
  MIPS: BCM63XX: add stub to register the SPI platform driver
  MIPS: BCM63XX: build SPI driver platform registration stub
  MIPS: BCM63XX: make board setup code register the spi platform device

 arch/mips/bcm63xx/Makefile                         |    3 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    3 +
 arch/mips/bcm63xx/clk.c                            |    6 +-
 arch/mips/bcm63xx/dev-spi.c                        |  117 +++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |   20 ++--
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |   89 +++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |  120 ++++++++++++++++++++
 7 files changed, 345 insertions(+), 13 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-spi.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h

-- 
1.7.5.4
