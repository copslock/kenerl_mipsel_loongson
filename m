Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 17:07:40 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:36776 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012764AbcBXQHjM5svO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 17:07:39 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Wed, 24 Feb 2016
 09:07:30 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Wed, 24 Feb 2016
 09:08:15 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Sandeep Sheriker <sandeepsheriker.mallikarjun@microchip.com>
Subject: [PATCH v8 0/3] PIC32MZDA Clock Driver
Date:   Wed, 24 Feb 2016 09:07:14 -0700
Message-ID: <1456330090-27226-1-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

Clock bindings got acked and then essentially unacked, while the clock
driver never made it upstream. In the meantime, the initial DTS file
made it upstream. This latest patch series includes a patch to go back
and correct the DTS files to reflect the new clock bindings in this
patch series.

This series still uses the CLK_OF_DECLARE approach despite not being
regarded as the best approach. On MIPS/PIC32 the first call of clk_get()
happens from "start_kernel -> time_init() -> plat_time_init()" which is
very early in boot sequence even before execution of early_initcall().
In short, by platform_driver way I was not able to register clock(s)
before the first clock user becomes ready. With CLK_OF_DECLARE() I can
explicitly call of_clk_init() in plat_time_init() just before calling
clk_get().

Purna Chandra Mandal (3):
  dt/bindings: Add PIC32 clock binding documentation
  clk: clk-pic32: Add PIC32 clock driver
  MIPS: dts: pic32: Update dts to reflect new PIC32MZDA clk binding

 .../devicetree/bindings/clock/microchip,pic32.txt  |   39 +
 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi        |  236 -----
 arch/mips/boot/dts/pic32/pic32mzda.dtsi            |   63 +-
 arch/mips/boot/dts/pic32/pic32mzda_sk.dts          |    5 +-
 drivers/clk/Kconfig                                |    3 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/microchip/Makefile                     |    2 +
 drivers/clk/microchip/clk-core.c                   |  954 ++++++++++++++++++++
 drivers/clk/microchip/clk-core.h                   |   78 ++
 drivers/clk/microchip/clk-pic32mzda.c              |  214 +++++
 include/dt-bindings/clock/microchip,pic32-clock.h  |   42 +
 11 files changed, 1378 insertions(+), 259 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt
 delete mode 100644 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi
 create mode 100644 drivers/clk/microchip/Makefile
 create mode 100644 drivers/clk/microchip/clk-core.c
 create mode 100644 drivers/clk/microchip/clk-core.h
 create mode 100644 drivers/clk/microchip/clk-pic32mzda.c
 create mode 100644 include/dt-bindings/clock/microchip,pic32-clock.h

--
1.7.9.5
