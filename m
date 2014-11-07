Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:47:23 +0100 (CET)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34704 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012031AbaKGGpTcvwIl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:19 +0100
Received: by mail-pd0-f178.google.com with SMTP id fp1so2757668pdb.9
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4dDFQr2m4pwM+8bR5C5jBNLuE7HvQBgROC308E1pL4=;
        b=eloQKoegkOd6slVRrRivqz6ezy+fp9uriGu33Fki66DAoH11HZ99k3ov//+m3K+1kp
         sJMqqfv4a3ZVO+kUe7OApR7apzy/WPGFNS1E09NKSyT7qlG99ZNMpPICeVt+crX/RDPK
         jrOXblsYKIrjJDO2HJz/h3e6KDiIKtkgJkh5graem0gt+qNp9yReT9OXGAJVvWd/OmML
         eTgYu0hkmSQ0uSbxA7oF8J1NYmc7wjnIOktVS4Nkte6Dk+BGylt+F92i+65C2nyIxLv9
         X6xucHZzHGtH+OXwDgZgHZ9TmkZIjvKr9LaJpxcVZCIKmx1alZZD9xR2f3ZJGoiHujdM
         WwkA==
X-Received: by 10.68.164.65 with SMTP id yo1mr9923426pbb.126.1415342713538;
        Thu, 06 Nov 2014 22:45:13 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.45.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:45:12 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 08/14] irqchip: bcm7120-l2: Make sure all register accesses use base+offset
Date:   Thu,  6 Nov 2014 22:44:23 -0800
Message-Id: <1415342669-30640-9-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43901
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
