Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 16:54:05 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37235 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861337AbaGHOxmh06BD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 16:53:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id E3D4F28BB85;
        Tue,  8 Jul 2014 16:51:37 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 6A17C28B44E;
        Tue,  8 Jul 2014 16:51:28 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 0/8] MIPS: BCM63XX: remove !RUNTIME_DETECT support
Date:   Tue,  8 Jul 2014 16:53:16 +0200
Message-Id: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

The advantages compared to the added maintaince burden of ensuring
that changes don't break the single-soc support with !RUNTIME_DETECT
are rather small, so remove it.

The only place where it might have any impact might be the irq code.
But even then replacing it with UASM might be a better choice, as it
would then profit all targets.

P.S: there is a small lie in 7/8, but since BCM6318 support isn't
yet upstream, it is valid for the current code. BCM6318 has only
a BCM3300 CPU, but it does have dc aliases (at least according to
the bootlog).

Jonas Gorski (8):
  MIPS: BCM63XX: remove !RUNTIME_DETECT code from register sets
  MIPS: BCM63XX: remove !RUNTIME_DETECT from irq setup code
  MIPS: BCM63XX: remove !RUNTIME_DETECT from reset code
  MIPS: BCM63XX: remove !RUNTIME_DETECT code from gpio code
  MIPS: BCM63XX: remove !RUNTIME_DETECT from spi code
  MIPS: BCM63XX: remove !RUNTIME_DETECT usage from enet code
  MIPS: BCM63XX: remove !RUNTIME_DETECT in cpu-feature-overrides
  MIPS: BCM63XX: remove !RUNTIME_DETECT code for bcmcpu_get_id

 arch/mips/bcm63xx/cpu.c                            |  11 +-
 arch/mips/bcm63xx/dev-enet.c                       |   4 -
 arch/mips/bcm63xx/dev-spi.c                        |   4 -
 arch/mips/bcm63xx/gpio.c                           |  14 --
 arch/mips/bcm63xx/irq.c                            | 109 ------------
 arch/mips/bcm63xx/reset.c                          |  60 -------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   | 198 ++++-----------------
 .../include/asm/mach-bcm63xx/bcm63xx_dev_enet.h    |  46 -----
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |  31 ----
 .../asm/mach-bcm63xx/cpu-feature-overrides.h       |   2 +-
 10 files changed, 39 insertions(+), 440 deletions(-)

-- 
2.0.0
