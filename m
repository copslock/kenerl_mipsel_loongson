Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 20:21:10 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:40410
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993907AbdAaTTVsEbIa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 20:19:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Date:Sender:Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:In-Reply-To; bh=TdheqHTMPLf5D3qCHJ+Z/u5Rsa7teq0uvSS2DQ4+xCI=;
        b=hmp/teMSLiHs1jOmhBPoWfEVuHJxLrJb6fEdPkLlmzQoyS3dnNJykY8mrAOx+yTbZwVKzr6qxT+YObozHrzzVprx7jXMJNomPeiwB32xOLB0dAEANb7YRFIL2MLWALOkDp7rqRT916K6Dy4xqzdH0hsHeNhBfWGE1nri3JT9I+Y=;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48510 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdxJ-0000jR-MA; Tue, 31 Jan 2017 19:19:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdxD-0000Wd-1D; Tue, 31 Jan 2017 19:18:59 +0000
In-Reply-To: <20170131191704.GA8281@n2100.armlinux.org.uk>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 4.10-rc3 07/13] net: mvneta: fix build errors when
 linux/phy*.h is removed from net/dsa.h
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1cYdxD-0000Wd-1D@rmk-PC.armlinux.org.uk>
Date:   Tue, 31 Jan 2017 19:18:59 +0000
Return-Path: <rmk+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+kernel@armlinux.org.uk
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

drivers/net/ethernet/marvell/mvneta.c:2694:26: error: storage size of 'status' isn't known
drivers/net/ethernet/marvell/mvneta.c:2695:26: error: storage size of 'changed' isn't known
drivers/net/ethernet/marvell/mvneta.c:2695:9: error: variable 'changed' has initializer but incomplete type
drivers/net/ethernet/marvell/mvneta.c:2709:2: error: implicit declaration of function 'fixed_phy_update_state' [-Werror=implicit-function-declaration]

Add linux/phy_fixed.h to mvneta.c

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvneta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index e05e22705cf7..eb0eb3e62ca0 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -28,6 +28,7 @@
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/phy.h>
+#include <linux/phy_fixed.h>
 #include <linux/platform_device.h>
 #include <linux/skbuff.h>
 #include <net/hwbm.h>
-- 
2.7.4
