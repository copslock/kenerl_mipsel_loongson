Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 19:09:24 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:45559 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012426AbbBBSJWYalVB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 19:09:22 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id CC6C71538A; Mon,  2 Feb 2015 18:09:16 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Kevin Cernekee <cernekee@chromium.org>
Cc:     Oleg Kolosov <bazurbat@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Few questions about porting Linux to SMP86xx boards
References: <54CEACC1.1040701@gmail.com>
        <CAJiQ=7AQuP1JsiApEs4yAR449w6-pcR_qqhSqKdpqNHL5L1mRQ@mail.gmail.com>
Date:   Mon, 02 Feb 2015 18:09:16 +0000
In-Reply-To: <CAJiQ=7AQuP1JsiApEs4yAR449w6-pcR_qqhSqKdpqNHL5L1mRQ@mail.gmail.com>
        (Kevin Cernekee's message of "Sun, 1 Feb 2015 15:55:31 -0800")
Message-ID: <yw1xwq409odv.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Kevin Cernekee <cernekee@chromium.org> writes:

> On Sun, Feb 1, 2015 at 2:46 PM, Oleg Kolosov <bazurbat@gmail.com> wrote:
>> Hello MIPS gurus!
>>
>> I'm adding support for Sigma Designs SMP8652/SMP8654 (Tango3 family,
>> MIPS 24kf CPU) to newer kernel. I've selectively adapted patches from
>> 2.6.32.15 (the latest officially available for us) to the latest mips
>> 3.18 stable branch and things seem to work (it boots, runs simple test
>> programs), but there are few questions which I was not able to resolve
>> yet with my limited experience:
>>
>> 1. They (Sigma Designs) have overridden __fast_iob which is identical to
>> the default one except for one line:
>>
>>     : "m" (*(int *)CKSEG1)
>>
>> is replaced with:
>>
>>     : "m" (*(int *)(CKSEG1+CPU_REMAP_SPACE))
>>
>> where CPU_REMAP_SPACE=0x4000000 is a compile time constant for Tango3
>> and also called KERNEL_START_ADDRESS in Makefiles. The same value is
>> also written to ebase:
>>
>> ebase = KSEG0ADDR(CPU_REMAP_SPACE);
>> write_c0_ebase(ebase);
>>
>> in traps.c:per_cpu_trap_init()
>>
>> while writing ebase is really necessary for the kernel to boot, I've not
>> found any negative effects of not applying __fast_iob patch. What is it
>> supposed to do?
>
> I do not have any direct experience with these SoCs, but you might
> want to look at the memory map to try to figure this one out.  i.e. if
> __fast_iob() normally performs an uncached dummy read from the first
> word of physical memory, does the address need to be adjusted by 64MB
> on the Sigma chips because system memory (or the memory allocated to
> the Linux application processor) starts at PA 0x0400_0000 instead of
> 0x0000_0000?
>
> That theory would also explain why the exception vectors were adjusted
> by the same offset.

The 86xx has two DRAM controllers mapped with 1GB windows at 0x8000_0000
and 0xc000_0000, and also with 256MB windows at 0x1000_0000 and 0x2000_0000.
To complicate matters, CPU physical addresses starting at 0x04000000 are
subjected to a set of remapping registers translating 6 blocks of 64MB
to an arbitrary (64MB-aligned) bus address (not that these addresses
overlap with the low mappings of the DRAM controllers).  The obvious way
to support this would be to simply set these registers to an identity
mapping and use highmem for anything that doesn't fit the low windows.
Obviously, they didn't do that.

> BTW, you can override ebase from the platform code, as was done in
> arch/mips/kernel/smp-bmips.c.  It probably isn't necessary to change
> the common per_cpu_trap_init() code (but it may have been necessary
> way back in 2.6.32).

Most of the hacks they've done to generic code are actually completely
unnecessary, if not outright wrong.

>> 2. In io.h they have added explicit __sync() to the end of
>> pfx##write##bwlq and pfx##out##bwlq##p. Is this really necessary? I've
>> not yet found any adverse effects of not doing so. Maybe this was a
>> workaround for some old kernel issue which was fixed since then?
>
> Adding a barrier in writel(), as was done on ARM, might have something
> to do with the SoC's busing or peripherals.  Sometimes there are chip
> bugs that cause MMIO transaction ordering to break in unexpected ways.
> Or it could be there to compensate for missing barriers or bad
> assumptions in a driver somewhere.
>
> For #2 and #3, it is likely that somebody at Sigma could find a bug
> report or changelog explaining why it was added.  In my experience
> these sorts of changes are usually made to work around subtle problems
> discovered in testing or production.  Figuring out the exact problem
> that inspired the patch can be difficult without insider knowledge,
> unless you happened to run across the same failure.

I suspect the Sigma patches were produced by randomly prodding a kernel
with a stick until it started working.

-- 
Måns Rullgård
mans@mansr.com
