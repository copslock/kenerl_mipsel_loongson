Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 20:03:42 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59804 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903740Ab1LITBy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2011 20:01:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 0B660398898;
        Fri,  9 Dec 2011 20:01:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4WlsFwIdJoUM; Fri,  9 Dec 2011 20:01:53 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id A9DA035E2DB;
        Fri,  9 Dec 2011 20:01:53 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     Matt Mackall <mpm@selenic.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/5] Broadcom BCM63xx RNG support
Date:   Fri,  9 Dec 2011 20:01:05 +0100
Message-Id: <1323457270-16330-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 32074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7990

The following patch serie adds support for the Broadcom BCM63xx RNG block.

Since it depends on some MIPS bits, it might be easier to merge it via the
MIPS tree.

Thanks!

Florian Fainelli (5):
  MIPS: BCM63XX: fix BCM6368 IPSec clock bit
  MIPS: BCM63XX: add support for "ipsec" clock
  MIPS: BCM63XX: add TRNG peripheral definitions
  MIPS: BCM63XX: add RNG driver platform_device stub
  hw_random: add Broadcom BCM63xx RNG driver

 arch/mips/bcm63xx/Makefile                        |    3 +-
 arch/mips/bcm63xx/clk.c                           |   14 ++
 arch/mips/bcm63xx/dev-trng.c                      |   40 +++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |    9 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   15 ++-
 drivers/char/hw_random/Kconfig                    |   14 ++
 drivers/char/hw_random/Makefile                   |    1 +
 drivers/char/hw_random/bcm63xx-rng.c              |  175 +++++++++++++++++++++
 8 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-trng.c
 create mode 100644 drivers/char/hw_random/bcm63xx-rng.c

-- 
1.7.5.4
