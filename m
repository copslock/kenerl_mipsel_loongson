Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 14:09:15 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:58454 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990757AbeIOMJNFyak2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Sep 2018 14:09:13 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 7269F41258;
        Sat, 15 Sep 2018 14:09:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 6EI1DZt-2pnq; Sat, 15 Sep 2018 14:09:06 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH net-next 0/5] net: lantiq: Minor fixes for vrx200 and gswip
Date:   Sat, 15 Sep 2018 14:08:44 +0200
Message-Id: <20180915120849.24630-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66325
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

These are mostly minor fixes to problems addresses in the latests round 
of the review of the original series adding these driver, which were not 
applied before the patches got merged into net-next.
In addition it fixes a data bus error on poweroff.

Hauke Mehrtens (5):
  dt-bindings: net: lantiq,xrx200-net: Use lower case in hex
  dt-bindings: net: dsa: lantiq,xrx200-gswip: Fix minor style fixes
  net: lantiq: lantiq_xrx200: Move clock prepare to probe function
  net: dsa: lantiq_gswip: Minor code style improvements
  net: dsa: tag_gswip: Add gswip to dsa_tag_protocol_to_str()

 .../devicetree/bindings/net/dsa/lantiq-gswip.txt   | 18 +++++-----
 .../devicetree/bindings/net/lantiq,xrx200-net.txt  |  4 +--
 drivers/net/dsa/lantiq_gswip.c                     | 38 ++++++++++------------
 drivers/net/ethernet/lantiq_xrx200.c               | 21 +++++++-----
 net/dsa/dsa.c                                      |  3 ++
 5 files changed, 45 insertions(+), 39 deletions(-)

-- 
2.11.0
