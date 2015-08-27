Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2015 03:15:03 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33310 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007563AbbH0BPBVY3Gn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Aug 2015 03:15:01 +0200
Received: by pacti10 with SMTP id ti10so5847554pac.0
        for <linux-mips@linux-mips.org>; Wed, 26 Aug 2015 18:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=/hiqYHhTrFcZLgIzwPcW5YFomB7ohyDgKdBwWIbrOYM=;
        b=ZAb8C8kq+RCMmKCCc1y5zS7VmgNUTsRTM6oKwsy1VmQ2FEUyATKTXxoqY7p9tHAQ7A
         2ymkYLHakqPo/A3++OOlHZqtSCmDn/kOLEeB/Z7Z54P5j4d0bW5vaj8P3/qAhugCfTWi
         HGStTKaoGQJs4at/gH6JjBn0DA4bXQeTkfGaAsKvgTzNOkNnVTnq36uIiVEEzIC1i7eF
         CyinxkHGVoNCi2hcFpHhwiNc7q+In60CZd2L0WPmmgID3Y60x6QVnASSgiTBZQl4tgcp
         ox/zIJ12YamBK6GzTz3D6qAleiDZWD4ojFbU0ATfxZc2gY/9JOjS3TM4/ooHebfn/2Gc
         BoCg==
X-Gm-Message-State: ALoCoQlHzTW3eX6EsXTJli4OXdnwjgIfamT0yv0KDw+3dZDFIBAETEOThDmK/pFXnCYJ6cJpN310
X-Received: by 10.68.114.196 with SMTP id ji4mr2475138pbb.46.1440638094952;
        Wed, 26 Aug 2015 18:14:54 -0700 (PDT)
Received: from phoenix (118-167-22-34.dynamic.hinet.net. [118.167.22.34])
        by smtp.gmail.com with ESMTPSA id jr12sm308543pbb.91.2015.08.26.18.14.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2015 18:14:53 -0700 (PDT)
Message-ID: <1440638090.18698.7.camel@ingics.com>
Subject: [PATCH 5/5] ASoC: txx9: Convert to devm_snd_soc_register_platform
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
Date:   Thu, 27 Aug 2015 09:14:50 +0800
In-Reply-To: <1440637769.18698.1.camel@ingics.com>
References: <1440637769.18698.1.camel@ingics.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <axel.lin@ingics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49037
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
 sound/soc/txx9/txx9aclc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 88eacfd..a8f705b 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -411,13 +411,8 @@ static struct snd_soc_platform_driver txx9aclc_soc_platform = {
 
 static int txx9aclc_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &txx9aclc_soc_platform);
-}
-
-static int txx9aclc_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &txx9aclc_soc_platform);
 }
 
 static struct platform_driver txx9aclc_pcm_driver = {
@@ -426,7 +421,6 @@ static struct platform_driver txx9aclc_pcm_driver = {
 	},
 
 	.probe = txx9aclc_soc_platform_probe,
-	.remove = txx9aclc_soc_platform_remove,
 };
 
 module_platform_driver(txx9aclc_pcm_driver);
-- 
2.1.0
