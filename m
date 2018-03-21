Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:34:03 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:35282
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994695AbeCUT241OuQZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:28:56 +0100
Received: by mail-qk0-x243.google.com with SMTP id s188so6711930qkb.2
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JOJQHsZ2b5xYYZC1NATiF6gocznbM4tPnkFtO0NeYBQ=;
        b=Vgbn/MbB37yLadmLdYCkzc8pdW2shGalh6rOtiN9ra2YQ1s69FMq/1xdAroJLNOaG9
         TYiEgUS5qkzSfuOk8c5o++I9ZCG6dFoGim11J2q2DrEsubGMrJbVRGhQ202RCGP8dPp1
         q7hhiTK5e3jzgQXaKhTYfqMYEOGCeTkcyB8dkfQQQqjA74EquKpn9IrDwaqE6rQ3nShY
         GCC9dnd1lutQ7Dnb1+YjLQHWKIly2lBBLyUfWVceGbkKcKisPNGJQoe/oR25iyfWh0bZ
         fz/ap6nbcE8CKQUKYL+IiWZYQelJbameIxDmkW6PDJKcEe5+0LMat5LLKEtHU64K+Jb5
         9+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JOJQHsZ2b5xYYZC1NATiF6gocznbM4tPnkFtO0NeYBQ=;
        b=AH8SpbsIUlpg/a/WKW/mJPKEiHgXe1DGHmJMukbrwwdIXFY10jfhZEnr4UOEAFXbGg
         VTObb46okHIAo1MBPyXQ2irBSWf7Jj/6cW5/GWA6OUNIyjZrFQynoYF4V2hbt6bqtVDM
         n6Ipg68LvQSmfUD+/INu8mNxSegASRWKIkU4MlHG+y/HigMbY2ZXXPX+2fwI3urD2WCR
         KjJSi/C0KC3JE+18lTGI6OtyuXTywCJK+BVC1v7dMrRZUEyiGo4wV3BzDIOUyX5fDY+U
         RjpWr3bWEith1NiJbmfxevhUfQFDtIk2TVMHeubswsuLR+fGEBKrzMiBEJAo9rozZrRC
         bKFQ==
X-Gm-Message-State: AElRT7EImlrn4GEivUKLgLM2WfmozAg4JNJnDQnad37vNnEA7HP249xx
        Yhk55M1nGmAZdWM0uS3NOojF6g==
X-Google-Smtp-Source: AG47ELsa83jHN673Hfg04Q4J+O4UdCMP+Z4wEkYra8VCg1PuIP+jGcfybhUmO9EV51EQMJeWp3xrHg==
X-Received: by 10.55.198.153 with SMTP id s25mr29271067qkl.221.1521660530437;
        Wed, 21 Mar 2018 12:28:50 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:28:49 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH 05/14] mmc: jz4740: Reset the device requesting the interrupt
Date:   Wed, 21 Mar 2018 16:27:32 -0300
Message-Id: <20180321192741.25872-6-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

In case a bootloader leaves the device in a bad state,
requesting the interrupt before resetting results in a bad
interrupt loop.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
[Ezequiel: cleanup commit description]
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/jz4740_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index b11f65077ce7..9f316d953b30 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1027,6 +1027,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	spin_lock_init(&host->lock);
 	host->irq_mask = 0xffff;
 
+	jz4740_mmc_reset(host);
+
 	ret = request_threaded_irq(host->irq, jz_mmc_irq, jz_mmc_irq_worker, 0,
 			dev_name(&pdev->dev), host);
 	if (ret) {
@@ -1034,7 +1036,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_free_gpios;
 	}
 
-	jz4740_mmc_reset(host);
 	jz4740_mmc_clock_disable(host);
 	timer_setup(&host->timeout_timer, jz4740_mmc_timeout, 0);
 
-- 
2.16.2
