Return-Path: <SRS0=vFX3=O2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819F1C43387
	for <linux-mips@archiver.kernel.org>; Mon, 17 Dec 2018 08:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D662084D
	for <linux-mips@archiver.kernel.org>; Mon, 17 Dec 2018 08:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeLQIzP (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:55:15 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:14228 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbeLQIzP (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 17 Dec 2018 03:55:15 -0500
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id DF015A131B;
        Mon, 17 Dec 2018 09:55:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id KmJ9gq1op8Ux; Mon, 17 Dec 2018 09:55:08 +0100 (CET)
Subject: Re: MIPS (mt7688): EBase change in U-Boot breaks Linux
To:     Paul Burton <paul.burton@mips.com>
Cc:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <e4f0fff9-a3c5-85ce-c4be-6e0aa0f74592@denx.de>
 <d81ac18d-47ed-02ec-bc37-f5a7e0ab9223@gmail.com>
 <543512d8-91ea-2a49-5423-680860c0ba9f@denx.de>
 <CACUy__X434rmJnX96i057-ir8yiCBjMac_V41HJ+pyG0xLPcRg@mail.gmail.com>
 <dad02a31-ed34-f99a-26c5-60e4a7209057@denx.de>
 <CACUy__XtyDY08KTTMnKoXXKq4oUrNYdRXZOmtuXEmnfD7UveiA@mail.gmail.com>
 <20181213194740.mtphrijpnkzo2za4@pburton-laptop>
 <4ff76006-c524-ebaa-235a-6b253ce9cc09@denx.de>
 <20181214212840.xf3kqukf6ryjaiqk@pburton-laptop>
From:   Stefan Roese <sr@denx.de>
Message-ID: <1c1ef02f-2ab5-2a92-101e-f0873ba9e6cc@denx.de>
Date:   Mon, 17 Dec 2018 09:55:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181214212840.xf3kqukf6ryjaiqk@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Paul.

On 14.12.18 22:28, Paul Burton wrote:
> On Fri, Dec 14, 2018 at 07:56:59AM +0100, Stefan Roese wrote:
>>> Does this Linux patch help by any chance?
>>>
>>> https://git.linux-mips.org/cgit/linux-mti.git/commit/?h=eng-v4.20&id=39e4d339a4540b66e9d9a8ea0da9ee41a21473b4
>>>
>>> I'm not sure I remember why I didn't get that upstreamed yet, I probably
>>> wanted to research what other systems were doing... Speaking for Malta,
>>> the kernel's board support has reserved the start of kseg0 for longer
>>> than I've been involved.
>>
>> No, this patch does not solve this issue (bootup still hangs or crashes
>> while mounting the rootfs). I can only assume that its too late to try
>> to reserve this memory region as the memblock_reserve() call returns 0
>> (no error).
> 
> Hmm, OK. Do you know what is getting overwritten? Is it part of the
> kernel binary itself?

Okay, I did a bit more research and debugging here. MIPS sets
CONFIG_ARCH_DISCARD_MEMBLOCK in general, which results in free'ing
the reserved memory region(s) via memblock_discard() at a later boot
stage.

I also changed arch/mips/Kconfig so that ARCH_DISCARD_MEMBLOCK is
not defined, but this did not solve the issue either. I'm not sure
why ARCH_DISCARD_MEMBLOCK is defined for MIPS. Here a log from
the system running with ARCH_DISCARD_MEMBLOCK disabled and EBase
set to some area where booting does work (for test purpose only):

root@mt7688:~# cat /sys/kernel/debug/memblock/
memory    reserved
root@mt7688:~# cat /sys/kernel/debug/memblock/memory
    0: 0x00000000..0x07ffffff
root@mt7688:~# cat /sys/kernel/debug/memblock/reserved
    0: 0x02220000..0x02220fff

memblock really only seems to be suitable for early memory handling.
Reserving memory for the complete OS lifetime does not work (AFAICT).
Perhaps moving to CMA would help here.

So back to your question: It's not kernel memory that is overwritten
at e.g. 0x06f5f000 (128MiB memory) but its some userspace memory allocated
dynamically when starting into the mount process of the rootfs. This
memory region is *not* revered at that stage any more. memblock does not
seem to be the correct way to reserve areas here.
  
>>> An alternative would be for Linux to allocate a page for use with the
>>> exception vectors using memblock, and ignore the EBase value U-Boot left
>>> us with. But just marking the area U-Boot used as reserved ought to do
>>> the trick, and has the advantage of ensuring U-Boot's vectors don't get
>>> overwritten before Linux sets up its own which sometimes allows U-Boot
>>> to provide some useful output.
>>
>> I agree that re-using the U-Boot value would be optimal for boot-time
>> error printing. But this does not seem to work on our platform AFAICT.
>> So how to proceed? Should I enable CONFIG_CPU_MIPSR2_IRQ_VI or #define
>> "cpu_has_veic" to 1 as Lantiq does?
> 
> I think the answer to the question above will be helpful - if it's the
> kernel binary itself getting overwritten then we have 2 options:
> 
>    1) Move the kernel, ie. change load-y in arch/mips/ralink/Platform.
> 
>    2) Have Linux recognize that the address in EBase is unsuitable &
>       allocate a new page.
> 
> Or perhaps even both - having Linux recognize & avoid the problem seems
> good for robustness, but if the kernel binary is overwriting the
> exception vectors it might be useful to move the kernel anyway so that
> we don't prevent U-Boot's vectors from working in between loading the
> kernel & booting it.
> 
> If it's not the kernel binary overwriting the vectors & then being
> overwritten, then I'd be interested in knowing what is in that memory.
> We shouldn't have allocated much of anything this early, but a possible
> fix might be to reserve the page EBase resides in from bootmem_init().

That does not help (see comments about memblock usage above). I could
add a check, if EBase resides in the system memory and if this is the
case, allocate a page and move EBase to this new location.

What do you think? Did I misinterpret this memblock usage on MIPS? Do
you have other ideas on how to solve this issue?

Thanks,
Stefan
