Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 19:12:02 +0100 (CET)
Received: from smtp4-g21.free.fr ([212.27.42.4]:51758 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904133Ab1KDSLz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 19:11:55 +0100
Received: from sakura.staff.proxad.net (unknown [213.36.7.13])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 27E9F4C82E0;
        Fri,  4 Nov 2011 19:11:49 +0100 (CET)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id C4739557C0B; Fri,  4 Nov 2011 19:11:48 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org
Subject: [PATCH v2 00/11] MIPS: BCM63XX: add support for Broadcom 6368 CPU.
Date:   Fri,  4 Nov 2011 19:09:24 +0100
Message-Id: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
To:     ralf@linux-mips.org
X-archive-position: 31390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3866


New in v2:

Addressed all Jonas comments but the SPI register set. Since Florian
and you have upcoming SPI drivers to submit, I'll let you decide which
block deserves its own register set.

External IRQ support has been changed slightly to handle more than 4
irq, it now uses a fixed number range above 100. It has been tested on
6348/58/68.

To make it easier to test, a complete patchset with USB/ethernet/board
support is here http://88.191.35.171/pub/bcm_6368_patches/

I will post remaining patches once this serie has been merged.


v1:

These patches add support for 6368 CPU to the existing bcm63xx code.

Basic CPU support for now, ethernet and board support will come soon.



Maxime Bizon (11):
  MIPS: BCM63XX: set default pci cache line size.
  MIPS: BCM63XX: hook up plat_ioremap to intercept soc registers
    remapping.
  MIPS: BCM63XX: call board_register_device from device_initcall()
  MIPS: BCM63XX: introduce bcm_readll & bcm_writell.
  MIPS: BCM63XX: cleanup cpu registers.
  MIPS: BCM63XX: add more register sets & missing register definitions.
  MIPS: BCM63XX: change irq code to prepare for per-cpu peculiarity.
  MIPS: BCM63XX: prepare irq code to handle different external irq
    hardware implementation.
  MIPS: BCM63XX: handle 64 bits irq stat register in irq code.
  MIPS: BCM63XX: add external irq support for non 6348 CPUs.
  MIPS: BCM63XX: add support for bcm6368 CPU.

 arch/mips/bcm63xx/Kconfig                         |    4 +
 arch/mips/bcm63xx/clk.c                           |   70 +++-
 arch/mips/bcm63xx/cpu.c                           |  255 +++------
 arch/mips/bcm63xx/dev-uart.c                      |    2 +-
 arch/mips/bcm63xx/irq.c                           |  403 ++++++++++++---
 arch/mips/bcm63xx/prom.c                          |    7 +-
 arch/mips/bcm63xx/setup.c                         |   32 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |  595 +++++++++++++--------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h   |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_irq.h  |   12 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |  228 ++++++++-
 arch/mips/include/asm/mach-bcm63xx/ioremap.h      |   42 ++
 arch/mips/include/asm/mach-bcm63xx/irq.h          |    8 +
 arch/mips/pci/pci-bcm63xx.c                       |    6 +-
 15 files changed, 1182 insertions(+), 486 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/ioremap.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/irq.h
