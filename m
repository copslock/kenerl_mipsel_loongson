Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 21:10:01 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:33458
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993359AbdGSTIvkEubC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2017 21:08:51 +0200
Received: by mail-qk0-x244.google.com with SMTP id u126so476279qka.0
        for <linux-mips@linux-mips.org>; Wed, 19 Jul 2017 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=by0/jUy+wdDqSRKigRsA+/wH1xecsQSzJ3grQpkZNCc=;
        b=NuK6JkHY/2wYJeS/igMAbHu+Z7Gs9WhN2LMK4UBZ8zR8kDcqFH9981WtzedXQS9COu
         sn4oK7NbFDsvx0X8eNAtIVZXl0+kseWnXXTDjLPcHMyjIEgqCmlpPlv3zdbRcAYZQHBp
         ZbK8FiiAbEy281UcY7fw1OvBtxIPEDXgD1SE7RzTD0NFMB/AOAdQ0Q8nZ6SPrv5PgL3f
         lOrutNxyqidlopQak4KEwBz8ydjgkNMpHfcHxv89TJ7ufE5Hm3YYw9wdoDbJC37Q3n2a
         LgmGngiWH+RJ3AtY3NpnMR2RZNO2wHmcOSRLKpRofS69O2joezB1TdvTMD5nw1fPcvLq
         5Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=by0/jUy+wdDqSRKigRsA+/wH1xecsQSzJ3grQpkZNCc=;
        b=WP/1s7WTaXGJKFfdNM5gdgSuRTc35TYBPjnRndGrIl+sYaT3zy8KWD+ec+7Vs2KFkD
         oEgEX0gpi2WCgCeTJ5sE0LG9uG5dqMWvadnRpqQtPyNh7q/o7mA+mCXQfe9uMtVIRdP0
         3d+Y8x+ilBJ2NB3N9f7YyQIQigRAqiP+mCOH/O4WyskQ0NjSLcuQkzBWK2ExYAUBXkqH
         7mJhvmvD1xVT5mxXbooJSRYnbe+W8NpBZisB+bCveLnYdqnrQmjgmsCr/CacyaB1oeOv
         HNUT0sd3cBI6h8EddTyk76uR/4KFrPMQsKeaMkxoIFQ+IYlbwV2kXyc35u9LDKOiamzf
         st0A==
X-Gm-Message-State: AIVw111wP56GoMAidzRkIbxsu/XTCHb9JE5OKKrfjJi3PVuto+Iuqskc
        ESm8H3eI9mBPYg==
X-Received: by 10.55.198.132 with SMTP id s4mr1486753qkl.280.1500491325436;
        Wed, 19 Jul 2017 12:08:45 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id 73sm518082qkx.30.2017.07.19.12.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2017 12:08:44 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Doug Berger <opendmb@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Frias <sf84@laposte.net>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/6] genirq: generic chip: remove irq_gc_mask_disable_reg_and_ack()
Date:   Wed, 19 Jul 2017 12:07:31 -0700
Message-Id: <20170719190734.18566-4-opendmb@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170719190734.18566-1-opendmb@gmail.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59155
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

Any usage of the irq_gc_mask_disable_reg_and_ack() function has
been replaced with the desired functionality.

The incorrect and ambiguously named function is removed here to
prevent accidental misuse.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 include/linux/irq.h       |  1 -
 kernel/irq/generic-chip.c | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 5b27f65c47d0..c73e2eca4abd 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1002,7 +1002,6 @@ void irq_gc_mask_clr_bit(struct irq_data *d);
 void irq_gc_unmask_enable_reg(struct irq_data *d);
 void irq_gc_ack_set_bit(struct irq_data *d);
 void irq_gc_ack_clr_bit(struct irq_data *d);
-void irq_gc_mask_disable_reg_and_ack(struct irq_data *d);
 void irq_gc_mask_disable_and_ack_set(struct irq_data *d);
 void irq_gc_eoi(struct irq_data *d);
 int irq_gc_set_wake(struct irq_data *d, unsigned int on);
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 7f61b6e9f5ca..49ea3347719e 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -135,22 +135,6 @@ void irq_gc_ack_clr_bit(struct irq_data *d)
 }
 
 /**
- * irq_gc_mask_disable_reg_and_ack - Mask and ack pending interrupt
- * @d: irq_data
- */
-void irq_gc_mask_disable_reg_and_ack(struct irq_data *d)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct irq_chip_type *ct = irq_data_get_chip_type(d);
-	u32 mask = d->mask;
-
-	irq_gc_lock(gc);
-	irq_reg_writel(gc, mask, ct->regs.mask);
-	irq_reg_writel(gc, mask, ct->regs.ack);
-	irq_gc_unlock(gc);
-}
-
-/**
  * irq_gc_mask_disable_and_ack_set - Mask and ack pending interrupt
  * @d: irq_data
  *
-- 
2.13.0
