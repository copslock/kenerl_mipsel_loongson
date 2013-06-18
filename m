Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 11:35:22 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:39639 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822837Ab3FRJexPlqJM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 11:34:53 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-012-093.pools.arcor-ip.net [88.73.12.93])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E6AB02803E8;
        Tue, 18 Jun 2013 11:33:21 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 0/2] MIPS: BCM63XX: add SMP support
Date:   Tue, 18 Jun 2013 11:34:30 +0200
Message-Id: <1371548072-6247-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36965
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

Most newer BCM63XX SoCs after BCM6358 use a BMIPS4350 CPU with SMP
support. This patchset allows BCM6368 and BCM6362 to boot a SMP kernel
(both tested, as well as (not yet upstreamed) BCM63268).

BCM6328 has its second core only in a few variants enabled, but this can
be probed at runtime.

BCM6358 is intentionally skipped because it shares a single TLB for
both cores/threads, which requires implementing locking for TLB accesses,
and ain't nobody got time for that.

The internal interrupt controller supports routing IRQs to both CPUs,
and support will be added in a later patchset. For now all hardware
interrupts will go to CPU0.

Totally unscientific OpenSSL benchmarking shows a nice ~90% speed
increase when enabling the second core.

No idea about the FIXME in 1/2, never had a problem with it so I left it
in place as to have it documented.

Changes V1 -> V2:
 * removed already applied patches
 * added a check for SMP availability on BCM6328
 * changed #ifdef FOO to if (IS_ENABLED(FOO))

Jonas Gorski (1):
  MIPS: BCM63XX: Enable second core SMP on BCM6328 if available

Kevin Cernekee (1):
  MIPS: BCM63XX: Add SMP support to prom.c

 arch/mips/bcm63xx/prom.c                          |   45 +++++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    7 ++++
 3 files changed, 54 insertions(+)

-- 
1.7.10.4
