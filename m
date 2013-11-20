Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2013 11:46:23 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43120 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816852Ab3KTKqTqDtfL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Nov 2013 11:46:19 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/3] Add support for the interAptiv cores
Date:   Wed, 20 Nov 2013 10:45:59 +0000
Message-ID: <1384944362-7197-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_20_10_46_14
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

This patchset adds support for the interAptiv cores.

The interAptiv is a power-efficient multi-core microprocessor
for use in system-on-chip (SoC) applications. The interAptiv combines
a multi-threading pipeline with a coherence manager to deliver improved
computational throughput and power efficiency. The interAptiv can
contain one to four MIPS32R3 interAptiv cores, system level
coherence manager with L2 cache, optional coherent I/O port,
and optional floating point unit.

http://www.imgtec.com/mips/mips-interaptiv.asp

This patchset depends on the proAptiv patchset
http://www.linux-mips.org/archives/linux-mips/2013-11/msg00086.html

Leonid Yegoshin (3):
  MIPS: Add processor identifiers for the interAptiv processors
  MIPS: Add support for interAptiv cores
  MIPS: kernel: cpu-probe: Add support for probing interAptiv cores

 arch/mips/include/asm/cpu-type.h     | 1 +
 arch/mips/include/asm/cpu.h          | 4 +++-
 arch/mips/kernel/cpu-probe.c         | 8 ++++++++
 arch/mips/kernel/idle.c              | 1 +
 arch/mips/kernel/spram.c             | 1 +
 arch/mips/kernel/traps.c             | 1 +
 arch/mips/mm/c-r4k.c                 | 1 +
 arch/mips/oprofile/common.c          | 1 +
 arch/mips/oprofile/op_model_mipsxx.c | 4 ++++
 9 files changed, 21 insertions(+), 1 deletion(-)

-- 
1.8.4.3
