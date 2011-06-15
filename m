Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 10:08:07 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33377 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1490982Ab1FOIIE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 10:08:04 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5F87xhI004307;
        Wed, 15 Jun 2011 09:08:00 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5F87wD1004304;
        Wed, 15 Jun 2011 09:07:58 +0100
Date:   Wed, 15 Jun 2011 09:07:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        Florian Fainelli <ffainelli@freebox.fr>
Subject: [PATCH] phylib: Allow BCM63XX PHY to be selected only on BCM63XX.
Message-ID: <20110615080758.GA3226@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12158

This PHY is available integrated into BCM63xx series SOCs only.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/net/phy/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 392a6c4..a702443 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -58,6 +58,7 @@ config BROADCOM_PHY
 
 config BCM63XX_PHY
 	tristate "Drivers for Broadcom 63xx SOCs internal PHY"
+	depends on BCM63XX
 	---help---
 	  Currently supports the 6348 and 6358 PHYs.
 
