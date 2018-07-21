Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jul 2018 21:14:48 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:50428 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993354AbeGUTOfdyC9Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Jul 2018 21:14:35 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id C3D2B476AF;
        Sat, 21 Jul 2018 21:14:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id eZBUBLrmzhmU; Sat, 21 Jul 2018 21:14:26 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/4] net: Add support for Lantiq / Intel vrx200 network
Date:   Sat, 21 Jul 2018 21:13:54 +0200
Message-Id: <20180721191358.13952-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65022
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

Hauke Mehrtens (4):
  MIPS: lantiq: Do not enable IRQs in dma open
  net: dsa: Add Lantiq / Intel GSWIP tag support
  net: lantiq: Add Lantiq / Intel vrx200 Ethernet driver
  net: dsa: Add Lantiq / Intel DSA driver for vrx200

 MAINTAINERS                          |   9 +
 arch/mips/lantiq/xway/dma.c          |   1 -
 arch/mips/lantiq/xway/sysctrl.c      |   2 +-
 drivers/net/dsa/Kconfig              |   8 +
 drivers/net/dsa/Makefile             |   1 +
 drivers/net/dsa/lantiq-gswip.c       | 750 +++++++++++++++++++++++++++++++++++
 drivers/net/dsa/lantiq_pce.h         | 153 +++++++
 drivers/net/ethernet/Kconfig         |   6 +
 drivers/net/ethernet/Makefile        |   1 +
 drivers/net/ethernet/lantiq_etop.c   |   1 +
 drivers/net/ethernet/lantiq_xrx200.c | 609 ++++++++++++++++++++++++++++
 include/net/dsa.h                    |   1 +
 net/dsa/Kconfig                      |   3 +
 net/dsa/Makefile                     |   1 +
 net/dsa/dsa.c                        |   3 +
 net/dsa/dsa_priv.h                   |   3 +
 net/dsa/tag_gswip.c                  | 110 +++++
 17 files changed, 1660 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq-gswip.c
 create mode 100644 drivers/net/dsa/lantiq_pce.h
 create mode 100644 drivers/net/ethernet/lantiq_xrx200.c
 create mode 100644 net/dsa/tag_gswip.c

-- 
2.11.0
