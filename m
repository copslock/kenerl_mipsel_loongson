Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:13:26 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33165 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833504Ab3A1TJ1c2-j1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id E3D65BF5178;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2SXtEhEIqvxq; Mon, 28 Jan 2013 20:09:25 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 59117BF5180;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 02/13] MIPS: BCM63XX: add USB device clock enable delay to clock code
Date:   Mon, 28 Jan 2013 20:06:20 +0100
Message-Id: <1359399991-2236-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch adds the required 10 micro seconds delay to the USB device
clock enable operation. Put this where the correct clock knowledege is,
which is in the clock code, and remove this delay from the bcm63xx_udc
gadget driver where it was before.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/clk.c          |    5 +++++
 drivers/usb/gadget/bcm63xx_udc.c |    1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index a39aeb8..1f1a6c1 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -182,6 +182,11 @@ static void usbd_set(struct clk *clk, int enable)
 		bcm_hwclock_set(CKCTL_6328_USBD_EN, enable);
 	else if (BCMCPU_IS_6368())
 		bcm_hwclock_set(CKCTL_6368_USBD_EN, enable);
+	else
+		return;
+
+	if (enable)
+		udelay(10);
 }
 
 static struct clk clk_usbd = {
diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
index 47a4993..ad17533 100644
--- a/drivers/usb/gadget/bcm63xx_udc.c
+++ b/drivers/usb/gadget/bcm63xx_udc.c
@@ -386,7 +386,6 @@ static inline void set_clocks(struct bcm63xx_udc *udc, bool is_enabled)
 	if (is_enabled) {
 		clk_enable(udc->usbh_clk);
 		clk_enable(udc->usbd_clk);
-		udelay(10);
 	} else {
 		clk_disable(udc->usbd_clk);
 		clk_disable(udc->usbh_clk);
-- 
1.7.10.4
