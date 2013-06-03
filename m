Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jun 2013 17:41:02 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:40384 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825883Ab3FCPkiMKKnm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Jun 2013 17:40:38 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-012-093.pools.arcor-ip.net [88.73.12.93])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9B94128016C;
        Mon,  3 Jun 2013 17:39:17 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 0/3] MIPS: BCM63XX: add SMP support
Date:   Mon,  3 Jun 2013 17:39:32 +0200
Message-Id: <1370273975-12373-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36662
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

BCM6328 is skipped because the only SMP versions will be rejected by
current code (they are BCM6329, which is treated as a totally
unsupported chip).

BCM6358 is intentionally skipped because it shares a single TLB for
both cores/threads, which requires implementing locking for TLB accesses,
and ain't nobody got time for that.

The internal interrupt controller supports routing IRQs to both CPUs,
and support will be added in a later patchset. For now all hardware
interrupts will go to CPU0.

Totally unscientific OpenSSL benchmarking shows a nice ~90% speed
increase when enabling the second core.

No idea about the FIXME in 1/3, never had a problem with it so I left it
in place as to have it documented.

Jonas Gorski (1):
  MIPS: BCM63XX: select BMIPS4350 and default to 2 CPUs for supported
    SoCs

Kevin Cernekee (2):
  MIPS: BCM63XX: Add SMP support to prom.c
  MIPS: BCM63XX: Handle SW IRQs 0-1

 arch/mips/Kconfig        |    2 ++
 arch/mips/bcm63xx/irq.c  |    4 ++++
 arch/mips/bcm63xx/prom.c |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

-- 
1.7.10.4
