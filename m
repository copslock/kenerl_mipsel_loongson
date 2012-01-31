Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:15:16 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59750 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904023Ab2AaOMs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:12:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 1245835E45B;
        Tue, 31 Jan 2012 15:12:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UqYWwCursDvm; Tue, 31 Jan 2012 15:12:47 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id A65CD31C642;
        Tue, 31 Jan 2012 15:12:47 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/5 v2] MIPS: BCM63XX: add support for hardware RNG
Date:   Tue, 31 Jan 2012 15:12:20 +0100
Message-Id: <1328019145-5946-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 32358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch set depends on the serie "MIPS: BCM63XX: add support for SPI"
and adds support for the RNG block found in BCM6368 SoCs.

Herbert, Matt, this will probably better to get this merged via
the MIPS tree considering the patches it depends on.

Florian Fainelli (5):
  MIPS: BCM63XX: fix BCM6368 IPSec clock bit
  MIPS: BCM63XX: add support for "ipsec" clock
  MIPS: BCM63XX: add RNG peripheral definitions
  MIPS: BCM63XX: add RNG driver platform_device stub
  hw_random: add Broadcom BCM63xx RNG driver

 arch/mips/bcm63xx/Makefile                        |    4 +-
 arch/mips/bcm63xx/clk.c                           |   14 ++
 arch/mips/bcm63xx/dev-rng.c                       |   40 +++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |    9 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   16 ++-
 drivers/char/hw_random/Kconfig                    |   14 ++
 drivers/char/hw_random/Makefile                   |    1 +
 drivers/char/hw_random/bcm63xx-rng.c              |  175 +++++++++++++++++++++
 8 files changed, 270 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-rng.c
 create mode 100644 drivers/char/hw_random/bcm63xx-rng.c

-- 
1.7.5.4
