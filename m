Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Sep 2015 17:23:40 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:34283 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007039AbbIAPXjJdaXU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Sep 2015 17:23:39 +0200
Received: from tock.adnet.avionic-design.de (unknown [78.54.126.133])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id C9F904B00AA;
        Tue,  1 Sep 2015 17:23:24 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 0/4] MIPS: ath79: Add USB support on the TL-WR1043ND
Date:   Tue,  1 Sep 2015 17:23:10 +0200
Message-Id: <1441120994-31476-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

this serie add a driver for the USB phy on the ATH79 SoCs and enable the
USB port on the TL-WR1043ND. The phy controller is really trivial as it
only use reset lines.

Alban

Alban Bedel (4):
  devicetree: Add bindings for the ATH79 USB phy
  phy: Add a driver for the ATH79 USB phy
  MIPS: ath79: Add the EHCI controller and USB phy to the AR9132 dtsi
  MIPS: ath79: Enable the USB port on the TL-WR1043ND

 .../devicetree/bindings/phy/phy-ath79-usb.txt      |  18 ++++
 arch/mips/boot/dts/qca/ar9132.dtsi                 |  24 +++++
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts   |   4 +
 drivers/phy/Kconfig                                |   8 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-ath79-usb.c                        | 115 +++++++++++++++++++++
 6 files changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
 create mode 100644 drivers/phy/phy-ath79-usb.c

-- 
2.0.0
