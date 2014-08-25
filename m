Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 15:26:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52563 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006715AbaHYN0pnX46A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 15:26:45 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PDQjFk030054
        for <linux-mips@linux-mips.org>; Mon, 25 Aug 2014 15:26:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PDQjjP030053
        for linux-mips@linux-mips.org; Mon, 25 Aug 2014 15:26:45 +0200
Date:   Mon, 25 Aug 2014 15:26:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Fwd: MIPS: Pull Request
Message-ID: <20140825132645.GA29979@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

FYI, below the last pull request to Linus.

  Ralf

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.linux-mips.org/pub/scm/ralf/upstream-linus.git upstream

for you to fetch changes up to 608308682addfdc7b8e2aee88f0e028331d88e4d:

  MIPS: OCTEON: make get_system_type() thread-safe (2014-08-19 18:24:42 +0200)

MIPS fixes for 3.17.  Pretty much all across the field so with this we
should be in reasonable shape for the upcoming -rc2.

Please consider pulling,

  Ralf

----------------------------------------------------------------

Aaro Koskinen (1):
      MIPS: OCTEON: make get_system_type() thread-safe

Guenter Roeck (1):
      MIPS: NL: Fix nlm_xlp_defconfig build error

Hauke Mehrtens (1):
      MIPS: BCM47XX: Fix reboot problem on BCM4705/BCM4785

Huacai Chen (1):
      MIPS: Loongson: Fix COP2 usage for preemptible kernel

Lars Persson (1):
      MIPS: Remove race window in page fault handling

Manuel Lauss (1):
      MIPS: Alchemy: Fix db1200 PSC clock enablement

Markos Chandras (6):
      MIPS: Malta: Improve system memory detection for '{e, }memsize' >= 2G
      MIPS: syscall: Fix AUDIT value for O32 processes on MIPS64
      MIPS: scall64-o32: Fix indirect syscall detection
      MIPS: EVA: Add new EVA header
      MIPS: Malta: EVA: Rename 'eva_entry' to 'platform_eva_init'
      MIPS: CPS: Initialize EVA before bringing up VPEs from secondary cores

Ralf Baechle (1):
      MIPS: GIC: Remove useless parens from GICBIS().

Sergey Ryazanov (2):
      MIPS: MSP71xx: remove unused plat_irq_dispatch() argument
      MIPS: Add common plat_irq_dispatch declaration

Wei Yongjun (1):
      MIPS: Remove duplicated include from numa.c

Yang Wei (1):
      MIPS: perf: Mark pmu interupt IRQF_NO_THREAD

 arch/mips/alchemy/devboards/db1200.c               |  6 +--
 arch/mips/bcm47xx/setup.c                          | 13 ++++++-
 arch/mips/cavium-octeon/setup.c                    | 19 +++++++---
 arch/mips/include/asm/eva.h                        | 43 ++++++++++++++++++++++
 arch/mips/include/asm/gic.h                        |  2 +-
 arch/mips/include/asm/irq.h                        |  2 +
 .../include/asm/mach-malta/kernel-entry-init.h     | 22 ++++++++---
 arch/mips/include/asm/mach-netlogic/topology.h     |  7 ----
 arch/mips/include/asm/pgtable.h                    |  8 ++--
 arch/mips/include/asm/syscall.h                    |  8 ++--
 arch/mips/kernel/cps-vec.S                         |  4 ++
 arch/mips/kernel/perf_event_mipsxx.c               |  2 +-
 arch/mips/kernel/scall64-o32.S                     | 12 ++++--
 arch/mips/loongson/loongson-3/cop2-ex.c            |  8 ++--
 arch/mips/loongson/loongson-3/numa.c               |  2 -
 arch/mips/mm/cache.c                               | 27 ++++++++++----
 arch/mips/mti-malta/malta-memory.c                 | 14 +++++--
 arch/mips/pmcs-msp71xx/msp_irq.c                   |  2 +-
 18 files changed, 142 insertions(+), 59 deletions(-)
 create mode 100644 arch/mips/include/asm/eva.h
