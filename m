Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 23:38:04 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:58410 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993937AbeKUWiBNQN0- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 23:38:01 +0100
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 7500720028;
        Thu, 22 Nov 2018 00:38:00 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 00/24] MIPS: OCTEON: cleanups
Date:   Thu, 22 Nov 2018 00:37:21 +0200
Message-Id: <20181121223745.22792-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

I noticed some noise from "sparse" when compiling OCTEON platform code,
and started to fix some of the most obvious issues (e.g. adding includes
for missing function declarations, using static where appropriate
etc.). Then I also got around to deleting some of the dead code.
We have some insanely large include files, and two of the biggest ones
should be now closer to normal..

Boot tested on OCTEON+ (EdgeRouter Lite) and OCTEON 2 (EdgeRouter Pro).

Build tested with cavium_octeon_defconfig.

A.

Aaro Koskinen (24):
  MIPS: OCTEON: cvmx-l2c: make cvmx_l2c_spinlock static
  MIPS: OCTEON: setup: make internal functions and data static
  MIPS: OCTEON: setup: include asm/fw/fw.h
  MIPS: OCTEON: setup: include asm/prom.h
  MIPS: OCTEON: cvmx-helper: make
    __cvmx_helper_errata_fix_ipd_ptr_alignment static
  MIPS: OCTEON: delete unused loopback configuration functions
  MIPS: OCTEON: octeon-platform: make octeon_ids static
  MIPS: OCTEON: octeon-platform: fix typing
  MIPS: OCTEON: octeon-irq: make octeon_irq_ciu3_set_affinity() static
  MIPS: OCTEON: csrc-octeon: include linux/sched/clock.h
  MIPS: OCTEON: smp: make internal symbols static
  MIPS: OCTEON: cvmx-helper-util: delete cvmx_helper_dump_packet
  MIPS: OCTEON: cvmx-helper-util: make cvmx_helper_setup_red_queue
    static
  MIPS: OCTEON: make cvmx_bootmem_alloc_range static
  MIPS: OCTEON: cvmx-bootmem: delete unused functions
  MIPS: OCTEON: cvmx-bootmem: move code to avoid forward declarations
  MIPS: OCTEON: cvmx-bootmem: make more functions static
  MIPS: OCTEON: delete cvmx override functions
  MIPS: OCTEON: gmxx-defs.h: delete unused functions and macros
  MIPS: OCTEON: cvmx-gmxx-defs.h: delete unused unions
  MIPS: OCTEON: cvmx-gmxx-defs.h: delete unused union fields
  MIPS: OCTEON: cvmx-gmxx-defs.h: use default register value return when
    possible
  MIPS: OCTEON: cvmx-ciu2-defs.h: delete unused macros
  MIPS: OCTEON: cvmx-ciu2-defs.h: delete unused unions

 arch/mips/cavium-octeon/csrc-octeon.c         |    1 +
 .../cavium-octeon/executive/cvmx-bootmem.c    |  149 +-
 .../executive/cvmx-helper-rgmii.c             |   68 -
 .../executive/cvmx-helper-sgmii.c             |   38 -
 .../executive/cvmx-helper-util.c              |   90 +-
 .../executive/cvmx-helper-xaui.c              |   39 -
 .../cavium-octeon/executive/cvmx-helper.c     |   87 +-
 arch/mips/cavium-octeon/executive/cvmx-l2c.c  |    2 +-
 arch/mips/cavium-octeon/octeon-irq.c          |    4 +-
 arch/mips/cavium-octeon/octeon-platform.c     |    4 +-
 arch/mips/cavium-octeon/setup.c               |    8 +-
 arch/mips/cavium-octeon/smp.c                 |    4 +-
 arch/mips/include/asm/octeon/cvmx-bootmem.h   |   76 -
 arch/mips/include/asm/octeon/cvmx-ciu2-defs.h | 7060 -----------------
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h | 4940 +-----------
 .../include/asm/octeon/cvmx-helper-rgmii.h    |   17 -
 .../include/asm/octeon/cvmx-helper-sgmii.h    |   17 -
 .../include/asm/octeon/cvmx-helper-util.h     |   23 -
 .../include/asm/octeon/cvmx-helper-xaui.h     |   16 -
 arch/mips/include/asm/octeon/cvmx-helper.h    |   36 -
 20 files changed, 295 insertions(+), 12384 deletions(-)

-- 
2.17.0
