Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 10:18:22 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38376 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993915AbdCJJRf1BDkm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2017 10:17:35 +0100
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25045360;
        Fri, 10 Mar 2017 09:17:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mirko Parthey <mirko.parthey@web.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 4.9 003/153] MIPS: BCM47XX: Fix button inversion for Asus WL-500W
Date:   Fri, 10 Mar 2017 10:07:16 +0100
Message-Id: <20170310083947.313094476@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170310083947.108106897@linuxfoundation.org>
References: <20170310083947.108106897@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/bcm47xx/buttons.c |   10 ++++++++--
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
@@ -79,8 +85,8 @@ bcm47xx_buttons_asus_wl500gpv2[] __initc
 
 static const struct gpio_keys_button
 bcm47xx_buttons_asus_wl500w[] __initconst = {
-	BCM47XX_GPIO_KEY(6, KEY_RESTART),
-	BCM47XX_GPIO_KEY(7, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY_H(6, KEY_RESTART),
+	BCM47XX_GPIO_KEY_H(7, KEY_WPS_BUTTON),
 };
 
 static const struct gpio_keys_button
