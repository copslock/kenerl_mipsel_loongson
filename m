Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2016 17:08:01 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36312 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991986AbcIUPHykC0j1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Sep 2016 17:07:54 +0200
Received: by mail-pf0-f193.google.com with SMTP id n24so2502328pfb.3
        for <linux-mips@linux-mips.org>; Wed, 21 Sep 2016 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvlDu0xhsBNoJAogSvHysygdb4WT4kVYDNOaRDICK9M=;
        b=I6En5XdnTWCMr55AXtRrCZ6idiNvXEKhkGJP2AiT/L65bMmEPpn2Gmv+Lc3yIEC0HR
         zm+1btVkNb/hLw2vSTDLnPAbl6SyW2zVjVoRMtjjAD7DmPJkYe0sDxI0W565uZcdcSPG
         gAA7tobvxsPcLOdJL4GriTdDcVpo8SVbUFbpQo7fpjfDKLDXbf0fgc+YLXqSNXBiBY7o
         1UFT8WOGVhcT27Hfr6ioiXY/ZSLV4cV2YFBTWJvzKY2yG1AtwtKkPWnOWz0Hog875Euv
         8wZjCgwzWsZh+EMz/Y+h3jWRM19GjGG6NymxSOp36FbEg8TMBs6kEkTffOrVeVaFqEU8
         pJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvlDu0xhsBNoJAogSvHysygdb4WT4kVYDNOaRDICK9M=;
        b=kjSQi6r87IXQnJ4OdSu6/dhsgsh5GWeTV4Pc6V8tiki+yxG0H5uG0mkawWqlS3KIeY
         dSVsqvdc5NmIMrPfsj90pkyNkqKBGao7FIIUAb4dcOtw1rFfrltbwGjBvZH35Yd/4xAj
         s+xnwPA9AKBHauXvuwzt9CR5zzZQs0rtNybSfytzHotT6m/A4ViCUdqf70zzyGEOldHz
         OmWK6GkiGSxPWYzBo0DVJpnbzar+3LjynoWz/qvBmodW2amkJVNVg5G6lgDBmkuVsfRv
         TcPS4OMG5jZELKsxcjAx6/iVPVJq+tC0sxx4W0//BoWNf1X2KdMhTqvAy8zIdbB/6Hre
         8Dxw==
X-Gm-Message-State: AE9vXwPtQZ3h5x46N+LtJ4V1U1dgPUZydhIhLo9szvxyJzjoYiHhDpzE89XmpUDT9NOH6g==
X-Received: by 10.98.102.81 with SMTP id a78mr39786658pfc.28.1474470468804;
        Wed, 21 Sep 2016 08:07:48 -0700 (PDT)
Received: from 192.168.0.37 (ec2-52-192-197-227.ap-northeast-1.compute.amazonaws.com. [52.192.197.227])
        by smtp.gmail.com with ESMTPSA id c64sm87422503pfa.51.2016.09.21.08.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 08:07:48 -0700 (PDT)
From:   Wei Yongjun <weiyj.lk@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-mips@linux-mips.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH -next] gpio: loongson1: remove redundant return value check of platform_get_resource()
Date:   Wed, 21 Sep 2016 15:07:39 +0000
Message-Id: <1474470459-2124-1-git-send-email-weiyj.lk@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <weiyj.lk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyj.lk@gmail.com
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

From: Wei Yongjun <weiyongjun1@huawei.com>

Remove unneeded error handling on the result of a call
to platform_get_resource() when the value is passed to
devm_ioremap_resource().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpio/gpio-loongson1.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index ad0a595..72b6403 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -56,11 +56,6 @@ static int ls1x_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "failed to get I/O memory\n");
-		return -EINVAL;
-	}
-
 	gpio_reg_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(gpio_reg_base))
 		return PTR_ERR(gpio_reg_base);
