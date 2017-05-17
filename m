Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2017 00:14:50 +0200 (CEST)
Received: from mout.web.de ([212.227.17.12]:55183 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994848AbdEQWOkyg3n4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 May 2017 00:14:40 +0200
Received: from guitar.localdomain ([88.130.134.221]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ljrlt-1diF2O4AET-00bodU; Thu, 18
 May 2017 00:14:34 +0200
Date:   Thu, 18 May 2017 00:14:27 +0200
From:   Mirko Parthey <mirko.parthey@web.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: BCM47XX: Fix LED inversion for WRT54GSv1
Message-ID: <20170517221418.GA8379@guitar.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:9yS4ap3jwrYZoYvG1AGhb6sMAqNiU2G1fA95uT8dz4Szsm2C4Ud
 0rZH2mstgQq8MaWCs70YmWMZ59MGaUQyrUQD5FdX+F6XwEnZXdELz+gugG2nn58MwOXD0E5
 EDOPatgm9o6D90lstCXAdy4jurGyuavEJaHwLmQHbh97Dvfm2hPkXbbAyMuzTzQRzbzEDEk
 rDzHiqDfd6Eb9tDRlLaFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nn4xV/4mDz4=:rgPTuZ9vywl1BmgljUBsCs
 Q8GxiHht21EPEKXA2+SoCpe71Fc3Ct9KydMk5EfoAi405mfJl/eUWkWWptIDxkDkqDRR2yFAU
 oEjhgE3eeGHIX79DW7vVbqik8REdRFO5Uj4tPIL1Xb/UPAgbfY5CdeM3vofzIfazUDQ+yjsDV
 tIh4PcP3CNRMM/YojCFyl05kEh8qRoJIn7ewPPK9ifqtBJe8b0yw2qnQ9yoQLmTjG0B0CkSx7
 KNyKr2ZHxHvKSmsOc/WwIFxRAYbQF9lpxYWeE+906OODKinvuuF1D0rfdl4M6nphkkPRDzC0v
 lPpVdRLlF3D6gVEaytSB1hRaCJHg+iyptOfnLd1lXBB/UHZmPT/fLzWYV0xu24vQqoA0g97Sz
 MMMAw+i/hpeCMfmKh7v8lFuNfb6Mlr7wnZCu8UfzftKa3iATKEfrbDZU9EDC7ZsN2FQ+LRARO
 BHiYRx2M77Yt5ma5g+9az88nlqlRVqrP7qQ6osnq7lNJLpkYuyH0CKEMh86PZtucUhB9Ok0Yp
 mJJ90JtXC7fjN6JOGbBX8oU3Qwfuwis3G7J7w+7knXvOKEPTlFv9kdCmoVdfR5NK2CbeszWuW
 28SBp4llwp895OKOakzS7f1DAyEGroLc1kWNpTrZ99pRkhGZ8xA+R6whQBvtodCjUh41UK6Kn
 v+8Ob0OC0QZVS1Cg0yc4JjxdBL3GBpOu2zn4HfP2o2fb9QJ6IwRs/P7Qh7jsBr4/T3cp7bWsC
 ARHClrlnGxGJLNJOKXIv4txVcpzECAWkZZEFzrmjeJvZGlNi9RtLkxc+oR4=
Return-Path: <mirko.parthey@web.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mirko.parthey@web.de
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

The WLAN LED on the Linksys WRT54GSv1 is active low, but the software
treats it as active high. Fix the inverted logic.
---
 arch/mips/bcm47xx/leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index a35f1d5cde9f..08ad23c492e7 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -330,7 +330,7 @@ bcm47xx_leds_linksys_wrt54g3gv2[] __initconst = {
 /* Verified on: WRT54GS V1.0 */
 static const struct gpio_led
 bcm47xx_leds_linksys_wrt54g_type_0101[] __initconst = {
-	BCM47XX_GPIO_LED(0, "green", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(0, "green", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
 	BCM47XX_GPIO_LED(1, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
 	BCM47XX_GPIO_LED(7, "green", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
-- 
2.1.4
