Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 02:22:29 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:33465 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010799AbaJHAW1LsWwx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Oct 2014 02:22:27 +0200
Received: by mail-la0-f41.google.com with SMTP id pn19so7477928lab.0
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 17:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=at2lb2RkOo7if4/ST6bMGKtxfxZsHqME5q0HZllCy9k=;
        b=dugc3LWI2YfdsvcKwnS6QSFmRGlhmE2KUcdrCt4cSTvZWFlTWibSM6Sn9g7ZZP7une
         G7aRBq3igKzHWMt0VW5YuBFh5IrT5xNlEND92Ra/k34qBYpPfeJy+KC0Ceh3X+0XyPXr
         xpNOMdN0OQENRv+371ywWVg1QxjCygWqsiVFb70QUV3K4/alTZz97Jq5t6lSKJtSXTtj
         myQ2In09J3idfsfBTT9o8d9t6yybAKEoTIlXht+cXnSDph6zBIVzUHeKXogzgC/aVShw
         oF+rGMyqGCZAYhZkbZ54MPVHL7zy8f6PLNiVgDb3A/ECwPjJQ8J8JbaTcbEPC7JpnJ/L
         l4tA==
X-Gm-Message-State: ALoCoQnujNHxsviQ0ZZ2cyLUJtTqkccx+YzBEvLnI8teRCiz20pp1Qyj0o3ALJjwimDOd4cl2O2p
X-Received: by 10.152.28.167 with SMTP id c7mr7476059lah.27.1412727741536;
 Tue, 07 Oct 2014 17:22:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Tue, 7 Oct 2014 17:22:01 -0700 (PDT)
In-Reply-To: <54344714.1000600@gmail.com>
References: <54332A64.5020605@caviumnetworks.com> <20141007000514.GD23797@brightrain.aerifal.cx>
 <543334CE.8060305@caviumnetworks.com> <20141007004915.GF23797@brightrain.aerifal.cx>
 <54337127.40806@gmail.com> <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org>
 <543431DA.4090809@imgtec.com> <CALCETrUQEbb=DotSzsneN7Hano_eC-EoTMko6uKcyZXvEcktkw@mail.gmail.com>
 <20141007190943.GM23797@brightrain.aerifal.cx> <54343C2B.2080801@imgtec.com>
 <20141007192107.GN23797@brightrain.aerifal.cx> <CALCETrU8qPL1qKGk7FqM=LCnoeSfuwDV_bG_a=5zcOKtWfkdGw@mail.gmail.com>
 <54344714.1000600@gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 7 Oct 2014 17:22:01 -0700
Message-ID: <CALCETrWNOPsPM689iXbV1dyBuGgV-_RtGo2fdF_--+3R0uN9Lg@mail.gmail.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     David Daney <david.daney@cavium.com>,
        Rich Felker <dalias@libc.org>,
        David Daney <david.s.daney@gmail.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43101
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

On Oct 7, 2014 1:03 PM, "David Daney" <ddaney.cavm@gmail.com> wrote:
>
> On 10/07/2014 12:28 PM, Andy Lutomirski wrote:
>>
>> On Tue, Oct 7, 2014 at 12:21 PM, Rich Felker <dalias@libc.org> wrote:
>>>
>>> On Tue, Oct 07, 2014 at 12:16:59PM -0700, Leonid Yegoshin wrote:
>>>>
>>>> On 10/07/2014 12:09 PM, Rich Felker wrote:
>>>>>
>>>>> I agree completely here. We should not break things (or, as it
>>>>> seems, leave them broken) for common usage cases that affect
>>>>> everyone just to coddle proprietary vendor-specific instructions.
>>>>> The latter just should not be used in delay slots unless the chip
>>>>> vendor also promises to provide fpu branch in hardware. Rich
>>>>
>>>> And what do you propose - remove a current in-stack emulation and
>>>> you still think it doesn't break a status-quo?
>>>
>>>
>>> The in-stack trampoline support could be left but used only for
>>> emulating instructions the kernel doesn't know. This would make all
>>> normal binaries immediately usable with non-executable stack, and
>>> would avoid the only potential source of regressions. Ultimately I
>>> think the "xol" stuff should be removed, but that could be a long term
>>> goal.
>>
>>
>> Does anything break if the xol stuff is disabled for PT_GNU_STACK tasks?
>>
>
> The instructions must be executed, if you turn on a non-executable stack, you cannot execute them on the stack, so they must be handled in another way, which is the subject of this thread.
>
> Options:
>
> 1a) XOL kernel manages the memory
> 1b) XOL userspace manages the menory
> 2) Emulate the instructions.
> 3) I don't think there is a 3rd. option.

4) SIGILL

5) single-step or use an HW breakpoint if available


But, yes, 3 seems reasonable.

--Andy
