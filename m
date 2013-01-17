Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 15:58:59 +0100 (CET)
Received: from mail-qc0-f180.google.com ([209.85.216.180]:57284 "EHLO
        mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832261Ab3AQO66C0o4k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2013 15:58:58 +0100
Received: by mail-qc0-f180.google.com with SMTP id v28so1711780qcm.11
        for <multiple recipients>; Thu, 17 Jan 2013 06:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=VnxVNsFYAC4NMFZhitLHz7QY0hm8lbe3vkFu34DPjNY=;
        b=h8smIGh1VGDUc0GDyZmeQNpi3WTtJJqtHZFinfY+0jB0fDIGnlRn61N8Lrzr7KLKVW
         EyLrM+oUPqITgJbijSD5PCFiG61zn+a1bDK4sXsbgAl8RgfzyipFILDaS/99LcryjHe9
         42qR+hce8vR3aR9/Frzybykw+7rESzd4XZyUg3pRqYTlROQKoV8uxjeT5J2kYKwfcDdH
         Ah0nZDkMeWrhH9t+SPfM2PU0nHB0pJHHewCmBnniXiHKloiN2Linjc3psP4GtTZK/+vI
         qUZFCur5n5E4FxY7dyBGDeh5NLXQj5QrnZmEsnIDxvYuxGuoU/ZV3DSuHJfVuHBf3+qO
         DMuA==
MIME-Version: 1.0
X-Received: by 10.224.216.9 with SMTP id hg9mr5858877qab.44.1358434731776;
 Thu, 17 Jan 2013 06:58:51 -0800 (PST)
Received: by 10.49.117.161 with HTTP; Thu, 17 Jan 2013 06:58:51 -0800 (PST)
In-Reply-To: <CAMuHMdUSRM6dauiRtSs20YVfHmNrROrc4RpZL+dKA_e2t82J6A@mail.gmail.com>
References: <1358379808-16449-1-git-send-email-alcooperx@gmail.com>
        <CAMuHMdUSRM6dauiRtSs20YVfHmNrROrc4RpZL+dKA_e2t82J6A@mail.gmail.com>
Date:   Thu, 17 Jan 2013 09:58:51 -0500
Message-ID: <CAOGqxeWNfknkq2Kad2sTWh9f9C8HpghdNBimsB9HFs8ze=LHHQ@mail.gmail.com>
Subject: Re: [PATCH V2] mips: function tracer: Fix broken function tracing
From:   Alan Cooper <alcooperx@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     rostedt@goodmis.org, ddaney.cavm@gmail.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

When the kernel first boots we have to be able to handle the gcc
generated jalr, addui sequence until ftrace_init gets a chance to run
and change the sequence. At this point mcount just adjusts the stack
and returns. When ftrace_init runs, we convert the jalr/addui to nops.
Then whenever tracing is enabled we convert the first nop to a "jalr
mcount+8". The mcount+8 entry point skips the stack adjust.


On Thu, Jan 17, 2013 at 1:27 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Jan 17, 2013 at 12:43 AM, Al Cooper <alcooperx@gmail.com> wrote:
>> Part of the sequence is "addiu sp,sp,-8" in the delay slot after every
>> call to the trace routine "_mcount" (some legacy thing where 2 arguments
>> used to be pushed on the stack). The _mcount routine is expected to
>> adjust the sp by +8 before returning.
>
> So when not disabled, the original jalr and addiu will be there, so _mcount has
> to adjust sp.
>
>> The problem is that when tracing is disabled for a function, the
>> "jalr _mcount" instruction is replaced with a nop, but the
>> "addiu sp,sp,-8" is still executed and the stack pointer is left
>> trashed. When frame pointers are enabled the problem is masked
>> because any access to the stack is done through the frame
>> pointer and the stack pointer is restored from the frame pointer when
>> the function returns.
>>
>> This patch writes two nops starting at the address of the "jalr _mcount"
>> instruction whenever tracing is disabled. This means that the
>> "addiu sp,sp.-8" will be converted to a nop along with the "jalr".
>
> When disabled, there will be two nops.
>
>> This is SMP safe because the first time this happens is during
>> ftrace_init() which is before any other processor has been started.
>> Subsequent calls to enable/disable tracing when other CPUs ARE running
>> will still be safe because the enable will only change the first nop
>> to a "jalr" and the disable, while writing 2 nops, will only be changing
>
> When re-enabled, there will be a jalr and a nop, which differs from the initial
> case, so _mcount doesn't have to adjust sp?
>
>> @@ -69,7 +68,7 @@ NESTED(ftrace_caller, PT_SIZE, ra)
>>         .globl _mcount
>>  _mcount:
>>         b       ftrace_stub
>> -        nop
>> +       addiu sp,sp,8
>>         lw      t1, function_trace_stop
>>         bnez    t1, ftrace_stub
>>         nop
>
> But _mcount will always adjust the stack pointer?
> What am I missing?
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
