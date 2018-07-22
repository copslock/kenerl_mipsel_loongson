Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2018 23:20:27 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:34140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993890AbeGVVUYYNqoS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2018 23:20:24 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 578F7ADC0;
        Sun, 22 Jul 2018 21:20:18 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 00/15] MIPS: pistachio: Creator Ci40 aka Marduk SPI-UART
Date:   Sun, 22 Jul 2018 23:19:55 +0200
Message-Id: <20180722212010.3979-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <afaerber@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afaerber@suse.de
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

Hello,

This patchset enables SPI and UARTs for the Ci40's mikroBUS and Raspberry Pi B+
connectors, as well as the remaining seven LEDs and as dependency the 802.15.4.

I also dug out some related driver fixes from their pistachio-4.9-lede branch:
https://github.com/CreatorDev/linux/commits/pistachio-4.9-lede

Tested with a LoRa click expansion board. [*]
Note that a number of drivers are missing in the pistachio defconfig. This
should probably be remedied as follow-up.

While all creatordev.io websites appear to be gone, I still had a local copy
of the Ci40 schematics document.

This patchset: https://github.com/afaerber/linux/commits/ci40-spi-uart.v1

Some more potential patches for missing features appear to be here:
https://github.com/CreatorDev/linux/commits/pistachio-4.9-wip

Have a lot of fun!

Cheers,
Andreas

P.S. As follow-up to this series I've reported on linux-serial that sc16is7xx
and serdev drivers don't appear to play nicely together:
https://marc.info/?l=linux-serial&m=153228314300681&w=2

[*] Cf. netdev https://patchwork.ozlabs.org/cover/937545/

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org

Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org

Andreas Färber (7):
  MIPS: dts: img: pistachio_marduk: Reorder nodes
  MIPS: dts: img: pistachio_marduk: Cleanups
  MIPS: dts: img: pistachio: Rename spim0-clk pin node label
  MIPS: dts: img: pistachio_marduk: Enable SPIM0
  MIPS: dts: img: pistachio_marduk: Add 6Lowpan node
  MIPS: dts: img: pistachio_marduk: Add SPI UART node
  MIPS: dts: img: pistachio_marduk: Add user LEDs

Damien Horsley (1):
  dmaengine: img-mdc: Handle early status read

Govindraj Raja (1):
  clk: pistachio: Fix wrong SDHost card speed

Ian Pozella (1):
  MIPS: dts: img: pistachio_marduk: Switch mmc to 1 bit mode

Ionela Voinescu (5):
  spi: img-spfi: Implement dual and quad mode
  spi: img-spfi: Set device select bits for SPFI port state
  spi: img-spfi: Use device 0 configuration for all devices
  spi: img-spfi: RX maximum burst size for DMA is 8
  spi: img-spfi: Finish every transfer cleanly

 arch/mips/boot/dts/img/pistachio.dtsi       |   2 +-
 arch/mips/boot/dts/img/pistachio_marduk.dts | 174 ++++++++++++++++++++++------
 drivers/clk/pistachio/clk-pistachio.c       |   3 +-
 drivers/dma/img-mdc-dma.c                   |  40 ++++---
 drivers/spi/spi-img-spfi.c                  | 165 +++++++++++++++++++++-----
 include/dt-bindings/clock/pistachio-clk.h   |   1 +
 6 files changed, 299 insertions(+), 86 deletions(-)

-- 
2.16.4
