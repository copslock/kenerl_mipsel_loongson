Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 22:59:34 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:37371
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeCLV7QqwkBf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:16 +0100
Received: by mail-qk0-x243.google.com with SMTP id y137so13246948qka.4
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qPSnQo8Fvk3KQ1TpaLjazN5Q//B2aJlpJq/5Gx/pvSg=;
        b=Km6uot8IOZ+Gp91+F89F7DNajMCoJaMJwD70Svmr/P/5sRvdaPoddDKTJ+zDKW8XJ4
         /iyc9ZIadSOdk3uOREf1iHgVOIdc6B60I0+GaoRaB5GXgScEdV5DRoc76nojwgHq1ZWp
         6+DTZq97wmNej5TO+coASipUoadWMDGkMiXTrfReJZOCfaetpjIr+L5pO3Y1ZD1UC2jX
         Ixhsw24D+23HCzw8kj3ixxw7oGuGG4cG8ncjf8GU2YE7oJQjeEiJ9RGmXqTEAwSDPfCq
         KbH5S8kSEVZknkcVIJhxZ99O/nGO11VE2VrROBNlm12zRHZCdYBVmI5QTuhhU2jPyX5g
         Ibdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qPSnQo8Fvk3KQ1TpaLjazN5Q//B2aJlpJq/5Gx/pvSg=;
        b=L7iIDPo1geivgn8AwPBNCcORJYUN17eVBdcFDA1PssYfOoCJXzvZ5+itRqlplfbwLh
         ghIrk1/cUZesp0wWSe8mYF2wvzWy4YXQM6lPXubA5D6/tfmQm1XyNYa0rJsihO/zAIEB
         It9RqXmJ+zMJi8V0060z0hrWvffdRPpdd4miSBWPu5+EHLnvxW2rE6rGGddMo6N5fYrz
         RiL9NmmEXkc/Y3OBBRjRZ/HFdlHAzSy0RtNzLqB5Ga1YNB1vtiKEZDYdOwy+At+EKWZ1
         JLKV5LXMCjJiBi4znMYeynjAzuWHzSJzu1rjS9Pg/S/nOVCqX6/AcXirMVgka3qkO0Xg
         T6zQ==
X-Gm-Message-State: AElRT7GLr1YH5C3frC6/Y+9yUjTwBRwQr43cRBMWmpbhwFdCj1vY5a8F
        L3UTTxru62ItvcmOz5LfN1NDPA==
X-Google-Smtp-Source: AG47ELvgG5WF91j/qMfptrLmvacnQUpRGkrH11nldqbutmz04HB3p+isKPw7RBFdevJaO0E02wEvxQ==
X-Received: by 10.55.192.151 with SMTP id v23mr10002579qkv.83.1520891950976;
        Mon, 12 Mar 2018 14:59:10 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:10 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Alex Smith <alex.smith@imgtec.com>, stable@vger.kernel.org
Subject: [PATCH v2 01/14] mmc: jz4740: Fix race condition in IRQ mask update
Date:   Mon, 12 Mar 2018 18:55:41 -0300
Message-Id: <20180312215554.20770-2-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62932
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
