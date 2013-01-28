Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:11:01 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33216 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833262Ab3A1TJ05q0KE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 90779BF51BF;
        Mon, 28 Jan 2013 20:09:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OB5yv9PSMv5Z; Mon, 28 Jan 2013 20:09:26 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D1977BF51A6;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 12/13] MIPS: BCM63XX: EHCI controller does not support overcurrent
Date:   Mon, 28 Jan 2013 20:06:30 +0100
Message-Id: <1359399991-2236-13-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35588
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

This patch sets the ignore_oc flag for the BCM63XX EHCI controller as it
does not support proper overcurrent reporting.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/dev-usb-ehci.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/bcm63xx/dev-usb-ehci.c b/arch/mips/bcm63xx/dev-usb-ehci.c
index 0ea7888..f7b6807 100644
--- a/arch/mips/bcm63xx/dev-usb-ehci.c
+++ b/arch/mips/bcm63xx/dev-usb-ehci.c
@@ -61,6 +61,7 @@ static void bcm63xx_ehci_power_off(struct platform_device *pdev)
 static struct usb_ehci_pdata bcm63xx_ehci_pdata = {
 	.big_endian_desc	= 1,
 	.big_endian_mmio	= 1,
+	.ignore_oc		= 1,
 	.power_on		= bcm63xx_ehci_power_on,
 	.power_off		= bcm63xx_ehci_power_off,
 	.power_suspend		= bcm63xx_ehci_power_off,
-- 
1.7.10.4
