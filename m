Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2012 01:05:31 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:47474 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903616Ab2CMAFX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Mar 2012 01:05:23 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 13FA38F68;
        Tue, 13 Mar 2012 01:05:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l4TC8tuLcxUB; Tue, 13 Mar 2012 01:05:09 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 46EC58F60;
        Tue, 13 Mar 2012 01:05:09 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 0/7] USB: OHCI/EHCI: generic platform driver
Date:   Tue, 13 Mar 2012 01:04:46 +0100
Message-Id: <1331597093-425-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This EHCI/OHCI platform driver should replace the simple EHCI and OHCI 
platform drivers. It was developed to be used for the USB core of the 
Broadcom SoCs supported by ssb and bcma, but it should also work for 
other devices.

Drivers like ehci-ath79.c, ehci-xls.c and ehci-ixp4xx.c should be 
relative easy be ported to this EHCI driver.
And drivers like ohci-ath79.c, ohci-ppc-soc.c, ohci-sh.c and ohci-xls.c 
should be easy be ported to the this OHCI driver.

I am unable to test the suspend and resume part, as my SoC does not 
support this, but most of the platform driver do not support 
suspend/resume too. The code here should work, but was never runtime 
tested.

This also contains patches adding USB support for the SoCs based on ssb 
and bcma and converts the ath79 code to use the generic usb driver.

This patch series is based on the usb tree and should go through it to Linus.

v4:
   * handle error when searching for a bridge on bcma
   * leave old Kconfig options and mark them deprecated and select the
     new driver

v3:
   * add patches for bcma and ssb usb driver again
   * add patch to convert ath79 to use the generic platform driver

v2:
   * split include/linux/usb/hci_driver.h into include/linux
     /usb/ehci_pdriver.h and include/linux/usb/ohci_pdriver.h
   * remove flags from include/linux/usb/{e,o}ehci_pdriver.h
   * add kernel doc
   * add some more options into the structs to activate hardware quirks.

Hauke Mehrtens (7):
  USB: OHCI: Add a generic platform device driver
  USB: EHCI: Add a generic platform device driver
  bcma: scan for extra address space
  USB: Add driver for the bcma bus
  USB: Add driver for the ssb bus
  USB: OHCI: remove old SSB OHCI driver
  USB: use generic platform driver on ath79

 arch/mips/ath79/dev-usb.c        |   31 +++-
 drivers/bcma/scan.c              |   19 ++-
 drivers/usb/host/Kconfig         |   63 +++++++-
 drivers/usb/host/Makefile        |    2 +
 drivers/usb/host/bcma-hcd.c      |  334 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-ath79.c    |  208 ------------------------
 drivers/usb/host/ehci-hcd.c      |   10 +-
 drivers/usb/host/ehci-platform.c |  198 ++++++++++++++++++++++
 drivers/usb/host/ohci-ath79.c    |  151 -----------------
 drivers/usb/host/ohci-hcd.c      |   31 +---
 drivers/usb/host/ohci-platform.c |  194 ++++++++++++++++++++++
 drivers/usb/host/ohci-ssb.c      |  260 -----------------------------
 drivers/usb/host/ssb-hcd.c       |  279 +++++++++++++++++++++++++++++++
 include/linux/bcma/bcma.h        |    1 +
 include/linux/usb/ehci_pdriver.h |   46 ++++++
 include/linux/usb/ohci_pdriver.h |   38 +++++
 16 files changed, 1206 insertions(+), 659 deletions(-)
 create mode 100644 drivers/usb/host/bcma-hcd.c
 delete mode 100644 drivers/usb/host/ehci-ath79.c
 create mode 100644 drivers/usb/host/ehci-platform.c
 delete mode 100644 drivers/usb/host/ohci-ath79.c
 create mode 100644 drivers/usb/host/ohci-platform.c
 delete mode 100644 drivers/usb/host/ohci-ssb.c
 create mode 100644 drivers/usb/host/ssb-hcd.c
 create mode 100644 include/linux/usb/ehci_pdriver.h
 create mode 100644 include/linux/usb/ohci_pdriver.h

-- 
1.7.5.4
