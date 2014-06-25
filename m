Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 20:08:31 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:53729 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859805AbaFYSIRHMzTG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 20:08:17 +0200
Received: by mail-lb0-f177.google.com with SMTP id u10so2095040lbd.22
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 11:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=UBU7C4aIdHE6S2meDCeETnjJQLczo6YLoFKf6bB/WAY=;
        b=QahELrws3F5qI67Mh7prWfkHAzmxoRvVxEqwesLdwnNR1NQR+mVZr1+E78kkHHZZ9h
         OikjyB4BkU4NcvBWnlZrinXXoiTVm1SZhtJ4WaLaHY73K8iW+uk1fh+H+VfcGBfRp6re
         OkgDxhp5sNHdx6dDy0fL7pNC8fmPqjzlgGtYWaOlPp5Oj7gkDNFXBN64LCDizMADGuTx
         Er0SO65R0iapBPb4G7LptN47a4mA8UQFlN6JnCTy2kx1mV4SPn0tlgkZVKKE2H51myvZ
         LxDmYslVhORLhdTTjMz4iC37Wmor6KevT5RpJbL6R13kKycl1/BZzG6Tdo75man75xtJ
         mqjA==
X-Gm-Message-State: ALoCoQmGWZLi8z9plx96WFsrogGgcOfOR2RXhPdflMQte4RDDpPnAccbJ28ZGNbZmE64RVv5ZARg
X-Received: by 10.112.34.170 with SMTP id a10mr6571785lbj.11.1403719691548;
 Wed, 25 Jun 2014 11:08:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Wed, 25 Jun 2014 11:07:51 -0700 (PDT)
In-Reply-To: <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-6-git-send-email-keescook@chromium.org> <20140625135121.GB7892@redhat.com>
 <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
 <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
 <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
 <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
 <20140625173245.GA17695@redhat.com> <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
 <20140625175136.GA18185@redhat.com> <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 25 Jun 2014 11:07:51 -0700
Message-ID: <CALCETrVNwhWSPNiBiZmgP1nD9zLJPTk6cH0yo=85rbxTPTYFRg@mail.gmail.com>
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
X-archive-position: 40829
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

On Wed, Jun 25, 2014 at 11:00 AM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jun 25, 2014 at 10:51 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> On 06/25, Andy Lutomirski wrote:
>>>
>>> On Wed, Jun 25, 2014 at 10:32 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> > On 06/25, Andy Lutomirski wrote:
>>> >>
>>> >> Write the filter, then smp_mb (or maybe a weaker barrier is okay),
>>> >> then set the bit.
>>> >
>>> > Yes, exactly, this is what I meant. Plas rmb() in __secure_computing().
>>> >
>>> > But I still can't understand the rest of your discussion about the
>>> > ordering we need ;)
>>>
>>> Let me try again from scratch.
>>>
>>> Currently there are three relevant variables: TIF_SECCOMP,
>>> seccomp.mode, and seccomp.filter.  __secure_computing needs
>>> seccomp.mode and seccomp.filter to be in sync, and it wants (but
>>> doesn't really need) TIF_SECCOMP to be in sync as well.
>>>
>>> My suggestion is to rearrange it a bit.  Move mode into seccomp.filter
>>> (so that filter == NULL implies no seccomp) and don't check
>
> This would require that we reimplement mode 1 seccomp via mode 2
> filters. Which isn't too hard, but may add complexity.
>
>>> TIF_SECCOMP in secure_computing.  Then turning on seccomp is entirely
>>> atomic except for the fact that the seccomp hooks won't be called if
>>> filter != NULL but !TIF_SECCOMP.  This removes all ordering
>>> requirements.
>>
>> Ah, got it, thanks. Perhaps I missed somehing, but to me this looks like
>> unnecessary complication at first glance.
>>
>> We alredy have TIF_SECCOMP, we need it anyway, and we should only care
>> about the case when this bit is actually set, so that we can race with
>> the 1st call of __secure_computing().
>>
>> Otherwise we are fine: we can miss the new filter anyway, ->mode can't
>> be changed it is already nonzero.
>>
>>> Alternatively, __secure_computing could still BUG_ON(!seccomp.filter).
>>> In that case, filter needs to be set before TIF_SECCOMP is set, but
>>> that's straightforward.
>>
>> Yep. And this is how seccomp_assign_mode() already works? It is called
>> after we change ->filter chain, it changes ->mode before set(TIF_SECCOMP)
>> just it lacks a barrier.
>
> Right, I think the best solution is to add the barrier. I was
> concerned that adding the read barrier in secure_computing would have
> a performance impact, though.
>

I can't speak for ARM, but I think that all of the read barriers are
essentially free on x86.  (smp_mb is a very different story, but that
shouldn't be needed here.)

--Andy
