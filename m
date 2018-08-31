Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2018 17:04:56 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:48563 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994583AbeHaPExhU2ZK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2018 17:04:53 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3B10020828; Fri, 31 Aug 2018 17:04:48 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0E5532071E;
        Fri, 31 Aug 2018 17:04:38 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] MIPS: generic: Add Network, SPI and I2C to ocelot_defconfig
Date:   Fri, 31 Aug 2018 17:04:34 +0200
Message-Id: <20180831150434.25050-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65813
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

Add support for the integrated switch, and the SPI and I2C controller found
on MSCC Ocelot.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/configs/generic/board-ocelot.config | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/configs/generic/board-ocelot.config b/arch/mips/configs/generic/board-ocelot.config
index aa815761d85e..f607888d2483 100644
--- a/arch/mips/configs/generic/board-ocelot.config
+++ b/arch/mips/configs/generic/board-ocelot.config
@@ -18,17 +18,25 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 
-CONFIG_GPIO_SYSFS=y
+CONFIG_NETDEVICES=y
+CONFIG_MSCC_OCELOT_SWITCH=y
+CONFIG_MSCC_OCELOT_SWITCH_OCELOT=y
+CONFIG_MDIO_MSCC_MIIM=y
+CONFIG_MICROSEMI_PHY=y
 
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
 
 CONFIG_SPI=y
 CONFIG_SPI_BITBANG=y
 CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_DW_MMIO=y
 CONFIG_SPI_SPIDEV=y
 
+CONFIG_GPIO_SYSFS=y
+
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_OCELOT_RESET=y
 
-- 
2.19.0.rc1
