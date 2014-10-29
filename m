Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 05:01:26 +0100 (CET)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34329 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011846AbaJ2D7XIb0lV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 04:59:23 +0100
Received: by mail-pd0-f177.google.com with SMTP id v10so2110726pde.22
        for <multiple recipients>; Tue, 28 Oct 2014 20:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OpcLw/6B4QVRLTUN4KWTKAuDq66MAqz5/zI7+1sn5GA=;
        b=pJcdNmXHtSD9WlB5qM1XNwgLt34Vt/IUDR2KvW6XH26RjHUpft9McawwRhU2xcLJt6
         drxHlwd//vtqEAw+DVEVwU/XSCL2H0Ju07uDcsYVmvlO6mc81Ovph3VENOZXddi5LElr
         FP1hy2sWuDRuZ4MAgsUKMtdqc9DbTIHEdiKz2emBb2sStgkzKlqCuSj1mTAPi2nKJHwh
         U1wJm3hkkf0tiysVRCiyksFntKo6f6QS5cg8RMQnhEHveS24WFXToQWPlJzJvkjYhMNi
         W9zvihZBfSWmA1lqzFeBkm6o8CcMSsY8a6sJKmSh2uD2mGXBV7FXXq3mxJzBdMK2gXt/
         SXqQ==
X-Received: by 10.68.108.36 with SMTP id hh4mr7898303pbb.108.1414555157060;
        Tue, 28 Oct 2014 20:59:17 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id kj9sm2946249pbc.37.2014.10.28.20.59.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 20:59:15 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH 08/11] irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
Date:   Tue, 28 Oct 2014 20:58:55 -0700
Message-Id: <1414555138-6500-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43678
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
---
 drivers/irqchip/irq-bcm7120-l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index f041992..e9331f8 100644
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
