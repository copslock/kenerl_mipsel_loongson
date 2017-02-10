Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 23:12:08 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:59338 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992186AbdBJWMBFuH0D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2017 23:12:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=kEpFI0bkVOq27ibuKcIIlcXleeIdnVbw5sN6tddn30w=; b=ryWZyFA/F8LJcOJ5aSD3E5Tl3O
        wx7n0iRdcColnLtxGQWnqDPWHdbeW3j0pKwOSdd2zZpFdm4yvV0W8AFQz9p1Cq8LJpE34jmrVZb2T
        WYzqnkmxT8MhustWG+TaXcyBQJPT7m2HHOgLA9jGw1lg4NePVerlh3Q42+oxBLowRG/ZUmYcfcUsv
        x1lfMrxoe24kVTrIQ2AXsvAYYC1HTkx0kd1+pjXs5awp/BqSof69Ov5dqSZWbdg0lTqOyIfrGL0lE
        wD7ORD3k2tee1D+elsX6SsT2wFGpoHd62mPmlkK9BFCN2eLXXBM+Hr7/kGrlPpUcrW1EteHlcNOf+
        0H37hrLQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:44074 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1ccJQ1-002rKK-BI; Fri, 10 Feb 2017 22:11:53 +0000
Date:   Fri, 10 Feb 2017 14:11:52 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Crash in -next due to 'MIPS: Add cacheinfo support'
Message-ID: <20170210221152.GA20435@roeck-us.net>
References: <20170208234523.GA13263@roeck-us.net>
 <CAJx26kWDuH2AbibrOdHi7yh9YG314T7J5Zz7CwgTrZCfwDGuYw@mail.gmail.com>
 <eee97bba-5386-9d78-1c82-9e9753a28920@roeck-us.net>
 <20170210094011.GB24226@jhogan-linux.le.imgtec.org>
 <20170210103952.GC24226@jhogan-linux.le.imgtec.org>
 <20170210174644.GA15372@roeck-us.net>
 <6360d767-39f9-ad9b-6ca4-cb16c617e3cc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6360d767-39f9-ad9b-6ca4-cb16c617e3cc@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Fri, Feb 10, 2017 at 11:15:31AM -0800, Florian Fainelli wrote:
> On 02/10/2017 09:46 AM, Guenter Roeck wrote:
> > On Fri, Feb 10, 2017 at 10:39:52AM +0000, James Hogan wrote:
> >> On Fri, Feb 10, 2017 at 09:40:11AM +0000, James Hogan wrote:
> >>> Hi Guenter,
> >>>
> >>> On Thu, Feb 09, 2017 at 08:50:04PM -0800, Guenter Roeck wrote:
> >>>> On 02/09/2017 04:01 PM, Justin Chen wrote:
> >>>>> Hello Guenter,
> >>>>>
> >>>>> I am unable to reproduce the problem. May you give me more details?
> >>>>>
> >>>> The scripts I am using are available at
> >>>>
> >>>> https://github.com/groeck/linux-build-test/tree/master/rootfs
> >>>>
> >>>> in the mips and mipsel subdirectories (both crash). Individual
> >>>> build logs are always available at kerneltests.org/builders,
> >>>> in the 'next' column.
> >>>
> >>> Did you find it 100% reproducible? I was trying to reproduce yesterday
> >>> evening, and did hit it a few times, but then it stopped happening
> >>> before I could try and figure out what was going wrong.
> >>
> >> I switched to gcc 5.2 (buildroot toolchain) for building kernel, and now
> >> it reproduces every time :)
> >>
> > gcc 5.4.0 (binutils 2.26.1) also reliably crashes. The exact crash depends on
> > the kernel (-next is different to ToT + offending patch, qemu command line
> > makes a difference, qemu version makes a difference), but the crash is easy
> > to reproduce, at least for me.
> 
> Just to clarify here, is the crash a combination of:
> 
> - the kernel image, based on different trees/branches

I tried with linux-next, and I tried with ToT with the offending patch
applied. Both fail reliably. Without the patch, both pass reliably.

> - different GCC versions

I can only say that I see it crashes with both gcc 5.2.0 and gcc 5.4.0.

> - different ways of invoking QEMU/QEMU version?
> 
Yes and no. One way of _not_ (or maybe not always) seeing this crash
is to use the bare-bone command line with qemu 2.7 or 2.8 (with no
root file system provided). This crashes because there is no root file
system, but not as described earlier. It does crash, though, when
providing a more comprehensive command line. All kernel versions
without this patch do not crash.

On the other side, blaming this on the qemu command line is akin to
saying that a crash only seen if a mouse is connected would be caused
by the mouse, so I am not entirely sure if that helps too much.
Also see below, regarding heisenbug.

> and essentially Justin's commit just made problem 1) to occur, but is
> not the root cause of the crash you are seeing?

That would not necessarily be my conclusion. Of course, the code appears
to be heavily SMP related, so it may well be that it exposes some
problem associated with cache handling or support in non-SMP configurations.

Of course, it might also be possible that there is a qemu problem somewhere
which only manifests itself on non-SMP mips images with Justin's commit
applied. That appears to be somewhat unlikely, though I have no hard data
supporting this guess.

I'll do some more testing and try to find the actual crash location.
Tricky though since it almost looks like there is a not completely
initialized workqueue. Making things worse, the problem "goes away"
if I add some debug log into process_one_work(), meaning there may
be a heisenbug.

Guenter
