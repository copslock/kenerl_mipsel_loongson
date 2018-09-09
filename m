Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Sep 2018 22:17:26 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:9838 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992087AbeIIURX2etp1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 9 Sep 2018 22:17:23 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 70BA541F46;
        Sun,  9 Sep 2018 22:17:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 2l1QHRkmo237; Sun,  9 Sep 2018 22:17:15 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 net-next 0/6] Add support for Lantiq / Intel vrx200 network
Date:   Sun,  9 Sep 2018 22:16:41 +0200
Message-Id: <20180909201647.32727-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66158
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

This depends on the patch "MIPS: lantiq: dma: add dev pointer" which 
should go into 4.19.

Changes since:
v2:
 * Send patch "MIPS: lantiq: dma: add dev pointer" separately
 * all: removed return in register write functions
 * switch: uses phylink
 * switch: uses hardware MDIO auto polling
 * switch: use usleep_range() in MDIO busy check
 * switch: configure MDIO bus to 2.5 MHz
 * switch: disable xMII link when it is not used
 * Ethernet: use NAPI for TX cleanups
 * Ethernet: enable clock in open callback
 * Ethernet: improve skb allocation
 * Ethernet: use net_dev->stats

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

Hauke Mehrtens (6):
  MIPS: lantiq: Do not enable IRQs in dma open
  net: dsa: Add Lantiq / Intel GSWIP tag support
  dt-bindings: net: Add lantiq,xrx200-net DT bindings
  net: lantiq: Add Lantiq / Intel VRX200 Ethernet driver
  dt-bindings: net: dsa: Add lantiq,xrx200-gswip DT bindings
  net: dsa: Add Lantiq / Intel DSA driver for vrx200

 .../devicetree/bindings/net/dsa/lantiq-gswip.txt   |  141 +++
 .../devicetree/bindings/net/lantiq,xrx200-net.txt  |   21 +
 MAINTAINERS                                        |    9 +
 arch/mips/lantiq/xway/dma.c                        |    1 -
 arch/mips/lantiq/xway/sysctrl.c                    |   14 +-
 drivers/net/dsa/Kconfig                            |    8 +
 drivers/net/dsa/Makefile                           |    1 +
 drivers/net/dsa/lantiq_gswip.c                     | 1169 ++++++++++++++++++++
 drivers/net/dsa/lantiq_pce.h                       |  153 +++
 drivers/net/ethernet/Kconfig                       |    7 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/lantiq_etop.c                 |    1 +
 drivers/net/ethernet/lantiq_xrx200.c               |  564 ++++++++++
 include/net/dsa.h                                  |    1 +
 net/dsa/Kconfig                                    |    3 +
 net/dsa/Makefile                                   |    1 +
 net/dsa/dsa.c                                      |    3 +
 net/dsa/dsa_priv.h                                 |    3 +
 net/dsa/tag_gswip.c                                |  109 ++
 19 files changed, 2202 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
 create mode 100644 Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
 create mode 100644 drivers/net/dsa/lantiq_gswip.c
 create mode 100644 drivers/net/dsa/lantiq_pce.h
 create mode 100644 drivers/net/ethernet/lantiq_xrx200.c
 create mode 100644 net/dsa/tag_gswip.c

-- 
2.11.0
