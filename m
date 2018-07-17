Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 16:23:40 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:50240 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993024AbeGQOXfE1YGD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 16:23:35 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BB031208FF; Tue, 17 Jul 2018 16:23:28 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 93A89203EC;
        Tue, 17 Jul 2018 16:23:18 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/5] Add support for MSCC Ocelot SPI
Date:   Tue, 17 Jul 2018 16:23:09 +0200
Message-Id: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

The MSCC MIPS SoC line uses a designware IP for the SPI controller but
still requires some special handling to give control of the SPI
interface to the IP and also has a specific handling for the chip
select.

Patches 1 to 3 should go through the SPI tree while 4 and 5 should
probably got throught the MIPS tree once patch 3 has been reviewed by
the DT maintainers.

Alexandre Belloni (5):
  spi: dw: fix possible race condition
  spi: dw: allow providing own set_cs callback
  spi: dw-mmio: add MSCC Ocelot support
  mips: dts: mscc: Add spi on Ocelot
  mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

 .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 11 +++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     | 10 +++
 drivers/spi/spi-dw-mmio.c                     | 86 +++++++++++++++++++
 drivers/spi/spi-dw.c                          |  6 +-
 drivers/spi/spi-dw.h                          |  1 +
 6 files changed, 116 insertions(+), 3 deletions(-)

-- 
2.18.0
