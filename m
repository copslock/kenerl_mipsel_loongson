Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2016 14:05:28 +0100 (CET)
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33882 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007490AbcCRNF1F6UKG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2016 14:05:27 +0100
Received: by mail-pf0-f169.google.com with SMTP id x3so167499757pfb.1
        for <linux-mips@linux-mips.org>; Fri, 18 Mar 2016 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=e2C3WNHVaQlgqTzkFVcjgu06SA57XXJfyGK3YU6hxw8=;
        b=L+1OMIsM7bh5QTooAWZM2cEKkm+hMiKnaYbDXcZyCNDtafDtdHtpJ9cT9wYY2BU+gL
         MUJ7fO7qWQ4UugAfDXOJeBCE8aES35olBJYHsMmjhe2Bks+juqLX3MHVSv5ZJsCGUvNp
         +ZMQmPUzT7E/P3eqpFlzXa/e7QpVKU7LB5UGOdbJkj2h3/qhAD1b9O1zdRroGINxjkam
         JL8uP6kbMctr1Us91y2ihFncY/rltmt8iKucCHF+jne+9VuaYaO+/hs3Hrj4Vz0DIi8V
         MmR4icw5JqixkiOhqVdfcGnMNjolinUHAqG8g8XoiTnFSNliWZKp0MqT3oIZSDMYzsSt
         +n3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=e2C3WNHVaQlgqTzkFVcjgu06SA57XXJfyGK3YU6hxw8=;
        b=GppN6Gb5y0Qbq2f5KuSlNefruOIrmaqgcioNEzoh4rQMPUTQXJ1sd4XI7KxXXM2LKl
         WmLbcZgUxbTWJtJ+ckLrY7gB0DNbOBPsS2Io2lVh23DGRaX/3ynijge65L9Kb3mChhwZ
         4Lf2HeFZOVs0suR3TVuc+oH27ZeoR73AKYT+Lyq2bzXzKArHFfPcc5tyXjrySjt0jOgR
         FMSGeh3S/NTJhxR/1BUbXOvw7tdbBSNAtDBitr4/gYKbhx1kvm3B9Y0no/E/A1ATsce4
         FRJFkAnZcrRj2aKqjN17kNchuJGV0woAA16+R+cnYxOc20Qz5OdsxAmYz0wgQbuQwPn6
         W59w==
X-Gm-Message-State: AD7BkJJ/ujWLgG1kq5e5HD1mKAZSP6Vn1g64AxD6hMKIONO76IygAjEUkRhmkogem6Cw0w==
X-Received: by 10.98.73.88 with SMTP id w85mr23812611pfa.82.1458306321094;
        Fri, 18 Mar 2016 06:05:21 -0700 (PDT)
Received: from phoenix (218-164-100-194.dynamic.hinet.net. [218.164.100.194])
        by smtp.gmail.com with ESMTPSA id n11sm21010220pfb.74.2016.03.18.06.05.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 06:05:20 -0700 (PDT)
Message-ID: <1458306316.17098.0.camel@ingics.com>
Subject: [PATCH 1/2] gpio: octeon: Convert to use devm_ioremap_resource
From:   Axel Lin <axel.lin@ingics.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Daney <david.daney@cavium.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org
Date:   Fri, 18 Mar 2016 21:05:16 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <axel.lin@ingics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: axel.lin@ingics.com
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

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/gpio/gpio-octeon.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
index 47aead1..9373d4e 100644
--- a/drivers/gpio/gpio-octeon.c
+++ b/drivers/gpio/gpio-octeon.c
@@ -83,6 +83,7 @@ static int octeon_gpio_probe(struct platform_device *pdev)
 	struct octeon_gpio *gpio;
 	struct gpio_chip *chip;
 	struct resource *res_mem;
+	void __iomem *reg_base;
 	int err = 0;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
@@ -91,21 +92,11 @@ static int octeon_gpio_probe(struct platform_device *pdev)
 	chip = &gpio->chip;
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res_mem == NULL) {
-		dev_err(&pdev->dev, "found no memory resource\n");
-		err = -ENXIO;
-		goto out;
-	}
-	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
-					resource_size(res_mem),
-				     res_mem->name)) {
-		dev_err(&pdev->dev, "request_mem_region failed\n");
-		err = -ENXIO;
-		goto out;
-	}
-	gpio->register_base = (u64)devm_ioremap(&pdev->dev, res_mem->start,
-						resource_size(res_mem));
+	reg_base = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(reg_base))
+		return PTR_ERR(reg_base);
 
+	gpio->register_base = (u64)reg_base;
 	pdev->dev.platform_data = chip;
 	chip->label = "octeon-gpio";
 	chip->parent = &pdev->dev;
@@ -119,11 +110,10 @@ static int octeon_gpio_probe(struct platform_device *pdev)
 	chip->set = octeon_gpio_set;
 	err = devm_gpiochip_add_data(&pdev->dev, chip, gpio);
 	if (err)
-		goto out;
+		return err;
 
 	dev_info(&pdev->dev, "OCTEON GPIO driver probed.\n");
-out:
-	return err;
+	return 0;
 }
 
 static struct of_device_id octeon_gpio_match[] = {
-- 
2.1.4
