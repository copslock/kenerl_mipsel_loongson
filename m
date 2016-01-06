Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2016 19:56:51 +0100 (CET)
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33483 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010086AbcAFS4TBGK8Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jan 2016 19:56:19 +0100
Received: by mail-pf0-f178.google.com with SMTP id q63so207366818pfb.0
        for <linux-mips@linux-mips.org>; Wed, 06 Jan 2016 10:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jljX2xnI9J7c3TG8ck+SDZWbULfIsrcFlljUiihFNlc=;
        b=ngLY1k2S1f/1wQZAc3l/ognRp9J1SkfdG5LVL5UVxTNP2VC72DeFvNGaZDu+b5WQ6Y
         2XA3lD0Sjk/85IkKXZ+sEufohZvQJE9TKSgtSqfLom7XylKCmXODUtzmfygqlOHxIJrp
         Uj4AR4SWoD9ZdpiIEawrMiCGM6OIDzavS+OKnG7AZh/SijdGTK7xU7FIVYhP+fXW9Tg7
         fFXdE5Q/rvmkGmt2/NESHTNW6gWdvTBAaDATQ0S+iTbfLDYrGf3gJihxffY1CqNn6pw3
         dksM85r5X2izNyOfj6mhiAyog6nFVgvmL/8nY/C81m4E9hxTBB9GjjhACL6lY0/ChyZN
         WUOg==
X-Received: by 10.98.69.73 with SMTP id s70mr143798697pfa.4.1452106573340;
        Wed, 06 Jan 2016 10:56:13 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id u67sm137196864pfa.84.2016.01.06.10.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jan 2016 10:56:12 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     linux-mips@linux-mips.org, gregory.0xf0@gmail.com,
        jaedon.shin@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/3] gpio: brcmstb: Set endian flags for big-endian MIPS
Date:   Wed,  6 Jan 2016 10:55:22 -0800
Message-Id: <1452106523-11556-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com>
References: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50945
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

Broadcom MIPS-based STB chips endianness is configured by boot strap,
which also reverses all bus endianness (i.e., big-endian CPU + big
endian bus ==> native endian I/O).

Other architectures (e.g., ARM) either do not support big endian, or
else leave I/O in little endian mode.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 3618b9fd0cba..8e8ddc76a56f 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -409,6 +409,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	int num_banks = 0;
 	int err;
 	static int gpio_base;
+	unsigned long flags = 0;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -438,6 +439,18 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	if (brcmstb_gpio_sanity_check_banks(dev, np, res))
 		return -EINVAL;
 
+	/*
+	 * MIPS endianness is configured by boot strap, which also reverses all
+	 * bus endianness (i.e., big-endian CPU + big endian bus ==> native
+	 * endian I/O).
+	 *
+	 * Other architectures (e.g., ARM) either do not support big endian, or
+	 * else leave I/O in little endian mode.
+	 */
+#if defined(CONFIG_MIPS) && defined(__BIG_ENDIAN)
+	flags = BGPIOF_BIG_ENDIAN_BYTE_ORDER;
+#endif
+
 	of_property_for_each_u32(np, "brcm,gpio-bank-widths", prop, p,
 			bank_width) {
 		struct brcmstb_gpio_bank *bank;
@@ -466,7 +479,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		err = bgpio_init(gc, dev, 4,
 				reg_base + GIO_DATA(bank->id),
 				NULL, NULL, NULL,
-				reg_base + GIO_IODIR(bank->id), 0);
+				reg_base + GIO_IODIR(bank->id), flags);
 		if (err) {
 			dev_err(dev, "bgpio_init() failed\n");
 			goto fail;
-- 
2.1.0
