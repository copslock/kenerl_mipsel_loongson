Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2016 19:56:36 +0100 (CET)
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33477 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010083AbcAFS4SR1ZaQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jan 2016 19:56:18 +0100
Received: by mail-pf0-f177.google.com with SMTP id q63so207366605pfb.0
        for <linux-mips@linux-mips.org>; Wed, 06 Jan 2016 10:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MDugv/eQgO+NcD0TTz656IGQ0uJ3T4jC8x74VZ5Jp7s=;
        b=i0Qzubp6eBsrhujBsBUjZK3ikQa5IE2bknh83S0Ms4LzHF1RH8/cJqgf8w2wApeIC6
         GjZqvoXXQsVjRR0z4N/UTonxP8oLLxcIImqKm2IkyG6CzuojT0r5n86ipkcZJHzUTupc
         kvYWtKLji2AM+R3pHA+mkMzdsau+vRG9VVOvIXBGOPfP53t/GoO3qndgUT93BgREWelU
         +j0hWX6M/UHRfX2hXdxOILMjNDfAThUon5arqbcugt9mUtIYf3e82TaLQXdtzzJ+fhMS
         vTgRernGVDRyBVKGvUdIn0bu3efUa+WayanqkYAIeGF5j4FTIYrqt49u0V2urdxoS/RK
         OqzQ==
X-Received: by 10.98.13.86 with SMTP id v83mr125946772pfi.127.1452106572388;
        Wed, 06 Jan 2016 10:56:12 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id u67sm137196864pfa.84.2016.01.06.10.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jan 2016 10:56:11 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     linux-mips@linux-mips.org, gregory.0xf0@gmail.com,
        jaedon.shin@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/3] gpio: brcmstb: have driver register during subsys_initcall()
Date:   Wed,  6 Jan 2016 10:55:21 -0800
Message-Id: <1452106523-11556-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com>
References: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Jim Quinlan <jim2101024@gmail.com>

Because regulators are started with subsys_initcall(), and gpio references may
be contained in the regulators, it makes sense to start the brcmstb-gpio's with
a subsys_initcall(). The order within the drivers/Makefile ensures that the
gpio initialization happens prior to the regulator's initialization.

We need to unroll module_platform_driver() now to allow this and have custom
exit and init module functions to control the initialization level.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index dc3f0395693b..3618b9fd0cba 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -535,7 +535,18 @@ static struct platform_driver brcmstb_gpio_driver = {
 	.probe = brcmstb_gpio_probe,
 	.remove = brcmstb_gpio_remove,
 };
-module_platform_driver(brcmstb_gpio_driver);
+
+static int __init brcmstb_gpio_init(void)
+{
+	return platform_driver_register(&brcmstb_gpio_driver);
+}
+subsys_initcall(brcmstb_gpio_init);
+
+static void __exit brcmstb_gpio_exit(void)
+{
+	platform_driver_unregister(&brcmstb_gpio_driver);
+}
+module_exit(brcmstb_gpio_exit);
 
 MODULE_AUTHOR("Gregory Fong");
 MODULE_DESCRIPTION("Driver for Broadcom BRCMSTB SoC UPG GPIO");
-- 
2.1.0
