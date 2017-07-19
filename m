Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 21:09:40 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:37853
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993457AbdGSTIspUazC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2017 21:08:48 +0200
Received: by mail-qk0-x244.google.com with SMTP id q130so479580qka.4
        for <linux-mips@linux-mips.org>; Wed, 19 Jul 2017 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0yjtnyNG+zG1tIECzgr+9YvpBG2F0oQ0A4xS/9ZsTE=;
        b=fRoLbyfwtFbmxbFdyekGx8zQAu2ZDi4OaHyw4voKPa6+NJkMUn5fZbkma1lCNBl97A
         AO5tb3dXnQNGOTuIUzvLeoe2tVAiOVfbz4HSO5cMZRZRHfsCS23v7AUnUnvpogzijsyU
         Iz/Bne1K+2Yd0QyKuGUO7fM16XiHxsZsLh6uHzEg1fvlf020mq11AWKfAaIIMl5n5Rs0
         8q1eBimUltLw60w/AtJwCAO+IW22pg9E2saq8tZ5VpdRDI/CWLe0FKkO1UNhPDsblHAc
         ewe1jZYXLNpJI0UQzA5FZXlV+RYrsePhjCzz2s2jo9WgC69qHy425NBm4MJ77pJeBJUj
         hf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0yjtnyNG+zG1tIECzgr+9YvpBG2F0oQ0A4xS/9ZsTE=;
        b=REcXtNokwIhbLLD56tDA967FBHAEkuvu2xPX2/f6mDVegKscZiGNLPgDBOP6LKiaOr
         VfRIrGx9fps/Zbc9e8lZalap4hPuSPDRVqYL0TWNGAxOhiDcXCfkN3BkoBNXFKvy+AAT
         cisii8zpqJ8s0SkVDaTMRh00Ey8HVd11i9qR7OuNS2P2R4i0UinjA2pHl612DpcKblAm
         7GeE2iLheVrVW5TLol82tYTnuPQgwLwotiTcEt4DrXIFwklvR0I18Yyxxs9I3t9BalSn
         EneGzfQ8JcoDilqjlp/d0MrpJJ1RXqGB9T2yVH7D0KrCY8po/52RsoVVgM8OZ7lk1kzB
         /4bg==
X-Gm-Message-State: AIVw110g1zGMcxjdPFnU0ih+L7VSMbVJJIuFhS/756fxMfCFFvux2Bsv
        WM0ueBwDWpQUIg==
X-Received: by 10.55.6.149 with SMTP id 143mr1606408qkg.49.1500491323040;
        Wed, 19 Jul 2017 12:08:43 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id 73sm518082qkx.30.2017.07.19.12.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2017 12:08:42 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Frias <sf84@laposte.net>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/6] irqchip/tango: Use irq_gc_mask_disable_and_ack_set
Date:   Wed, 19 Jul 2017 12:07:30 -0700
Message-Id: <20170719190734.18566-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170719190734.18566-1-opendmb@gmail.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opendmb@gmail.com
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

From: Florian Fainelli <f.fainelli@gmail.com>

The only usage of the irq_gc_mask_disable_reg_and_ack() function
is by the Tango irqchip driver. This usage is replaced by the
irq_gc_mask_disable_and_ack_set() function since it provides the
intended functionality.

Fixes: 4bba66899ac6 ("irqchip/tango: Add support for Sigma Designs SMP86xx/SMP87xx interrupt controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/irqchip/irq-tango.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
index bdbb5c0ff7fe..0c085303a583 100644
--- a/drivers/irqchip/irq-tango.c
+++ b/drivers/irqchip/irq-tango.c
@@ -141,7 +141,7 @@ static void __init tangox_irq_init_chip(struct irq_chip_generic *gc,
 	for (i = 0; i < 2; i++) {
 		ct[i].chip.irq_ack = irq_gc_ack_set_bit;
 		ct[i].chip.irq_mask = irq_gc_mask_disable_reg;
-		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_reg_and_ack;
+		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
 		ct[i].chip.irq_unmask = irq_gc_unmask_enable_reg;
 		ct[i].chip.irq_set_type = tangox_irq_set_type;
 		ct[i].chip.name = gc->domain->name;
-- 
2.13.0
