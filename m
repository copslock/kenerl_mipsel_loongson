Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 18:41:19 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39136 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827470Ab3FNQlBGz600 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 18:41:01 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: javier)
        with ESMTPSA id 0232A1708684
From:   Javier Martinez Canillas <javier.martinez@collabora.co.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/7] genirq: add irq_get_trigger_type() to get IRQ flags
Date:   Fri, 14 Jun 2013 18:40:43 +0200
Message-Id: <1371228049-27080-2-git-send-email-javier.martinez@collabora.co.uk>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
Return-Path: <javier.martinez@collabora.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: javier.martinez@collabora.co.uk
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

Drivers that want to get the trigger edge/level type flags for a
given interrupt have to first call irq_get_irq_data(irq) to get
the struct irq_data and then irqd_get_trigger_type(irq_data) to
obtain the IRQ flags.

This is not only error prone but also unnecessary exposes the
struct irq_data to callers.

It's better to have an irq_get_trigger_type() function to obtain
the edge/level flags for an IRQ.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 include/linux/irq.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index bc4e066..0e8e3a6 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -579,6 +579,12 @@ static inline struct msi_desc *irq_data_get_msi(struct irq_data *d)
 	return d->msi_desc;
 }
 
+static inline u32 irq_get_trigger_type(unsigned int irq)
+{
+	struct irq_data *d = irq_get_irq_data(irq);
+	return d ? irqd_get_trigger_type(d) : 0;
+}
+
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 		struct module *owner);
 
-- 
1.7.7.6
