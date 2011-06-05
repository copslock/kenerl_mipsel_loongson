Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 00:08:14 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:60263 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491773Ab1FEWIL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 00:08:11 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 65D618B10;
        Mon,  6 Jun 2011 00:08:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ijg80cnM0mII; Mon,  6 Jun 2011 00:08:04 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-251-075.ewe-ip-backbone.de [91.97.251.75])
        by hauke-m.de (Postfix) with ESMTPSA id 33F428B06;
        Mon,  6 Jun 2011 00:08:04 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org
Cc:     zajec5@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC][PATCH 00/10] bcma: add support for embedded devices like bcm4716
Date:   Mon,  6 Jun 2011 00:07:28 +0200
Message-Id: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
X-archive-position: 30222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3683

This patch series adds support for embedded devices like bcm47xx to 
bcma. Bcma is used on bcm4716 and bcm4718 SoCs. With these patches my 
bcm4716 device boots up till it tries to access the flash, because the 
serial flash chip is unsupported for now, this will be my next task. 
This adds support for MIPS cores, interrupt configuration and the 
serial console.

These patches are based on ssb code, some patches by George Kashperko 
and Bernhard Loos and parts of the source code release by ASUS and 
Netgear for their devices.

This was tested on a Netgear WNDR3400, but did not work fully because 
of serial flash.

This is bases on linux-next next-20110603, to which subsystem 
maintainer should I send these patches later, as it is based on the 
most recent version of bcma and bcm47xx?
I do not have any normal PCIe based wireless device using this bus, so 
I have not tested it with such a device, it will be nice to hear if it 
is still working on them.
The parallel flash should work so it could be that it will boot on an 
Asus rt-n16, I have not tested that.

An Ethernet driver is not included because the Braodcom source code 
available is not licensed under a GPL compatible license and building a 
new driver on that based is not possible.

Hauke Mehrtens (10):
  bcma: Use array to store cores.
  bcma: Make it possible to run bcma_register_cores() later
  bcma: add embedded bus
  bcma: add mips driver
  bcma: add serial support
  bcma: get CPU clock
  bcma: add pci(e) host mode
  bcm47xx: prepare to support different buses
  bcm47xx: add support for bcma bus
  bcm47xx: fix irq assignment for new SoCs.

 arch/mips/Kconfig                            |    4 +
 arch/mips/bcm47xx/gpio.c                     |   63 +++++---
 arch/mips/bcm47xx/irq.c                      |    8 +
 arch/mips/bcm47xx/nvram.c                    |   21 ++-
 arch/mips/bcm47xx/serial.c                   |   37 ++++-
 arch/mips/bcm47xx/setup.c                    |   55 +++++-
 arch/mips/bcm47xx/time.c                     |   12 +-
 arch/mips/bcm47xx/wgt634u.c                  |   13 +-
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |   17 ++-
 arch/mips/include/asm/mach-bcm47xx/gpio.h    |   71 ++++++--
 drivers/bcma/Kconfig                         |   20 ++
 drivers/bcma/Makefile                        |    3 +
 drivers/bcma/bcma_private.h                  |   16 ++
 drivers/bcma/driver_chipcommon.c             |   62 +++++++
 drivers/bcma/driver_chipcommon_pmu.c         |   86 +++++++++
 drivers/bcma/driver_mips.c                   |  248 ++++++++++++++++++++++++++
 drivers/bcma/driver_pci.c                    |   12 ++-
 drivers/bcma/driver_pci_host.c               |   44 +++++
 drivers/bcma/host_embedded.c                 |   93 ++++++++++
 drivers/bcma/main.c                          |  160 +++++++++++++----
 drivers/bcma/scan.c                          |   87 +++++----
 drivers/watchdog/bcm47xx_wdt.c               |   18 ++-
 include/linux/bcma/bcma.h                    |   24 ++-
 include/linux/bcma/bcma_driver_chipcommon.h  |   35 ++++
 include/linux/bcma/bcma_driver_mips.h        |   52 ++++++
 include/linux/bcma/bcma_driver_pci.h         |    1 +
 include/linux/bcma/bcma_embedded.h           |    8 +
 27 files changed, 1132 insertions(+), 138 deletions(-)
 create mode 100644 drivers/bcma/driver_mips.c
 create mode 100644 drivers/bcma/driver_pci_host.c
 create mode 100644 drivers/bcma/host_embedded.c
 create mode 100644 include/linux/bcma/bcma_driver_mips.h
 create mode 100644 include/linux/bcma/bcma_embedded.h

-- 
1.7.4.1
