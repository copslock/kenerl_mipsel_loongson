Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 23:31:52 +0100 (CET)
Received: from mout.web.de ([212.227.17.11]:58806 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992110AbdBOWbplcR9p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Feb 2017 23:31:45 +0100
Received: from guitar.localdomain ([94.134.221.77]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MORiL-1chgU92Te1-005srM; Wed, 15
 Feb 2017 23:31:36 +0100
Date:   Wed, 15 Feb 2017 23:31:30 +0100
From:   Mirko Parthey <mirko.parthey@web.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: bcm47xx: Fix button inversion for Asus WL-500W
Message-ID: <20170215223130.GA18959@guitar.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:6h9fxfcNHgR5XwVAxxoyWMIWfVjz1UgegEaogVKgLIhiuIkH3Wb
 4X/maAnhAYDlWanO1ckLK5L/lckezBp1bxVkYeKWOHBqvOWLJmyLLPeqmQG/TdNxjVjTyYE
 Faklw/BQnvFqomyGSBZIud5zlXRmVNrglc63VOhavo7f+PWoKf5ddeiEhz1APGUqo/ZA3n7
 UzVw7OPL7BV0RYkA9lmgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:olyN+Bb7ZH0=:/VAycRkFsiD/gqss0NsJD6
 9xznaqoOyjuTJbsGaXrAqAa9XsL720A9Qdb5wY37NpsGq2sIwxKTNuIjiFwts4HPkc5oKdAv1
 uyFOf8eVUsYG1fQFOdox2kU+CifS3t1vhyhpsOu+ohkjIrDfNYCVTWKDNtzJnnJPDaEvKXKU9
 wYklzjIAXZ3JPRcbUfhrKgSa4/845h93q5v6HMluEVmCv0g8uq2G2a8L5IwlSGUo1bCXTZ5XK
 FgqfOIo2A/dBWFW5FMcd5vzEmkeTatBLyYq+TH7lf3MHDLusaRTQH2ztYa2SpCt2HTGo8Pv7o
 enXiAz1QDGji7sNJG44j5OINPA1mx0p/EqcKgQ0IdxbUlef7fu3u1HuiyygSOT2cidvEZhK+J
 ehmzRqHcdUIF2UqpPxygEen2B12yu8RrdxH3hk3brZ2hI0ypwNRrxNfmQZ2sXld9B5tCzcLcY
 0ECfLOVegH899+w/I9oa3jcZd77MibSRwEoQayGLxtN62JnLMmoFQ3jMWxcLkUW/5ca7Ngshe
 uJsRfr/0pX/4paI0bVBjoU8hUmzprLgiDRibmqhs9QlJBwxQ1uwCxVYFuWb+bnT9WbdK4smUy
 98oD1Hf7sD9StvJ9b/WcndhUOD8b3jqC3Xnp3w47jihGMht5vYVnBgRnGZk7EoXDL8XM6v1+h
 vN75gV578J0caeRxSO4vO6sQJaBIuUuDXBtF6gMYFEJ+z4zADypG+iprlWey+GHJHK50w1YzK
 WRr9jQr0LNYBsP5nctybVHqbGYid91zD5wA0xYpNBAkIATNDMBIIsLSZYDg=
Return-Path: <mirko.parthey@web.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56832
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

The Asus WL-500W buttons are active high,
but the software treats them as active low.
Fix the inverted logic.

Signed-off-by: Mirko Parthey <mirko.parthey@web.de>
---
 arch/mips/bcm47xx/buttons.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 7d582275908c..8a760d801895 100644
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
@@ -79,8 +85,8 @@ bcm47xx_buttons_asus_wl500gpv2[] __initconst = {
 
 static const struct gpio_keys_button
 bcm47xx_buttons_asus_wl500w[] __initconst = {
-	BCM47XX_GPIO_KEY(6, KEY_RESTART),
-	BCM47XX_GPIO_KEY(7, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY_H(6, KEY_RESTART),
+	BCM47XX_GPIO_KEY_H(7, KEY_WPS_BUTTON),
 };
 
 static const struct gpio_keys_button
-- 
2.1.4
