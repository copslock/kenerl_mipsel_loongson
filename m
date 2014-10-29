Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 05:00:27 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:40806 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011820AbaJ2D7SA-pRM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 04:59:18 +0100
Received: by mail-pd0-f173.google.com with SMTP id v10so2122279pde.18
        for <multiple recipients>; Tue, 28 Oct 2014 20:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A+91M2SvRSa1jaeun2hSM8XeaiZj6MFMAQlNQvIqs/Q=;
        b=TpsjObJaI04mlVNhtBPGMp51+z3GLm4U+WC8J+KGmZA5jUhnkLUsRfjhw4LRyK9rVX
         KIWOmNX0jE8EeoD3+yOQC5zMLyytxHZfXYxb7kQWFaoFR6uPga481qMzMW3XBMOP7M2K
         elaUvsEsYqUVDQKhRfV656qfVr5b31Ecsmvj3Jboh9CCP8aqk/QAHQbjypnz35KZ4Gk1
         HTTa0bhSo3VccANFqNnwtEXgZPsPVqKAyLWo+aLZKwrQyp+qSYpFMiTOISnQOU+HN+7M
         XkIqppUb87Ow4GyuUMvMz3dJ0GtingFVVOOH9yMY8nWR+D0Q+ciCbXTM2NMSh+QQPdzg
         s1Ig==
X-Received: by 10.68.111.161 with SMTP id ij1mr8034900pbb.10.1414555151903;
        Tue, 28 Oct 2014 20:59:11 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id kj9sm2946249pbc.37.2014.10.28.20.59.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 20:59:11 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH 05/11] irqchip: bcm7120-l2: Make sure all register accesses use base+offset
Date:   Tue, 28 Oct 2014 20:58:52 -0700
Message-Id: <1414555138-6500-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

A couple of accesses to IRQEN (base+0x00) just used "base" directly, so
they would break if IRQEN ever became nonzero.  Make sure that all
reads/writes specify the register offset constant.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 49d8f3d..6472b71 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -66,10 +66,10 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
 
 	irq_gc_lock(gc);
 	/* Save the current mask and the interrupt forward mask */
-	b->saved_mask = __raw_readl(b->base) | b->irq_fwd_mask;
+	b->saved_mask = __raw_readl(b->base + IRQEN) | b->irq_fwd_mask;
 	if (b->can_wake) {
 		reg = b->saved_mask | gc->wake_active;
-		__raw_writel(reg, b->base);
+		__raw_writel(reg, b->base + IRQEN);
 	}
 	irq_gc_unlock(gc);
 }
@@ -81,7 +81,7 @@ static void bcm7120_l2_intc_resume(struct irq_data *d)
 
 	/* Restore the saved mask */
 	irq_gc_lock(gc);
-	__raw_writel(b->saved_mask, b->base);
+	__raw_writel(b->saved_mask, b->base + IRQEN);
 	irq_gc_unlock(gc);
 }
 
-- 
2.1.1
