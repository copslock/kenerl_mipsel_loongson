Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 00:06:38 +0200 (CEST)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:45283 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861360AbaGPWGdKiqM9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 00:06:33 +0200
Received: by mail-lb0-f178.google.com with SMTP id c11so235654lbj.23
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 15:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=v45fhVatImJwmfpdF/DtWQRhUFXARELcqJN97J5pN7U=;
        b=JFon2jjnzOHAk8ZLo5keB9RcD8ssRPj0jRjoBXnk1dY6L0//L3IesyW7HbpJHrN/rs
         KHs+wl8cQ/qDACWDP3UcCFNpH9GTgX/aIKzKNXLOHU64yo3gHEwAAT4a7RkgLDFfLjQ9
         2DlTutoZsFVyq7C1q+Lmx95KC/ENSDcmxVlsjL7Yvn/zqkB3mKShlZU3om/FiDR6U7y+
         +Yz7sSSmhaB/2cfGZF/jFrbXuQ1748EGHE5aXlrH1Ys3OECDRR2qbJYU6WEqEhWk652N
         C8EyA22VfkNJce5F+VUBYp9faDUDLo1sSntUNLU4hQFN//OPFBPMITrNL1wZqpIKYl1o
         eVlA==
X-Gm-Message-State: ALoCoQnbN+PgHcfb+ICVGHdmBBZHQHY3NS1Cpzh6JiNLn3aCPZ9AURhqbBiRX1dCMcWk3X1OJsVe
X-Received: by 10.112.4.228 with SMTP id n4mr13768755lbn.46.1405548387492;
 Wed, 16 Jul 2014 15:06:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Wed, 16 Jul 2014 15:06:07 -0700 (PDT)
In-Reply-To: <CAGXu5j+1C7HnVz7WW3si_rpOw2OBMz1KQB1a9ynrncgUH_1RfQ@mail.gmail.com>
References: <cover.1405452484.git.luto@amacapital.net> <4f153feea35430104d6d1a7c83805fccbffdf089.1405452484.git.luto@amacapital.net>
 <CAGXu5jK0v=dtPNY4Y2m7D01peeNoBSDq8zowgLu_rjZe41=eUg@mail.gmail.com>
 <CALCETrW7UEBTprnJdca0X1Vd-bstyQi1LK9GbfUzdr8FFWze9w@mail.gmail.com> <CAGXu5j+1C7HnVz7WW3si_rpOw2OBMz1KQB1a9ynrncgUH_1RfQ@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 16 Jul 2014 15:06:07 -0700
Message-ID: <CALCETrW_ZsOGTNj--vjnkryzRA=QRrDs21TXr_bHqZb8ntFLeg@mail.gmail.com>
Subject: Re: [PATCH 2/7] seccomp: Refactor the filter callback and the API
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41255
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

On Wed, Jul 16, 2014 at 2:56 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jul 16, 2014 at 1:56 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Wed, Jul 16, 2014 at 1:12 PM, Kees Cook <keescook@chromium.org> wrote:
>>> On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>> The reason I did this is to add a seccomp API that will be usable
>>>> for an x86 fast path.  The x86 entry code needs to use a rather
>>>> expensive slow path for a syscall that might be visible to things
>>>> like ptrace.  By splitting seccomp into two phases, we can check
>>>> whether we need the slow path and then use the fast path in if the
>>>> filter allows the syscall or just returns some errno.
>>>>
>>>> As a side effect, I think the new code is much easier to understand
>>>> than the old code.
>>>
>>> I'd agree. The #idefs got a little weirder, but the actual code flow
>>> was much easier to read. I wonder if "phase1" and "phase2" should be
>>> renamed "pretrace" and "tracing" or something more meaningful? Or
>>> "fast" and "slow"?
>>
>> Queue the bikeshedding :)
>>
>> I like "phase1" and "phase2" because it makes it clear that phase1 has
>> to come first.  But I'd be amenable to counterarguments.
>
> That works. I didn't have a strong feeling about it. I was just
> wondering if there was a good way to self-document that phase1 is on
> the fast path, and phase2 was on the slow path for tracing. The
> existing comments really should be sufficient, though.
>
> You mentioned architectures providing "sd" directly. I wonder if that
> new optional ability should be mentioned in the Kconfig help text that
> defines what's needed for an arch to support SECCOMP_FILTER?

Good call.  Queued for v2.

>
> -Kees
>
> --
> Kees Cook
> Chrome OS Security



-- 
Andy Lutomirski
AMA Capital Management, LLC
