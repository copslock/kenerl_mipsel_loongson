Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 11:41:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18233 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009596AbbGIJlL1tDFh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 11:41:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B9E1910F43807
        for <linux-mips@linux-mips.org>; Thu,  9 Jul 2015 10:41:03 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Jul 2015 10:41:05 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 9 Jul 2015 10:41:04 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 00/19] Initial I6400 and CM3 support
Date:   Thu, 9 Jul 2015 10:40:34 +0100
Message-ID: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48137
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

This patchset adds support for I6400 processor along with the new
Coherent Manager 3.

More information about the I-Class Warrior family can be found below:

http://www.imgtec.com/mips/warrior/iclass.asp

Markos Chandras (15):
  MIPS: Add MIPS I6400 PRid and cputype identifiers
  MIPS: Add cases for CPU_I6400
  MIPS: Add MIPS I6400 probe support
  MIPS: Kconfig: Disable MIPS MT and SMP implementations for R6
  MIPS: Add platform callback before initializing the L2 cache
  MIPS: asm: mips-cm: Extend CM accessors for 64-bit CPUs
  MIPS: kernel: mips-cm: The CMGCRBase register is 64-bit on MIPS64
  MIPS: kernel: mips-cpc: Fix type for GCR CPC base reg for 64-bit
  MIPS: kernel: mips-cm: Add support for reporting CM cache errors
  drivers: irqchip: irq-mips-gic: Extend GIC accessors for 64-bit CMs
  drivers: irqchip: irq-mips-gic: Add support for CM3 64-bit timer irqs
  MIPS: kernel: cpu-probe: Remove cp0 hazard barrier when enabling the
    FTLB
  MIPS: Add default case for the FTLB enable/disable code
  MIPS: kernel: cpu-probe: Fix VTLB/FTLB configuration for R6
  MIPS: Set up FTLB probability for I6400

Paul Burton (4):
  MIPS: asm: mips-cm: Implement mips_cm_revision
  MIPS: asm: add CM GCR_L2_CONFIG register accessors
  MIPS: mm: c-r4k: extend way_string array
  MIPS: support CM3 L2 cache

 arch/mips/Kconfig                    |   6 +-
 arch/mips/include/asm/cpu-type.h     |   4 +
 arch/mips/include/asm/cpu.h          |   2 +
 arch/mips/include/asm/mips-cm.h      |  97 ++++++++++++-
 arch/mips/include/asm/mipsregs.h     |   2 +
 arch/mips/kernel/cpu-probe.c         |  47 +++++--
 arch/mips/kernel/idle.c              |   1 +
 arch/mips/kernel/mips-cm.c           | 257 ++++++++++++++++++++++++++++++++++-
 arch/mips/kernel/mips-cpc.c          |   2 +-
 arch/mips/kernel/perf_event_mipsxx.c |   6 +
 arch/mips/kernel/pm-cps.c            |   2 +
 arch/mips/kernel/spram.c             |   1 +
 arch/mips/kernel/traps.c             |   1 +
 arch/mips/mm/c-r4k.c                 |   5 +-
 arch/mips/mm/sc-mips.c               |  42 ++++++
 arch/mips/mti-malta/malta-init.c     |   7 +
 arch/mips/mti-malta/malta-int.c      | 112 +--------------
 arch/mips/oprofile/common.c          |   1 +
 arch/mips/oprofile/op_model_mipsxx.c |   4 +
 drivers/irqchip/irq-mips-gic.c       | 140 ++++++++++++-------
 include/linux/irqchip/mips-gic.h     |  14 +-
 21 files changed, 573 insertions(+), 180 deletions(-)

-- 
2.4.5
