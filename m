Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 17:53:45 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:33938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025894AbcC3PxoPCF7N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2016 17:53:44 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 614BBADE2;
        Wed, 30 Mar 2016 15:53:41 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 0/5] Cleaning printk stuff in NMI context
Date:   Wed, 30 Mar 2016 17:53:25 +0200
Message-Id: <1459353210-20260-1-git-send-email-pmladek@suse.com>
X-Mailer: git-send-email 1.8.5.6
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmladek@suse.com
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

This patch set generalizes the already existing solution for
printing NMI messages. The main idea comes from Peter Zijlstra.

v4 adds one more patch that flushes NNI buffers when the system
is panicing. Otherwise, it is almost the same as the last version
in the -mm tree, see changes below for more details

There is a trivial conflict with Sergey's v8 of async printk,
see http://thread.gmane.org/gmane.linux.kernel/2183611
In short, we must handle console in vprintk_emit() neither in sched
nor in nmi. Therefore we need the line

	if (!in_sched && !deferred_console_in_nmi()) {


There are move conflicts with the nmi_backtrace improvements
from Chris Metcalf, see
 http://marc.info/?l=linux-kernel&m=145866814901740&w=2
Feel free to ask me to resolve them.


Changes against v3:

  + merged all small changes from -mm tree, including commit
    descriptions

  + disabled interrupts when taking the read_lock in __printk_nmi_flush();
    printk_nmi_flush() might be called from any context; reported
    by lockdep

  + never introduce NEED_PRINTK_NMI; in -mm tree was introduced
    in 1st patch and removed in the 4th one

  + flush NMI buffers when the system goes down (new 5th patch);
    addresses Daniel's concerns


Changes against v2:

  + fixed compilation problems reported by 0-day build robot

  + MN10300 and Xtensa architectures will get handled separately

  + dropped the patch that printed NMI messages directly when Oops
    in progress; it made the solution less reliable

  + made the size of the buffer configurable; use real numbers
    instead of PAGE_SIZE


Changes against v1:

  + rebased on top of 4.4-rc2; there the old implementation was
    moved to lib/nmi_backtrace.c and used also on arm; I hope that
    I got the arm side correctly; I was not able to test on arm :-(

  + defined HAVE_NMI on arm for !CPU_V7M instead of !CPU_V7;
    handle_fiq_as_nmi() is called from entry-armv.S that
    is compiled when !CPU_V7M

  + defined HAVE_NMI also on mips; it calls nmi_enter() and
    seems to have real NMIs (or am I wrong?)

  + serialized backtraces when printing directly
    (oops_in_progress)


Petr Mladek (5):
  printk/nmi: generic solution for safe printk in NMI
  printk/nmi: use IRQ work only when ready
  printk/nmi: warn when some message has been lost in NMI context
  printk/nmi: increase the size of NMI buffer and make it configurable
  printk/nmi: flush NMI messages on the system panic

 arch/Kconfig                  |   4 +
 arch/arm/Kconfig              |   1 +
 arch/arm/kernel/smp.c         |   2 +
 arch/avr32/Kconfig            |   1 +
 arch/blackfin/Kconfig         |   1 +
 arch/cris/Kconfig             |   1 +
 arch/mips/Kconfig             |   1 +
 arch/powerpc/Kconfig          |   1 +
 arch/s390/Kconfig             |   1 +
 arch/sh/Kconfig               |   1 +
 arch/sparc/Kconfig            |   1 +
 arch/tile/Kconfig             |   1 +
 arch/x86/Kconfig              |   1 +
 arch/x86/kernel/apic/hw_nmi.c |   1 -
 include/linux/hardirq.h       |   2 +
 include/linux/percpu.h        |   3 -
 include/linux/printk.h        |  16 ++-
 init/Kconfig                  |  27 +++++
 init/main.c                   |   1 +
 kernel/kexec_core.c           |   1 +
 kernel/panic.c                |   6 +-
 kernel/printk/Makefile        |   1 +
 kernel/printk/internal.h      |  57 ++++++++++
 kernel/printk/nmi.c           | 258 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c        |  43 +++----
 lib/nmi_backtrace.c           |  89 +--------------
 26 files changed, 411 insertions(+), 111 deletions(-)
 create mode 100644 kernel/printk/internal.h
 create mode 100644 kernel/printk/nmi.c

-- 
1.8.5.6
