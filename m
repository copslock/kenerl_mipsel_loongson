Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:34:35 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36884 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903685Ab2BQKdS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:18 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/6] MIPS: lantiq: use devm_request_gpio inside falcon gpio driver
Date:   Fri, 17 Feb 2012 11:32:48 +0100
Message-Id: <1329474771-20874-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474771-20874-1-git-send-email-blogic@openwrt.org>
References: <1329474771-20874-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Start using the devm_request_gpio() api inside our falcon gpio_request wrapper.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/falcon/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/falcon/gpio.c b/arch/mips/lantiq/falcon/gpio.c
index 3eebd51..b7611d7 100644
--- a/arch/mips/lantiq/falcon/gpio.c
+++ b/arch/mips/lantiq/falcon/gpio.c
@@ -97,7 +97,7 @@ int ltq_gpio_mux_set(unsigned int pin, unsigned int mux)
 }
 EXPORT_SYMBOL(ltq_gpio_mux_set);
 
-int ltq_gpio_request(unsigned int pin, unsigned int mux,
+int ltq_gpio_request(struct device *dev, unsigned int pin, unsigned int mux,
 			unsigned int dir, const char *name)
 {
 	int port = pin / 100;
@@ -106,7 +106,7 @@ int ltq_gpio_request(unsigned int pin, unsigned int mux,
 	if (offset >= PINS_PER_PORT || port >= MAX_PORTS)
 		return -EINVAL;
 
-	if (gpio_request(pin, name)) {
+	if (devm_gpio_request(dev, pin, name)) {
 		pr_err("failed to setup lantiq gpio: %s\n", name);
 		return -EBUSY;
 	}
-- 
1.7.7.1
