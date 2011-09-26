Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2011 11:12:41 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:63548 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492005Ab1IZJMh convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Sep 2011 11:12:37 +0200
Received: by yxi11 with SMTP id 11so4984632yxi.36
        for <multiple recipients>; Mon, 26 Sep 2011 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qVweLBTZQWwnkfg5ImwzuEs+CkUWZ/2wmtmfFfYfInM=;
        b=Zj4nx4bv0itKgIGXJGP4b0ale61K6QL/s7VjU1DpBtnvGf+mg2yVQtvbo8IA2RRO6W
         fR5RZVD8pf9/bL/BoQAg5XKfPeI7wkzsgaRjjZA0cjKisT0i5TK8abvXeoEKlImEOSU9
         Y1RiMEqS8iPT391i6BJuy/Qa+muAYb4/UDoXc=
MIME-Version: 1.0
Received: by 10.236.129.165 with SMTP id h25mr37700440yhi.38.1317028351102;
 Mon, 26 Sep 2011 02:12:31 -0700 (PDT)
Received: by 10.236.69.232 with HTTP; Mon, 26 Sep 2011 02:12:31 -0700 (PDT)
In-Reply-To: <4E7E4110.40603@gmail.com>
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
        <1316712378-7282-4-git-send-email-david.daney@cavium.com>
        <CAOfQC98+G6Ar8RAT8697GS3MMhEQH86WSyrGjPAo4ELMCWzJHw@mail.gmail.com>
        <4E7E4110.40603@gmail.com>
Date:   Mon, 26 Sep 2011 17:12:31 +0800
Message-ID: <CAOfQC99chot=wRfBSrQrvnSkpvEEQhBgdF8hQVc6eeqC0g4wJA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] MIPS: perf: Reorganize contents of perf support files.
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <david.s.daney@gmail.com>
Cc:     ralf@linux-mips.org, David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dezhong Diao <dediao@cisco.com>,
        Gabor Juhos <juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14428

2011/9/25 David Daney <david.s.daney@gmail.com>:
> On 09/23/2011 07:50 PM, Deng-Cheng Zhu wrote:
>>
>> 2011/9/23 David Daney<david.daney@cavium.com>
>>>
>>> The contents of arch/mips/kernel/perf_event.c and
>>> arch/mips/kernel/perf_event_mipsxx.c were divided in a seemingly ad
>>> hoc manner, with the first including the second.
>>>
>>> I moved all the hardware counter support code to perf_event_mipsxx.c
>>> and removed the gating #ifdefs to the Kconfig and Makefile.
>>>
>>> Now perf_event.c contains only the callchain support, everything else
>>> is in perf_event_mipsxx.c
>>>
>> Sorry for my late comment. I personally don't think it's a bad idea to
>> use the original gating #ifdefs, because it allows sharing common code
>> among different types of MIPS PMUs. Also, using CPU types as compiling
>> conditions seems make sense. If you move the common hunk to
>> perf_event_mipsxx.c, other CPUs like loognson series will have to
>> duplicate
>> these stuff.
>>
>
> I disagree, and here is why:
>
> Almost all the the code is mipsxx specific.
>
> If Loongson has a PMU that can reuse this code, it can just be added to
> perf_event_mipsxx.c along with all the other mips compatible PMUs
>
> If this is not feasible, then it can have its own file and and common code
> can be removed to a common place at that time.
>
> In any event, I have not seen any Loongson PMU patches, if someone has such
> patches I would be happy to consider changes that would make the kernel as a
> whole cleaner.  But preventing cleanup and removal of a ton of #ifdefery in
> hope that Loongson patches may someday want something different is not what
> I would call a good way forward.

[DC]: Here's a patch set to support Loongson2 sent by Wu Zhangjin based on
MIPS Perf-events v2:

http://www.linux-mips.org/archives/linux-mips/2010-04/msg00161.html

It used the "skeleton code (perf_event.c) + PMU specific code
(perf_event_$PMU.c)" model. The current perf_event.c is right the place
you mentioned as "a common place" to accommodate common code.

The naming convention here came from the current Oprofile code which
contains op_model_mipsxx.c, op_model_loongson2.c and op_model_rm9000.c. I
think it will confuse people if we put Loongson perf code into
perf_event_mipsxx.c.


Deng-Cheng
