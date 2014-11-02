Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 02:07:27 +0100 (CET)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:38403 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012452AbaKBBFGPsR93 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 02:05:06 +0100
Received: by mail-pd0-f177.google.com with SMTP id v10so9294812pde.8
        for <multiple recipients>; Sat, 01 Nov 2014 18:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x+k1st+9eghd/5a+JeGjwi6jh5QZCbY6YqHagPVR5oY=;
        b=DghQsbHiEJUPN6mL46BOYlfNdH+r1KsfECUHFabmozaMZd4cqOiuM7DEMuSv2124fx
         VnIc81Fb9p99CuEgdPS+8gY4oqIiopITzFe9GVxRHMXAd0jJlOKhQ068et6zjPyi2F+x
         +JWbv4xJOr4BV9Z5zKbbhK+SzkG/GqRMfThFxt+FYDP/c48yp4GYWsNYhquzBpxkM8T1
         L54kbQusl4DJ/wAA10TmF8eMasQFsEacbs6mI71MVfK575IBqfyt3726tUNoq2nOW4sB
         w/2xKRFDL8ubbT54+m+aWbGe8Q8q292cFYMkbj14PwYCUaE2cxjp7kunvNt9L9nwP+yP
         QDFQ==
X-Received: by 10.70.11.2 with SMTP id m2mr34045172pdb.31.1414890300180;
        Sat, 01 Nov 2014 18:05:00 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id f7sm13488343pdj.15.2014.11.01.18.04.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Nov 2014 18:04:59 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
Cc:     linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V3 09/14] irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
Date:   Sat,  1 Nov 2014 18:03:56 -0700
Message-Id: <1414890241-9938-10-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43831
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

This mask should have been 0xffff_ffff, not 0x0fff_ffff.

The change should not have an effect on current users (STB) because bits
31:27 are unused.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 22d3fa1..b70679f8 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -171,7 +171,7 @@ int __init bcm7120_l2_intc_of_init(struct device_node *dn,
 	}
 
 	gc = irq_get_domain_generic_chip(data->domain, 0);
-	gc->unused = 0xfffffff & ~data->irq_map_mask;
+	gc->unused = 0xffffffff & ~data->irq_map_mask;
 	gc->reg_base = data->base;
 	gc->private = data;
 	ct = gc->chip_types;
-- 
2.1.1
