Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Sep 2018 13:46:23 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:37894 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990471AbeIALqQy1Vqd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 1 Sep 2018 13:46:16 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id ED9AB40E62;
        Sat,  1 Sep 2018 13:46:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id FxuyHVPDBjYL; Sat,  1 Sep 2018 13:46:09 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 net-next 0/7] Add support for Lantiq / Intel vrx200 network
Date:   Sat,  1 Sep 2018 13:45:28 +0200
Message-Id: <20180901114535.9070-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This adds basic support for the GSWIP (Gigabit Switch) found in the
VRX200 SoC.
There are different versions of this IP core used in different SoCs, but
this driver was currently only tested on the VRX200 SoC line, for other
SoCs this driver probably need some adoptions to work.

I also plan to add Layer 2 offloading to the DSA driver and later also
layer 3 offloading which is supported by the PPE HW block.

All these patches should go through the net-next tree.

"MIPS: lantiq: dma: add dev pointer" fixes a problem introduces with
4.19-rc1 and this should also go into 4.19, but it changes the API and I
need this API change in this new driver added in these patches.

Changes since:
v1:
 * Add "MIPS: lantiq: dma: add dev pointer"
 * checkpatch fixes a all patches
 * Added binding documentation
 * use readx_poll_timeout function and ETIMEOUT error code
 * integrate GPHY firmware loading into DSA driver
 * renamed to NET_DSA_LANTIQ_GSWIP
 * removed some needed casts
 * added of_device_id.data information about the detected switch
 * fixed John's email address

Hauke Mehrtens (7):
  MIPS: lantiq: dma: add dev pointer
  MIPS: lantiq: Do not enable IRQs in dma open
  net: dsa: Add Lantiq / Intel GSWIP tag support
  dt-bindings: net: Add lantiq,xrx200-net DT bindings
  net: lantiq: Add Lantiq / Intel VRX200 Ethernet driver
  dt-bindings: net: dsa: Add lantiq,xrx200-gswip DT bindings
  net: dsa: Add Lantiq / Intel DSA driver for vrx200

 .../devicetree/bindings/net/dsa/lantiq-gswip.txt   |  141 +++
 .../devicetree/bindings/net/lantiq,xrx200-net.txt  |   21 +
 MAINTAINERS                                        |    9 +
 arch/mips/include/asm/mach-lantiq/xway/xway_dma.h  |    1 +
 arch/mips/lantiq/xway/dma.c                        |    5 +-
 arch/mips/lantiq/xway/sysctrl.c                    |   14 +-
 drivers/net/dsa/Kconfig                            |    8 +
 drivers/net/dsa/Makefile                           |    1 +
 drivers/net/dsa/lantiq_gswip.c                     | 1018 ++++++++++++++++++++
 drivers/net/dsa/lantiq_pce.h                       |  153 +++
 drivers/net/ethernet/Kconfig                       |    7 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/lantiq_etop.c                 |    2 +
 drivers/net/ethernet/lantiq_xrx200.c               |  591 ++++++++++++
 include/net/dsa.h                                  |    1 +
 net/dsa/Kconfig                                    |    3 +
 net/dsa/Makefile                                   |    1 +
 net/dsa/dsa.c                                      |    3 +
 net/dsa/dsa_priv.h                                 |    3 +
 net/dsa/tag_gswip.c                                |  107 ++
 20 files changed, 2080 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
 create mode 100644 Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
 create mode 100644 drivers/net/dsa/lantiq_gswip.c
 create mode 100644 drivers/net/dsa/lantiq_pce.h
 create mode 100644 drivers/net/ethernet/lantiq_xrx200.c
 create mode 100644 net/dsa/tag_gswip.c

-- 
2.11.0
