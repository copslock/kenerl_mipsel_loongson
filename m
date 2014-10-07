Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 20:17:21 +0200 (CEST)
Received: from mail-lb0-f175.google.com ([209.85.217.175]:38140 "EHLO
        mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010739AbaJGSRT7VdZF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 20:17:19 +0200
Received: by mail-lb0-f175.google.com with SMTP id u10so6557678lbd.6
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 11:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Z11F87o5R6iidx2wtQGXhGlO16A1JCUC8zzJA3zgUyA=;
        b=JvzeKuFCfuQQsOLT34lwQdwPRO++5SPhyjZpZUCpryuUJhIcE+/sF5ejweICoeI8Ol
         3ZCqGGq/QolfORN4dNI+cNQaXVIaNaKjjMA4c/ZZFrcrad+nw8ZL9AW69ktjReSEHqgO
         j3BmIsdHh8GXIK+0k7wci9gg6lBcvI/FdKkVlW76h/DG3xZf5sw1wsUcTmtcIPEZa+/H
         0cbeQoXq8lmNpW8EBH+4FV9clZGBHW9NogWWPUzuUz4De0H1m251VBW8Q86aB1+QJjFf
         Zus6F1h+l7P4fYJdcEpqbSRNSK2swdOYqaW/RyxXpBJdze++vUzHjrY7zGqgnuP4RYlF
         bmGg==
X-Gm-Message-State: ALoCoQkgJVoIsmwbF92z0WNSffgsh/lZOIHnLDjdZZtTVpWMPU3+6r9GdRo7K/g5Ar6cnkN7tC6z
X-Received: by 10.152.234.232 with SMTP id uh8mr5975710lac.19.1412705834320;
 Tue, 07 Oct 2014 11:17:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Tue, 7 Oct 2014 11:16:54 -0700 (PDT)
In-Reply-To: <54341013.2030509@caviumnetworks.com>
References: <5433071B.4050606@caviumnetworks.com> <20141006213101.GA23797@brightrain.aerifal.cx>
 <54330D79.80102@caviumnetworks.com> <20141006215813.GB23797@brightrain.aerifal.cx>
 <543327E7.4020608@amacapital.net> <54332A64.5020605@caviumnetworks.com>
 <20141007000514.GD23797@brightrain.aerifal.cx> <543334CE.8060305@caviumnetworks.com>
 <20141007004915.GF23797@brightrain.aerifal.cx> <54337127.40806@gmail.com>
 <20141007111102.GH23797@brightrain.aerifal.cx> <54341013.2030509@caviumnetworks.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 7 Oct 2014 11:16:54 -0700
Message-ID: <CALCETrWHE0nMZFthg_JP9dEABpvyumcKoHGn1-2q2F2nm2CvLg@mail.gmail.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Rich Felker <dalias@libc.org>,
        David Daney <david.s.daney@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Oct 7, 2014 9:09 AM, "David Daney" <ddaney@caviumnetworks.com> wrote:
>
> On 10/07/2014 04:11 AM, Rich Felker wrote:
>>
>> On Mon, Oct 06, 2014 at 09:50:47PM -0700, David Daney wrote:
>>>>>
>>>>> the out-of-line execution trick, but do it somewhere other than in
>>>>> stack memory.
>>>>
>>>> How do you answer Andy Lutomirski's question about what happens when a
>>>> signal handler interrupts execution while the program counter is
>>>> pointing at this "out-of-line execution" trampoline? This seems like a
>>>> show-stopper for using anything other than the stack.
>>>
>>> It would be nice to support, but not doing so would not be a
>>> regression from current behavior.
>>
>>
>> It's not just "nice" to support, it's mandatory. Otherwise you will
>> execute essentially *random instructions* in this case, providing a
>> very nice attack vector that can almost certainly be elevated to
>> arbitrary code execution via timing of signals during floating point
>> code.
>>
>> The current behavior in regards to this is correct: because you have a
>> *stack*, each trampoline is pushed onto the stack in its own context,
>> and popped when it's no longer needed. You can have arbitrarily many
>> such trampolines up to the stack size. Note that each nested signal
>> handler already requires sizeof(ucontext_t) in stack space, so these
>> trampolines are a negligible additional cost without major effects on
>> the number of signal handlers you can nest without overflowing the
>> stack.
>
>
> Yes, the stack takes care of the allocations, but the current implementation has many problems:
>
> 1) Signals clobber the emulation area.
> 2) Signals caused by the emulation, have incorrect saved machine state.
>
> We have a low bar to pass, any new solution doesn't have to be perfect, it only has to be an improvement.
>
> Keep in mind that we are not starting from a clean slate, there are many years of legacy code that has built up here.

A lesson I learned when doing the x86 vsyscall stuff: Don't waste time
improving legacy crap without a really good reason.  Especially don't
extend the interface.  Deprecate it (without breaking working user
code) and move on.

--Andy

>
> David Daney
