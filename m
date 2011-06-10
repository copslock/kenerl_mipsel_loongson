Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 23:48:08 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:52589 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491133Ab1FJVrj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 23:47:39 +0200
Received: from bobafett.staff.proxad.net (unknown [213.228.1.121])
        by smtp4-g21.free.fr (Postfix) with ESMTP id E7D4F4C8137;
        Fri, 10 Jun 2011 23:47:34 +0200 (CEST)
Received: from sakura.staff.proxad.net (unknown [172.18.3.156])
        by bobafett.staff.proxad.net (Postfix) with ESMTP id 8FC5F180651;
        Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 5356B55B08D; Fri, 10 Jun 2011 23:47:30 +0200 (CEST)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, florian@openwrt.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 00/11] MIPS: BCM63XX: add support for Broadcom 6368 CPU.
Date:   Fri, 10 Jun 2011 23:47:10 +0200
Message-Id: <1307742441-28284-1-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.7.1.1
X-archive-position: 30326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9570

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
 arch/mips/bcm63xx/cpu.c                           |  221 +++------
 arch/mips/bcm63xx/dev-uart.c                      |    2 +-
 arch/mips/bcm63xx/irq.c                           |  321 ++++++++++--
 arch/mips/bcm63xx/prom.c                          |    7 +-
 arch/mips/bcm63xx/setup.c                         |    2 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |  593 +++++++++++++--------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h   |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |  213 +++++++-
 arch/mips/include/asm/mach-bcm63xx/ioremap.h      |   42 ++
 arch/mips/pci/pci-bcm63xx.c                       |    6 +-
 13 files changed, 1065 insertions(+), 420 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/ioremap.h
