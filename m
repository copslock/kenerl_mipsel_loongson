Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 20:57:02 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:52988 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860046AbaF0S46OhRJ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2014 20:56:58 +0200
Received: by mail-la0-f41.google.com with SMTP id hz20so3278900lab.14
        for <linux-mips@linux-mips.org>; Fri, 27 Jun 2014 11:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ljAlMhIfQymDVQ+8/yxSjpfk64CdD0Szdy9+hjVjXvo=;
        b=cSmiKttVukik3hkF9hCb65GYaFm24BivEh3UMfx6O3ftAopa/l7TOqriH3cPR7GYNE
         QK5GUCYSaMNj6R2zGqod2ahZJw26vOBeUDOT/ejgNjLVSwHO6vNXy1P3pcGU9uYLLDP6
         cpaVwZ5l81RwNK4eTF4aameH52ABKi/44A+Hg//AvI11sMIpkyZpONILZNX7oiE3qDlw
         haBqJBRSKFM1OSckrBEy9rc96s6Oc2Aj21orh2tDGLYn6YVUxeWb+4itRKIFKTATXMsF
         ii5zSyNgS+rwEN99jvdBp3naozQbT2YYRZIH4IYDs/JMfXmkQrPtZZxWtJekjvjvBGoK
         Z9XA==
X-Gm-Message-State: ALoCoQkTPdKM9oP5lQSmwxAJu04AtA8n+3jaK9dLXKLIdyUjLUeH6CCZVB4upPsyptimRhLQzIRh
X-Received: by 10.152.19.164 with SMTP id g4mr17335803lae.47.1403895412479;
 Fri, 27 Jun 2014 11:56:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Fri, 27 Jun 2014 11:56:32 -0700 (PDT)
In-Reply-To: <CAGXu5j+wPvAuo6pVc_XoJqv7CvW6yDf3YE6P7tFwtO9hfcUUsg@mail.gmail.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-6-git-send-email-keescook@chromium.org> <20140625135121.GB7892@redhat.com>
 <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
 <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
 <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
 <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
 <20140625173245.GA17695@redhat.com> <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
 <20140625175136.GA18185@redhat.com> <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
 <CALCETrVNwhWSPNiBiZmgP1nD9zLJPTk6cH0yo=85rbxTPTYFRg@mail.gmail.com>
 <CAGXu5jLavA8FJD8m-1y4wO0uzh3qvvMmajAg0Lrr1Cn_Om3a3w@mail.gmail.com>
 <CALCETrUPxTxseJ=sOhD9CyJPtOqCR5sL8yx7KezLmLZcFSFNMA@mail.gmail.com> <CAGXu5j+wPvAuo6pVc_XoJqv7CvW6yDf3YE6P7tFwtO9hfcUUsg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 27 Jun 2014 11:56:32 -0700
Message-ID: <CALCETrWr+5n_w+q-fNc0G55eUteN57sm+7-bPCXKb7acmLu0Cg@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
To:     Kees Cook <keescook@chromium.org>
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
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40874
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

