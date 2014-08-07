Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2014 13:48:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37217 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6862110AbaHGLshl4uC5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Aug 2014 13:48:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s77BmYhM000950;
        Thu, 7 Aug 2014 13:48:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s77BmVIp000949;
        Thu, 7 Aug 2014 13:48:31 +0200
Date:   Thu, 7 Aug 2014 13:48:31 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wei.Yang@windriver.com
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v1] MIPS: perf: Mark pmu interupt IRQF_NO_THREAD
Message-ID: <20140807114831.GB29898@linux-mips.org>
References: <1407217067-1144-1-git-send-email-Wei.Yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1407217067-1144-1-git-send-email-Wei.Yang@windriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41896
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

On Tue, Aug 05, 2014 at 01:37:47PM +0800, Wei.Yang@windriver.com wrote:

> From: Yang Wei <Wei.Yang@windriver.com>
> 
> In RT kernel, I ran into the following calltrace, so PMU interrupts cannot
> be threaded
> 
> in_atomic(): 1, irqs_disabled(): 1, pid: 0, name: swapper/0
> INFO: lockdep is turned off.
> Call Trace:
> [<ffffffff8088595c>] dump_stack+0x1c/0x50
> [<ffffffff801a958c>] __might_sleep+0x13c/0x148
> [<ffffffff80891c54>] rt_spin_lock+0x3c/0xb0
> [<ffffffff801ad29c>] __wake_up+0x3c/0x80
> [<ffffffff80243ba4>] perf_event_wakeup+0x8c/0xf8
> [<ffffffff80243c50>] perf_pending_event+0x40/0x78
> [<ffffffff8023d88c>] irq_work_run+0x74/0xc0
> [<ffffffff80152640>] mipsxx_pmu_handle_shared_irq+0x110/0x228
> [<ffffffff8015276c>] mipsxx_pmu_handle_irq+0x14/0x30
> [<ffffffff801ffda4>] handle_irq_event_percpu+0xbc/0x470
> [<ffffffff80204478>] handle_percpu_irq+0x98/0xc8
> [<ffffffff801ff284>] generic_handle_irq+0x4c/0x68
> [<ffffffff8089748c>] do_IRQ+0x2c/0x48
> [<ffffffff80105864>] plat_irq_dispatch+0x64/0xd0 

Hm...  I don't see why based on this backtrace you concluce the
handler needs to be marked IRQF_NO_THREAD.  However there's another
reason to mark it IRQF_NO_THREAD.  IRQ threads may be rescheduled to
other CPUs but this handler is fiddling with per-CPU resources.

See https://patchwork.linux-mips.org/patch/2818/ for a similar
scenario a few years ago.

  Ralf
