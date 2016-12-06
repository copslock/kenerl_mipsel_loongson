Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2016 23:09:49 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:36272 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993377AbcLFWJn0j7OD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Dec 2016 23:09:43 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a5038b13;
        Tue, 6 Dec 2016 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=pgKr8qaEk+qs7lJAuMvj6XUOUj8=; b=rcqCHN
        yYUH8qCuIESUp/kmX1nxqroL0UYq7bU2vnvhbguSK4EPaKmChyXU6ecUg6AEcpSZ
        21xI8ziJMgpfwolYgNq0nChLCXaHuAMK1DA1yRdKE3CJb0Me5Ij7YXyOpsEIHvIU
        v/NpSaSzbxxJgTrWDvSa8B99B2LK24VVdjDLUy9XYkcZZ+I7r9aivEtrHL/gvB+r
        5WJnn/BODxGQPZbqEeKzwHM3SLK3Kccr3oSnZKoM6YSY2CHpInvXSnEif1Yfr2XN
        fsh6zpvBpzPxW/U/YvosRuvGPPLgpucnq/ryS1cZdOd3IbUSbD9Osh668NoufA5S
        tWsfKocwODOrfF6w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 585523e3 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 6 Dec 2016 22:04:10 +0000 (UTC)
Received: by mail-wj0-f177.google.com with SMTP id xy5so339431419wjc.0;
        Tue, 06 Dec 2016 14:09:30 -0800 (PST)
X-Gm-Message-State: AKaTC03XDMRC3qxqCqDZnQCZZsb8HRTLIhZinrYu3VTPlL29lJGUiXo4WyeT4RZh5vzz0/8xTy7d7xfXZWJoCA==
X-Received: by 10.25.195.195 with SMTP id t186mr19016395lff.96.1481062168826;
 Tue, 06 Dec 2016 14:09:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.215.12 with HTTP; Tue, 6 Dec 2016 14:09:28 -0800 (PST)
In-Reply-To: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com>
References: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 6 Dec 2016 23:09:28 +0100
X-Gmail-Original-Message-ID: <CAHmME9pEB6uBJN0AWh4igmfbxSya1e8eYXdDp_dwRZZZGPjVug@mail.gmail.com>
Message-ID: <CAHmME9pEB6uBJN0AWh4igmfbxSya1e8eYXdDp_dwRZZZGPjVug@mail.gmail.com>
Subject: Re: [PATCH 0/5] MIPS: Add per-cpu IRQ stack
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

Hi Matt,

Thanks for submitting this. A happy OpenWRT/WireGuard user has
reported to me that this patch set frees ~1300 bytes of stack on a
small MIPS router. This kind of savings should allow me to reintroduce
my crypto operations to be on the stack, rather than the conditional
MIPS kmallocing, which will be a performance win.

By the way, it looks like x86 and SPARC have separately allocated hard
IRQ and soft IRQ stacks. ARM has only one for both, similar to this
MIPS patchset.

Jason

On Fri, Dec 2, 2016 at 2:39 PM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>
> This series adds a separate stack for each CPU wihin the system to use
> when handling IRQs. Previously IRQs were handled on the kernel stack of
> the current task. If that task was deep down a call stack at the point
> of the interrupt, and handling the interrupt required a deep IRQ stack,
> then there was a likelihood of stack overflow. Since the kernel stack
> is in normal unmapped memory, overflowing it can lead to silent
> corruption of other kernel data, with weird and wonderful results.
>
> Before this patch series, ftracing the maximum stack size of a v4.9-rc6
> kernel running on a Ci40 board gave:
> 4996
>
> And with this series:
> 4084
>
> Handling interrupts on a separate stack reduces the maximum kernel stack
> usage in this configuration by ~900 bytes.
>
> Since do_IRQ is now invoked on a separate stack, we select
> HAVE_IRQ_EXIT_ON_IRQ_STACK so that softirqs will also be executed on the
> irq stack rather than attempting to switch with do_softirq_own_stack().
>
> This series has been tested on MIPS Boston, Malta and SEAD3 platforms,
> Pistachio on the Creator Ci40 board and Cavium Octeon III.
>
>
>
> Matt Redfearn (5):
>   MIPS: Introduce irq_stack
>   MIPS: Stack unwinding while on IRQ stack
>   MIPS: Only change $28 to thread_info if coming from user mode
>   MIPS: Switch to the irq_stack in interrupts
>   MIPS: Select HAVE_IRQ_EXIT_ON_IRQ_STACK
>
>  arch/mips/Kconfig                  |  1 +
>  arch/mips/include/asm/irq.h        | 12 ++++++
>  arch/mips/include/asm/stackframe.h | 10 +++++
>  arch/mips/kernel/asm-offsets.c     |  1 +
>  arch/mips/kernel/genex.S           | 81 +++++++++++++++++++++++++++++++++++---
>  arch/mips/kernel/irq.c             | 11 ++++++
>  arch/mips/kernel/process.c         | 15 ++++++-
>  7 files changed, 125 insertions(+), 6 deletions(-)
>
> --
> 2.7.4
>