On Fri, Jun 27, 2014 at 11:52 AM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jun 27, 2014 at 11:39 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Fri, Jun 27, 2014 at 11:33 AM, Kees Cook <keescook@chromium.org> wrote:
>>> On Wed, Jun 25, 2014 at 11:07 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>> On Wed, Jun 25, 2014 at 11:00 AM, Kees Cook <keescook@chromium.org> wrote:
>>>>> On Wed, Jun 25, 2014 at 10:51 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>>>> On 06/25, Andy Lutomirski wrote:
>>>>>>>
>>>>>>> On Wed, Jun 25, 2014 at 10:32 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>>>>> > On 06/25, Andy Lutomirski wrote:
>>>>>>> >>
>>>>>>> >> Write the filter, then smp_mb (or maybe a weaker barrier is okay),
>>>>>>> >> then set the bit.
>>>>>>> >
>>>>>>> > Yes, exactly, this is what I meant. Plas rmb() in __secure_computing().
>>>>>>> >
>>>>>>> > But I still can't understand the rest of your discussion about the
>>>>>>> > ordering we need ;)
>>>>>>>
>>>>>>> Let me try again from scratch.
>>>>>>>
>>>>>>> Currently there are three relevant variables: TIF_SECCOMP,
>>>>>>> seccomp.mode, and seccomp.filter.  __secure_computing needs
>>>>>>> seccomp.mode and seccomp.filter to be in sync, and it wants (but
>>>>>>> doesn't really need) TIF_SECCOMP to be in sync as well.
>>>>>>>
>>>>>>> My suggestion is to rearrange it a bit.  Move mode into seccomp.filter
>>>>>>> (so that filter == NULL implies no seccomp) and don't check
>>>>>
>>>>> This would require that we reimplement mode 1 seccomp via mode 2
>>>>> filters. Which isn't too hard, but may add complexity.
>>>>>
>>>>>>> TIF_SECCOMP in secure_computing.  Then turning on seccomp is entirely
>>>>>>> atomic except for the fact that the seccomp hooks won't be called if
>>>>>>> filter != NULL but !TIF_SECCOMP.  This removes all ordering
>>>>>>> requirements.
>>>>>>
>>>>>> Ah, got it, thanks. Perhaps I missed somehing, but to me this looks like
>>>>>> unnecessary complication at first glance.
>>>>>>
>>>>>> We alredy have TIF_SECCOMP, we need it anyway, and we should only care
>>>>>> about the case when this bit is actually set, so that we can race with
>>>>>> the 1st call of __secure_computing().
>>>>>>
>>>>>> Otherwise we are fine: we can miss the new filter anyway, ->mode can't
>>>>>> be changed it is already nonzero.
>>>>>>
>>>>>>> Alternatively, __secure_computing could still BUG_ON(!seccomp.filter).
>>>>>>> In that case, filter needs to be set before TIF_SECCOMP is set, but
>>>>>>> that's straightforward.
>>>>>>
>>>>>> Yep. And this is how seccomp_assign_mode() already works? It is called
>>>>>> after we change ->filter chain, it changes ->mode before set(TIF_SECCOMP)
>>>>>> just it lacks a barrier.
>>>>>
>>>>> Right, I think the best solution is to add the barrier. I was
>>>>> concerned that adding the read barrier in secure_computing would have
>>>>> a performance impact, though.
>>>>>
>>>>
>>>> I can't speak for ARM, but I think that all of the read barriers are
>>>> essentially free on x86.  (smp_mb is a very different story, but that
>>>> shouldn't be needed here.)
>>>
>>> It looks like SMP ARM issues dsb for rmb, which seems a bit expensive.
>>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204g/CIHJFGFE.html
>>>
>>> If I skip the rmb in the secure_computing call before checking mode,
>>> it sounds like I run the risk of racing an out-of-order TIF_SECCOMP vs
>>> mode and filter. This seems unlikely to me, given an addition of the
>>> smp_mb__before_atomic() during the seccomp_assign_mode()? I guess I
>>> don't have a sense of how aggressively ARM might do data caching in
>>> this area. Could the other thread actually see TIF_SECCOMP get set but
>>> still have an out of date copy of seccomp.mode?
>>>
>>> I really want to avoid adding anything to the secure_computing()
>>> execution path. :(
>>
>> Hence my suggestion to make the ordering not matter.  No ordering
>> requirement, no barriers.
>
> I may be misunderstanding something, but I think there's still an
> ordering problem. We'll have TIF_SECCOMP already, so if we enter
> secure_computing with a NULL filter, we'll kill the process.
>
> Merging .mode and .filter would remove one of the race failure paths:
> having TIF_SECCOMP and not having a mode set (leading to BUG). With
> the merge, we could still race and land in the same place as have
> TIF_SECCOMP and mode==2, but filter==NULL, leading to WARN and kill.

You could just make secure_computing do nothing if filter == NULL.
It's probably faster to test that than TIF_SECCOMP anyway, since you
need to read the filter cacheline regardless, and testing a regular
variable for non-NULLness might be faster than an atomic bit test
operation.  (Or may not -- I don't know.)

>
> I guess the question is how large is the race risk on ARM? Is it
> possible to have TIF_SECCOMP that far out of sync for the thread?

Dunno.  I don't like leaving crashy known races around.

--Andy



>
> -Kees
>
> --
> Kees Cook
> Chrome OS Security



-- 
Andy Lutomirski
AMA Capital Management, LLC
