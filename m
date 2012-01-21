Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2012 23:19:54 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45775 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1901168Ab2AUWTr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2012 23:19:47 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6303D8F68;
        Sat, 21 Jan 2012 23:19:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZvJH45zIil6o; Sat, 21 Jan 2012 23:19:43 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id B00B68F60;
        Sat, 21 Jan 2012 23:19:42 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        zajec5@gmail.com, linux-wireless@vger.kernel.org, m@bues.ch,
        george@znau.edu.ua, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/7] EHCI and OHCI for bcma and ssb
Date:   Sat, 21 Jan 2012 23:19:20 +0100
Message-Id: <1327184367-8824-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 32300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch series adds an EHCI and an OHCI driver for bcma and ssb 
based SoCs. These SoCs provide one device with two address spaces one 
for the OHCI and one for the EHCI part. The USB controllers are using 
the same interface as an PCI controller. This patch series is based on 
the mips Linux tree. It was in OpenWrt for some time and it was 
reviewed by George Kashperko recently.

Hauke Mehrtens (7):
  bcma: scan for extra address space
  bcma: add function to check every 10 us if a reg is set
  USB: OHCI: Add a generic platform device driver
  USB: EHCI: Add a generic platform device driver
  USB: Add driver for the bcma bus
  USB: Add driver for the ssb bus
  USB: OHCI: remove old SSB OHCI driver

 drivers/bcma/core.c              |   52 ++++---
 drivers/bcma/scan.c              |   18 ++-
 drivers/usb/host/Kconfig         |   57 ++++++--
 drivers/usb/host/Makefile        |    2 +
 drivers/usb/host/bcma-hcd.c      |  307 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c      |    5 +
 drivers/usb/host/ehci-platform.c |  211 ++++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c      |   26 +---
 drivers/usb/host/ohci-platform.c |  193 ++++++++++++++++++++++++
 drivers/usb/host/ohci-ssb.c      |  260 --------------------------------
 drivers/usb/host/ssb-hcd.c       |  270 +++++++++++++++++++++++++++++++++
 include/linux/bcma/bcma.h        |    4 +
 12 files changed, 1089 insertions(+), 316 deletions(-)
 create mode 100644 drivers/usb/host/bcma-hcd.c
 create mode 100644 drivers/usb/host/ehci-platform.c
 create mode 100644 drivers/usb/host/ohci-platform.c
 delete mode 100644 drivers/usb/host/ohci-ssb.c
 create mode 100644 drivers/usb/host/ssb-hcd.c

-- 
1.7.5.4
