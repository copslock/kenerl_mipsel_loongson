Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jan 2014 00:08:17 +0100 (CET)
Received: from mail-we0-f173.google.com ([74.125.82.173]:65382 "EHLO
        mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825752AbaAWXIOeFPqQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jan 2014 00:08:14 +0100
Received: by mail-we0-f173.google.com with SMTP id t60so1924664wes.4
        for <linux-mips@linux-mips.org>; Thu, 23 Jan 2014 15:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fkR2ea5qculN6qiVobabWavefOaCadEiJfFiN8C+PI0=;
        b=DUSB6ZAeejRWJYDfxZ3HiKlJqmFANpazEEyqydHvKrKywMaDcAkYvn22EAtPQCpQrf
         smxGpG7I7x+fNynVouhYtOP6ykUgS3GjBJqJIIjfv5tgF335ZGBKIwoyosnvIw2nA31O
         TO2vpr17NueINTuodZBzVcw8doOYRXjHWL5Uyw8/ZGn77NBVm1W8wuvD3oxEPzBidP4+
         gyiQ6UnFAgTa8JDmrr4NHQzsvU05mi2mJkfZibsQzM4dkrEZLX7e9hRZ3IfAxPFo5tzL
         qkn8iC6HD0/9cG8/q6MW1z/fp71ff8Mzc7yKyjyMIe5uPK2xRFFCuSRPIpZPor8bpD09
         B41g==
X-Gm-Message-State: ALoCoQn3kRse0AS9FSDOXngSMCMOmWWeO40dDFwvuka4taGWH7U4URxrsSJ/nVANzc0l+vGQCMd2
X-Received: by 10.180.198.52 with SMTP id iz20mr865435wic.59.1390518488833;
        Thu, 23 Jan 2014 15:08:08 -0800 (PST)
Received: from localhost.localdomain ([85.235.11.236])
        by mx.google.com with ESMTPSA id u6sm986587wif.6.2014.01.23.15.08.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2014 15:08:08 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] gpio: vr41xx: mark GPIO lines used for IRQ
Date:   Fri, 24 Jan 2014 00:07:57 +0100
Message-Id: <1390518477-10020-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 1.8.4.2
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
the gpiolib so we can keep track of the usage centrally.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
It would be much appreciated if one of the MIPS people could
test this patch, thanks in advance. (I did compile-test it
with a MIPS cross compiler.)
---
 drivers/gpio/gpio-vr41xx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index b983bc079102..c6728cee0cfd 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -80,6 +80,7 @@ static DEFINE_SPINLOCK(giu_lock);
 static unsigned long giu_flags;
 
 static void __iomem *giu_base;
+static struct gpio_chip vr41xx_gpio_chip;
 
 #define giu_read(offset)		readw(giu_base + (offset))
 #define giu_write(offset, value)	writew((value), giu_base + (offset))
@@ -134,12 +135,31 @@ static void unmask_giuint_low(struct irq_data *d)
 	giu_set(GIUINTENL, 1 << GPIO_PIN_OF_IRQ(d->irq));
 }
 
+static unsigned int startup_giuint(struct irq_data *data)
+{
+	if (gpio_lock_as_irq(&vr41xx_gpio_chip, data->hwirq))
+		dev_err(vr41xx_gpio_chip.dev,
+			"unable to lock HW IRQ %lu for IRQ\n",
+			data->hwirq);
+	/* Satisfy the .enable semantics by unmasking the line */
+	unmask_giuint_low(data);
+	return 0;
+}
+
+static void shutdown_giuint(struct irq_data *data)
+{
+	mask_giuint_low(data);
+	gpio_unlock_as_irq(&vr41xx_gpio_chip, data->hwirq);
+}
+
 static struct irq_chip giuint_low_irq_chip = {
 	.name		= "GIUINTL",
 	.irq_ack	= ack_giuint_low,
 	.irq_mask	= mask_giuint_low,
 	.irq_mask_ack	= mask_ack_giuint_low,
 	.irq_unmask	= unmask_giuint_low,
+	.irq_startup	= startup_giuint,
+	.irq_shutdown	= shutdown_giuint,
 };
 
 static void ack_giuint_high(struct irq_data *d)
-- 
1.8.4.2
