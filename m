Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jun 2017 17:49:45 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37498 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993997AbdFAPpFO0Ce- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jun 2017 17:45:05 +0200
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSHX-00059Z-BZ; Thu, 01 Jun 2017 16:45:03 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dGSHV-0007rP-Q9; Thu, 01 Jun 2017 16:45:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "=?UTF-8?Q?Rafa=C5=82=20?= =?UTF-8?Q?Mi=C5=82ecki?=" 
        <rafal@milecki.pl>, "Mirko Parthey" <mirko.parthey@web.de>,
        "Hauke Mehrtens" <hauke@hauke-m.de>,
        "James Hogan" <james.hogan@imgtec.com>
Date:   Thu, 01 Jun 2017 16:43:16 +0100
Message-ID: <lsq.1496331796.275771157@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 136/212] MIPS: BCM47XX: Fix button inversion for Asus
 WL-500W
In-Reply-To: <lsq.1496331794.574686034@decadent.org.uk>
X-SA-Exim-Connect-IP: 82.70.136.246
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.44-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mirko Parthey <mirko.parthey@web.de>

commit bdfdaf1a016ef09cb941f2edad485a713510b8d5 upstream.

The Asus WL-500W buttons are active high, but the software treats them
as active low. Fix the inverted logic.

Fixes: 3be972556fa1 ("MIPS: BCM47XX: Import buttons database from OpenWrt")
Signed-off-by: Mirko Parthey <mirko.parthey@web.de>
Acked-by: Rafał Miłecki <rafal@milecki.pl>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15295/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/bcm47xx/buttons.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -17,6 +17,12 @@
 		.active_low	= 1,					\
 	}
 
+#define BCM47XX_GPIO_KEY_H(_gpio, _code)				\
+	{								\
+		.code		= _code,				\
+		.gpio		= _gpio,				\
+	}
+
 /* Asus */
 
 static const struct gpio_keys_button
@@ -74,8 +80,8 @@ bcm47xx_buttons_asus_wl500gpv2[] __initc
 
 static const struct gpio_keys_button
 bcm47xx_buttons_asus_wl500w[] __initconst = {
-	BCM47XX_GPIO_KEY(6, KEY_RESTART),
-	BCM47XX_GPIO_KEY(7, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY_H(6, KEY_RESTART),
+	BCM47XX_GPIO_KEY_H(7, KEY_WPS_BUTTON),
 };
 
 static const struct gpio_keys_button
