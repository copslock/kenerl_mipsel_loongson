Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 20:11:37 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33166 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833256Ab3A1TJ07V0AX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 20:09:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id CFA9BBF5166;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OlqrIaTfLZC1; Mon, 28 Jan 2013 20:09:25 +0100 (CET)
Received: from flexo.localdomain (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 4E655BF5178;
        Mon, 28 Jan 2013 20:09:25 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, jogo@openwrt.org, mbizon@freebox.fr,
        cenerkee@gmail.com, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        blogic@openwrt.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 01/13] MIPS: BCM63XX: add USB host clock enable delay
Date:   Mon, 28 Jan 2013 20:06:19 +0100
Message-Id: <1359399991-2236-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359399991-2236-1-git-send-email-florian@openwrt.org>
References: <1359399991-2236-1-git-send-email-florian@openwrt.org>
X-archive-position: 35590
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

Knowledge of the clock setup delay should remain at the clock level (so
it can be clock specific and CPU specific). Add the 100 milliseconds
required clock delay for the USB host clock when it gets enabled.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/clk.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index b9e948d..a39aeb8 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -162,6 +162,11 @@ static void usbh_set(struct clk *clk, int enable)
 		bcm_hwclock_set(CKCTL_6348_USBH_EN, enable);
 	else if (BCMCPU_IS_6368())
 		bcm_hwclock_set(CKCTL_6368_USBH_EN, enable);
+	else
+		return;
+
+	if (enable)
+		msleep(100);
 }
 
 static struct clk clk_usbh = {
-- 
1.7.10.4
