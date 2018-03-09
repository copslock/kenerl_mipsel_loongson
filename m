Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:15:47 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:39713
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994817AbeCIPNfr-D7w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:35 +0100
Received: by mail-qk0-x244.google.com with SMTP id z197so3970716qkb.6
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B9LBph9PERzTxzGTwCiq+cyHJkzgMM6NHXkYMt5PnMw=;
        b=AqTtkLdlH+z7y9rQ+07DjM2LqO9ZE4ED4LP0X+kG0U54kTNaYkG4CFJLJrAxB3G1i5
         85T3USQSwtIoaaDLi29HG3V6hN9OJyjWDUv41MPQrSMtn/kWCsnyl4FrehgiY7lJiXrF
         NOC6joVDNSBUFEwY+0ofbz+RsVxZjmouVEmQWVLShVNKvHqO0SwEsk0RMPoAf7qkKvQo
         K9M8T7nA3b155VNkqOaGb5aI2NqjstYsSBqTPaXEQIxlZZritE/SCDzhRQRnG4ilFlxm
         Bn6WMSbV3O0n2m0qnLOAMAWKdTXsUuLPKa2VugGeW5pmL1x8pgSwxjrGtbYH05WDqJ0K
         q03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B9LBph9PERzTxzGTwCiq+cyHJkzgMM6NHXkYMt5PnMw=;
        b=g1VAKfeGeqFLMCerqmBntYsXI4xzDHXy5xJiX/M6y/ry2ybIVU58CGt3CSOL+M0QeQ
         Mj0VUCOFia4p3iODAwhHl2l2BR/bcVmSjEABlt6cIF2PsD4r30kR4pOG2StsKWjsYTwd
         tVpkap2+5l/IRJvKcfQDU5kSwLzzdwKWcOvwhl8Mi6knKvxLxCFv7ysipycuZ+mhABDy
         dZmpwvKHBJPr3CFJpcl4v1MRkCEu52zPe/FlmimOpOR9fT9/HqAK83zaR03Hqs5WWq5s
         C9VPnfFqNeOKQH3a+BbF6VVVilARkD+ZXrNQIIhCMZCANl1s/UZDAqDJjEYIhsV6FBot
         eo7A==
X-Gm-Message-State: AElRT7Hl1vGJmmpoacUV0GnnnJbIrOyIoTdNOaOp5PCDqer3RPARNfy9
        L0ABUljNO1CKh3pi1UN741Kwog==
X-Google-Smtp-Source: AG47ELtLPPcz9+g+mNTEtTpRwr7dESRySnvRpROHjU9dRVbjNat44Z/GTQCLb7HxN8+xFe0G8ypPiw==
X-Received: by 10.55.23.201 with SMTP id 70mr43352498qkx.24.1520608409807;
        Fri, 09 Mar 2018 07:13:29 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:29 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH 09/14] mmc: jz4740: Fix race condition in IRQ mask update
Date:   Fri,  9 Mar 2018 12:12:14 -0300
Message-Id: <20180309151219.18723-10-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62886
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

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
 drivers/mmc/host/jz4740_mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index bb1b9114ef53..55587d798d47 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -410,13 +410,15 @@ static void jz4740_mmc_set_irq_enabled(struct jz4740_mmc_host *host,
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
+
 	if (enabled)
 		host->irq_mask &= ~irq;
 	else
 		host->irq_mask |= irq;
-	spin_unlock_irqrestore(&host->lock, flags);
 
 	host->write_irq_mask(host, host->irq_mask);
+
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void jz4740_mmc_clock_enable(struct jz4740_mmc_host *host,
-- 
2.16.2
