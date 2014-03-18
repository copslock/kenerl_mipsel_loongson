Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 01:04:56 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49554 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867486AbaCRAEw7ha-k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2014 01:04:52 +0100
Received: by mail-pa0-f49.google.com with SMTP id lj1so6418292pab.36
        for <multiple recipients>; Mon, 17 Mar 2014 17:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hEqPr+PVSDKYAkabl+4LLk1gg5h+NKwJf0ShtzlflUs=;
        b=wQ7IX9Unc/d8DoijBzwRehVOS6g5UjiG+VUQr3ZxXxs7GQ8emKhi81vR+KWM01GXt6
         Dq6n27jT1OU5QJlqbcLhGVSM7GhxLIYQPL7qTskLHsepzEdM7AV9+RqIweJ/LAfEV1AN
         GLC3XRnQxzTmYWHZs/1lvtZ3CdRSfz82ZeFEGuJGYuTHA2K81zY4JSfRhfACcjkzykcO
         rbqQsqPTaZrMNLM0vtD3Mp9PF/q+8dIPbOiqLZJNB7euslC3pV5lB9c/FL5cB+w1Kgbj
         y6lyZ0qYCk8tCwaEZzYgjXSMXrd7djJG4S3pDOTKSLKIbXhd0SOOpp85zED8BgvqCHm2
         xI5Q==
MIME-Version: 1.0
X-Received: by 10.66.66.66 with SMTP id d2mr29478859pat.80.1395101085986; Mon,
 17 Mar 2014 17:04:45 -0700 (PDT)
Received: by 10.70.43.144 with HTTP; Mon, 17 Mar 2014 17:04:45 -0700 (PDT)
In-Reply-To: <20140317145641.GN19285@linux-mips.org>
References: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
        <1393055209-28251-2-git-send-email-villerhsiao@gmail.com>
        <20140317145641.GN19285@linux-mips.org>
Date:   Tue, 18 Mar 2014 08:04:45 +0800
Message-ID: <CAA1JSY+0_4Vb9y0T+oWdZRKPEpy08soa05kNT=7Hw9+qfPG5DQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MIPS: ftrace: Tweak safe_load()/safe_store() macros
From:   Viller Hsiao <villerhsiao@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Qais Yousef <Qais.Yousef@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <villerhsiao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: villerhsiao@gmail.com
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

On Mon, Mar 17, 2014 at 10:56 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Feb 22, 2014 at 03:46:48PM +0800, Viller Hsiao wrote:
>
>> Due to name collision in ftrace safe_load and safe_store macros,
>> these macros cannot take expressions as operands.
>>
>> For example, compiler will complain for a macro call like the following:
>>   safe_store_code(new_code2, ip + 4, faulted);
>>
>>   arch/mips/include/asm/ftrace.h:61:6: note: in definition of macro 'safe_store'
>>      : [dst] "r" (dst), [src] "r" (src)\
>>         ^
>>   arch/mips/kernel/ftrace.c:118:2: note: in expansion of macro 'safe_store_code'
>>     safe_store_code(new_code2, ip + 4, faulted);
>>     ^
>>   arch/mips/kernel/ftrace.c:118:32: error: undefined named operand 'ip + 4'
>>     safe_store_code(new_code2, ip + 4, faulted);
>>                                   ^
>>   arch/mips/include/asm/ftrace.h:61:6: note: in definition of macro 'safe_store'
>>      : [dst] "r" (dst), [src] "r" (src)\
>>         ^
>>   arch/mips/kernel/ftrace.c:118:2: note: in expansion of macro 'safe_store_code'
>>     safe_store_code(new_code2, ip + 4, faulted);
>>     ^
>>
>> This patch tweaks variable naming in those macros to allow flexible
>> operands.
>
> Interesting catch - and while I think your patch indeed is an improvment
> nobody seems to have observed this in a kernel tree, so I'm going to treat
> this as a non-urgent improvment and queue it for 3.15.
>
> If this can be triggered in any -stable or v3.14-rc7 tree, please let me
> know.
>
> Thanks,
>
>   Ralf

Hi Ralf,

If you get plan to merge it later, please help to handle another patch
in the patchset at the same time,
   [PATCH v2 2/2] MIPS: ftrace: Fix icache flush range error

Or the 2nd one might have compilation error shown in this commit
message. Sorry for the inconvenience.

Viller
