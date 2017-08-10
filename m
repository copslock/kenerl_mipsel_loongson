Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 19:32:36 +0200 (CEST)
Received: from mail-io0-x22c.google.com ([IPv6:2607:f8b0:4001:c06::22c]:34066
        "EHLO mail-io0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993256AbdHJRc3TihYw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 19:32:29 +0200
Received: by mail-io0-x22c.google.com with SMTP id o9so12232142iod.1
        for <linux-mips@linux-mips.org>; Thu, 10 Aug 2017 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LH3yLYmCMWeTrJvZU5JuycFXKAe5myz7KpA75veOP2M=;
        b=VsKJxI3/rQlj8Nwtnrau03urHlOFVrT/39wzXzAEEY/TdFXldLQUurLw0k0UT49cbm
         xI50CcTmuBrTDWnxrJ1bSSMWPIuxjoPh1UByAqjlbpR1G7hhopSboTN9uAde7oHGDNFW
         NpPgR6D/GHl324zCsUsMkny5pp8Oj3ACLBo91xgZTChKs4IteavX5+P8FBHnbQ6suQV5
         +KVZP5SiD86jKyqsYvqF0BGr+LbioSmtSTpjG3I+dJ3QwwBQjYcAdX7OIidWY3E+O06i
         R35d0yZHTw5MVxHbNCZC+NohjhN7bHz80tvdhl2LGSav2biQkDRsSGYhucnJoZ49yrPK
         7k2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LH3yLYmCMWeTrJvZU5JuycFXKAe5myz7KpA75veOP2M=;
        b=ciEqVJNlQFoXqpdyk4nAsoDhMnbPkae1glv2vijBdwc0QOdfm7LsBBgRYN7p1CFhdH
         cZ47EWSCkcbrg2oS9xeUf20ObUBbXTeeiQ1nGLpTqpbOPvFDK7AVPXC/FefLvCp/iZlz
         d3reTYq5H85LpqM0TowTJByQCsxtgPvlap4EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LH3yLYmCMWeTrJvZU5JuycFXKAe5myz7KpA75veOP2M=;
        b=kSFUllAi3xYdQmKTKxx1b7mm+oPZpNepC0ghZmjbAfHA1cqva7t3Qo6zSJZx3lN44f
         rvKVLFU0PrgaBLyUT6jN2omTcgVDklJ+iAoQpgiLZdSBSo2HvFQrMoyGsArewO2rYNQc
         RiHqUhFeO89PeBlYBck3DeF7of3Cwf5CHVpKiPBPcByxYDPEP+Rl4zz1rNQvRNTPmwz4
         dUeCi10LtplYeVXyMH3DZDRNPKnt7El3ZaDPZiLZE6RyWzWSryCrZ+B6Q6JUfC2yl9N3
         KRhfy9hZPOErd/t4z6qhTvQNM7BHFoQQno1/CBR+7WYFlSyhk9jSJwarM77zSwZRU5qq
         v75w==
X-Gm-Message-State: AIVw11199mHZLfgcebI8CQfos51L0vO3zsGKWms49ZmeGcP6fnqS/q3o
        xK6hh0WuOgSLxC5pJyCgch2OREWevBE9
X-Received: by 10.107.6.86 with SMTP id 83mr10210529iog.190.1502386343337;
 Thu, 10 Aug 2017 10:32:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.138.161 with HTTP; Thu, 10 Aug 2017 10:32:22 -0700 (PDT)
In-Reply-To: <28ab1c38-f8a7-3fca-7a5a-e44248bec69f@imgtec.com>
References: <1502195022-18161-1-git-send-email-matt.redfearn@imgtec.com>
 <CAGXu5j+nF5sAO=NMLq2Oh2aHJRxGVED93oCH0GK28yU0SXQ=MA@mail.gmail.com> <28ab1c38-f8a7-3fca-7a5a-e44248bec69f@imgtec.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 10 Aug 2017 10:32:22 -0700
X-Google-Sender-Auth: vjUkHbGzi7f2w_4Jh_dSdO48D7o
Message-ID: <CAGXu5jL_b2-2OFBSKhumag_vViqMFutaZfvpBRWB5L-Gng1zuA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: usercopy: Implement stack frame object validation
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Thu, Aug 10, 2017 at 1:24 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> Hi Kees,
>
>
> On 08/08/17 20:11, Kees Cook wrote:
>>
>> On Tue, Aug 8, 2017 at 5:23 AM, Matt Redfearn <matt.redfearn@imgtec.com>
>> wrote:
>>>
>>> This implements arch_within_stack_frames() for MIPS that validates if an
>>> object is wholly contained by a kernel stack frame.
>>>
>>> With CONFIG_HARDENED_USERCOPY enabled, MIPS now passes the LKDTM tests
>>> USERCOPY_STACK_FRAME_TO, USERCOPY_STACK_FRAME_FROM and
>>> USERCOPY_STACK_BEYOND on a Creator Ci40.
>>>
>>> Since the MIPS kernel does not use frame pointers, we re-use the MIPS
>>> kernels stack frame unwinder which uses instruction inspection to deduce
>>> the stack frame size. As such it introduces a larger performance penalty
>>> than on arches which use the frame pointer.
>>
>> Hmm, given x86's plans to drop the frame pointer, I wonder if the
>> inter-frame checking code should be gated by a CONFIG. This (3%) is a
>> rather high performance hit to take for a relatively small protection
>> (it's mainly about catching too-large-reads, since most
>> too-large-writes will be caught by the stack canary).
>>
>> What do you think?
>
>
> If x86 is going to move to a more expensive stack unwinding method than the
> frame pointer then I guess it may end up seeing a similar performance hit to
> what we see on MIPS. In that case it might make sense to add a CONFIG for
> this such that only those who wish to make the trade off of performance for
> the added protection need enable it.

Sounds good. Can you send a v2 that adds a CONFIG, maybe something
like CONFIG_HARDENED_USERCOPY_UNWINDER with a description of the
trade-offs? Then x86 can do this too when it drops frame pointers.

Thanks!

-Kees


-- 
Kees Cook
Pixel Security
