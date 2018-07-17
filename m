Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 13:49:04 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:44069 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992279AbeGQLsqtHtFT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 13:48:46 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E272C207B4; Tue, 17 Jul 2018 13:48:40 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B5B0420765;
        Tue, 17 Jul 2018 13:48:40 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/5] Add support for MSCC Ocelot i2c
Date:   Tue, 17 Jul 2018 13:48:32 +0200
Message-Id: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64873
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

Hi,

Because the designware IP was not able to the the SDA hold time, MSCC has
its own implementation. Add support for it and then add i2c on ocelot
boards.

I would expect patches 1 to 3 to go through the i2c tree and 4-5 through
the mips tree once patch 3 has been reviewed by the DT maintainers.

Alexandre Belloni (5):
  i2c: designware: factorize setting SDA hold time
  i2c: designware: allow IP specific sda_hold_time
  i2c: designware: add MSCC Ocelot support
  mips: dts: mscc: Add i2c on ocelot
  mips: dts: mscc: enable i2c on ocelot_pcb123

 .../bindings/i2c/i2c-designware.txt           |  5 ++-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 19 +++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |  5 +++
 drivers/i2c/busses/i2c-designware-common.c    | 33 +++++++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h      |  3 ++
 drivers/i2c/busses/i2c-designware-master.c    | 22 +------------
 drivers/i2c/busses/i2c-designware-platdrv.c   | 20 +++++++++++
 drivers/i2c/busses/i2c-designware-slave.c     | 22 +------------
 8 files changed, 86 insertions(+), 43 deletions(-)

-- 
2.18.0
