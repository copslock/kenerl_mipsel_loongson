Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 14:14:04 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35589 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867261Ab3LRNOA3ezZc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 14:14:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 9043828A923;
        Wed, 18 Dec 2013 14:11:42 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0C17528026E;
        Wed, 18 Dec 2013 14:11:36 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2 00/13] MIPS: improve BMIPS support
Date:   Wed, 18 Dec 2013 14:11:58 +0100
Message-Id: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.5.1
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38733
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

This patchset aims at unifying the different BMIPS support code to allow
building a kernel that runs on multiple BCM63XX SoCs which might have
different BMIPS flavours on them, regardless of SMP support enabled in
the kernel.

The first few patches clean up BMIPS itself and prepare it for multi-cpu
support, while the latter add support to BCM63XX for running a SMP kernel
with support for all SoCs, even those that do not have a SMP capable
CPU.

This patchset is runtime tested on BCM6348, BCM6328 and BCM6368, to
verify that it actually does what it claims it does.

Lacking hardware, it is only build tested for BMIPS4380 and BMIPS5000.

Changes V1 -> V2:
 * dropped the compilation fix (a different fix  was already comitted)
 * rebased on the cpu-type cleanup patches
 * used the cpu-type cleanup effects to remove the macros and replace
   them with normal switch-cases.
 * Let BCM47XX_SSB also select BMIPS32_3300

Jonas Gorski (13):
  MIPS: BCM63XX: disable SMP also on BCM3368
  MIPS: allow asm/cpu.h to be included from assembly
  MIPS: BMIPS: change compile time checks to runtime checks
  MIPS: BMIPS: merge CPU options into one option
  MIPS: BMIPS: select CPU_SUPPORTS_HIGHMEM
  MIPS: BMIPS: select CPU_HAS_PREFETCH
  MIPS: BMIPS: extend BMIPS3300 to include BMIPS32
  MIPS: BMIPS: add a smp ops registration helper
  MIPS: BCM63XX: always register bmips smp ops
  MIPS: BCM63XX: let the individual SoCs select the appropriate CPUs
  MIPS: BCM47XX: select BMIPS CPUs for BCM47XX_SSB
  MIPS: cpu-type: guard BMIPS variants with SYS_HAS_CPU_BMIPS*
  MIPS: BCM63XX: drop SYS_HAS_CPU_MIPS32R1

 arch/mips/Kconfig                |  84 +++++------
 arch/mips/bcm47xx/Kconfig        |   1 +
 arch/mips/bcm63xx/Kconfig        |   8 +
 arch/mips/bcm63xx/prom.c         |  14 +-
 arch/mips/include/asm/bmips.h    |  29 +++-
 arch/mips/include/asm/cpu-type.h |  13 +-
 arch/mips/include/asm/cpu.h      |   3 +
 arch/mips/kernel/bmips_vec.S     |  55 +++++--
 arch/mips/kernel/smp-bmips.c     | 312 ++++++++++++++++++++++++---------------
 9 files changed, 329 insertions(+), 190 deletions(-)

-- 
1.8.5.1
