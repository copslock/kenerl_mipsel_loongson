Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2016 14:06:17 +0100 (CET)
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36843 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007490AbcCRNGQUNx6G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2016 14:06:16 +0100
Received: by mail-pf0-f175.google.com with SMTP id u190so167932178pfb.3
        for <linux-mips@linux-mips.org>; Fri, 18 Mar 2016 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5vw0h3RmkvaFvs6RQqoBott3WMhTFAPQAnLDPQV/C8=;
        b=kSDELDpiaVsyNMXy9I7GYQhW7P5RS7bff5O4jQwn/osFDnueUg5+n/FoBSkjr7nid7
         FVxJ6bhcjaxfjjFiJiFfPCKMSiFmZMVjLQvty/CsqOcv/T/chEQDBcEfyWCsElY6MHxM
         7G2l7XOJalKQ60O/4b1HTG9DAF92+6aGsTUDlGLCQ/nu1gNvmr59c6swJg/mPYRDEnTP
         pHLCuYoG4k9G1q4hQr8RhosOjOtaAOLYQBR7PMX8I8PdEwG6Tl0+TM7K5/fVNOSKVBDb
         Nh6XPC75Y6lXb76J0dQ3qZZLabSrdhJjqTh2P7Uvk1/rKJiqkswxTe2ufPfNnJfsqTs1
         HIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5vw0h3RmkvaFvs6RQqoBott3WMhTFAPQAnLDPQV/C8=;
        b=UDkyd6gaNdyGf80OZFCk4FDJmDsKB2hBULbe7xLNz2CD296ybOePQRjI3J2+V1qigf
         XtGSOUM39uhALo1w8QPioGrUmzEkdPGJ1NFQuH31EQs449pkkCuPfb05JxGCipWkcc+9
         2VFM5dP1au3s7l8+8sCES3xoC+M9zLGsuGQKzyXry4egfJgVsyeOz+JvAJgMe2nb42oG
         +vFxpytTmVB7R3w/Y6Qa4dD0l2LymTwQEwnBM/8FO25DVAQ9HzcxBji69gjCD+tngMX3
         ifIMFJPbQx1TP5sIBpOM3XFKEXtIdo0bqS8YWEItGLyikCQv7hNJbj/WdEnb2eEbDxr8
         DCVQ==
X-Gm-Message-State: AD7BkJIZ4THzG72kS7lCadljb2CisduU3ge+zcPRlgBQOgOPVyLcsUuzGaBsTTieaMCu1g==
X-Received: by 10.98.17.78 with SMTP id z75mr23915179pfi.40.1458306370657;
        Fri, 18 Mar 2016 06:06:10 -0700 (PDT)
Received: from phoenix (218-164-100-194.dynamic.hinet.net. [218.164.100.194])
        by smtp.gmail.com with ESMTPSA id o71sm21015927pfj.68.2016.03.18.06.06.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 06:06:09 -0700 (PDT)
Message-ID: <1458306366.17098.1.camel@ingics.com>
Subject: [PATCH 2/2] gpio: octeon: Constify octeon_gpio_match table
From:   Axel Lin <axel.lin@ingics.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Daney <david.daney@cavium.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org
Date:   Fri, 18 Mar 2016 21:06:06 +0800
In-Reply-To: <1458306316.17098.0.camel@ingics.com>
References: <1458306316.17098.0.camel@ingics.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <axel.lin@ingics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52659
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
 drivers/gpio/gpio-octeon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
index 9373d4e..96a8a8c 100644
--- a/drivers/gpio/gpio-octeon.c
+++ b/drivers/gpio/gpio-octeon.c
@@ -116,7 +116,7 @@ static int octeon_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id octeon_gpio_match[] = {
+static const struct of_device_id octeon_gpio_match[] = {
 	{
 		.compatible = "cavium,octeon-3860-gpio",
 	},
-- 
2.1.4
