Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:33:01 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:41286
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994680AbeCUT2pZF3MZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:28:45 +0100
Received: by mail-qt0-x242.google.com with SMTP id j4so6502291qth.8
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qPSnQo8Fvk3KQ1TpaLjazN5Q//B2aJlpJq/5Gx/pvSg=;
        b=pRv7XScY5yBV3Gwtq2NhztFtYIJQTHBCzGb3M0DOuOfytnFis5FsHqcZpbdvfa/16i
         TH/NKQ2AZBftYSYFt+wjYv6Mfya5NjQjBl5lGapC7XEk+fQTJn5vdR9sD5xeODfJtuWM
         ILxTLUqoHh6EVamcuXBdBmiUvnXnceBoLltYEc6rGAIwFoU8dve68sYm0O/aJbdOVggX
         YXNjisj7a7bkaziTIz5ifMVYgcS++rglvoIMd+wahBI7ofi1JUxaKwSf0EPv9uozocEi
         3RH1cmBtecehTOA7gKwU7hdbpaW+3b8eIfwt0xUVjVfKo6YfOspM3vAhpntx3iTPCl3j
         UdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qPSnQo8Fvk3KQ1TpaLjazN5Q//B2aJlpJq/5Gx/pvSg=;
        b=WTCSjtKaMpSzd/HpoaqKMlgGIGrEU99SmGuVvVENdxpdEuBIYO2p9dT8sY6TeKE4T0
         dJVRx+rM6u7ESDIaeDzBSF7DuaJA6gruZGTiarxV+UKI+MI9n9TQVawEH0nWCmazOyc7
         M6Uj4XJQ7TmAoN77YAt1pH4/kGoniIF277fUiJWLq5UMZB0i5fAA65vivGuQd9wXATU1
         +rYgaw/WDZaHVZ/oLZeyKH7US9859CNZ3nGMQxy2a6sRgaxlpLHlmfZyxTnjKtv2AVif
         4rNhlRvo5PTKfffsGjxtEgVrRvO5V61tGEe/Y6sM74zDJxcPvWMfrTuD7tf8TWQMFIXi
         ygag==
X-Gm-Message-State: AElRT7EuJR3oTWtW/KuIqBuy77cH84yL0YEK7+WVtrlHg/rI3Yhe5Iam
        EIpQe4c9BfMvSu6pNZfT6QCKqQ==
X-Google-Smtp-Source: AG47ELux32y7hcRDntIkJxqDPbWSYBV6KBfzrn7KSdb9xUffRU9c8xBrR+GiQ3NBCz9FuH5XYGtIIQ==
X-Received: by 10.200.62.10 with SMTP id z10mr31810684qtf.15.1521660519572;
        Wed, 21 Mar 2018 12:28:39 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:28:38 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Alex Smith <alex.smith@imgtec.com>, stable@vger.kernel.org
Subject: [PATCH 01/14] mmc: jz4740: Fix race condition in IRQ mask update
Date:   Wed, 21 Mar 2018 16:27:28 -0300
Message-Id: <20180321192741.25872-2-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63124
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

From: Alex Smith <alex.smith@imgtec.com>

A spinlock is held while updating the internal copy of the IRQ mask,
but not while writing it to the actual IMASK register. After the lock
is released, an IRQ can occur before the IMASK register is written.
If handling this IRQ causes the mask to be changed, when the handler
returns back to the middle of the first mask update, a stale value
will be written to the mask register.

If this causes an IRQ to become unmasked that cannot have its status
cleared by writing a 1 to it in the IREG register, e.g. the SDIO IRQ,
then we can end up stuck with the same IRQ repeatedly being fired but
not handled. Normally the MMC IRQ handler attempts to clear any
unexpected IRQs by writing IREG, but for those that cannot be cleared
in this way then the IRQ will just repeatedly fire.

This was resulting in lockups after a while of using Wi-Fi on the
CI20 (GitHub issue #19).

Resolve by holding the spinlock until after the IMASK register has
been updated.

Cc: stable@vger.kernel.org
Link: https://github.com/MIPS/CI20_linux/issues/19
Fixes: 61bfbdb85687 ("MMC: Add support for the controller on JZ4740 SoCs.")
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
 drivers/mmc/host/jz4740_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 712e08d9a45e..a0168e9e4fce 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -362,9 +362,9 @@ static void jz4740_mmc_set_irq_enabled(struct jz4740_mmc_host *host,
 		host->irq_mask &= ~irq;
 	else
 		host->irq_mask |= irq;
-	spin_unlock_irqrestore(&host->lock, flags);
 
 	writew(host->irq_mask, host->base + JZ_REG_MMC_IMASK);
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void jz4740_mmc_clock_enable(struct jz4740_mmc_host *host,
-- 
2.16.2
