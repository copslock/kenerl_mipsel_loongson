Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:38:52 +0100 (CET)
Received: from mail.perches.com ([173.55.12.10]:1036 "EHLO mail.perches.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492067Ab0KLViV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Nov 2010 22:38:21 +0100
Received: from Joe-Laptop.home (unknown [192.168.1.162])
        by mail.perches.com (Postfix) with ESMTP id C096F24368;
        Fri, 12 Nov 2010 13:37:31 -0800 (PST)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
        linux-mtd@lists.infradead.org, socketcan-core@lists.berlios.de,
        netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-usb@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 00/14] Use printf extension %pR for struct resource
Date:   Fri, 12 Nov 2010 13:37:50 -0800
Message-Id: <cover.1289597644.git.joe@perches.com>
X-Mailer: git-send-email 1.7.3.1.g432b3.dirty
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

Yet more trivia...

Joe Perches (14):
  arch/frv: Use printf extension %pR for struct resource
  arch/mips: Use printf extension %pR for struct resource
  arch/powerpc: Use printf extension %pR for struct resource
  drivers/dma/ppc4xx: Use printf extension %pR for struct resource
  drivers/infiniband: Use printf extension %pR for struct resource
  drivers/mfd: Use printf extension %pR for struct resource
  drivers/mtd/maps: Use printf extension %pR for struct resource
  drivers/mtd/nand: Use printf extension %pR for struct resource
  drivers/net/can/sja1000: Use printf extension %pR for struct resource
  drivers/parisc: Use printf extension %pR for struct resource
  drivers/rapidio: Use printf extension %pR for struct resource
  drivers/uwb: Use printf extension %pR for struct resource
  drivers/video: Use printf extension %pR for struct resource
  sound/ppc: Use printf extension %pR for struct resource

 arch/frv/mb93090-mb00/pci-vdk.c               |    8 ++------
 arch/mips/txx9/generic/pci.c                  |    7 ++-----
 arch/powerpc/kernel/pci_64.c                  |    3 +--
 arch/powerpc/sysdev/tsi108_dev.c              |    8 ++++----
 drivers/dma/ppc4xx/adma.c                     |    5 ++---
 drivers/infiniband/hw/ipath/ipath_driver.c    |    5 ++---
 drivers/mfd/sm501.c                           |    7 ++-----
 drivers/mtd/maps/amd76xrom.c                  |    7 ++-----
 drivers/mtd/maps/ck804xrom.c                  |    7 ++-----
 drivers/mtd/maps/esb2rom.c                    |    9 +++------
 drivers/mtd/maps/ichxrom.c                    |    9 +++------
 drivers/mtd/maps/physmap_of.c                 |    4 +---
 drivers/mtd/maps/scx200_docflash.c            |    5 ++---
 drivers/mtd/nand/pasemi_nand.c                |    2 +-
 drivers/net/can/sja1000/sja1000_of_platform.c |    8 ++------
 drivers/parisc/dino.c                         |   13 +++++--------
 drivers/parisc/hppb.c                         |    6 ++----
 drivers/rapidio/rio.c                         |    4 ++--
 drivers/uwb/umc-dev.c                         |    7 ++-----
 drivers/video/platinumfb.c                    |    8 ++------
 sound/ppc/pmac.c                              |   12 ++++--------
 21 files changed, 48 insertions(+), 96 deletions(-)

-- 
1.7.3.1.g432b3.dirty
