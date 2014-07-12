Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:49:55 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46933 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822968AbaGLKtxVbF6Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:49:53 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 5D57B2845A0;
        Sat, 12 Jul 2014 12:47:45 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 79C18280133;
        Sat, 12 Jul 2014 12:47:44 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 00/10] MIPS: BCM63XX: add irq affinity support for IPIC
Date:   Sat, 12 Jul 2014 12:49:32 +0200
Message-Id: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41159
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

This patch set adds support for setting the irq affinity of the internal
PIC found on SMP capable bcm63xx SoCs.

The PIC has two sets of mask/status registers, wired to two mips IRQs.
Each of the mips irqs can be assigned to a different core, so the irq to
cpu distribution is not fixed, but for simplicity it is assumed that
cpu0 => irq 2, and cpu 1 => irq 3.

Jonas Gorski (10):
  MIPS: BCM63XX: add width to __dispatch_internal
  MIPS: BCM63XX: move bcm63xx_init_irq down
  MIPS: BCM63XX: replace irq dispatch code with a generic version
  MIPS: BCM63XX: append irq line to irq_{stat,mask}*
  MIPS: BCM63XX: populate irq_{stat,mask}_addr for second cpu
  MIPS: BCM63XX: add cpu argument to dispatch internal
  MIPS: BCM63XX: protect irq register accesses
  MIPS: BCM63XX: wire up the second cpu's irq line
  MIPS: BCM63XX: use irq_desc as argument for (un)mask
  MIPS: BCM63XX: allow setting affinity for IPIC

 arch/mips/bcm63xx/irq.c                           | 451 +++++++++++++---------
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |  16 +-
 2 files changed, 278 insertions(+), 189 deletions(-)

-- 
2.0.0
