Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2017 21:30:25 +0200 (CEST)
Received: from mout.web.de ([217.72.192.78]:55478 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994854AbdERTaQnTNco (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 May 2017 21:30:16 +0200
Received: from guitar.localdomain ([94.134.203.212]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgYOH-1dnT2y2gXV-00nyKj; Thu, 18
 May 2017 21:30:09 +0200
Date:   Thu, 18 May 2017 21:30:03 +0200
From:   Mirko Parthey <mirko.parthey@web.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: BCM47XX: Fix LED inversion for WRT54GSv1
Message-ID: <20170518193002.GA8186@guitar.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:AllylyBu4QVMv11DA93IzwZO0szdQaqgJEDtla1pwptAzVLbUki
 a/kw5kewUREJ8VppwJIH3ssFNFKrKVxI+N/v/oXEcJqRyfd4ni7Xnthn0xN+9NykwThg+HG
 o7/AJfUbozkJSWcNK4/YqVSivg0cqe8Bk8oAWorbx3LRrXGZONKJZNru80Qa0a1MvKwQkEz
 /pwu/3x4U9y4QKIYMlQYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:thUB2A5t9Ho=:26CkgmaZOH8xCp3k5SkmQy
 IXYI1oMXHpqfd6QwgJ3Ixwddy2tenEQ2hSSjHB2K6EGPtFuCPEmkiveSrVPbqHL1cqpojttGL
 nL8btpGkJ9AGUiCgrEPc9MIPkMU8M+j/5ucYvFv3jeMIwQWlI1h3U8kUIuIpKeBCTQwgq9JNx
 lFNoPuCPBEFBxwzSdckuFytjy1h5pfAVEu8VRWXpEdkL8u7h4WzPcPcfnBF2RPyuVLQQ6PW7E
 mtJvL8y51kUYrNv3PjWq0AmJ8O8r9SdZKlRuQkgACOFbDq4kACZFd5j5pYvQHRMB1/tOhSvzW
 WryBke5ZGrBPequoGE2ye8KUFug9SAFIHHgSkAvKxNZqhkFf1y4dZoAh20gSFuVkFz813TPzj
 NjqaK9muHpdWmxl94CwqBEZLQgNxwQ5/pZgD/sW3Ov/IEjqwEHRUpKrMmEYpcZGA2L5wEu6D4
 KCPa/6k7Bs4YKfNARGMpvpGZO9ifZhwtrMTt5ZUvTZOzE3fmyYr2z+LFf4t9uPv5G7/EXNUKY
 YEYoSb/QBbXjetS661zMMueFltoUzhN42R2+ppiDo6D2WHQWkVhn9z9bEtwOEaCfkyq8wQOYt
 ysW76RnLUKtq6eDSORVIU9tNFxTmVy2jkClDlHyMzm1wLRE6TjmqjnRP28k5vYaN2GiyulNPz
 xFtW+5g25XCklINurUtSjv4lzzHAE/u7efTgFRiEPu1VxMwQPO6myjBWd9Bwe5cQMFLy+Dz8j
 7T72US6dC708KZJzjneN+Y1Y0RTP7rN7v+9dXVtpZyOUoN+hoUgEl9ctesU=
Return-Path: <mirko.parthey@web.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57901
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

Signed-off-by: Mirko Parthey <mirko.parthey@web.de>
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
