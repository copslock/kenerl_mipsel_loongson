Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 16:39:24 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:48882 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993094AbeGaOjD1wSjh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2018 16:39:03 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3658C20799; Tue, 31 Jul 2018 16:38:56 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 11E1020731;
        Tue, 31 Jul 2018 16:38:56 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, Paul Burton <paul.burton@mips.com>
Cc:     James Hogan <jhogan@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 0/3] Add support for MSCC Ocelot SPI
Date:   Tue, 31 Jul 2018 16:38:52 +0200
Message-Id: <20180731143855.7131-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65323
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

This series only contains the DT documentation and the corresponding DT addition
since it has been rebased on spi-next.

Alexandre Belloni (3):
  spi: dw: document Microsemi integration
  mips: dts: mscc: Add spi on Ocelot
  mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt       |  6 ++++--
 arch/mips/boot/dts/mscc/ocelot.dtsi                   | 11 +++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts             | 10 ++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.18.0
