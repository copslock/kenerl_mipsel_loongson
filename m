Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 14:05:54 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:43244 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992482AbeG0MFub6zls (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jul 2018 14:05:50 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D3A3D2073D; Fri, 27 Jul 2018 14:05:43 +0200 (CEST)
Received: from localhost (unknown [88.128.81.178])
        by mail.bootlin.com (Postfix) with ESMTPSA id 935A320717;
        Fri, 27 Jul 2018 14:05:43 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/4] Add support for MSCC Ocelot SPI
Date:   Fri, 27 Jul 2018 14:05:31 +0200
Message-Id: <20180727120535.16504-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65197
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

Changes in v2:
 - Removed already applied patches
 - separated DT binding changes from the driver patch

Alexandre Belloni (4):
  dt-bindings: spi: snps,dw-apb-ssi: document Microsemi integration
  spi: dw-mmio: add MSCC Ocelot support
  mips: dts: mscc: Add spi on Ocelot
  mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

 arch/mips/boot/dts/mscc/ocelot.dtsi       | 11 +++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 10 +++
 drivers/spi/spi-dw-mmio.c                 | 91 +++++++++++++++++++++++
 3 files changed, 112 insertions(+)

-- 
2.18.0
