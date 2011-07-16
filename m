Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2011 18:56:11 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:50798 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491025Ab1GPQ4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jul 2011 18:56:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id EAF778C65;
        Sat, 16 Jul 2011 18:56:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5QLY0lkwAV2b; Sat, 16 Jul 2011 18:55:59 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-255-051.ewe-ip-backbone.de [91.97.255.51])
        by hauke-m.de (Postfix) with ESMTPSA id 67D2B8C4F;
        Sat, 16 Jul 2011 18:55:58 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        zajec5@gmail.com, linux-mips@linux-mips.org
Cc:     jonas.gorski@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de,
        julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: =?UTF-8?q?=5BPATCH=20v2=2000/11=5D=20bcma=3A=20add=20support=20for=20embedded=20devices=20like=20bcm4716?=
Date:   Sat, 16 Jul 2011 18:55:31 +0200
Message-Id: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11702

This patch series adds support for embedded devices like bcm47xx to 
bcma. Bcma is used on bcm4716 and bcm4718 SoCs as the system bus and
replaced ssb used on older devices. With these patches my bcm4716 
device boots up till it tries to access the flash, because the serial 
flash chip is unsupported for now, this will be my next task. This adds 
support for MIPS cores, interrupt configuration and the serial console.

These patches are not containing all functions needed to get the SoC to 
fully work and support every feature, but it is a good start.
These patches are now integrated in OpenWrt for everyone how wants to
test them.

This was tested with a BCM4704 device (SoC with ssb bus), a BCM4716 
device and a pcie wireless card supported by bcma.


@Rafał: If you are fine with the bcma patches could you please give
your Signed-off on them.

@Ralf: Could you please merger this into the mips tree so that it will be in linux-3.1.

PATCH v2:
 * define inline function bcma_core_mips_init() if mips driver is not build
 * iounmap core->io_wrap and core->io_addr after it was used.
 * update bcma based on new braodcom driver code
   * add workaround for 5357b0
 * move flash informations into own struct and store it in chipcommon.
   When adding serial flash support it will be in chipcommon and then all flash structs should be there.
 * some changes to bcma_chipco_serial_init()
  * some changes are done after looking into a more recent version of broadcom driver.
  * changes suggested by Jonas
  * serial struct is in chipcommon as it is accessed through chipcommon.
  * use bcma_pmu_alp_clock() to get the clock.
 * cpu clock: add detection support for some newer SoCs.

PATCH v1:
 * rebased on mips tree (mips/queue)
 * drop pcie hostmode patch as Rafał sent a better patch to wireless mailing list
 * drop sprom patch because sprom is not supported in bcma version from mips tree,
     I will send a separate patch to wireless mailing list.
 * fix compilation of arch/mips/bcm47xx/wgt634u.c
 * fix texts in arch/mips/bcm47xx/Kconfig
RFC v3:
 * make bcm47xx built either with bcma, ssb or both and use mips MIPS 74K optimizations if possible
 * add block io support
 * some minor fixes for code and doku
RFC v2:
 * use list and no arry to store cores
 * rename bcma_host_bcma_ to bcma_host_soc_
 * use core->io_addr and core->io_wrap to access cores
 * checkpatch fixes
 * some minor fixes

Hauke Mehrtens (11):
  bcma: move parsing of EEPROM into own function.
  bcma: move initializing of struct bcma_bus to own function.
  bcma: add functions to scan cores needed on SoCs
  bcma: add SOC bus
  bcma: add mips driver
  bcma: add serial console support
  bcma: get CPU clock
  bcm47xx: prepare to support different buses
  bcm47xx: make it possible to build bcm47xx without ssb.
  bcm47xx: add support for bcma bus
  bcm47xx: fix irq assignment for new SoCs.

 arch/mips/Kconfig                            |    8 +-
 arch/mips/bcm47xx/Kconfig                    |   31 +++
 arch/mips/bcm47xx/Makefile                   |    3 +-
 arch/mips/bcm47xx/gpio.c                     |   82 +++++--
 arch/mips/bcm47xx/irq.c                      |   12 +
 arch/mips/bcm47xx/nvram.c                    |   29 ++-
 arch/mips/bcm47xx/serial.c                   |   46 ++++-
 arch/mips/bcm47xx/setup.c                    |   90 ++++++-
 arch/mips/bcm47xx/time.c                     |   16 +-
 arch/mips/bcm47xx/wgt634u.c                  |   14 +-
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |   26 ++-
 arch/mips/include/asm/mach-bcm47xx/gpio.h    |  108 +++++++--
 arch/mips/pci/pci-bcm47xx.c                  |    6 +
 drivers/bcma/Kconfig                         |   13 +
 drivers/bcma/Makefile                        |    2 +
 drivers/bcma/bcma_private.h                  |   18 ++
 drivers/bcma/driver_chipcommon.c             |   53 ++++
 drivers/bcma/driver_chipcommon_pmu.c         |  133 ++++++++++
 drivers/bcma/driver_mips.c                   |  256 +++++++++++++++++++
 drivers/bcma/driver_pci.c                    |    3 +
 drivers/bcma/host_soc.c                      |  183 ++++++++++++++
 drivers/bcma/main.c                          |   65 +++++
 drivers/bcma/scan.c                          |  348 ++++++++++++++++++--------
 drivers/watchdog/bcm47xx_wdt.c               |   27 ++-
 include/linux/bcma/bcma.h                    |    8 +
 include/linux/bcma/bcma_driver_chipcommon.h  |   67 +++++
 include/linux/bcma/bcma_driver_mips.h        |   51 ++++
 include/linux/bcma/bcma_soc.h                |   16 ++
 28 files changed, 1535 insertions(+), 179 deletions(-)
 create mode 100644 arch/mips/bcm47xx/Kconfig
 create mode 100644 drivers/bcma/driver_mips.c
 create mode 100644 drivers/bcma/host_soc.c
 create mode 100644 include/linux/bcma/bcma_driver_mips.h
 create mode 100644 include/linux/bcma/bcma_soc.h

-- 
1.7.4.1
