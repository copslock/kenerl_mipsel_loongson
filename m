Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 00:04:21 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41764 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903705Ab2A3XEQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2012 00:04:16 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 19F6F8F68;
        Tue, 31 Jan 2012 00:04:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B6F99mUoS62O; Tue, 31 Jan 2012 00:04:12 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 668328F60;
        Tue, 31 Jan 2012 00:04:12 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/7] bcma: add PCIe host controller
Date:   Tue, 31 Jan 2012 00:03:30 +0100
Message-Id: <1327964617-7910-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 32336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

These patches are adding support for a PCIe Host controller found on 
some Broadcom SoCs using bcma as the System bus. This was tested with 
one BCM4716 based device, a Netgear WNDR3400 with a BCM43224 connected 
through PCIe.
These patches are based on wireless-testing.

Hauke Mehrtens (7):
  bcma: add the core unit number
  bcma: add constants for PCI and use them
  bcma: export bcma_pcie_read()
  bcma: make some functions __devinit
  bcma: add PCIe host controller
  bcma: add bus num counter
  bcma: add extra sprom check

 arch/mips/pci/pci-bcm47xx.c                 |   49 ++-
 drivers/bcma/bcma_private.h                 |    8 +-
 drivers/bcma/driver_pci.c                   |  168 ++++-----
 drivers/bcma/driver_pci_host.c              |  578 ++++++++++++++++++++++++++-
 drivers/bcma/host_pci.c                     |    4 +-
 drivers/bcma/main.c                         |   14 +-
 drivers/bcma/scan.c                         |   14 +
 drivers/bcma/sprom.c                        |    7 +
 include/linux/bcma/bcma.h                   |    2 +
 include/linux/bcma/bcma_driver_chipcommon.h |   16 +
 include/linux/bcma/bcma_driver_pci.h        |  125 ++++++-
 include/linux/bcma/bcma_regs.h              |   27 ++
 12 files changed, 908 insertions(+), 104 deletions(-)

-- 
1.7.5.4
