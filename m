Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:09:47 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33157 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816743Ab3A1TJ0gYrIc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id C3A10BF519E;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6ru70MNUaM17; Mon, 28 Jan 2013 20:09:25 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 35893BF5166;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 00/13] MIPS: BCM63XX: support for OHCI and EHCI integrated controllers
Date:   Mon, 28 Jan 2013 20:06:18 +0100
Message-Id: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Hi all,

This patch series adds support for the Broadcom BCM63xx OHCI and EHCI
integrated controllers. Thanks to the latest developments of the OHCI and
EHCI platform drivers we no longer need a dedicated ohci or ehci driver
stub and can use the generic platform drivers instead.

This serie was initially posted by Maxime Bizon:
http://marc.info/?l=linux-mips&m=126487413022204&w=2
http://marc.info/?l=linux-mips&m=126487415322241&w=2

I would like this serie to go via the MIPS tree to avoid merge conflicts
as it touches code in both arch/mips/ and drivers/usb/.

Patches 11 and 12 have been volontarily splitted so they do not block the
merging of the 10 first patches.

Thanks!

Florian Fainelli (13):
  MIPS: BCM63XX: add USB host clock enable delay
  MIPS: BCM63XX: add USB device clock enable delay to clock code
  MIPS: BCM63XX: move code touching the USB private register
  MIPS: BCM63XX: add OHCI/EHCI configuration bits to common USB code
  MIPS: BCM63XX: introduce BCM63XX_OHCI configuration symbol
  MIPS: BCM63XX: add support for the on-chip OHCI controller
  MIPS: BCM63XX: register OHCI controller if board enables it
  MIPS: BCM63XX: introduce BCM63XX_EHCI configuration symbol
  MIPS: BCM63XX: add support for the on-chip EHCI controller
  MIPS: BCM63XX: register EHCI controller if board enables it
  USB: EHCI: add ignore_oc flag to disable overcurrent checking
  MIPS: BCM63XX: EHCI controller does not support overcurrent
  MIPS: BCM63XX: update defconfig

 arch/mips/bcm63xx/Kconfig                          |   24 +++-
 arch/mips/bcm63xx/Makefile                         |    2 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    8 ++
 arch/mips/bcm63xx/clk.c                            |   10 ++
 arch/mips/bcm63xx/dev-usb-ehci.c                   |   93 ++++++++++++
 arch/mips/bcm63xx/dev-usb-ohci.c                   |   94 ++++++++++++
 arch/mips/bcm63xx/usb-common.c                     |  150 ++++++++++++++++++++
 arch/mips/configs/bcm63xx_defconfig                |   22 ++-
 .../asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h        |    6 +
 .../asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h        |    6 +
 .../include/asm/mach-bcm63xx/bcm63xx_usb_priv.h    |   11 ++
 drivers/usb/gadget/bcm63xx_udc.c                   |   28 +---
 drivers/usb/host/Kconfig                           |    5 +-
 drivers/usb/host/ehci-hcd.c                        |    2 +-
 drivers/usb/host/ehci-hub.c                        |    4 +-
 drivers/usb/host/ehci.h                            |    1 +
 include/linux/usb/ehci_pdriver.h                   |    1 +
 17 files changed, 419 insertions(+), 48 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-usb-ehci.c
 create mode 100644 arch/mips/bcm63xx/dev-usb-ohci.c
 create mode 100644 arch/mips/bcm63xx/usb-common.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_usb_priv.h

-- 
1.7.10.4
