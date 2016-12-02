Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 14:39:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53624 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992121AbcLBNjkOlHh6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 14:39:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 93634CEB22E53;
        Fri,  2 Dec 2016 13:39:30 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 13:39:33 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] MIPS: Add per-cpu IRQ stack
Date:   Fri, 2 Dec 2016 13:39:12 +0000
Message-ID: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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


This series adds a separate stack for each CPU wihin the system to use
when handling IRQs. Previously IRQs were handled on the kernel stack of
the current task. If that task was deep down a call stack at the point
of the interrupt, and handling the interrupt required a deep IRQ stack,
then there was a likelihood of stack overflow. Since the kernel stack
is in normal unmapped memory, overflowing it can lead to silent
corruption of other kernel data, with weird and wonderful results.

Before this patch series, ftracing the maximum stack size of a v4.9-rc6
kernel running on a Ci40 board gave:
4996

And with this series:
4084

Handling interrupts on a separate stack reduces the maximum kernel stack
usage in this configuration by ~900 bytes.

Since do_IRQ is now invoked on a separate stack, we select
HAVE_IRQ_EXIT_ON_IRQ_STACK so that softirqs will also be executed on the
irq stack rather than attempting to switch with do_softirq_own_stack().

This series has been tested on MIPS Boston, Malta and SEAD3 platforms,
Pistachio on the Creator Ci40 board and Cavium Octeon III.



Matt Redfearn (5):
  MIPS: Introduce irq_stack
  MIPS: Stack unwinding while on IRQ stack
  MIPS: Only change $28 to thread_info if coming from user mode
  MIPS: Switch to the irq_stack in interrupts
  MIPS: Select HAVE_IRQ_EXIT_ON_IRQ_STACK

 arch/mips/Kconfig                  |  1 +
 arch/mips/include/asm/irq.h        | 12 ++++++
 arch/mips/include/asm/stackframe.h | 10 +++++
 arch/mips/kernel/asm-offsets.c     |  1 +
 arch/mips/kernel/genex.S           | 81 +++++++++++++++++++++++++++++++++++---
 arch/mips/kernel/irq.c             | 11 ++++++
 arch/mips/kernel/process.c         | 15 ++++++-
 7 files changed, 125 insertions(+), 6 deletions(-)

-- 
2.7.4
