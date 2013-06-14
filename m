Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 18:43:15 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39195 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827514Ab3FNQlKMmORR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 18:41:10 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: javier)
        with ESMTPSA id 64B7A1E8801A
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
Subject: [PATCH 6/7] MIPS: octeon: use irq_get_trigger_type() to get IRQ flags
Date:   Fri, 14 Jun 2013 18:40:48 +0200
Message-Id: <1371228049-27080-7-git-send-email-javier.martinez@collabora.co.uk>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
Return-Path: <javier.martinez@collabora.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36901
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

Use irq_get_trigger_type() to get the IRQ trigger type flags
instead calling irqd_get_trigger_type(irq_desc_get_irq_data(irq))

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/mips/cavium-octeon/octeon-irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index a22f06a..7181def 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -607,7 +607,7 @@ static void octeon_irq_ciu_gpio_ack(struct irq_data *data)
 
 static void octeon_irq_handle_gpio(unsigned int irq, struct irq_desc *desc)
 {
-	if (irqd_get_trigger_type(irq_desc_get_irq_data(desc)) & IRQ_TYPE_EDGE_BOTH)
+	if (irq_get_trigger_type(irq) & IRQ_TYPE_EDGE_BOTH)
 		handle_edge_irq(irq, desc);
 	else
 		handle_level_irq(irq, desc);
-- 
1.7.7.6
