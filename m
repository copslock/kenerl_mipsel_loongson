Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 16:19:42 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:10300 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026050AbbDXOTl0dE0Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Apr 2015 16:19:41 +0200
Received: from localhost.localdomain (unknown [85.177.202.128])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPA id C62BA822FC;
        Fri, 24 Apr 2015 16:17:07 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-spi@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Brown <broonie@kernel.org>, Alban Bedel <albeu@free.fr>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 0/4] spi: spi-ath79: Devicetree support and misc fixes
Date:   Fri, 24 Apr 2015 16:19:20 +0200
Message-Id: <1429885164-28501-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47072
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

Hello all,

this serie add a DT support for the ATH79 SPI controller and fix a few
trivial bugs. While adding DT support we also remove the unused custom
controller data in favor of the generic GPIO based chip select.

The clock patch add the missing clk_un/prepare to fix the warnings once
the platform is moved to the generic clock framework.

Finally the last patch is to ensure that CS_HIGH chips using CS0 get the
proper CS level before the first transfer.

Alban

Alban Bedel (4):
  devicetree: add binding documentation for the AR7100 SPI controller
  spi: spi-ath79: Add device tree support
  spi: spi-ath79: Use clk_prepare_enable and clk_disable_unprepare
  spi: spi-ath79: Set the initial state of CS0

 .../devicetree/bindings/spi/spi-ath79.txt          | 24 +++++++++++++++
 .../include/asm/mach-ath79/ath79_spi_platform.h    |  4 ---
 drivers/spi/spi-ath79.c                            | 34 ++++++++++++++--------
 3 files changed, 46 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-ath79.txt

-- 
2.0.0
