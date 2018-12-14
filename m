Return-Path: <SRS0=qAeu=OX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30A3C67839
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 06:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9955120811
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 06:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9955120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbeLNG5I (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:57:08 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:9810 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeLNG5H (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 14 Dec 2018 01:57:07 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id AB7A9A10E7;
        Fri, 14 Dec 2018 07:57:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id eOUW4smcOwP1; Fri, 14 Dec 2018 07:57:03 +0100 (CET)
Subject: Re: MIPS (mt7688): EBase change in U-Boot breaks Linux
To:     Paul Burton <paul.burton@mips.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
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
From:   Stefan Roese <sr@denx.de>
Message-ID: <4ff76006-c524-ebaa-235a-6b253ce9cc09@denx.de>
Date:   Fri, 14 Dec 2018 07:56:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181213194740.mtphrijpnkzo2za4@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Paul,

On 13.12.18 20:47, Paul Burton wrote:
> On Thu, Dec 13, 2018 at 03:23:39PM +0100, Daniel Schwierzeck wrote:
>>>>>>> Finally I found that this line in U-Boot makes Linux break:
>>>>>>>
>>>>>>> arch/mips/lib/traps.c:
>>>>>>>
>>>>>>> void trap_init(ulong reloc_addr)
>>>>>>>        unsigned long ebase = gd->irq_sp;
>>>>>>>        ...
>>>>>>>        write_c0_ebase(ebase);
>>>>>>>
>>>>>>> This sets EBase to something like 0x87e9b000 on my system (128MiB).
>>>>>>> And Linux then re-uses this value and copies the exceptions handlers
>>>>>>> to this address, overwriting random code and leading to an unstable
>>>>>>> system.
>>>>>>>
>>>>>>> So my questions now is, how should this be handled on the MT7688
>>>>>>> platform instead? One way would be to set EBase back to the
>>>>>>> original value (0x80000000) before booting into Linux. Another
>>>>>>> solution would be to add some Linux code like board_ebase_setup()
>>>>>>> to the MT7688 Linux port.
>> %
>>>> I could also prepare a U-Boot patch to restore the original ebase value before
>>>> handing the control over to the OS.
>>>
>>> I'm not so sure, if overwriting 0x80000000 (default value of EBase on
>>> this SoC) with the exception handler is allowed. Is this address "zero"
>>> handled somewhat specific in MIPS Linux? AFAICT, the complete DDR
>>> area on my platform (0x8000.0000 - 0x87ff.ffff) is available for Linux.
>>> So allocating some memory for this exception handler seems the right
>>> way to go to me.
>>
>> maybe that's why some platforms define a load address of 0x80002000 or similar
>> to protect this area somehow.
> 
> Does this Linux patch help by any chance?
> 
> https://git.linux-mips.org/cgit/linux-mti.git/commit/?h=eng-v4.20&id=39e4d339a4540b66e9d9a8ea0da9ee41a21473b4
> 
> I'm not sure I remember why I didn't get that upstreamed yet, I probably
> wanted to research what other systems were doing... Speaking for Malta,
> the kernel's board support has reserved the start of kseg0 for longer
> than I've been involved.

No, this patch does not solve this issue (bootup still hangs or crashes
while mounting the rootfs). I can only assume that its too late to try
to reserve this memory region as the memblock_reserve() call returns 0
(no error).
  
> An alternative would be for Linux to allocate a page for use with the
> exception vectors using memblock, and ignore the EBase value U-Boot left
> us with. But just marking the area U-Boot used as reserved ought to do
> the trick, and has the advantage of ensuring U-Boot's vectors don't get
> overwritten before Linux sets up its own which sometimes allows U-Boot
> to provide some useful output.

I agree that re-using the U-Boot value would be optimal for boot-time
error printing. But this does not seem to work on our platform AFAICT.
So how to proceed? Should I enable CONFIG_CPU_MIPSR2_IRQ_VI or #define
"cpu_has_veic" to 1 as Lantiq does?

Thanks,
Stefan
