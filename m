Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 14:56:50 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:38351 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827335AbaAON4s1hTFH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 14:56:48 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 00/10] MIPS CPS cpuidle
Date:   Wed, 15 Jan 2014 13:55:27 +0000
Message-ID: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_13_56_42
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series introduces a cpuidle driver for systems based around the
MIPS Coherent Processing System, ie. those with a Coherence Manager and
optionally a Cluster Power Controller. The resulting driver is very
much foundational work to which deeper power states will later be added.

Tested on Malta using interAptiv bitstreams with both 1 & 2 VPEs in each
of 2 cores, and a multi-core proAptiv bitstream.

This series depends upon the CM changes of my "MIPS CPS SMP" series.

Paul Burton (10):
  MIPS: inst.h: define COP0 wait op
  MIPS: inst.h: define missing microMIPS POOL32AXf ops
  MIPS: uasm: add sync instruction
  MIPS: uasm: add wait instruction
  MIPS: uasm: add jr.hb instruction
  MIPS: uasm: add mftc0 & mttc0 instructions
  MIPS: uasm: add a label variant of beq
  MIPS: support use of cpuidle
  cpuidle: declare cpuidle_dev in cpuidle.h
  cpuidle: cpuidle driver for MIPS CPS

 arch/mips/Kconfig                  |   2 +
 arch/mips/include/asm/idle.h       |  14 +
 arch/mips/include/asm/uasm.h       |   7 +
 arch/mips/include/uapi/asm/inst.h  |  15 +-
 arch/mips/kernel/idle.c            |  20 +-
 arch/mips/mm/uasm-micromips.c      |   3 +
 arch/mips/mm/uasm-mips.c           |   5 +
 arch/mips/mm/uasm.c                |  25 +-
 drivers/cpuidle/Kconfig            |   5 +
 drivers/cpuidle/Kconfig.mips       |  14 +
 drivers/cpuidle/Makefile           |   3 +
 drivers/cpuidle/cpuidle-mips-cps.c | 545 +++++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h            |   1 +
 13 files changed, 650 insertions(+), 9 deletions(-)
 create mode 100644 drivers/cpuidle/Kconfig.mips
 create mode 100644 drivers/cpuidle/cpuidle-mips-cps.c

-- 
1.8.4.2
