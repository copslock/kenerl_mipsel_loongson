Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2017 02:35:30 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:34832
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994822AbdHaAfXajk-j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Aug 2017 02:35:23 +0200
Received: by mail-qk0-x244.google.com with SMTP id p67so6486380qkd.2
        for <linux-mips@linux-mips.org>; Wed, 30 Aug 2017 17:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vxqN5JZAn/oqYiz49UrBTdppqL8l+sqsWoxCjiCXRNo=;
        b=a4baU9I4c2+DOpMfvQ9D3o6+0zveXIsf9FSI+VhrQaV/xqPEWir0RWDv9nXwU/L52N
         4MyEjV4y0uDO+hpA+SrBXj7agt5HF3HOArNpXGEqqSnATyAAo05Y5EEJG5FxqngMvQKz
         Z0wXKAKWyNZw6RsxSCLzHkKbjRwo+LJ1p41DrOwWOBaeUh0qYk0XvbKVxqzh6xxX3/oQ
         bEEkkZpwYhOKLwrzyp65ZzX4HGZIrMpNlwNuiwZ3jP8K1YOogs4dpx+Zbu61Qn7h72LG
         6PQpko/zqJQO0q0Ao3XSNwopdPUvr0CYzBYRtHc/5Moun1J/Jldgx7P/vIdirY9NiY/m
         RSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vxqN5JZAn/oqYiz49UrBTdppqL8l+sqsWoxCjiCXRNo=;
        b=nN0HrooZqaH2Hdo590zihE343WOi2rHbKDzFf/uPEUOPEWohqTGDrfBg7z841UIZ/q
         ItwP9zWjG8E+dQWUE8wjFaPyPY9G30vpZjR4ggoMn9CNzYPtdb+K8RG3yOQQKD/k5Vxn
         2bFCEGYGff2jZEzTqTDdWvjEyyK1MOEzKkKD1ETllvMI0DvL73VXLMj3SUM1U73Riqmf
         m3P934rUnbsWhXCqYisd44S3nKmHC1iy3eajDYyszGjwa9JWLEbfu2Zn53PqVwAf4YSq
         yNBLxRmPgho+iAvD1KKRVnSx7xOWGsriUId1foKQ7Fla7FeLgTS/dZw1IKYEi1OB9tub
         RX2Q==
X-Gm-Message-State: AHYfb5hMx9VHcqJvY3P2fogkMAEx67HvJN6vWGUReDTR+5ET71mWsOO5
        zMejZdCmVXCLsQ==
X-Received: by 10.55.164.82 with SMTP id n79mr1608432qke.45.1504139717462;
        Wed, 30 Aug 2017 17:35:17 -0700 (PDT)
Received: from stb-bld-04.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id u13sm4661485qku.56.2017.08.30.17.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 17:35:16 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-mips@linux-mips.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE)
Subject: [PATCH v2] irqchip: irq-bcm7120-l2: Use correct I/O accessors for irq_fwd_mask
Date:   Wed, 30 Aug 2017 17:29:16 -0700
Message-Id: <1504139356-1052-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59895
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

Initialization of irq_fwd_mask was done using __raw_writel() which
happens to work for all cases except when using ARM BE8 which requires
writel() (with the proper swapping). Move the initialization of the
irq_fwd_mask till later when we have correctly defined our I/O
accessors.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- corrected readl vs. writel in commit subject, spotted by Marc

 drivers/irqchip/irq-bcm7120-l2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 64c2692070ef..983640eba418 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -250,12 +250,6 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 	if (ret < 0)
 		goto out_free_l1_data;
 
-	for (idx = 0; idx < data->n_words; idx++) {
-		__raw_writel(data->irq_fwd_mask[idx],
-			     data->pair_base[idx] +
-			     data->en_offset[idx]);
-	}
-
 	for (irq = 0; irq < data->num_parent_irqs; irq++) {
 		ret = bcm7120_l2_intc_init_one(dn, data, irq, valid_mask);
 		if (ret)
@@ -297,6 +291,10 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		gc->reg_base = data->pair_base[idx];
 		ct->regs.mask = data->en_offset[idx];
 
+		/* gc->reg_base is defined and so is gc->writel */
+		irq_reg_writel(gc, data->irq_fwd_mask[idx],
+			       data->en_offset[idx]);
+
 		ct->chip.irq_mask = irq_gc_mask_clr_bit;
 		ct->chip.irq_unmask = irq_gc_mask_set_bit;
 		ct->chip.irq_ack = irq_gc_noop;
-- 
1.9.1
