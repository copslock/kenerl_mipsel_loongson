Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2017 03:00:31 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:34663
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993195AbdISBAX3eXl- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2017 03:00:23 +0200
Received: by mail-qt0-x244.google.com with SMTP id q8so1435046qtb.1
        for <linux-mips@linux-mips.org>; Mon, 18 Sep 2017 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CpC7g0CclT8mwnuiOWDHAN5ovNQTTbHi0jhb/xfjshw=;
        b=GAWoC9HjW6OkR5QPAfdUt9KHGQFoUdoWuv+n5Au78iFLrxOw18trTsdxN45E5cBpuQ
         zbJlDb1Ldln0ffERIEPpOfrVIukwrRixbHd9XPofAzLuewzFTxyVbbKNosGZQIKGL16U
         20tKrQuJ0ZC2jk6Vb/H5YfQ3Wci7UdxBm9/iyP55Y6Ww5XcHZEHATSJxqDhpb3ZdcOYx
         VZQSyUHY0p+xB+AjCT6zblmMqemqvxzyRXFKth3OeTsK/oksmxeILOnC6rAouIqZ98UX
         9lcKdq/quknfBahb23X4SSfvV+9scPWDZlWbPCl3OSZ7ze9eoSXcPxkDw1yL2KNu3xYk
         qMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CpC7g0CclT8mwnuiOWDHAN5ovNQTTbHi0jhb/xfjshw=;
        b=TI+LmdTHAD2hIqBDnISUAS1g+tX3WLNcwf0Gwcw6PcNmqRz/pxkZmjVmR/vspLxRvP
         BnTfSff5BfYeEnLtKzYJfHZkW2Ryo9WoZkBLe7PgxZZ8Ns2+CqS5vhvRH3nTR5mZb8mm
         auWFhe2KTooyspmb+0K4kIq3PMMW7A2sNxtNy6oeHTdg/fmQf/Spkkqolm7KAoXfappH
         sXhWkBCARVhg28BJgnXn7R5caemFpERLqHIQJvjYr6qQAi4jds2ClDWLx0nmKFCP7EDr
         zYcwUX9+H0tcHujGoGwT3uUZ7c6vgj8+bAMaxWoJ7HIQ8QoC/dSm6GjVteCqxbFYkkql
         gBSQ==
X-Gm-Message-State: AHPjjUhKOBbVRup3Z+IvAI+u571c2ez0jM7UrgrgJDU0b3AwEVHPsi74
        3zeB2LCkU5YXKQ==
X-Google-Smtp-Source: AOwi7QC3RQJuO7w7i0FprrrlpD1AXudUTrBb/bsSKA6eFlG2xzU4XpgAJLMXey5BcYzkWZNXHK9l/Q==
X-Received: by 10.200.35.21 with SMTP id a21mr44883807qta.215.1505782817204;
        Mon, 18 Sep 2017 18:00:17 -0700 (PDT)
Received: from stb-bld-02.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id x39sm6113273qtc.93.2017.09.18.18.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 18:00:16 -0700 (PDT)
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
        Mans Rullgard <mans@mansr.com>, Mason <slash.tmp@free.fr>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Frias <sf84@laposte.net>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/3] Add support for BCM7271 style interrupt controller
Date:   Mon, 18 Sep 2017 17:59:57 -0700
Message-Id: <20170919010000.32072-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.14.1
Return-Path: <opendmb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60067
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
for my needs.  Previous submissions offered candidate solutions to
address my needs within the generic irqchip library, but since those
submissions appear to have stalled I am submitting this version that
includes the function in the driver to prevent controversy and allow
the new functionality to be included. 

Changes in v4:

- The first three commits were removed from the patch set to remove any
  dependencies on changing the generic irqchip or irqchip-tango imple-
  mentations. If there is a will to make those changes in the future
  they can be applied at that time, but they needn't hold up the accept-
  ance of this patch set.
  
Changes in v3:

- I did not submit a v3 patch set, but Marc Gonzalez included a PATCH v3
  in a response to the v2 patch so I am skipping ahead to v4 to avoid
  confusion.
  
Changes in v2:

- removed unused permutations of irq_mask_ack methods
- added Reviewed-by and Acked-by responses from first submission

Doug Berger (3):
  irqchip: brcmstb-l2: Remove some processing from the handler
  irqchip: brcmstb-l2: Abstract register accesses
  irqchip: brcmstb-l2: Add support for the BCM7271 L2 controller

 .../bindings/interrupt-controller/brcm,l2-intc.txt |   3 +-
 drivers/irqchip/irq-brcmstb-l2.c                   | 171 +++++++++++++++------
 2 files changed, 126 insertions(+), 48 deletions(-)

-- 
2.14.1
