Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 20:20:46 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:40400
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993905AbdAaTTJOzova (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 20:19:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Date:Sender:Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:In-Reply-To; bh=fFfPpBqa1SWUTIHnikQzPx4YEGTxjpAl1Wm0ItItQ00=;
        b=LZ/3zJQ4gxP/8gryoI9DWD9Ote73qUgtucRZBNRhxXWG/kB7mxOPWf2IavGZ+/llxg/WmN/MbOr0K8vEkNMD2dgu2+VgV0RXolyb1QA7o5u5kBJaWVo7mCPhcqaDHvWvzliOJWbzoP675naIcSYoIQUTZUjeKekbHxaVXykZbC0=;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:48794 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdxE-0000jL-3e; Tue, 31 Jan 2017 19:19:00 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1cYdx7-0000WW-So; Tue, 31 Jan 2017 19:18:53 +0000
In-Reply-To: <20170131191704.GA8281@n2100.armlinux.org.uk>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 4.10-rc3 06/13] net: fman: fix build errors when linux/phy*.h
 is removed from net/dsa.h
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1cYdx7-0000WW-So@rmk-PC.armlinux.org.uk>
Date:   Tue, 31 Jan 2017 19:18:53 +0000
Return-Path: <rmk+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56557
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

drivers/net/ethernet/freescale/fman/fman_memac.c:519:21: error: dereferencing pointer to incomplete type 'struct fixed_phy_status'

Add linux/phy_fixed.h to fman_memac.c

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 71a5ded9d1de..cd6a53eaf161 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/phy.h>
+#include <linux/phy_fixed.h>
 #include <linux/of_mdio.h>
 
 /* PCS registers */
-- 
2.7.4
