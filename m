Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:27:47 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35865 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491146Ab1FTT1L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:11 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 86A8514020D;
        Mon, 20 Jun 2011 21:27:06 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 148B1140209;
        Mon, 20 Jun 2011 21:27:06 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 00/13] MIPS: ath79: add initial support for AR933X SoCs
Date:   Mon, 20 Jun 2011 21:26:00 +0200
Message-Id: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-VBMS: A1316539F9E | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16491

This patch set adds initial support for the Atheros AR933X SoCs.

The patch set depends on the following unmerged patches:
MIPS: ath79: modify number of available IRQs
MIPS: ath79: handle more MISC IRQs
MIPS: ath79: add common USB Host Controller device

Gabor Juhos (13):
  MIPS: ath79: remove superfluous parentheses
  MIPS: ath79: add revision id for the AR933X SoCs
  MIPS: ath79: add early printk support for the AR933X SoCs
  MIPS: ath79: add AR933X specific clock init
  MIPS: ath79: add AR933X specific glue for
    ath79_device_reset_{set,clear}
  MIPS: ath79: add AR933X specific IRQ initialization
  MIPS: ath79: add AR933X specific GPIO initialization
  MIPS: ath79: add config symbol for the AR933X SoCs
  USB: ehci-ath79: add device_id entry for the AR933X SoCs
  MIPS: ath79: add AR933X specific USB platform device registration
  serial: add driver for the built-in UART of the AR933X SoC
  MIPS: ath79: register UART device for the AR933X SoCs
  MIPS: ath79: add initial support for the Atheros AP121 reference
    board

 arch/mips/ath79/Kconfig                            |   15 +
 arch/mips/ath79/Makefile                           |    1 +
 arch/mips/ath79/clock.c                            |   55 ++
 arch/mips/ath79/common.c                           |    4 +
 arch/mips/ath79/dev-common.c                       |   38 +-
 arch/mips/ath79/dev-usb.c                          |   19 +
 arch/mips/ath79/early_printk.c                     |   76 ++-
 arch/mips/ath79/gpio.c                             |    2 +
 arch/mips/ath79/irq.c                              |    5 +-
 arch/mips/ath79/mach-ap121.c                       |   88 +++
 arch/mips/ath79/machtypes.h                        |    1 +
 arch/mips/ath79/setup.c                            |   18 +-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |   43 ++
 arch/mips/include/asm/mach-ath79/ar933x_uart.h     |   67 ++
 .../include/asm/mach-ath79/ar933x_uart_platform.h  |   18 +
 arch/mips/include/asm/mach-ath79/ath79.h           |   10 +-
 drivers/tty/serial/Kconfig                         |   23 +
 drivers/tty/serial/Makefile                        |    2 +
 drivers/tty/serial/ar933x_uart.c                   |  688 ++++++++++++++++++++
 drivers/usb/host/Kconfig                           |    2 +-
 drivers/usb/host/ehci-ath79.c                      |    4 +
 include/linux/serial_core.h                        |    4 +
 22 files changed, 1166 insertions(+), 17 deletions(-)
 create mode 100644 arch/mips/ath79/mach-ap121.c
 create mode 100644 arch/mips/include/asm/mach-ath79/ar933x_uart.h
 create mode 100644 arch/mips/include/asm/mach-ath79/ar933x_uart_platform.h
 create mode 100644 drivers/tty/serial/ar933x_uart.c

-- 
1.7.2.1
