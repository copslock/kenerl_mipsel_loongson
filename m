Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 16:42:16 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:54533 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012831AbcBPPl573dtn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 16:41:57 +0100
Received: from wuerfel.lan. ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPA (Nemesis) id 0Lr6Rz-1a0EYS1l3b-00eZAT; Tue, 16 Feb
 2016 16:41:23 +0100
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
Subject: [PATCH v2 2/5] gpio: remove broken irq_to_gpio() interface
Date:   Tue, 16 Feb 2016 16:40:35 +0100
Message-Id: <1455637261-2920972-2-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455637261-2920972-1-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
X-Provags-ID: V03:K0:UY7KgFRESGsZqo3RjHOskQaSayC6+nUAG4MDu3zYUjuMv/jE+l1
 ZBGa8OlIBPPw6osqfSSVXYmlftsu1ckWT7ES3RXACMjlJLws5Ac5iQaaMco2KWGX7yB+yT3
 zeVdwqMaNHeTJ75IzCtHwY14LQmPD6poRMCblKCCFrKESt9m6SalFl02oKYjrrpl2E/3gOb
 5HMBeFp5Q6k3xlQ5ZjB5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2RdMCxG5lto=:6db6buIAUFCj06FeOmvow/
 KwRcWBcK4NKaqYlYjZbhSXu+4xEX0GqN4uD89TjpM8llF8BiTTjl4LU3zD9T0vPyz1gkSchrg
 aOwK2VuiXw2ldJ6gUqb7MzQehuSwtih9XZJNZAj6y/eoOv6FyUan9ik+MRjyMmKqERPtD7rWX
 iROJn+9t0yWxtMnVmNcuesQ7M2UweUvWZDH4ezKKQmGDjGcJnyJI58WNosNemGDtkBb5eMei8
 QBzTMSxZgm3sAa8WF45ilvoX9ZtmFthiDmbbNj/NJyAOyA1H2icU8vu2OK8TenW96Z2/020IA
 p1jcYTxShVeUPyfxhj8F1UBvEHIERXFIKtn9IS/1EW2MdMcFKTbIKURuUGEfLBNoD5S7H7Scv
 2DswQL/3MPs2lqFzhrUJlXNmKTVjJ+XVCSPKHfiHtxXvEGt3i4YxLjVtl8/kSOwsnELdNqGHe
 lu86zDn+BDSyyW/SakdE/RHs9O/pa11eIJzVpI9vhfseFRnqOKshxdx6BzxR8NmJXt66nYSZ8
 XUKtYG4Hu61PopZspMSwi85xMqmeo3eGGYsaS1BevLzpk10+Drop9+w2/sZkeQOA+Ppon79os
 l5OLr8fIsTMDjaZX9wbnANbS0YyB8hdj/v0QovLtaId5z0t0QoN7P40qzVkfwYzU7yw0Yl3cd
 Q6PqOVmCTn+ErQ8ZyrdbQKv5jNPiXQoat8gcXluxnKjsiRHSjYHEPj3aLjsbRT8DPwPY=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52085
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

gpiolib has removed the irq_to_gpio() API several years ago,
but the global header still provided a non-working stub.

To prevent new users of this broken function from showing
up, let's remove the stubs as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/gpio.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index d12b5d566e4b..6fc1c9e74854 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -70,11 +70,6 @@ static inline int gpio_to_irq(unsigned int gpio)
 	return __gpio_to_irq(gpio);
 }
 
-static inline int irq_to_gpio(unsigned int irq)
-{
-	return -EINVAL;
-}
-
 #endif /* ! CONFIG_ARCH_HAVE_CUSTOM_GPIO_H */
 
 /* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
@@ -222,13 +217,6 @@ static inline void gpiochip_unlock_as_irq(struct gpio_chip *chip,
 	WARN_ON(1);
 }
 
-static inline int irq_to_gpio(unsigned irq)
-{
-	/* irq can never have been returned from gpio_to_irq() */
-	WARN_ON(1);
-	return -EINVAL;
-}
-
 static inline int
 gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 		       unsigned int gpio_offset, unsigned int pin_offset,
-- 
2.7.0
