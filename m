Return-Path: <SRS0=GeJD=PU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1BC43387
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 08:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FD62086C
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 08:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbfALIUK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:20:10 -0500
Received: from mail.loongson.cn ([114.242.206.163]:58916 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfALIUK (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 12 Jan 2019 03:20:10 -0500
Received: from ambrosehua-ThinkPad-X201s (unknown [10.20.42.116])
        by mail (Coremail) with SMTP id QMiowPDxNuQrozlczNxtAA--.3950S2;
        Sat, 12 Jan 2019 16:19:55 +0800 (CST)
Date:   Sat, 12 Jan 2019 16:19:55 +0800
From:   huangpei <huangpei@loongson.cn>
To:     =?UTF-8?B?5b6Q5oiQ5Y2O?= <xuchenghua@loongson.cn>
Cc:     "Paul Burton" <paul.burton@mips.com>,
        "Yunqiang Su" <ysu@wavecomp.com>,
        "Paul Burton" <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "zhangfx@lemote.com" <zhangfx@lemote.com>,
        "wuzhangjin@gmail.com" <wuzhangjin@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Message-ID: <20190112161955.24f426b7@ambrosehua-ThinkPad-X201s>
In-Reply-To: <63891c52.59c1.16841159520.Coremail.xuchenghua@loongson.cn>
References: <37e1dca1.5987.1683cede2ff.Coremail.xuchenghua@loongson.cn>
        <20190111190049.pba3243a5ln5fw56@pburton-laptop>
        <63891c52.59c1.16841159520.Coremail.xuchenghua@loongson.cn>
Organization: Loongson
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: QMiowPDxNuQrozlczNxtAA--.3950S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4UZw15KrWUJrW8tw4fZrb_yoW5Cw47pF
        W7t3W5KFWDtFZIywnrG3y0q3WS9r48AF43Jr93Zr92y3y5ur1IyF4IqwsY9F9xurs2y3W2
        vF4093srXF18ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x0EwIxGrVCF72vEw4AK0wACjI8F5VA0
        II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUeqXdUUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sat, 12 Jan 2019 16:02:40 +0800 (GMT+08:00)
徐成华 <xuchenghua@loongson.cn> wrote:

> > > For Loongson 3A1000 and 3A3000, when a memory access instruction
> > > (load, store, or prefetch)'s executing occurs between the
> > > execution of LL and SC, the success or failure of SC is not
> > > predictable.  Although programmer would not insert memory access
> > > instructions between LL and SC, the memory instructions before LL
> > > in program-order, may dynamically executed between the execution
> > > of LL/SC, so a memory fence(SYNC) is needed before LL/LLD to
> > > avoid this situation.
> > > 
> > > Since 3A3000, we improved our hardware design to handle this case.
> > > But we later deduce a rarely circumstance that some speculatively
> > > executed memory instructions due to branch misprediction between
> > > LL/SC still fall into the above case, so a memory fence(SYNC) at
> > > branch-target(if its target is not between LL/SC) is needed for
> > > 3A1000 and 3A3000.  
> > 
> > Thank you - that description is really helpful.
> > 
> > I have a few follow-up questions if you don't mind:
> > 
> >  1) Is it correct to say that the only consequence of the bug is
> > that an SC might fail when it ought to have succeeded?  

here is an example:

both cpu1 and cpu2 simutaneously run atomic_add by 1 on same
variable,  this bug cause both sc run  by two cpus (in atomic_add)
succeed at same time( sc return 1), and the variable is only added by 1,
which is wrong and unacceptable.( it should be added by 2)

I think sc do it wrong, instead of failing to to it;

> 
> Unfortunately, the SC succeeded when it should fail that cause a
> functional error. 
> >  2) Does that mean placing a sync before the LL is purely a
> > performance optimization? ie. if we don't have the sync & the SC
> > fails then we'll retry the LL/SC anyway, and this time not have the
> > reordered instruction from before the LL to cause a problem.  
> 
> It's functional bug not performance bug.
> 
> >  3) In the speculative execution case would it also work to place a
> > sync before the branch instruction, instead of at the branch
> > target? In some cases this might be nicer since the workaround
> > would be contained within the LL/SC loop, but I guess it could
> > potentially add more overhead if the branch is conditional & not
> > taken.  
> 
> Yes, it more overhead so we don't use that.


 
> 
> >  4) When we talk about branches here, is it really just branch
> >     instructions that are affected or will the CPU speculate past
> > jump instructions too?  
>  
> No, bug only expose when real program-order is still ll/sc,
> unconditional branch or jump is not really ll/sc, so it not affected.
> 
> > I just want to be sure that we work around this properly, and
> > document it in the kernel so that it's clear to developers why the
> > workaround exists & how to avoid introducing bugs for these CPUs in
> > future. 
> > > Our processor is continually evolving and we aim to to remove all
> > > these workaround-SYNCs around LL/SC for new-come processor.   
> > 
> > I'm very glad to hear that :)
> > 
> > I hope one day I can get my hands on a nice Loongson laptop to test
> > with.  
> 
> We can ship one to you as a gift when the laptop is stable.
> 
> > Thanks,
> >     Paul  
> 
> 
> --
> 
> 
> 
> 
>

