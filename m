Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:19:47 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:39422 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012203AbaJ3CToginds (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:19:44 +0100
Received: by mail-pd0-f173.google.com with SMTP id v10so4165015pde.4
        for <multiple recipients>; Wed, 29 Oct 2014 19:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jcaouG6evwTuHjgCiIw6o50AWXtklE4oswJu0F7f8zE=;
        b=VitHGHTWDZhzVww9h9WwfbJy8TmKBZsGrpwiwKUr3In56osDGBfU6NE3/k2m/vslFf
         jPLspD0xUDiMaqVdH/APSKW9drDwex4fqxaCHjtTAjT/ckVNrI4silOAAN5QOIKhPbho
         9zE4D3TL6Zp0YptodD9UZQk9x7ljwxKZPUvunBmR7AsTl2RqBrYvAKsrWEWhXDuijyMO
         1dPwzaeeawfXfNg0j3kZab8/Z98lLLZk47s5WzYydme3jhEkA2h73LhldyhA5BMwr/Bl
         Z1OFcXGxVQfGG3qu/xFTU4ynzphJAs6YWfXgDVd1IccInYItNH+RsUaFNucB+A8DWM+v
         Hbfw==
X-Received: by 10.70.96.227 with SMTP id dv3mr13894165pdb.119.1414635578054;
        Wed, 29 Oct 2014 19:19:38 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.19.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:19:37 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 00/15] genirq endian fixes; bcm7120/brcmstb IRQ updates
Date:   Wed, 29 Oct 2014 19:17:53 -0700
Message-Id: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43739
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

I don't know if this will make everyone 100% happy but hopefully we're
inching slightly closer to a solution...

V1->V2:

 - Rework big endian support per the discussion on the list
 - Get rid of the global compile-time irq_reg_{readl,writel} accessors
   and make them private to generic-chip.c, so that on multiplatform
   kernels, different irqchip drivers can specify different MMIO behavior
 - Rebase on Linus's head of tree

Patch 06/15 still feels a bit like premature optimization to me.  Perhaps
we can drop it if nobody reports a measurable performance advantage in
any known configuration?


Kevin Cernekee (15):
  irqchip: Replace irq_reg_{readl,writel} with {readl,writel}
  sh: Eliminate unused irq_reg_{readl,writel} accessors
  genirq: Generic chip: Move irq_reg_{readl,writel} accessors into
    generic-chip.c
  genirq: Generic chip: Change irq_reg_{readl,writel} arguments
  genirq: Generic chip: Add big endian I/O accessors
  genirq: Generic chip: Optimize for fixed-endian systems
  irqchip: brcmstb-l2: Eliminate dependency on ARM code
  irqchip: bcm7120-l2: Eliminate bad IRQ check
  irqchip: Remove ARM dependency for bcm7120-l2 and brcmstb-l2
  irqchip: bcm7120-l2: Make sure all register accesses use base+offset
  irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
  irqchip: bcm7120-l2: Use gc->mask_cache to simplify suspend/resume
    functions
  irqchip: bcm7120-l2: Extend driver to support 64+ bit controllers
  irqchip: Decouple bcm7120-l2 from brcmstb-l2
  irqchip: bcm7120-l2: Enable big endian register accesses on BE kernels

 .../interrupt-controller/brcm,bcm7120-l2-intc.txt  |  26 +++-
 arch/arm/mach-bcm/Kconfig                          |   1 +
 arch/sh/boards/mach-se/7343/irq.c                  |   3 -
 arch/sh/boards/mach-se/7722/irq.c                  |   3 -
 drivers/irqchip/Kconfig                            |   8 +-
 drivers/irqchip/Makefile                           |   4 +-
 drivers/irqchip/irq-atmel-aic.c                    |  40 ++---
 drivers/irqchip/irq-atmel-aic5.c                   |  63 ++++----
 drivers/irqchip/irq-bcm7120-l2.c                   | 169 +++++++++++++--------
 drivers/irqchip/irq-brcmstb-l2.c                   |   7 +-
 drivers/irqchip/irq-sunxi-nmi.c                    |   4 +-
 drivers/irqchip/irq-tb10x.c                        |   4 +-
 include/linux/irq.h                                |   8 +-
 kernel/irq/Kconfig                                 |   5 +
 kernel/irq/Makefile                                |   1 +
 kernel/irq/generic-chip.c                          |  51 +++++--
 16 files changed, 237 insertions(+), 160 deletions(-)

-- 
2.1.1
