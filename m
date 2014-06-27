Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 20:39:55 +0200 (CEST)
Received: from mail-lb0-f175.google.com ([209.85.217.175]:44699 "EHLO
        mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860046AbaF0SjvqVj0H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2014 20:39:51 +0200
Received: by mail-lb0-f175.google.com with SMTP id n15so4226141lbi.6
        for <linux-mips@linux-mips.org>; Fri, 27 Jun 2014 11:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=13P1VDlVcE9vLQIeB0adbdnzVuSrf1DiZZKLmXhiLDw=;
        b=YaP7djUkf/MQLszMYAHRMekBu2tixls/6QsmWg2W+bKoHYL90rzptrC0oYH/46mSxz
         TBud5H8iqmHFIFyRmcYIYqAhiRkD5RSnfqIT6OZTBm9cpGzYqwHcuDWsGLCKHmISnhru
         cMMVnxiQ8Wi5fKKYBoUfvinV+ywFcUesWDiXJg5YDLAMm7Eo2FxOZh8p/bHAn3nQbH4h
         faHTUEGEw70MwcDTxRuWRQuobajwQpGvszIg5hzmpa9dfHpHq56uGrDVHdWU1Z56Y/3A
         OuDg+13Cp2Ic3zvmzXFN5mYtf5w8mHTde0GpA4BUWWdz+sSwytjoxjVnuDu+esmS4ABW
         kdsQ==
X-Gm-Message-State: ALoCoQmHTeCGkpQ07uEIg1o/leOOlFwQLzXKms6eiN0QlEw3cFi0immWVGYB6NFUIgaJ5aPwYLY5
X-Received: by 10.112.41.195 with SMTP id h3mr7884lbl.103.1403894386065; Fri,
 27 Jun 2014 11:39:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Fri, 27 Jun 2014 11:39:25 -0700 (PDT)
In-Reply-To: <CAGXu5jLavA8FJD8m-1y4wO0uzh3qvvMmajAg0Lrr1Cn_Om3a3w@mail.gmail.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-6-git-send-email-keescook@chromium.org> <20140625135121.GB7892@redhat.com>
 <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
 <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
 <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
 <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
 <20140625173245.GA17695@redhat.com> <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
 <20140625175136.GA18185@redhat.com> <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
 <CALCETrVNwhWSPNiBiZmgP1nD9zLJPTk6cH0yo=85rbxTPTYFRg@mail.gmail.com> <CAGXu5jLavA8FJD8m-1y4wO0uzh3qvvMmajAg0Lrr1Cn_Om3a3w@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 27 Jun 2014 11:39:25 -0700
Message-ID: <CALCETrUPxTxseJ=sOhD9CyJPtOqCR5sL8yx7KezLmLZcFSFNMA@mail.gmail.com>
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
X-archive-position: 40871
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

On Fri, Jun 27, 2014 at 11:33 AM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jun 25, 2014 at 11:07 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Wed, Jun 25, 2014 at 11:00 AM, Kees Cook <keescook@chromium.org> wrote:
>>> On Wed, Jun 25, 2014 at 10:51 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>> On 06/25, Andy Lutomirski wrote:
>>>>>
>>>>> On Wed, Jun 25, 2014 at 10:32 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>>> > On 06/25, Andy Lutomirski wrote:
>>>>> >>
>>>>> >> Write the filter, then smp_mb (or maybe a weaker barrier is okay),
>>>>> >> then set the bit.
>>>>> >
>>>>> > Yes, exactly, this is what I meant. Plas rmb() in __secure_computing().
>>>>> >
>>>>> > But I still can't understand the rest of your discussion about the
>>>>> > ordering we need ;)
>>>>>
>>>>> Let me try again from scratch.
>>>>>
>>>>> Currently there are three relevant variables: TIF_SECCOMP,
>>>>> seccomp.mode, and seccomp.filter.  __secure_computing needs
>>>>> seccomp.mode and seccomp.filter to be in sync, and it wants (but
>>>>> doesn't really need) TIF_SECCOMP to be in sync as well.
>>>>>
>>>>> My suggestion is to rearrange it a bit.  Move mode into seccomp.filter
>>>>> (so that filter == NULL implies no seccomp) and don't check
>>>
>>> This would require that we reimplement mode 1 seccomp via mode 2
>>> filters. Which isn't too hard, but may add complexity.
>>>
>>>>> TIF_SECCOMP in secure_computing.  Then turning on seccomp is entirely
>>>>> atomic except for the fact that the seccomp hooks won't be called if
>>>>> filter != NULL but !TIF_SECCOMP.  This removes all ordering
>>>>> requirements.
>>>>
>>>> Ah, got it, thanks. Perhaps I missed somehing, but to me this looks like
>>>> unnecessary complication at first glance.
>>>>
>>>> We alredy have TIF_SECCOMP, we need it anyway, and we should only care
>>>> about the case when this bit is actually set, so that we can race with
>>>> the 1st call of __secure_computing().
>>>>
>>>> Otherwise we are fine: we can miss the new filter anyway, ->mode can't
>>>> be changed it is already nonzero.
>>>>
>>>>> Alternatively, __secure_computing could still BUG_ON(!seccomp.filter).
>>>>> In that case, filter needs to be set before TIF_SECCOMP is set, but
>>>>> that's straightforward.
>>>>
>>>> Yep. And this is how seccomp_assign_mode() already works? It is called
>>>> after we change ->filter chain, it changes ->mode before set(TIF_SECCOMP)
>>>> just it lacks a barrier.
>>>
>>> Right, I think the best solution is to add the barrier. I was
>>> concerned that adding the read barrier in secure_computing would have
>>> a performance impact, though.
>>>
>>
>> I can't speak for ARM, but I think that all of the read barriers are
>> essentially free on x86.  (smp_mb is a very different story, but that
>> shouldn't be needed here.)
>
> It looks like SMP ARM issues dsb for rmb, which seems a bit expensive.
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204g/CIHJFGFE.html
>
> If I skip the rmb in the secure_computing call before checking mode,
> it sounds like I run the risk of racing an out-of-order TIF_SECCOMP vs
> mode and filter. This seems unlikely to me, given an addition of the
> smp_mb__before_atomic() during the seccomp_assign_mode()? I guess I
> don't have a sense of how aggressively ARM might do data caching in
> this area. Could the other thread actually see TIF_SECCOMP get set but
> still have an out of date copy of seccomp.mode?
>
> I really want to avoid adding anything to the secure_computing()
> execution path. :(

Hence my suggestion to make the ordering not matter.  No ordering
requirement, no barriers.

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
