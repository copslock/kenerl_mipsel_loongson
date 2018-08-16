Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2018 10:46:26 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:50869 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994585AbeHPIpkTvZQu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2018 10:45:40 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1BD4720EB9; Thu, 16 Aug 2018 10:45:34 +0200 (CEST)
Received: from localhost (unknown [78.250.249.73])
        by mail.bootlin.com (Postfix) with ESMTPSA id B97E2204AE;
        Thu, 16 Aug 2018 10:45:23 +0200 (CEST)
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
Subject: [PATCH v4 0/7] Add support for MSCC Ocelot i2c
Date:   Thu, 16 Aug 2018 10:45:14 +0200
Message-Id: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65596
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

Because the designware IP was not able to handle the SDA hold time before
version 1.11a, MSCC has its own implementation. Add support for it and then add
i2c on ocelot boards.

I would expect patches 1 to 5 to go through the i2c tree and 6-7 through
the mips tree once patch 4 has been reviewed by the DT maintainers.

This is based on top of i2c-next

Changes in v4:
 - collected review and ack tags
 - split bindings to a separate patch

Changes in v3:
 - collected review tags
 - fixed build warnings on 64bit machines

Changes in v2:
 - removed first patch as a similar one is in i2c-next
 - rebase on top of i2c-next
 - Added two patches to implement ideas from Andy


Alexandre Belloni (7):
  i2c: designware: use generic table matching
  i2c: designware: move #ifdef CONFIG_OF to the top
  i2c: designware: allow IP specific sda_hold_time
  i2c: designware: document MSCC Ocelot bindings
  i2c: designware: add MSCC Ocelot support
  MIPS: dts: mscc: Add i2c on ocelot
  MIPS: dts: mscc: enable i2c on ocelot_pcb123

 .../bindings/i2c/i2c-designware.txt           |  7 ++-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 18 ++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |  6 ++
 drivers/i2c/busses/i2c-designware-common.c    |  2 +
 drivers/i2c/busses/i2c-designware-core.h      |  4 ++
 drivers/i2c/busses/i2c-designware-platdrv.c   | 63 +++++++++++++++----
 6 files changed, 86 insertions(+), 14 deletions(-)

-- 
2.18.0
