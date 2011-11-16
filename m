Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 14:33:05 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47436 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903822Ab1KPN3O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 14:29:14 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Matti Laakso <malaakso@elisanet.fi>
Subject: [PATCH V2 4/6] MIPS: lantiq: fix pull gpio up resistors usage
Date:   Wed, 16 Nov 2011 15:28:40 +0100
Message-Id: <1321453722-2689-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1321453722-2689-1-git-send-email-blogic@openwrt.org>
References: <1321453722-2689-1-git-send-email-blogic@openwrt.org>
X-archive-position: 31667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13401

The register that enables a gpios internal pullups was not used. This patch
makes sure the pullups are activated correctly.

Signed-off-by: Matti Laakso <malaakso@elisanet.fi>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/gpio.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/xway/gpio.c b/arch/mips/lantiq/xway/gpio.c
index f204f6c..14ff7c7 100644
--- a/arch/mips/lantiq/xway/gpio.c
+++ b/arch/mips/lantiq/xway/gpio.c
@@ -21,6 +21,8 @@
 #define LTQ_GPIO_ALTSEL0	0x0C
 #define LTQ_GPIO_ALTSEL1	0x10
 #define LTQ_GPIO_OD		0x14
+#define LTQ_GPIO_PUDSEL		0x1C
+#define LTQ_GPIO_PUDEN		0x20
 
 #define PINS_PER_PORT		16
 #define MAX_PORTS		3
@@ -106,6 +108,8 @@ static int ltq_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 
 	ltq_gpio_clearbit(ltq_gpio->membase, LTQ_GPIO_OD, offset);
 	ltq_gpio_clearbit(ltq_gpio->membase, LTQ_GPIO_DIR, offset);
+	ltq_gpio_setbit(ltq_gpio->membase, LTQ_GPIO_PUDSEL, offset);
+	ltq_gpio_setbit(ltq_gpio->membase, LTQ_GPIO_PUDEN, offset);
 
 	return 0;
 }
@@ -117,6 +121,8 @@ static int ltq_gpio_direction_output(struct gpio_chip *chip,
 
 	ltq_gpio_setbit(ltq_gpio->membase, LTQ_GPIO_OD, offset);
 	ltq_gpio_setbit(ltq_gpio->membase, LTQ_GPIO_DIR, offset);
+	ltq_gpio_clearbit(ltq_gpio->membase, LTQ_GPIO_PUDSEL, offset);
+	ltq_gpio_clearbit(ltq_gpio->membase, LTQ_GPIO_PUDEN, offset);
 	ltq_gpio_set(chip, offset, value);
 
 	return 0;
-- 
1.7.7.1
