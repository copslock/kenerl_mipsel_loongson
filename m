Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2012 18:16:04 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:45516 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903842Ab2IZQPz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Sep 2012 18:15:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 9D364A1A66;
        Wed, 26 Sep 2012 18:15:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yjmcGETCPcJp; Wed, 26 Sep 2012 18:15:54 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 2E045A194F;
        Wed, 26 Sep 2012 18:15:54 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/2] MIPS: AR7: remove "registered %d GPIOs" message
Date:   Wed, 26 Sep 2012 18:15:01 +0200
Message-Id: <1348676102-5651-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 34551
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

gpiolib already prints something similar, so let's get rid of this
duplicate message.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/ar7/gpio.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index d8dbd8f..4b242b0 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -338,8 +338,6 @@ int __init ar7_gpio_init(void)
 					gpch->chip.label);
 		return ret;
 	}
-	printk(KERN_INFO "%s: registered %d GPIOs\n",
-				gpch->chip.label, gpch->chip.ngpio);
 
 	if (ar7_is_titan())
 		titan_gpio_init();
-- 
1.7.9.5
