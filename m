Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 21:04:35 +0200 (CEST)
Received: from mail-oa0-f41.google.com ([209.85.219.41]:34806 "EHLO
        mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856090AbaF0TEdDhigs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2014 21:04:33 +0200
Received: by mail-oa0-f41.google.com with SMTP id l6so6162505oag.28
        for <linux-mips@linux-mips.org>; Fri, 27 Jun 2014 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YXaVrv18+t3kV/UOEP8HMN7w82QHWVta5FajNxCYEJA=;
        b=i/UfWLAnzPuwYDr7B51kg7rwgLlSQMKwcXyGUUixwC5x/pi1E/hl0lxp7ZbviLUa8j
         FqWKw+zBaj+B0MHCRQhP4QjZGRlDbvdaC48j8a6kvN3Fzacrr7Eik6UfLeGQXjOh2er6
         C4q48YkoUFBThzflIt20m1JFm5dxjIwwNBRIchsSv2+vsmXcvMN8XC0bsBk1VXvAVQ7q
         nISU2WqxpjQyhh16epIp9K94GYG22p0a+n1W8x1CQ46ZriFSNNRuq45W9n3DxZAND/L6
         Ck/P/iLUP6DVDSFsy0VNqkJPrI1y8NmDjYlT5gUs5xbAfaeAQjVUcsAlGy9TX4PAS+E1
         syLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YXaVrv18+t3kV/UOEP8HMN7w82QHWVta5FajNxCYEJA=;
        b=W0Zr/7ZO08ZYdNceBm25RlMrSIxaamwwkfQBbGx+5WzyHPe54TyrPZoPvyNiPjJ7mC
         3CO0y5RPd8vRtQCVgMJuiz+1/clALI4YXpTn2J5SVdiToreK6ZEtG5q72wHinvw2ug3V
         GD/w86+FtEad/OsJX/PUUdo1EZhH3wF5TgP+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YXaVrv18+t3kV/UOEP8HMN7w82QHWVta5FajNxCYEJA=;
        b=LZMh/lpiPmH/GajPTRKeptpLmLt+8oc/f256BKzacHepQwYgdeOVVQUBXUagT+ZsOD
         IM/PGsKlrn3O0yXMCNhvb6PxaJhzhTlEtvleMmW2SwfXiTjmTO2ahZ/VutpxWNoNpNoJ
         QW2QQhv3lhgL65+rjvM0a7pgu/gRgng30Gf77QANxpTawa+Mk/zAI6TAmcD13QlMXoZl
         g7fvUcR0EkPoE8qpO0lQqnVJysML8g7O9awrZz1l5LqJF205Shn/qDRQbSwFqMAVy5rn
         qyZjFSwt/Kt0xUG56kpPDiIb4fpMvpPjd5Bc5vQYjQBBek4YlmHIKgKtidKOSFl2W/Ow
         9fVA==
X-Gm-Message-State: ALoCoQlFBRs4TRr+CU5vjSD2ziTzgQ7RMBUr8sVtEN+bG4Ig++HWZfFYcdFYd9WJLU78uw/aGaCj
MIME-Version: 1.0
X-Received: by 10.182.81.99 with SMTP id z3mr13103141obx.79.1403895866945;
 Fri, 27 Jun 2014 12:04:26 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Fri, 27 Jun 2014 12:04:26 -0700 (PDT)
In-Reply-To: <CALCETrWr+5n_w+q-fNc0G55eUteN57sm+7-bPCXKb7acmLu0Cg@mail.gmail.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <1403642893-23107-6-git-send-email-keescook@chromium.org>
        <20140625135121.GB7892@redhat.com>
        <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
        <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
        <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
        <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
        <20140625173245.GA17695@redhat.com>
        <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
        <20140625175136.GA18185@redhat.com>
        <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
        <CALCETrVNwhWSPNiBiZmgP1nD9zLJPTk6cH0yo=85rbxTPTYFRg@mail.gmail.com>
        <CAGXu5jLavA8FJD8m-1y4wO0uzh3qvvMmajAg0Lrr1Cn_Om3a3w@mail.gmail.com>
        <CALCETrUPxTxseJ=sOhD9CyJPtOqCR5sL8yx7KezLmLZcFSFNMA@mail.gmail.com>
        <CAGXu5j+wPvAuo6pVc_XoJqv7CvW6yDf3YE6P7tFwtO9hfcUUsg@mail.gmail.com>
        <CALCETrWr+5n_w+q-fNc0G55eUteN57sm+7-bPCXKb7acmLu0Cg@mail.gmail.com>
Date:   Fri, 27 Jun 2014 12:04:26 -0700
X-Google-Sender-Auth: a01VumeYOucZw45g5SyIFCWC4v4
Message-ID: <CAGXu5jL5rN6=2-SwHiiEVuGVain-T7Ucg2PsN7u08vQ5Rxz6Mg@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40875
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

On Fri, Jun 27, 2014 at 11:56 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Fri, Jun 27, 2014 at 11:52 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Fri, Jun 27, 2014 at 11:39 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> On Fri, Jun 27, 2014 at 11:33 AM, Kees Cook <keescook@chromium.org> wrote:
>>>> On Wed, Jun 25, 2014 at 11:07 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>>> On Wed, Jun 25, 2014 at 11:00 AM, Kees Cook <keescook@chromium.org> wrote:
>>>>>> On Wed, Jun 25, 2014 at 10:51 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>>>>> On 06/25, Andy Lutomirski wrote:
>>>>>>>>
>>>>>>>> On Wed, Jun 25, 2014 at 10:32 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>>>>>> > On 06/25, Andy Lutomirski wrote:
>>>>>>>> >>
>>>>>>>> >> Write the filter, then smp_mb (or maybe a weaker barrier is okay),
>>>>>>>> >> then set the bit.
>>>>>>>> >
>>>>>>>> > Yes, exactly, this is what I meant. Plas rmb() in __secure_computing().
>>>>>>>> >
>>>>>>>> > But I still can't understand the rest of your discussion about the
>>>>>>>> > ordering we need ;)
>>>>>>>>
>>>>>>>> Let me try again from scratch.
>>>>>>>>
>>>>>>>> Currently there are three relevant variables: TIF_SECCOMP,
>>>>>>>> seccomp.mode, and seccomp.filter.  __secure_computing needs
>>>>>>>> seccomp.mode and seccomp.filter to be in sync, and it wants (but
>>>>>>>> doesn't really need) TIF_SECCOMP to be in sync as well.
>>>>>>>>
>>>>>>>> My suggestion is to rearrange it a bit.  Move mode into seccomp.filter
>>>>>>>> (so that filter == NULL implies no seccomp) and don't check
>>>>>>
>>>>>> This would require that we reimplement mode 1 seccomp via mode 2
>>>>>> filters. Which isn't too hard, but may add complexity.
>>>>>>
>>>>>>>> TIF_SECCOMP in secure_computing.  Then turning on seccomp is entirely
>>>>>>>> atomic except for the fact that the seccomp hooks won't be called if
>>>>>>>> filter != NULL but !TIF_SECCOMP.  This removes all ordering
>>>>>>>> requirements.
>>>>>>>
>>>>>>> Ah, got it, thanks. Perhaps I missed somehing, but to me this looks like
>>>>>>> unnecessary complication at first glance.
>>>>>>>
>>>>>>> We alredy have TIF_SECCOMP, we need it anyway, and we should only care
>>>>>>> about the case when this bit is actually set, so that we can race with
>>>>>>> the 1st call of __secure_computing().
>>>>>>>
>>>>>>> Otherwise we are fine: we can miss the new filter anyway, ->mode can't
>>>>>>> be changed it is already nonzero.
>>>>>>>
>>>>>>>> Alternatively, __secure_computing could still BUG_ON(!seccomp.filter).
>>>>>>>> In that case, filter needs to be set before TIF_SECCOMP is set, but
>>>>>>>> that's straightforward.
>>>>>>>
>>>>>>> Yep. And this is how seccomp_assign_mode() already works? It is called
>>>>>>> after we change ->filter chain, it changes ->mode before set(TIF_SECCOMP)
>>>>>>> just it lacks a barrier.
>>>>>>
>>>>>> Right, I think the best solution is to add the barrier. I was
>>>>>> concerned that adding the read barrier in secure_computing would have
>>>>>> a performance impact, though.
>>>>>>
>>>>>
>>>>> I can't speak for ARM, but I think that all of the read barriers are
>>>>> essentially free on x86.  (smp_mb is a very different story, but that
>>>>> shouldn't be needed here.)
>>>>
>>>> It looks like SMP ARM issues dsb for rmb, which seems a bit expensive.
>>>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204g/CIHJFGFE.html
>>>>
>>>> If I skip the rmb in the secure_computing call before checking mode,
>>>> it sounds like I run the risk of racing an out-of-order TIF_SECCOMP vs
>>>> mode and filter. This seems unlikely to me, given an addition of the
>>>> smp_mb__before_atomic() during the seccomp_assign_mode()? I guess I
>>>> don't have a sense of how aggressively ARM might do data caching in
>>>> this area. Could the other thread actually see TIF_SECCOMP get set but
>>>> still have an out of date copy of seccomp.mode?
>>>>
>>>> I really want to avoid adding anything to the secure_computing()
>>>> execution path. :(
>>>
>>> Hence my suggestion to make the ordering not matter.  No ordering
>>> requirement, no barriers.
>>
>> I may be misunderstanding something, but I think there's still an
>> ordering problem. We'll have TIF_SECCOMP already, so if we enter
>> secure_computing with a NULL filter, we'll kill the process.
>>
>> Merging .mode and .filter would remove one of the race failure paths:
>> having TIF_SECCOMP and not having a mode set (leading to BUG). With
>> the merge, we could still race and land in the same place as have
>> TIF_SECCOMP and mode==2, but filter==NULL, leading to WARN and kill.
>
> You could just make secure_computing do nothing if filter == NULL.
> It's probably faster to test that than TIF_SECCOMP anyway, since you
> need to read the filter cacheline regardless, and testing a regular
> variable for non-NULLness might be faster than an atomic bit test
> operation.  (Or may not -- I don't know.)

I am uncomfortable about making filter == NULL be a "fail open"
condition if TIF_SECCOMP is set.

>> I guess the question is how large is the race risk on ARM? Is it
>> possible to have TIF_SECCOMP that far out of sync for the thread?
>
> Dunno.  I don't like leaving crashy known races around.

Yeah, me too. Hrmpf. I will do some rmb() timing tests...

-Kees

-- 
Kees Cook
Chrome OS Security
