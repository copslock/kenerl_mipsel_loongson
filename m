Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 02:07:08 +0100 (CET)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:49493 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012451AbaKBBFEkEu9r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 02:05:04 +0100
Received: by mail-pd0-f177.google.com with SMTP id v10so9294783pde.8
        for <multiple recipients>; Sat, 01 Nov 2014 18:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4dDFQr2m4pwM+8bR5C5jBNLuE7HvQBgROC308E1pL4=;
        b=hUUOiY21ZSp7osvuQUa+OsfobUs2kQTV7AefVaasxm/zvZ2K39zigWH0SyE8VJ69jt
         jKNB1xvNsE+wZOK8OTu4LVxNuQ9quiwJsLfpb+5P0MXobG/5RVsJ27FXwChasixH1D9E
         TLITZ3E8ZQ8pCbRj0+SLEu1sA4hGWhTIspBI6urdLEULqN8Jc7BQ0OINiR9XQABWkfLz
         zpCydiRXcFZbwVyZllF/HpNG6C69LZpMSKPG2VIZ6ePfBV3N5LA9Pzu/LXotfTPD/A3m
         cCqxMADu0sy/k5FvfM+fcF+hzLV00gHCDmgyw8Bu8VwEisUOD3mKiscS6Z87EiMwmHj+
         8kPg==
X-Received: by 10.70.5.130 with SMTP id s2mr1835038pds.17.1414890298565;
        Sat, 01 Nov 2014 18:04:58 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id f7sm13488343pdj.15.2014.11.01.18.04.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Nov 2014 18:04:57 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
Cc:     linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V3 08/14] irqchip: bcm7120-l2: Make sure all register accesses use base+offset
Date:   Sat,  1 Nov 2014 18:03:55 -0700
Message-Id: <1414890241-9938-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43830
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 7086fe0..22d3fa1 100644
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
