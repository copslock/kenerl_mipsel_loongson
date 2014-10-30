Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:23:34 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:49010 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012264AbaJ3CUBxvxut (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:20:01 +0100
Received: by mail-pa0-f42.google.com with SMTP id bj1so4446097pad.29
        for <multiple recipients>; Wed, 29 Oct 2014 19:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MIhE8KTdzY87ZHANi/UzIwJf+W+YIwCt6CsZpnN4tF0=;
        b=U7xoB3EnAjfsHS97ZURS/dSbQA5UQTzv5QrdiGsjGgseaSbRNcAAqhatjGU3NYZlHu
         9iZX+k4s/qmS74abKnuG35mwvFLrJmuByCnTc5cfH/6IcL5N+Cs9Ci8uEnZhtme8PJLF
         jw8DEPU4P1sCKOw3jAtEBFEgKSJ9etkJOzdqaeDwgYJMgBRNyDtkyp1RYSw4ZGGhma7L
         OwMfWH0U8jSghwBR8lExKi91fkRwXjV5ISy0vuRMu4KdzGKrPhjZxIFEZ46zBwVQAh4v
         REhk9i8QRJY4RwNGcsvh5ZXT0gfsLKClOi//YQQ9wE3i5WeRk4TRl4itrBhXFuRRa6Kr
         AyHg==
X-Received: by 10.66.232.67 with SMTP id tm3mr13991879pac.7.1414635595584;
        Wed, 29 Oct 2014 19:19:55 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.19.54
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:19:55 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 11/15] irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
Date:   Wed, 29 Oct 2014 19:18:04 -0700
Message-Id: <1414635488-14137-12-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43750
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
index 6472b71..e3cfff5 100644
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
