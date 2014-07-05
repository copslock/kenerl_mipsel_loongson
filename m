Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2014 21:30:05 +0200 (CEST)
Received: from seketeli.net ([94.23.218.202]:42187 "EHLO ms.seketeli.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859971AbaGET3pKFYD9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Jul 2014 21:29:45 +0200
Received: from amegan.ahome.fr (176-26-190-109.dsl.ovh.fr [109.190.26.176])
        by ms.seketeli.fr (Postfix) with ESMTPSA id 046112360045;
        Sat,  5 Jul 2014 21:29:45 +0200 (CEST)
Received: by amegan.ahome.fr (Postfix, from userid 1000)
        id 59593A40B41; Sat,  5 Jul 2014 21:30:15 +0200 (CEST)
From:   Apelete Seketeli <apelete@seketeli.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        John Crispin <blogic@openwrt.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Vinod Koul <vinod.koul@intel.com>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] mips: jz4740: rename usb_nop_xceiv to usb_phy_generic
Date:   Sat,  5 Jul 2014 21:30:15 +0200
Message-Id: <1404588615-14722-2-git-send-email-apelete@seketeli.net>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1404588615-14722-1-git-send-email-apelete@seketeli.net>
References: <1404588615-14722-1-git-send-email-apelete@seketeli.net>
Return-Path: <apelete@seketeli.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apelete@seketeli.net
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

Rename usb_nop_xceiv to usb_phy_generic in platform data to match the
name change of the nop transceiver driver in commit 4525bee (usb: phy:
rename usb_nop_xceiv to usb_phy_generic).

The name change induced a kernel panic due to an unhandled kernel
unaligned access while trying to dereference musb->xceiv->io_ops in
musb_init_controller().

Signed-off-by: Apelete Seketeli <apelete@seketeli.net>
---
 arch/mips/jz4740/platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index a447101..0b12f27 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -59,7 +59,7 @@ struct platform_device jz4740_usb_ohci_device = {
 
 /* USB Device Controller */
 struct platform_device jz4740_udc_xceiv_device = {
-	.name = "usb_phy_gen_xceiv",
+	.name = "usb_phy_generic",
 	.id   = 0,
 };
 
-- 
1.7.10.4
