Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2016 12:08:54 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:51874 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008157AbcCWLIxEUlEX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2016 12:08:53 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Wed, 23 Mar 2016
 04:08:43 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Wed, 23 Mar 2016
 16:37:06 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-clk@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Sandeep Sheriker <sandeepsheriker.mallikarjun@microchip.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v10 0/3] PIC32MZDA Clock Driver
Date:   Wed, 23 Mar 2016 16:36:45 +0530
Message-ID: <1458731208-25333-1-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

Purna Chandra Mandal (3):
  dt/bindings: Add PIC32 clock binding documentation
  clk: microchip: Add PIC32 clock driver
  MIPS: dts: pic32: Update dts to reflect new PIC32MZDA clk binding

 .../devicetree/bindings/clock/microchip,pic32.txt  |  39 +
 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi        | 236 -----
 arch/mips/boot/dts/pic32/pic32mzda.dtsi            |  63 +-
 arch/mips/boot/dts/pic32/pic32mzda_sk.dts          |   5 +-
 drivers/clk/Kconfig                                |   3 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/microchip/Makefile                     |   2 +
 drivers/clk/microchip/clk-core.c                   | 954 +++++++++++++++++++++
 drivers/clk/microchip/clk-core.h                   |  78 ++
 drivers/clk/microchip/clk-pic32mzda.c              | 240 ++++++
 include/dt-bindings/clock/microchip,pic32-clock.h  |  42 +
 11 files changed, 1404 insertions(+), 259 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt
 delete mode 100644 arch/mips/boot/dts/pic32/pic32mzda-clk.dtsi
 create mode 100644 drivers/clk/microchip/Makefile
 create mode 100644 drivers/clk/microchip/clk-core.c
 create mode 100644 drivers/clk/microchip/clk-core.h
 create mode 100644 drivers/clk/microchip/clk-pic32mzda.c
 create mode 100644 include/dt-bindings/clock/microchip,pic32-clock.h

-- 
1.8.3.1
