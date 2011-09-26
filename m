Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2011 11:08:00 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:60118 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492000Ab1IZJHw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Sep 2011 11:07:52 +0200
Received: by gyg13 with SMTP id 13so4828582gyg.36
        for <multiple recipients>; Mon, 26 Sep 2011 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+BIGkCSkZhhXh1/7AiW+sZtjaYevoJdHb7ghMdtm3NE=;
        b=Tyxdb7QKtplqsCTwWutWH1FXJUMX2OWLXE8gh8ZvEOvZXW3v7FgH7dzz9bdQ3lYsBS
         pKYcHlImBSmuE5pam14foWksfyX+auLmzU5OgRswYcin0XsTQJ7B3CiWipu97Alb9aW+
         /oTjZPsPdDNTPuo/cmQbNOj12NVZTzsxbgdrw=
MIME-Version: 1.0
Received: by 10.236.129.242 with SMTP id h78mr37660892yhi.89.1317028066001;
 Mon, 26 Sep 2011 02:07:46 -0700 (PDT)
Received: by 10.236.69.232 with HTTP; Mon, 26 Sep 2011 02:07:45 -0700 (PDT)
In-Reply-To: <4E7E4444.4010706@gmail.com>
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
        <1316712378-7282-5-git-send-email-david.daney@cavium.com>
        <CAOfQC98YwVoFWz+ZYv5JYCPG=NhzoeMKy70oE7aJbwAB+yZ6gA@mail.gmail.com>
        <4E7E4444.4010706@gmail.com>
Date:   Mon, 26 Sep 2011 17:07:45 +0800
Message-ID: <CAOfQC9-pejNEWyFjyGc_k+NkuZquYQZrhNKMe+p7MT-R4Zn0vw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] MIPS: perf: Add support for 64-bit perf counters.
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <david.s.daney@gmail.com>
Cc:     ralf@linux-mips.org, David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14421

2011/9/25 David Daney <david.s.daney@gmail.com>:
> On 09/23/2011 07:54 PM, Deng-Cheng Zhu wrote:
>>
>> 2011/9/23 David Daney<david.daney@cavium.com>:
>>>
>>> The hard coded constants are moved to struct mips_pmu.  All counter
>>> register access move to the read_counter and write_counter function
>>> pointers, which are set to either 32-bit or 64-bit access methods at
>>> initialization time.
>>>
>>> Many of the function pointers in struct mips_pmu were not needed as
>>> there was only a single implementation, these were removed.
>>>
>>> I couldn't figure out what made struct cpu_hw_events.msbs[] at all
>>> useful, so I removed it too.
>>
>> The idea behind msbs is to simulate 32-bit counters based on the fact
>> of MIPS using the MSB to trigger the overflow interrupt. By doing this,
>> the
>> average length of the overflow ISR can be shorter in the case of event
>> period is bigger than 0x80000000.
>
> It doesn't make the maximum overflow period any shorter.  It just hides it
> from the perf core, which is perfectly capable of handling the shorter
> maximum overflow period.

[DC] To start with, I didn't mean that shorter maximum overflow period
couldn't be well supported by the perf core. In fact, as you know, I
tested your patch set several months ago and observed correct
functionality. But your implementation simply prevents the possiblity of
the sample period being bigger than 0x80000000 (let's talk about 32-bit
counters):

Your code:
mipspmu_event_set_period():
        if (left > mipspmu.max_period) {
                left = mipspmu.max_period;
                local64_set(&hwc->period_left, left);
        }

        local64_set(&hwc->prev_count, mipspmu.overflow - left);

        mipspmu.write_counter(idx, mipspmu.overflow - left);

If this case is to be supported, then you'll still need additional
algorithm in the code - meanwhile, to go through this big event period,
the perf code needs to experience the 'full' ISR twice. In the existing
implementation (using msbs), one of the two is pseudo (simply updates
msbs). This is what I called "the average length of the overflow ISR can
be shorter in the case of...". Since the case of big sample period is not
helpful in performance analysis, I do not have a strong objection to your
changes on this matter indeed.


Deng-Cheng
