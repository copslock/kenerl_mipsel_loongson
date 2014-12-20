Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 18:28:45 +0100 (CET)
Received: from mail-qc0-f178.google.com ([209.85.216.178]:36444 "EHLO
        mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009284AbaLTR2lzc0zp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 18:28:41 +0100
Received: by mail-qc0-f178.google.com with SMTP id b13so2167943qcw.37;
        Sat, 20 Dec 2014 09:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fP20op2Pt6ZaSZf6K+XH+EwbTlt0io2HPshJA+p9ALw=;
        b=umzLMBTy/yo8EhTkLrg5et84nHL5omaTa5aP5ya3KiGRWw7c1gJa/rZ9e9tLvkXt03
         cKm61bzha7TzDk4866Tds13zFmzJxFykPEi0GmvKb9hNHfw4y0KzSefkjY1bmo9XfDc+
         zSlYWxYqPLsW4q646MJSVw/zIRIFK3ODKMU/L78+owChVLVku9aY1u7DoXYPPjwB+qNJ
         6KaF5M/nqj1R/A8sSwnumSdGKXU7cK0/z+eOdZhd+mjcXaN4NT0+iD01lN+Ql+Ve+TnH
         P2SrPikBTUKLDGQBb0H50B9fJXaL3w/OgDrw5yGWEdSnO+KPx/KwIfnAFUVXFKBko0ab
         bIvw==
X-Received: by 10.224.4.196 with SMTP id 4mr23174646qas.35.1419096516057; Sat,
 20 Dec 2014 09:28:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.82.48 with HTTP; Sat, 20 Dec 2014 09:28:15 -0800 (PST)
In-Reply-To: <CAOiHx=m9RzU5n2fjJcph6u=avUAEZJYw0-mBCSMRzDJvSD5CFA@mail.gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
 <1418422034-17099-14-git-send-email-cernekee@gmail.com> <CAOiHx=nX9jJEFZmkA-1fWj47whq85wj-ZgUxnZBwpAYDUfAO4w@mail.gmail.com>
 <CAJiQ=7AZdwCX6bmLD1B4TzfmKriE3HVEEa5zP3WRnENZjGS-hA@mail.gmail.com> <CAOiHx=m9RzU5n2fjJcph6u=avUAEZJYw0-mBCSMRzDJvSD5CFA@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Sat, 20 Dec 2014 09:28:15 -0800
Message-ID: <CAJiQ=7CjWMELO0fL+Zrx29Q-kRzkSZYpgEPRgJgULgwJ6KNN+g@mail.gmail.com>
Subject: Re: [PATCH V5 13/23] MIPS: BMIPS: Flush the readahead cache after DMA
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Norris <computersforpeace@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Sat, Dec 20, 2014 at 4:44 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> On Sat, Dec 20, 2014 at 2:39 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
>> On Mon, Dec 15, 2014 at 1:43 AM, Jonas Gorski <jogo@openwrt.org> wrote:
>>> On Fri, Dec 12, 2014 at 11:07 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
>>>> BMIPS 3300/435x/438x CPUs have a readahead cache that is separate from
>>>> the L1/L2.  During a DMA operation, accesses adjacent to a DMA buffer
>>>> may cause parts of the DMA buffer to be prefetched into the RAC.  To
>>>> avoid possible coherency problems, flush the RAC upon DMA completion.
>>>
>>> According to what I have, any cpu [d-]cache invalidate operation
>>> should already flush the full RAC unless explicitly disabled in the
>>> RAC configuration - is this intended as an optimization/shortcut?
>>
>> Correct - performing a RAC flush instead of blasting the entire range
>> again via CACHE instructions should be considerably faster in most
>> cases.  CACHE instructions are not pipelined on BMIPS3300/43xx.

BTW, I forgot to mention earlier that the RAC is different from an
L2/L3 in two important ways:

 - In terms of prefetching you only need to worry about RAC blocks
(lines) on the "edges" on the DMA buffer.  It won't randomly fill
blocks in the middle, unlike the BMIPS5000 prefetching logic.

 - It typically isn't possible to invalidate just part of the RAC.
The hardware flushes the whole thing at once.

>> There may be a couple of old CPU versions (possibly 130nm) that don't
>> automatically perform the RAC flush on each CACHE instruction.  Also,
>> a fun bit of trivia: MVA based cache flushes on B15 do flush the RAC,
>> but index based instructions do not.
>
> Because I'm laz^W^Wstill need to do some christmas shopping, I'll ask
> a few dumb questions:
>
> Since a RAC flush won't flush the I/D-caches themselves, I assume
> there is no cache invalidate needed for BMIPS?

On unmap this is true.  The L1/L2 flush happens on map, pre-DMA.

> Also is it still needed
> if the RAC is setup to only prefetch instructions (which it seems to
> be on bcm963xx)?

Not sure.  Do we ever execute directly from memory that has been
freshly populated via DMA?  If so, anything executed in the vicinity
of that buffer could have prefetched stale data.  Keeping in mind that
the RAC won't prefetch across 4KB boundaries.

The most common RAC D$ coherency problems we've seen have involved DMA
buffers adjacent to other structs in kernel memory, e.g. a DMA buffer
that sits next to the wait_queue head used to sleep during the
transfer.  If the wait_queue struct is accessed at an unfortunate
time, the RAC could start prefetching from the DMA buffer.

RAC I$ problems are probably much more rare, and subtle.

> I also fail to find any RAC flushing on either bcm963xx or bcm947xx
> SDK kernels, that's why I'm a bit wondering whether they really need
> it. But maybe they always do explicit syncs, haven't checked that.
>
> Furthermore, I see code to enable data prefetching in setup on
> bcm963xx, so I wonder if it wouldn't make sense to add the RAC as an
> extra node in DT / register/enable/configure it from bmips setup code
> (because then we can also properly setup the address range in case the
> bootloader didn't).

Historically there has been a great deal of debate as to whether the
RAC should be set up in the bootloader or in the kernel:

 - If it is set up in the bootloader, it can be part of the library
that handles general cache/CPU initialization for the platform.  But
the RAC does require extra flushing, so non-RAC-aware OSes can be
caught off guard (especially if you're thinking about running a fairly
stock image, like the ARMv7 multiplatform kernel from upstream).

 - If it is set up in the kernel, the kernel will be able to decide
whether it can handle the extra flushes.  If problems are seen later,
it is easy to just change the kernel to leave RAC disabled, at the
expense of memcpy() performance.

On BCM7xxx MIPS, the RAC is always set up from the bootloader.  On
BCM7xxx ARM, it is currently left up to the kernel (last I heard).  On
BCM3384 Viper it is controlled by the CM firmware on TP0.  Not sure
about the other SoCs.
