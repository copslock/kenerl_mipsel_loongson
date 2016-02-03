Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:16:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7361 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006154AbcBCDQY3-gF0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:16:24 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id AA35B8BF532D1;
        Wed,  3 Feb 2016 03:16:17 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:16:17 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:16:17 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "Ezequiel Garcia" <ezequiel.garcia@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Petri Gynther <pgynther@google.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 00/15] Support for MIPSr6 Virtual Processors (multi-threading)
Date:   Wed, 3 Feb 2016 03:15:20 +0000
Message-ID: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51628
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

This series introduces support for the multi-core & multi-threading
capabilities of the I6400. That is, it introduces support for MIPSr6
Virtual Processors & enables CPS SMP for MIPSr6.

Based atop v4.5-rc2.

Markos Chandras (3):
  MIPS: traps: Make sure secondary cores have a sane ebase register
  MIPS: pm-cps: Avoid offset overflow on MIPSr6
  MIPS: CPC: Add start, stop and running CM3 CPC registers

Paul Burton (12):
  MIPS: Detect MIPSr6 Virtual Processor support
  MIPS: CM: Add CM GCR_BEV_BASE accessors
  MIPS: CM: Fix mips_cm_max_vp_width for UP kernels
  irqchip: mips-gic: Use HW IDs for VPE_OTHER_ADDR
  irqchip: mips-gic: Provide VP ID accessor
  MIPS: smp-cps: Ensure our VP ident calculation is correct
  MIPS: smp-cps: Pull cache init into a function
  MIPS: smp-cps: Pull boot config retrieval out of mips_cps_boot_vpes
  MIPS: smp-cps: Skip core setup if coherent
  MIPS: smp-cps: Support MIPSr6 Virtual Processors
  MIPS: smp-cps: Add nothreads kernel parameter
  MIPS: smp-cps: Stop printing EJTAG exceptions to UART

 arch/mips/Kconfig                    |   2 +-
 arch/mips/include/asm/cpu-features.h |   4 +
 arch/mips/include/asm/cpu-info.h     |   4 +-
 arch/mips/include/asm/cpu.h          |   1 +
 arch/mips/include/asm/mips-cm.h      |   6 +-
 arch/mips/include/asm/mips-cpc.h     |   3 +
 arch/mips/include/asm/mipsregs.h     |   1 +
 arch/mips/include/asm/smp-cps.h      |   2 +-
 arch/mips/kernel/cps-vec.S           | 296 ++++++++++++++++++++++-------------
 arch/mips/kernel/cpu-probe.c         |   2 +
 arch/mips/kernel/pm-cps.c            |  15 +-
 arch/mips/kernel/smp-cps.c           |  64 +++++++-
 arch/mips/kernel/traps.c             |   7 +
 drivers/irqchip/irq-mips-gic.c       |  22 ++-
 include/linux/irqchip/mips-gic.h     |  17 ++
 15 files changed, 320 insertions(+), 126 deletions(-)

-- 
2.7.0
