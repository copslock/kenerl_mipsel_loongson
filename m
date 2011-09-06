Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2011 21:22:09 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:39476 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491846Ab1IFTWE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Sep 2011 21:22:04 +0200
Received: by fxd20 with SMTP id 20so105701fxd.36
        for <linux-mips@linux-mips.org>; Tue, 06 Sep 2011 12:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aHESF7+hJosJoOMjGzH7rlLoe94+rBb/mSvjwexmE+4=;
        b=aJbUX+GaP/dKZO/J1bNDtzWgXfz48GaYPr19hvLn9wAVc+jAS4a5sLMPSamY71+GR/
         2HKEXU/aqOwyOZX5LCAUB7RVODpC7hmLAzMFihHBmUstL54aBYYbxBzyh/dSs2Q4T5yT
         +5W+lbT376Jfz2rOqhvAzW+mQlpslpEc26r1I=
MIME-Version: 1.0
Received: by 10.223.47.67 with SMTP id m3mr393345faf.27.1315336919574; Tue, 06
 Sep 2011 12:21:59 -0700 (PDT)
Received: by 10.223.83.203 with HTTP; Tue, 6 Sep 2011 12:21:59 -0700 (PDT)
In-Reply-To: <4E6671B0.4040603@cavium.com>
References: <CAFsuBjW4XZy6x4gDL+0cw92jUbuEodF4vzCcCijQDize97wkNQ@mail.gmail.com>
        <4E6668A4.8010300@cavium.com>
        <CAFsuBjU_VnUPL+hpQV=m1HNJ6Fis38hyToOHBgROmiYYTEQHyQ@mail.gmail.com>
        <4E6671B0.4040603@cavium.com>
Date:   Wed, 7 Sep 2011 00:51:59 +0530
Message-ID: <CAFsuBjXDsY6-==jYi2+CeYtynLfRPYbLaM7sK9WrEz31WVxb=A@mail.gmail.com>
Subject: Re: MIPS: Octeon: mailbox_interrupt is not registered as per cpu
From:   SAURABH MALPANI <saurabh140585@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: saurabh140585@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3422

On Wed, Sep 7, 2011 at 12:47 AM, David Daney <david.daney@cavium.com> wrote:
> On 09/06/2011 12:02 PM, SAURABH MALPANI wrote:
>>
>> Hi David,
>>
>> Thanks a bunch for clarifying this. Just to complete, I have some code
>> which calls CHECK_IRQ_PER_CPU(desc->status) after every time a
>> descriptor is created for an irq. And based on it we create either per
>> cpu data structures or single data structure for that particular irq.
>>
>> After your clarification, I can safely create exception for
>> OCTEON_IRQ_MBOX0 and OCTEON_IRQ_MBOX1 as you mention that missing the
>> flag is just cosmetic.
>>
>
> Well the performance counter and timer interrupts may suffer in a similar
> manner.
>
> David Daney
>


Since the timer interrupt is registered via the clock device
infrastructure, I found that hrtimer_interrupt irq descriptor was
indeed succeeding the CHECK_IRQ_PER_CPU test. So far in our testing we
only hit an exception for mailbox interrupt.
