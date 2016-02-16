Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 16:41:59 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:49474 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011844AbcBPPl57SFWn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 16:41:57 +0100
Received: from wuerfel.lan. ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPA (Nemesis) id 0MCucZ-1adi5s0jxb-009gKj; Tue, 16 Feb
 2016 16:41:27 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v2 3/5] gpio: ks8695: remove irq_to_gpio function
Date:   Tue, 16 Feb 2016 16:40:36 +0100
Message-Id: <1455637261-2920972-3-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455637261-2920972-1-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
X-Provags-ID: V03:K0:RHyJA5NbnimJeXzJNmLJgrFVR60PmG362MbQhRaRPn/nu/fG3MX
 KHpQScypIVaZ28e7W/JHnnk5W5DOZE7gZEB8mYOC74D1i4DDk+pYkWurDKbur8ADq8gJHGK
 72v1GZdttf12WglQpFIES66f88OSeDnTQk3YquP0ktqNMqxq0jIqKSnCk/nVE5IHUn1M4eK
 p/eIUBg2Gwb0f0MXh72Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0h6encW2r6U=:V1DNevHH5svF0bIqNxdFlH
 EXNEjB2tFiAzyIN/OuEuZpPnDfJX4iBDLzJiGvPwLKpt+j2AiMWmN/ohLefYFpyjwhoQbRaav
 043N1XMNBwPO2IuOjnDx0r2J91XiGrHjc2q16t4yl6LhUrOgBd7omqFT4Fg/fu8fVBow7w+oO
 uxCT9OPAuTZun2QxjD86HDXmb+yaIJUTePwysmPM3p6KIVv30EItiJDD62O7Ojz4vNrLWi0lf
 dCyPx5o/xHJ0zplgbT6SCNI/O07/8MkeiKBAk/W54h6n/HM3q0KcY285QLV5ykfZ/2km1oPBr
 ON/6DnUnB1NEB3i5VwzuxQn+mDD2rqoqtP+FNMIGKrl5qMcZ7t08ZDS662q4GXYubQwGXdrL8
 nQs1zB5LGYKKnf56BFQGwPMDAoXPNDEFVRuhBX2b54qYtmanx1bRn1NDzOesmSdJlAj9Jf59P
 GX+l+ohP6Anw++FG4jymci0aqVuRbxZ5sEqbXeKyStqFsmLYDI4/B7BJXH/N0TvqvBMttESWD
 6/RkeqxZZfN4d/NGR808hnIVwUI0Y+4qSBojpUzTVALC+azSOhtJK/Od03Qt1c0ks2FktH1Sp
 ZeGnoRb2F8PEQYShQjoZ1clM2CUbENeFjEJQ6/S7/PZpDBeNAmtLYsmFq6UEZ0fG0es1m/eRD
 XiE5H+BnbiyJt9o2Oyzj1xNkbrIhXJulyM4ZmZghrFmttoVKjRFmrPhB3sVUzwTNZ100=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

The ks8695 gpio driver has its own copy of the irq_to_gpio()
function. This is completely unused in the mainline kernel
after we converted all remaining users several years ago,
so we can remove the definition as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-ks8695.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpio/gpio-ks8695.c b/drivers/gpio/gpio-ks8695.c
index 9f86ed9c753b..179723d02f55 100644
--- a/drivers/gpio/gpio-ks8695.c
+++ b/drivers/gpio/gpio-ks8695.c
@@ -205,18 +205,6 @@ static int ks8695_gpio_to_irq(struct gpio_chip *gc, unsigned int pin)
 	return gpio_irq[pin];
 }
 
-/*
- * Map IRQ number to GPIO line.
- */
-int irq_to_gpio(unsigned int irq)
-{
-	if ((irq < KS8695_IRQ_EXTERN0) || (irq > KS8695_IRQ_EXTERN3))
-		return -EINVAL;
-
-	return (irq - KS8695_IRQ_EXTERN0);
-}
-EXPORT_SYMBOL(irq_to_gpio);
-
 /* GPIOLIB interface */
 
 static struct gpio_chip ks8695_gpio_chip = {
-- 
2.7.0
