Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 08:53:09 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33041 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822284AbaCRHxHV80sn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2014 08:53:07 +0100
Received: by mail-pa0-f51.google.com with SMTP id kq14so6929171pab.38
        for <multiple recipients>; Tue, 18 Mar 2014 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/MJqaeC07oj+809b7flBGybHm4vlJ2ITmfHeO0coIe4=;
        b=ct4PIcK+kz5BZQAMmyPQ+uVuHiMbRedgfAR/zsEiuLDikuRY/0zPZtq5gvreW04OW1
         piBteuQm1vWebd5t7VifKNqL+Ujd+2Mi8yx+9qsThv4KFB1tPVytvqwX9eLnYcmk73gh
         WekwZOdJ5iWvC0AEk2jGI4/ocA8sWjfaqLdiyJzSdMvX0DXh4uLVJEqg2tsCPE/pTohU
         vUSafGQGJWvWJ7YpqaeKhQJd4iufuuex718iYO/kudHCqZNuSSoWdKKWiOT0qbvMKj1w
         FtgGJ7z4tz2KZReCU+TlpThb/jGaZ4chaGSbUFPtyvx6dsIkLJTDwydtDKn32OG0tsBY
         ghZg==
MIME-Version: 1.0
X-Received: by 10.69.31.171 with SMTP id kn11mr31620705pbd.47.1395129181001;
 Tue, 18 Mar 2014 00:53:01 -0700 (PDT)
Received: by 10.70.43.144 with HTTP; Tue, 18 Mar 2014 00:53:00 -0700 (PDT)
In-Reply-To: <CAA1JSY+0_4Vb9y0T+oWdZRKPEpy08soa05kNT=7Hw9+qfPG5DQ@mail.gmail.com>
References: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
        <1393055209-28251-2-git-send-email-villerhsiao@gmail.com>
        <20140317145641.GN19285@linux-mips.org>
        <CAA1JSY+0_4Vb9y0T+oWdZRKPEpy08soa05kNT=7Hw9+qfPG5DQ@mail.gmail.com>
Date:   Tue, 18 Mar 2014 15:53:00 +0800
Message-ID: <CAA1JSY+pzsUp+Pfhvm2-rMJ0KfeZr8YaDvuefO3KqRr-Xbmj6A@mail.gmail.com>
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
X-archive-position: 39490
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

On Tue, Mar 18, 2014 at 8:04 AM, Viller Hsiao <villerhsiao@gmail.com> wrote:
> On Mon, Mar 17, 2014 at 10:56 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Sat, Feb 22, 2014 at 03:46:48PM +0800, Viller Hsiao wrote:
>>
>>> Due to name collision in ftrace safe_load and safe_store macros,
>>> these macros cannot take expressions as operands.
>>>
>>> For example, compiler will complain for a macro call like the following:
>>>   safe_store_code(new_code2, ip + 4, faulted);
>>>
>>>   arch/mips/include/asm/ftrace.h:61:6: note: in definition of macro 'safe_store'
>>>      : [dst] "r" (dst), [src] "r" (src)\
>>>         ^
>>>   arch/mips/kernel/ftrace.c:118:2: note: in expansion of macro 'safe_store_code'
>>>     safe_store_code(new_code2, ip + 4, faulted);
>>>     ^
>>>   arch/mips/kernel/ftrace.c:118:32: error: undefined named operand 'ip + 4'
>>>     safe_store_code(new_code2, ip + 4, faulted);
>>>                                   ^
>>>   arch/mips/include/asm/ftrace.h:61:6: note: in definition of macro 'safe_store'
>>>      : [dst] "r" (dst), [src] "r" (src)\
>>>         ^
>>>   arch/mips/kernel/ftrace.c:118:2: note: in expansion of macro 'safe_store_code'
>>>     safe_store_code(new_code2, ip + 4, faulted);
>>>     ^
>>>
>>> This patch tweaks variable naming in those macros to allow flexible
>>> operands.
>>
>> Interesting catch - and while I think your patch indeed is an improvment
>> nobody seems to have observed this in a kernel tree, so I'm going to treat
>> this as a non-urgent improvment and queue it for 3.15.
>>
>> If this can be triggered in any -stable or v3.14-rc7 tree, please let me
>> know.
>>
>> Thanks,
>>
>>   Ralf
>
> Hi Ralf,
>
> If you get plan to merge it later, please help to handle another patch
> in the patchset at the same time,
>    [PATCH v2 2/2] MIPS: ftrace: Fix icache flush range error
>
> Or the 2nd one might have compilation error shown in this commit
> message. Sorry for the inconvenience.
>
> Viller

Hi Ralf,

The operand name and variable name are a little ambiguous in PATCH v2.
Therefore I tweaked and submitted PATCH v3. Please help to use them if
possible.

Thanks,
Viller
