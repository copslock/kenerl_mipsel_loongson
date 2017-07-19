Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 21:09:09 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:37553
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993423AbdGSTIsJUZ7C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2017 21:08:48 +0200
Received: by mail-qt0-x242.google.com with SMTP id n43so1267177qtc.4
        for <linux-mips@linux-mips.org>; Wed, 19 Jul 2017 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q+Rwf2fsp1i1CklUpVeSQbSDTeODAkwZs2/BoCo3blM=;
        b=BSUgT5yUeyfeZ3LF376kJ1mfTkXAoKr0ZMgxVL4SFatbqeW4ZN5D3r5oQ6Ccp+fTrC
         eepiYHEy1XaP4V2KiTMVxLFXFs6u1IZmoML8zRtmnSrAftkA5zkujYPG63EPuDRhHXb/
         VT48O0oJB3EPZaF+RAhFNIM9K5OkfJ5vhcTTDo2cmqD+YqSZs9ACJzPflRRLuGkD1LGm
         RCIH4Oc4WrxKm7oVK9B6EvEydzpX8dnHM1uJWI4PT7WVUUo5zyfw38Df094VM9yRAI0F
         Qjw9kXGDtOho14vcwxinQ8exZRfy1FDldMmeO0o4SlRiLZTAVR0jJ8MoK0dzQH8rtx48
         0M8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q+Rwf2fsp1i1CklUpVeSQbSDTeODAkwZs2/BoCo3blM=;
        b=QaK2Po4FlYPkyYn0SF+ApCxpQFjdebu8ACnaPO96Ba7iDYON2F62De8QUHXbnNT3Gf
         wgjA51IwUj7uwYJBhBW+Pj+26CDfetFppEzOOqPCpIxEaOllf0R1FsdzYgWabEuojGk/
         lNgEaO43OM7yXuwiW6xZfOGcnA+jb7Be2CSaiHWs6cnVWz9PItspCfn2p4qNEEz5ad3B
         9FkBu52l5Q9iXIJQDzjEBJ0cgRGm+/GU88asF6DtSg653uSdtPfuewdX3Uc8GvCANYYG
         s3VZoWb9ZveJtxy1yZ/l+Q+bYoBvqEBdsVtLPuvm4Hk3spbXdHHKXlJoQkRzMEQO2XQe
         Hc8A==
X-Gm-Message-State: AIVw112oDQ1h55Yhiqpf4Md5Poiwp7DNWWu8OyPn9ysyzZ35YEToK3ef
        NnDowi7NFSD9Qg==
X-Received: by 10.200.50.2 with SMTP id x2mr1643251qta.23.1500491320608;
        Wed, 19 Jul 2017 12:08:40 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id 73sm518082qkx.30.2017.07.19.12.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2017 12:08:39 -0700 (PDT)
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
Subject: [PATCH v2 1/6] genirq: generic chip: add irq_gc_mask_disable_and_ack_set()
Date:   Wed, 19 Jul 2017 12:07:29 -0700
Message-Id: <20170719190734.18566-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170719190734.18566-1-opendmb@gmail.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59153
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

The irq_gc_mask_disable_reg_and_ack() function name implies that it
provides the combined functions of irq_gc_mask_disable_reg() and
irq_gc_ack().  However, the implementation does not actually do
that since it writes the mask instead of the disable register. It
also does not maintain the mask cache which makes it inappropriate
to use with other masking functions.

In addition, commit 659fb32d1b67 ("genirq: replace irq_gc_ack() with
{set,clr}_bit variants (fwd)") effectively renamed irq_gc_ack() to
irq_gc_ack_set_bit() so this function probably should have also been
renamed at that time.

The generic chip code currently provides three functions for use
with the irq_mask member of the irq_chip structure and two functions
for use with the irq_ack member of the irq_chip structure. These
functions could be combined into six functions for use with the
irq_mask_ack member of the irq_chip structure.  However, since only
one of the combinations is currently used, only the function
irq_gc_mask_disable_and_ack_set() is added by this commit.

The '_reg' and '_bit' portions of the base function name were left
out of the new combined function name in an attempt to keep the
function name length manageable with the 80 character source code
line length while still allowing the distinct aspects of each
combination to be captured by the name.

If other combinations are desired in the future please add them to
the irq generic chip library at that time.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 include/linux/irq.h       |  1 +
 kernel/irq/generic-chip.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 00db35b61e9e..5b27f65c47d0 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1003,6 +1003,7 @@ void irq_gc_unmask_enable_reg(struct irq_data *d);
 void irq_gc_ack_set_bit(struct irq_data *d);
 void irq_gc_ack_clr_bit(struct irq_data *d);
 void irq_gc_mask_disable_reg_and_ack(struct irq_data *d);
+void irq_gc_mask_disable_and_ack_set(struct irq_data *d);
 void irq_gc_eoi(struct irq_data *d);
 int irq_gc_set_wake(struct irq_data *d, unsigned int on);
 
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index f7086b78ad6e..7f61b6e9f5ca 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -151,6 +151,31 @@ void irq_gc_mask_disable_reg_and_ack(struct irq_data *d)
 }
 
 /**
+ * irq_gc_mask_disable_and_ack_set - Mask and ack pending interrupt
+ * @d: irq_data
+ *
+ * This generic implementation of the irq_mask_ack method is for chips
+ * with separate enable/disable registers instead of a single mask
+ * register and where a pending interrupt is acknowledged by setting a
+ * bit.
+ *
+ * Note: This is the only permutation currently used.  Similar generic
+ * functions should be added here if other permutations are required.
+ */
+void irq_gc_mask_disable_and_ack_set(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	irq_reg_writel(gc, mask, ct->regs.disable);
+	*ct->mask_cache &= ~mask;
+	irq_reg_writel(gc, mask, ct->regs.ack);
+	irq_gc_unlock(gc);
+}
+
+/**
  * irq_gc_eoi - EOI interrupt
  * @d: irq_data
  */
-- 
2.13.0
