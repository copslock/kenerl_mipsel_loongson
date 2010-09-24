Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2010 10:36:43 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:35345 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490962Ab0IXIgk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Sep 2010 10:36:40 +0200
Received: by arkanian.console-pimps.org (Postfix, from userid 1000)
        id 5BAAD4432D; Fri, 24 Sep 2010 09:36:38 +0100 (BST)
Date:   Fri, 24 Sep 2010 09:36:38 +0100
From:   Matt Fleming <matt@console-pimps.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Subject: Re: [PATCH v6 4/7] MIPS: add support for hardware performance
        events (skeleton)
Message-ID: <20100924083638.GA7503@console-pimps.org>
References: <1276058130-25851-1-git-send-email-dengcheng.zhu@gmail.com> <1276058130-25851-5-git-send-email-dengcheng.zhu@gmail.com> <20100922122711.GB6392@console-pimps.org> <AANLkTinq+2LHgycDGyPgrEfkp3PSYxqagV1TfbjcQTwO@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTinq+2LHgycDGyPgrEfkp3PSYxqagV1TfbjcQTwO@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 27817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19121

On Thu, Sep 23, 2010 at 03:39:51PM +0800, Deng-Cheng Zhu wrote:
> 2010/9/22 Matt Fleming <matt@console-pimps.org>:
> > I'm probably just being stupid but I can't figure out what this snippet
> > of code is doing. You're checking to see if the counter has overflowed,
> > and if it has then you just clear the overflow bit? I would have
> > expected you to reset the counter to 0.
> [DC]: Maybe my original code comment for the member msbs of the struct
> cpu_hw_events is too simple. And here is more: Unlike the perf counters in
> some other architectures, a 32bit MIPS perf counter, for example, will
> generate an interrupt after 0x7fffffff. But we want the operation to look
> like: 0x0 -> 0xffffffff -> interrupt. So there's a "pseudo" signal halfway.
> Please also note that the counter value will be brought back to 0 soon
> after it reaches 0x80000000 *each time*.

Ah OK, thanks.

> > Having conditional code like this is a pretty sure sign that you haven't
> > separated support for the various performance hardware properly. Have
> > you had a look at how SH uses a registration interface to register
> > sh_pmus?  Ideally all the internals for each type of perfcounter
> > hardware should be in their own file.
> [DC]: It does look ugly. It should be easy to put conditional code into
> perf_event_[mipsxx|loongson2|rm9000].c. I'll post a patch to fix it when
> the whole thing is accepted.

The potential problem with doing a cleanup patch after this series has
been merged is that it will modify most of the code in this patch
series - essentially rewriting it. I don't have a strong opinion
either way but Ralf may.

> > SH also has this problem that it doesn't have any sort of performance
> > counter interrupt and so can't check for overflow. This lack of
> > interrupt really needs to be solved generically in perf as it's a
> > problem that effects quite a few architectures. I suspect that using a
> > hrtimer instead of piggy-backing the timer interrupt would make the core
> > perf guys happier. Writing support for this is on my ever-growing list
> > of things todo. I've already started on some patches for the perf tool
> > so that it's possible to sample counters even though there is no
> > periodic interrupt (but that's a different problem).
> [DC]: Please add me into your post list when your patches are ready :-)
> Finally, thanks for your time to review the code.

Sure, I will do. No problem!
