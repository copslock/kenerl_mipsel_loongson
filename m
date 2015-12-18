Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2015 15:52:14 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:34591 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006918AbbLROwKxsCV0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Dec 2015 15:52:10 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7BA6AB13;
        Fri, 18 Dec 2015 14:52:08 +0000 (UTC)
Date:   Fri, 18 Dec 2015 15:52:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Cris <linux-cris-kernel@axis.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
Message-ID: <20151218145207.GK3729@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
 <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
 <5673DD60.7080302@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5673DD60.7080302@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50689
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

On Fri 2015-12-18 10:18:08, Daniel Thompson wrote:
> On 11/12/15 23:26, Jiri Kosina wrote:
> >On Fri, 11 Dec 2015, Russell King - ARM Linux wrote:
> >
> >>I'm personally happy with the existing code, and I've been wondering why
> >>there's this effort to apply further cleanups - to me, the changelogs
> >>don't seem to make that much sense, unless we want to start using
> >>printk() extensively in NMI functions - using the generic nmi backtrace
> >>code surely gets us something that works across all architectures...
> >
> >It is already being used extensively, and not only for all-CPU backtraces.
> >For starters, please consider
> >
> >- WARN_ON(in_nmi())
> >- BUG_ON(in_nmi())
> 
> Sorry to join in so late but...
> 
> Today we risk deadlock when we try to issue these diagnostic errors
> directly from NMI context.
> 
> After this change we will still risk deadlock, because that's what
> the diagnostic code is trying to tell us, *and* we delay actually
> reporting the error until, and only if, the NMI handler completes.

I think that NMI messages about a possible deadlock are the ones
from

    kernel/locking/rtmutex.c
    kernel/irq_work.c
    include/linux/hardirq.h

You are right that if the deadlock happens, this patch set lowers the
chance to see the message.

On the other hand, all the other printk's in NMI seems to be non-fatal
warnings. In this case, this patch set increases the chance to see
them.

A compromise might be to explicitly call printk_nmi_flush() in the few
fatal cases. Alternatively we could force the messages on the
early_console when available.


> >- anything being printed out from MCE handlers
> 
> The MCE handlers should only call printk() when they decide to panic
> and *after* busting the spinlocks. At this point deferring printk()
> until it is safe is not very helpful.
> 
> When we bust the spinlocks we should probably restore the normal
> printk() function to give best chance of the failure messages making
> it out.

The problem is that we do not know what locks need to be busted. There
are too many consoles and too many locks involved. Also busting locks
open another can of worms.

Best Regards,
Petr
