Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:23:14 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:48421 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012259AbaJ3CUAKD0uJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:20:00 +0100
Received: by mail-pa0-f43.google.com with SMTP id eu11so4432163pac.30
        for <multiple recipients>; Wed, 29 Oct 2014 19:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DWCDotFMDmN3B8rdDkxccN7lAGqgXMt2P6EQGATiMc4=;
        b=xchuXayXO+AhvV02EJlG1g14XDM/IkdbD+tIUWojSIMHLoEYr6nWWulGuQo+/Njdu9
         LPkVTm0p4HK92pO27BBGTHwsDRqBrO10JntRtL0ubCWeK/Rrov1JyGk6A4pIXQHrmb6N
         SL97r8sgnSfSqJX25agX0DHChbk749MkMrFJ2LlcjrdRlpdLh+GugWLB+kYL+ZbNtS97
         8Ylu9fCsipjbIoKKH5r8DeVzLG2RoN/Gy0WKQTdM6VYQsR9ebuOoQ+CAVGCiwFp5IvJ8
         7zXL7nlaSfRAZK7XuCbKb0yvByTdujPTEba14LF1P+4NNJziuhGMAsxq8tpsCOvyNBSY
         d1yA==
X-Received: by 10.70.27.225 with SMTP id w1mr14253409pdg.40.1414635594038;
        Wed, 29 Oct 2014 19:19:54 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.19.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:19:53 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 10/15] irqchip: bcm7120-l2: Make sure all register accesses use base+offset
Date:   Wed, 29 Oct 2014 19:18:03 -0700
Message-Id: <1414635488-14137-11-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43749
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
