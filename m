Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 21:08:43 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:35835
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992209AbdGSTIgXcTZC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2017 21:08:36 +0200
Received: by mail-qk0-x244.google.com with SMTP id t186so480184qkf.2
        for <linux-mips@linux-mips.org>; Wed, 19 Jul 2017 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HPNA9MdN5QLAxBD1rsPx5YsUrUN0NdKoMi1QtyG8Ahs=;
        b=SNRpU9XWNPLEhvgGHGZhuOgxI/ePRB1T8qoODefO8+VHSGsjU/epcfc4jYoDtlx101
         gbtoMGKteR5yN89QIHUQ9se2p6YoavMAeCA2LKTY8Gbxe+Yw5jRwd6KmSgP5rri4JhUS
         W+SbS4TCmd0WABBzkhkr97MZRDmhm0mBGQx4cSn9GsezTvRm8u40A/hBadKIWRHeaVA4
         vHkYikMMy3IOqQOhtMtVTOk2DOk37FlHjjnGko5Q/cj7lwmwzhn8zCI8rdXAqUOqn1qt
         rfVddtBBCGLJx+NrBGEbk1LSog3lRMGK7H13euIdCn8YIYO2QZ0DjueMgvEmS6t9t1YF
         X2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HPNA9MdN5QLAxBD1rsPx5YsUrUN0NdKoMi1QtyG8Ahs=;
        b=cP2bogLhbt5nbR12ESUEtI1jc6GeOQRYM8G89oDP2hv4pJC2Cri5fUddK+8K846PzT
         UPrvFhxpg/OjpqYDVZRds9cggU+cVY67dpB1pXI8t6L9undzotuk9MfLoah3i1WEsKQ3
         sVXOXbOTxYSlKQxukx7/965xYYegWX5UPx2Antb2aNz7+Kq+gc+b33zs3zE+U3GInwvm
         jA/ZzcqWDplU53ljPaIrRNKGmtp/L6kLMRC3/zqs9FzgSLLEBmGkPANC2P7gKQR/Z62x
         VbItmyGHn1DTJ9f9D2Cc5A79i9VzGaOl3SybcCAU1f5j1l5E4J5wdyA/QGWC3SMjaDbw
         tbtg==
X-Gm-Message-State: AIVw113PFDULOBiLDaOkUBLmxqweWPfxAy9rufK0jrWSFpNyvlmxFmVv
        9p5AnOS2u1W7/A==
X-Received: by 10.55.159.147 with SMTP id i141mr1571787qke.150.1500491310473;
        Wed, 19 Jul 2017 12:08:30 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id 73sm518082qkx.30.2017.07.19.12.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2017 12:08:29 -0700 (PDT)
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
Subject: [PATCH v2 0/6] Add support for BCM7271 style interrupt controller
Date:   Wed, 19 Jul 2017 12:07:28 -0700
Message-Id: <20170719190734.18566-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.13.0
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59152
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

This patch set extends the functionality of the irq-brcmstb-l2 interrupt
controller driver to cover a hardware variant first introduced in the
BCM7271 SoC.  The main difference between this variant and the block
found in earlier brcmstb SoCs is that this variant only supports level
sensitive interrupts and therefore does not latch the interrupt state
based on edges.  Since there is no longer a need to ack interrupts with
a register write to clear the latch the register map has been changed.

Therefore the change to add support for the new hardware block is to
abstract the register accesses to accommodate different maps and to
identify the block with a new device-tree compatible string.

I also took the opportunity to make some small efficiency enhancements
to the driver.  One of these was to make use of the slightly more
efficient irq_mask_ack method.  However, I discovered that the defined
irq_gc_mask_disable_reg_and_ack() generic irq function was insufficient
for my needs.  The first three commits of this set are intended to be a
correction of the existing generic irq implementation to provide a
function that can be used by interrupt controller drivers for their
irq_mask_ack method when disable/enable registers are used for masking
and interrupts are acknowledged by setting a bit in an ack register.

I believe these first three commits should be added to the irq/core
repository and possibly stable branches. The remaining commits should be
added to the irqchip/core repository but I have included the complete
set here for improved context since the irqchip patches are dependent on
the irq patches.  This entire set is therefore based on the irq/core
master branch.  Please let me know if you would like a different
packaging.

If the changes to genirq are not acceptable I can implement the
irq_mask_ask method locally in the irq-brcmstb-l2 driver and submit
that on its own.

Changes in v2:

- removed unused permutations of irq_mask_ack methods
- added Reviewed-by and Acked-by responses from first submission

Doug Berger (5):
  genirq: generic chip: add irq_gc_mask_disable_and_ack_set()
  genirq: generic chip: remove irq_gc_mask_disable_reg_and_ack()
  irqchip: brcmstb-l2: Remove some processing from the handler
  irqchip: brcmstb-l2: Abstract register accesses
  irqchip: brcmstb-l2: Add support for the BCM7271 L2 controller

Florian Fainelli (1):
  irqchip/tango: Use irq_gc_mask_disable_and_ack_set

 .../bindings/interrupt-controller/brcm,l2-intc.txt |   3 +-
 drivers/irqchip/irq-brcmstb-l2.c                   | 145 ++++++++++++++-------
 drivers/irqchip/irq-tango.c                        |   2 +-
 include/linux/irq.h                                |   2 +-
 kernel/irq/generic-chip.c                          |  15 ++-
 5 files changed, 114 insertions(+), 53 deletions(-)

-- 
2.13.0
