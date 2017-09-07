Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 01:26:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49652 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994818AbdIGX0IRLB1k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2017 01:26:08 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 79B593ABE7B90;
        Fri,  8 Sep 2017 00:25:56 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 8 Sep 2017 00:26:01
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <dianders@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Brian Norris <briannorris@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>,
        <jeffy.chen@rock-chips.com>, Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <tfiga@chromium.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [RFC PATCH v1 0/9] Support shared percpu interrupts; clean up MIPS hacks
Date:   Thu, 7 Sep 2017 16:25:33 -0700
Message-ID: <20170907232542.20589-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1682867.tATABVWsV9@np-p-burton>
References: <1682867.tATABVWsV9@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59954
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

This series introduces support for percpu shared interrupts and makes
use of this support to clean up some hacks that have been used to
support such interrupts on MIPS.

- Patch 1 allows users of shared interrupts to opt into IRQ_NOAUTOEN
  behaviour & avoid warnings from doing so.

- Patch 2 introduces support for shared percpu_devid interrupts.

- Patch 3 introduces a helper allowing users to detect whether an
  interrupt is a percpu_devid interrupt or not, which is useful
  during the transition phase where interrupts may be either.

- Patches 4 & 5 removes an ugly custom implementation of shared
  interrupts between the MIPS cevt-r4k timer driver & users of
  performance counters, in favor of using standard IRQF_SHARED &
  multiple handlers.

- Patches 6 & 7 add percpu interrupt support to the MIPS perf &
  cevt-r4k timer drivers respectively.

- Patch 8 configures the MIPS cop 0 count/compare, fast debug channel &
  performance counter overflow interrupts as percpu_devid when they are
  mapped by the irqchip-mips-cpu driver.

- Patch 9 removes a hack from the irqchip-mips-gic driver that was
  used to enable & disable an interrupt across all CPUs, which is no
  longer necessary with users of those interrupts using the percpu
  interrupt APIs correctly. This mirrors patch 8 for systems where we
  map the CPU local interrupts via the GIC.

There's a little more work necessary before this could go in - the
MIPS oprofile code needs adjusting to use the percpu interrupt APIs, as
does the fast debug channel driver.

Applies atop next-20170905.

Paul Burton (9):
  genirq: Allow shared interrupt users to opt into IRQ_NOAUTOEN
  genirq: Support shared per_cpu_devid interrupts
  genirq: Introduce irq_is_percpu_devid()
  MIPS: Remove perf_irq interrupt sharing fallback
  MIPS: Remove perf_irq
  MIPS: perf: percpu_devid interrupt support
  MIPS: cevt-r4k: percpu_devid interrupt support
  irqchip: mips-cpu: Set timer, FDC & perf interrupts percpu_devid
  irqchip: mips-gic: Remove gic_all_vpes_local_irq_controller

 arch/mips/include/asm/time.h            |  1 -
 arch/mips/kernel/cevt-r4k.c             | 77 ++++++++++++-----------------
 arch/mips/kernel/perf_event_mipsxx.c    | 71 +++++++++++----------------
 arch/mips/kernel/time.c                 |  9 ----
 arch/mips/kernel/traps.c                |  2 +-
 arch/mips/oprofile/op_impl.h            |  2 -
 arch/mips/oprofile/op_model_loongson3.c | 39 +++++++--------
 arch/mips/oprofile/op_model_mipsxx.c    | 10 +---
 drivers/irqchip/irq-mips-cpu.c          |  9 +++-
 drivers/irqchip/irq-mips-gic.c          | 69 +++-----------------------
 include/linux/interrupt.h               |  2 +
 include/linux/irqdesc.h                 |  8 +++
 kernel/irq/chip.c                       |  8 +--
 kernel/irq/handle.c                     |  8 ++-
 kernel/irq/manage.c                     | 86 +++++++++++++++++++++++++--------
 kernel/irq/settings.h                   |  5 ++
 16 files changed, 189 insertions(+), 217 deletions(-)

-- 
2.14.1
