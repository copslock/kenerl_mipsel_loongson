Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 20:49:52 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:35315
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995072AbdH2StloXU7H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 20:49:41 +0200
Received: by mail-wr0-x244.google.com with SMTP id a47so2848124wra.2
        for <linux-mips@linux-mips.org>; Tue, 29 Aug 2017 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TVLxS7EURYJFk18Osgoa9NUdLsID/WNuGDrIdlzIEIA=;
        b=C8SHRYCirmS84iv98l0UbZQoSgADgDIDCshL6oPTlroz3TZ4v7bXcvwTrecc7ByPGQ
         DWq7Zgjc3GaQGp1Zkb+FTZgpNr7M/WAdBQNqBrqxC2W+pjn3KEgtsUfsg2ZhsmsePReu
         g/RUww/V2CMoo2o2autTNNRmD6/Rhp0YR9vnXmtwAKtvSVQsqokObJGIu8q3jQchEeTE
         XwwCN1tAbNRBBvcW0vLNcMjzyU3Z/OUh1mNt2wlPUYckYSJzPTbvnmP7izqn/TKMFplP
         HKID53d/2KAtdsCv+eI1+7BMebMH5fdu9MOAQWw29BMIYxhV/UyHfnQcKzPaK9tFRNG0
         jk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TVLxS7EURYJFk18Osgoa9NUdLsID/WNuGDrIdlzIEIA=;
        b=d5uABji6zWc8+PUOpopnlRkKZXzA801cOdAycbBxL45AErMCkUfS5slvnbO3ykV8kY
         D9B1XRiN8MuWGFN/LIFYAM/CTGA6feAX1cIIhJbAabKMErRjtEE75N/z2C/5nq4skroj
         GrhLvXjVG/T6t31tNTv2fc0u1H9zRnclrGyuRo+05z9BoZz3MMDhHk3j6YW6pAjStle3
         ltzUwx/loIL/edY1ftvD+eQS8xIRqrtu1RiDV3JkBDlerUM/T09IDyneRQ/QoAutW7l0
         EA843SGc5g27ybIsi7EzPv/ZLxcmY+A4awcdVLo3MCm5U3eNbDmI7CUrD7iNXDHN4zXQ
         38cA==
X-Gm-Message-State: AHYfb5hjD0VqaadQZxcGrFIxliwwJX2tjZcK90L/gmdge1+3vvO5C520
        h1vIkEbw7Ya6/g==
X-Received: by 10.223.199.75 with SMTP id b11mr774641wrh.293.1504032576286;
        Tue, 29 Aug 2017 11:49:36 -0700 (PDT)
Received: from stb-bld-04.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id o191sm1899055wmg.5.2017.08.29.11.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 11:49:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-mips@linux-mips.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE)
Subject: [PATCH] irqchip: irq-bcm7120-l2: Use correct I/O accessors for irq_fwd_mask
Date:   Tue, 29 Aug 2017 11:43:06 -0700
Message-Id: <1504032187-53035-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59882
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

Initialization of irq_fwd_mask was done using __raw_readl() which
happens to work for all cases except when using ARM BE8 which requires
readl() (with the proper swapping). Move the initialization of the
irq_fwd_mask till later when we have correctly defined our I/O
accessors.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
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
