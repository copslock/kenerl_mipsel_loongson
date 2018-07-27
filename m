Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 21:55:16 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:54832 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993003AbeG0TzBiQu2u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jul 2018 21:55:01 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 381C42093C; Fri, 27 Jul 2018 21:54:55 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 07B2920908;
        Fri, 27 Jul 2018 21:53:59 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 0/5] Add support for MSCC Ocelot SPI
Date:   Fri, 27 Jul 2018 21:53:53 +0200
Message-Id: <20180727195358.23336-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65209
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

Changes in v3:
 - Added a patch to export dw_spi_set_cs

Changes in v2:
 - Removed already applied patches
 - separated DT binding changes from the driver patch

Alexandre Belloni (5):
  spi: dw: export dw_spi_set_cs
  dt-bindings: spi: snps,dw-apb-ssi: document Microsemi integration
  spi: dw-mmio: add MSCC Ocelot support
  mips: dts: mscc: Add spi on Ocelot
  mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

 .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 11 +++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     | 10 +++
 drivers/spi/spi-dw-mmio.c                     | 90 +++++++++++++++++++
 drivers/spi/spi-dw.c                          |  3 +-
 drivers/spi/spi-dw.h                          |  1 +
 6 files changed, 117 insertions(+), 3 deletions(-)

-- 
2.18.0
