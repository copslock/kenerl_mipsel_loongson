Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 07:45:08 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44040 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006516AbaKGGpGnQVmk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 07:45:06 +0100
Received: by mail-pa0-f47.google.com with SMTP id kx10so2919758pab.34
        for <multiple recipients>; Thu, 06 Nov 2014 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=v77CPUXcNIsyEC6VoCZbq4rkQdn0slaSpER+vfEWyOU=;
        b=oc5zHsvCQY08PttQAIGZFwwE7nZgisg4XxYmVvoqs5qes0jWI/w/M1hDFxIhTMgKC8
         aMmSNrSeKO5b4eQVYTKO8Ca4PNVtLjxbeXcpVWkhqIbiIxS/DPtDt5DMMZQEKLX5IEdn
         QJ0nSeBJ3KzvfYihh1VZX6jJZNsTm6CLEHiEgrWlEnxWs/bF7JylK0Dx9lJn5/KCwsvU
         h/iktJgCm+RdJeMQMzmRvjr41ijyAFg9zSw0RkroIkH1NX4imqF4Jjb3C1cdNujjKvpr
         viihxykAGYWDY0b/1LbdB+Vcpmra7wpKhPOeZnH3dRu8cT5vbvi0YGWWGxV58x6FZRyv
         devw==
X-Received: by 10.70.123.169 with SMTP id mb9mr921048pdb.62.1415342700427;
        Thu, 06 Nov 2014 22:45:00 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fy4sm7686827pbb.42.2014.11.06.22.44.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 22:44:59 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org,
        sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: [PATCH V4 00/14] genirq endian fixes; bcm7120/brcmstb IRQ updates
Date:   Thu,  6 Nov 2014 22:44:15 -0800
Message-Id: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43893
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

V3->V4:

 - Fix buildbot bisectability warning on patch 02/14 (missing include)

 - Add kernel-doc text for the new reg_{readl,writel} struct members and
   IRQ_GC_BE_IO flag


Kevin Cernekee (14):
  sh: Eliminate unused irq_reg_{readl,writel} accessors
  genirq: Generic chip: Change irq_reg_{readl,writel} arguments
  genirq: Generic chip: Allow irqchip drivers to override
    irq_reg_{readl,writel}
  genirq: Generic chip: Add big endian I/O accessors
  irqchip: brcmstb-l2: Eliminate dependency on ARM code
  irqchip: bcm7120-l2: Eliminate bad IRQ check
  irqchip: bcm7120-l2, brcmstb-l2: Remove ARM Kconfig dependency
  irqchip: bcm7120-l2: Make sure all register accesses use base+offset
  irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
  irqchip: bcm7120-l2: Use gc->mask_cache to simplify suspend/resume
    functions
  irqchip: bcm7120-l2: Extend driver to support 64+ bit controllers
  irqchip: bcm7120-l2: Decouple driver from brcmstb-l2
  irqchip: bcm7120-l2: Convert driver to use irq_reg_{readl,writel}
  irqchip: brcmstb-l2: Convert driver to use irq_reg_{readl,writel}

 .../interrupt-controller/brcm,bcm7120-l2-intc.txt  |  26 ++-
 arch/arm/mach-bcm/Kconfig                          |   1 +
 arch/sh/boards/mach-se/7343/irq.c                  |   3 -
 arch/sh/boards/mach-se/7722/irq.c                  |   3 -
 drivers/irqchip/Kconfig                            |   6 +-
 drivers/irqchip/Makefile                           |   4 +-
 drivers/irqchip/irq-atmel-aic.c                    |  40 ++---
 drivers/irqchip/irq-atmel-aic5.c                   |  65 ++++----
 drivers/irqchip/irq-bcm7120-l2.c                   | 174 +++++++++++++--------
 drivers/irqchip/irq-brcmstb-l2.c                   |  41 +++--
 drivers/irqchip/irq-sunxi-nmi.c                    |   4 +-
 drivers/irqchip/irq-tb10x.c                        |   4 +-
 include/linux/irq.h                                |  32 +++-
 kernel/irq/generic-chip.c                          |  36 +++--
 14 files changed, 263 insertions(+), 176 deletions(-)

-- 
2.1.1
