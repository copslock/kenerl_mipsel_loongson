Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 11:21:23 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990825AbdK1KVPzA0Dr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 11:21:15 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 888ABAEF;
        Tue, 28 Nov 2017 10:21:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mirko Parthey <mirko.parthey@web.de>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 3.18 11/67] MIPS: BCM47XX: Fix LED inversion for WRT54GSv1
Date:   Tue, 28 Nov 2017 11:19:10 +0100
Message-Id: <20171128100421.776519586@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171128100420.274075224@linuxfoundation.org>
References: <20171128100420.274075224@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61114
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mirko Parthey <mirko.parthey@web.de>

commit 56a46acf62af5ba44fca2f3f1c7c25a2d5385b19 upstream.

The WLAN LED on the Linksys WRT54GSv1 is active low, but the software
treats it as active high. Fix the inverted logic.

Fixes: 7bb26b169116 ("MIPS: BCM47xx: Fix LEDs on WRT54GS V1.0")
Signed-off-by: Mirko Parthey <mirko.parthey@web.de>
Looks-ok-by: Rafał Miłecki <zajec5@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16071/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/bcm47xx/leds.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -323,7 +323,7 @@ bcm47xx_leds_linksys_wrt54g3gv2[] __init
 /* Verified on: WRT54GS V1.0 */
 static const struct gpio_led
 bcm47xx_leds_linksys_wrt54g_type_0101[] __initconst = {
-	BCM47XX_GPIO_LED(0, "green", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(0, "green", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
 	BCM47XX_GPIO_LED(1, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
 	BCM47XX_GPIO_LED(7, "green", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
