Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 16:47:55 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.135]:57030 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011838AbcBOPryekeDN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 16:47:54 +0100
Received: from wuerfel.lan. ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue002) with ESMTPA (Nemesis) id 0M6JFz-1ZlCjn0IN1-00yRTc; Mon, 15 Feb
 2016 16:47:16 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH 1/4] gpio: remove broken irq_to_gpio() interface
Date:   Mon, 15 Feb 2016 16:46:28 +0100
Message-Id: <1455551208-2825510-2-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455551208-2825510-1-git-send-email-arnd@arndb.de>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1455551208-2825510-1-git-send-email-arnd@arndb.de>
X-Provags-ID: V03:K0:4yiXAIC+kozwy3fbtOfqbIRVx92K/Fo3wKpdLS39Mwd4ZimsG8m
 eUGwOXDKe7/UcxFsQIrVI9TG4UlFc9DCNQRYL5G6RG+2qlU2Qqn9cN1P5EWvaDZ00H7fd5C
 uE+6r1X7dJBgPVsxwTaVeeELvNZT51Yy5v3ff6Op034jvOZR8pZ5DgPrpUG/HOu4zVSeHcc
 Cvcv0M5ynfpTromRTjGOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RdfwHsebjOY=:LrJBybT6dOAQVNHYTgjvx7
 cexgeaRO7ycx5jeBP3255tWAZJF3eyy3EBe0ilGeHt8wc9EnIm4+7EIiWgi8u9FKFhmnDi/Kf
 YHD0E07ye4wirH2wbJyviDR1JeSMte41Hn4YYNYqKgIwJRbI699lMWmPieJy9Cqy87KZt6oBU
 nw+kMXkCvB3dRRzvZM9PycmLqHRgTJAhtK+O0Q8XHfb3OeN7+UsADaXZhakYuw4iEa1v2hyVm
 Hfw26GBKfzUzteG6Szpbv0WXZ8JXhYlkFQ4qLBZpYWAsBZXkmS30htyCMePABGt1LPchHt50h
 mb/5L3R1+wztT8xxIEM/B19dnyRM/hNkGBNknKHSIeoNxpwzpA/sRHpEtpOi9JCeao1IL1WFh
 Zhx5DRivnKF2713FVm8N0PcFbQTD2AZcEXK38W4SjLbINhntDXbC7RnFM5pKgeMryjQLkEcGF
 iGEHD9xBQr1FqJyZl93lt0ITwCTrDndblIs2MLTl+6rzTFWiftKNTzELGHFBeqHBGQXUaJ6no
 wpcozjeQ6rrO0r1I0ZrWH4YDGXYmHX2w8Fy5jecORs0UXbjlUcLEmpXU2nNEJAWf14NEYNYJH
 a9mna60TulXCQzgVcgZ/fkGlzMp8n4aokirFKn22y80wogVrUk3Pw8YQ2KP0Z6rPCZ50GVTAJ
 hrtTNBcpYAJnWi22ghnYB7dAS9m145lYLdgr5I2tp5iuWR9a7B2sA3dSAgyQEV3BxWrg=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52062
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

Apparently one new user has shown up in arch/mips, so this patch
moves the broken definition to where it is used, ensuring that
we get new users but not changing the current behavior on jz4740.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/jz4740/gpio.c |  7 +++++++
 include/linux/gpio.h    | 12 ------------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 8c6d76c9b2d6..e9bb43714892 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/compiler.h>
 
 #include <linux/io.h>
 #include <linux/gpio.h>
@@ -270,6 +271,12 @@ uint32_t jz_gpio_port_get_value(int port, uint32_t mask)
 }
 EXPORT_SYMBOL(jz_gpio_port_get_value);
 
+static inline __deprecated int irq_to_gpio(unsigned int irq)
+{
+	/* this has clearly not worked for a long time */
+	return -EINVAL;
+}
+
 #define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)
 
 static void jz_gpio_check_trigger_both(struct jz_gpio_chip *chip, unsigned int irq)
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
