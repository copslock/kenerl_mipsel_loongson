Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2015 22:46:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32352 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011533AbbA0VqSsPqZj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2015 22:46:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 56A5FED119CE;
        Tue, 27 Jan 2015 21:46:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 27 Jan 2015 21:46:12 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 27 Jan 2015 21:46:11 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Robert Richter <rric@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <oprofile-list@lists.sf.net>
Subject: [PATCH 0/9] MIPS: Allow shared IRQ for timer & perf counter
Date:   Tue, 27 Jan 2015 21:45:46 +0000
Message-ID: <1422395155-16511-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The main purpose of this patchset is to enable the MIPS CPU IRQ lines to
be shared by the timer handler and performance counter handlers on MIPS
r2+ cores, i.e. using IRQF_SHARED instead of having the timer handler
directly call the perf counter handler.

This will allow the handling of local IRQs to scale to a 3rd IRQ for the
fast debug channel (FDC), which would get pretty messy using calls
between handlers as each interrupt can be arbitrarily routed to
different or shared IRQ lines since MIPS r2.

Pre-r2 IRQF_SHARED cannot be used as we aren't guaranteed to have
individual local interrupt pending bits in CP0_Cause, so the interrupt
conditions must be checked in the right order by the cevt-r4k handler.


Patches 1-5 are minor refactors for stuff noticed along the way and
shouldn't have any functional change by themselves.

Patches 6-8 convert each of the timer and perf handlers to use
compatible IRQ flags, and finally patch 9 makes the switch so that the
interrupt line numbers may be the same on r2.


Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Robert Richter <rric@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
Cc: oprofile-list@lists.sf.net


James Hogan (9):
  MIPS: cevt-r4k: Move handle_perf_irq() out of header
  MIPS: Use CAUSEF_TI, CAUSEF_PCI constants
  MIPS: Remove redundant IPTI==IPPCI logic
  irqchip: mips-gic: Fix typo in comment
  irqchip: mips-gic: Add missing definitions for FDC IRQ
  MIPS: cevt-r4k: Make interrupt handler shared
  MIPS: perf: Allow sharing IRQ with timer
  MIPS: OProfile: Allow sharing IRQ with timer
  MIPS: Allow shared IRQ for timer & perf counter

 arch/mips/include/asm/cevt-r4k.h     | 19 -------------------
 arch/mips/kernel/cevt-r4k.c          | 28 ++++++++++++++++++++++++++--
 arch/mips/kernel/perf_event_mipsxx.c | 11 ++++++-----
 arch/mips/kernel/traps.c             |  2 --
 arch/mips/oprofile/op_model_mipsxx.c | 10 ++++++----
 drivers/irqchip/irq-mips-gic.c       |  2 +-
 include/linux/irqchip/mips-gic.h     |  6 ++++++
 7 files changed, 45 insertions(+), 33 deletions(-)

-- 
2.0.5
