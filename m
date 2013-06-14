Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 18:41:00 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39126 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825866Ab3FNQlACGpk6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 18:41:00 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: javier)
        with ESMTPSA id 278271708682
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
Subject: [PATCH 0/7] genirq: add irq_get_trigger_type() to get IRQ flags
Date:   Fri, 14 Jun 2013 18:40:42 +0200
Message-Id: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
X-Mailer: git-send-email 1.7.7.6
Return-Path: <javier.martinez@collabora.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36895
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
struct irq_data to callers. This patch-set adds a new function
irq_get_trigger_type() to obtain the edge/level flags for an IRQ
and updates the places where irq_get_irq_data(irq) was called
just to obtain the flags from the struct irq_data.

The patch-set is composed of the following patches:

[PATCH 1/7] genirq: add irq_get_trigger_type() to get IRQ flags
[PATCH 2/7] gpio: mvebu: use irq_get_trigger_type() to get IRQ flags
[PATCH 3/7] mfd: twl4030-irq: use irq_get_trigger_type() to get IRQ flags
[PATCH 4/7] mfd: stmpe: use irq_get_trigger_type() to get IRQ flags
[PATCH 5/7] arm: orion: use irq_get_trigger_type() to get IRQ flags
[PATCH 6/7] MIPS: octeon: use irq_get_trigger_type() to get IRQ flags
[PATCH 7/7] irqdomain: use irq_get_trigger_type() to get IRQ flags

 arch/arm/plat-orion/gpio.c           |    2 +-
 arch/mips/cavium-octeon/octeon-irq.c |    2 +-
 drivers/gpio/gpio-mvebu.c            |    2 +-
 drivers/mfd/stmpe.c                  |    3 +--
 drivers/mfd/twl4030-irq.c            |    5 +----
 include/linux/irq.h                  |    6 ++++++
 kernel/irq/irqdomain.c               |    2 +-
 7 files changed, 12 insertions(+), 10 deletions(-)

Best regards,
Javier
