Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 17:36:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46179 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993094AbcKJQgRiBk7B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2016 17:36:17 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EDBB27D300C2C;
        Thu, 10 Nov 2016 16:36:07 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 10 Nov
 2016 16:36:11 +0000
Subject: Re: Proposal: HAVE_SEPARATE_IRQ_STACK?
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
 <alpine.DEB.2.20.1611092227200.3501@nanos>
 <CAHmME9pGoRogjHSSy-G-sB4-cHMGcjCeW9PSrNw1h5FsKzfWAw@mail.gmail.com>
 <alpine.DEB.2.20.1611100959040.3501@nanos>
 <CAHmME9pHYA82M3iDNfDtDE96gFaZORSsEAn_KnePd3rhFioqHQ@mail.gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-mm@kvack.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        <k@vodka.home.kg>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <db056fb5-82b3-c17e-46ce-263872ef7334@imgtec.com>
Date:   Thu, 10 Nov 2016 16:36:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAHmME9pHYA82M3iDNfDtDE96gFaZORSsEAn_KnePd3rhFioqHQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55774
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

Hi Jason,


On 10/11/16 11:41, Jason A. Donenfeld wrote:
> On Thu, Nov 10, 2016 at 10:03 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> If you want to go with that config, then you need
>> local_bh_disable()/enable() to fend softirqs off, which disables also
>> preemption.
> Thanks. Indeed this is what I want.
>
>>> What clever tricks do I have at my disposal, then?
>> Make MIPS use interrupt stacks.
> Yea, maybe I'll just implement this. It clearly is the most correct solution.
> @MIPS maintainers: would you merge something like this if done well?
> Are there reasons other than man-power why it isn't currently that
> way?

I don't see a reason not to do this - I'm taking a look into it.

Thanks,
Matt

>> Does the slowdown come from the kmalloc overhead or mostly from the less
>> efficient code?
>>
>> If it's mainly kmalloc, then you can preallocate the buffer once for the
>> kthread you're running in and be done with it. If it's the code, then bad
>> luck.
> I fear both. GCC can optimize stack variables in ways that it cannot
> optimize various memory reads and writes.
>
> Strangely, the solution that appeals to me most at the moment is to
> kmalloc (or vmalloc?) a new stack, copy over thread_info, and fiddle
> with the stack registers. I don't see any APIs, however, for a
> platform independent way of doing this. And maybe this is a horrible
> idea. But at least it'd allow me to keep my stack-based code the
> same...
>
