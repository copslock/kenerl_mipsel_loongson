Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 23:56:54 +0200 (CEST)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:57840 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861357AbaGPV4sW27mU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 23:56:48 +0200
Received: by mail-ig0-f181.google.com with SMTP id h3so1626571igd.8
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wSd9Zj9xHMBFkl5plb7FzsDgkpfJBADCq+Dhv56TlWA=;
        b=Zgr/hkkWuT6ZggWI3t6147VCdRV1G9Rtop4KBxhJCqPtXZ2D4uMc40C3xH2SBelS4I
         zPERWdN3ZSl3hdWKi2DSWS7orkDh2K/8n3xy7HAQ+e+Bjx1yaSU397FbDFUilmMS3Qh1
         Keswdy0F2UT/4bTC02o/dCBRXkMW0Yrh8iwpUTzyopVcRVGwi/2TKJ7sL6fBlOr6zsBQ
         sWvH+3uPYK+GLy7b2ATvtZnaJkZUarHHo2bn4YbCyEa9r6G0zYGJg/2uSgryNlUVpT9P
         lEcYiOgNlxNA6uDfgL9C1wi8dlzQadOxRyOhsluMXCRkpb16EO8Sl55OZ54qM3+OgVYb
         B3Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wSd9Zj9xHMBFkl5plb7FzsDgkpfJBADCq+Dhv56TlWA=;
        b=l85dVX6w5Ye8jCRS1qXFRFoqLEwpEBtD/xkwQ2QC9fp53f3UxD+CWXuawf7nuw5wUf
         Mnc5YFp8ENTcGJ4HVPF6f0NszSt/9D8zF//ic32vmxRPBAUlo616ePX44F7mPxWr5Yzl
         fSHU3y7lG+tM+BndCs7ev6Nq0grCzX5SSshsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wSd9Zj9xHMBFkl5plb7FzsDgkpfJBADCq+Dhv56TlWA=;
        b=doV5uu/EX57nBz0EsnF4q/jnr+Kq4sjw5v/S/9+RUJYAsKxWSk9NnpX5Iicm5SFF/I
         0oR/Uz9Ko0Rc913XILPqGWLSlcrmEFOLeUOhbtYB+QgnfZElansdUqqr9NNzisiFyz9G
         sA5+Vu+UZ4P2Xm5Tyt9B0mxdEfuHjj3V1UJbTBthzj8KKZBpS2ss0k69/JPomNidfPFr
         r0ZoLwN/Ru4BPXRzDJrSPRQlL28/laVaf/pbS8zNsb06WQ2ibVmCT5bS8hNi4P3w3HAm
         WsgUH4KrSxR5iQqwzy2kFJcQo2j2O+oeABjh5zxpZ8sDeh/vWQWgZrV1tBDKKAnPix0A
         kgfA==
X-Gm-Message-State: ALoCoQmZpdXJyNSdcnAiMUxVWHFBLt21gaSdnW5aFara7VtxbyvJfhWPlX/0Qk1RkJupbA6TjU4+
MIME-Version: 1.0
X-Received: by 10.60.52.5 with SMTP id p5mr25102326oeo.55.1405547802146; Wed,
 16 Jul 2014 14:56:42 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 16 Jul 2014 14:56:42 -0700 (PDT)
In-Reply-To: <CALCETrW7UEBTprnJdca0X1Vd-bstyQi1LK9GbfUzdr8FFWze9w@mail.gmail.com>
References: <cover.1405452484.git.luto@amacapital.net>
        <4f153feea35430104d6d1a7c83805fccbffdf089.1405452484.git.luto@amacapital.net>
        <CAGXu5jK0v=dtPNY4Y2m7D01peeNoBSDq8zowgLu_rjZe41=eUg@mail.gmail.com>
        <CALCETrW7UEBTprnJdca0X1Vd-bstyQi1LK9GbfUzdr8FFWze9w@mail.gmail.com>
Date:   Wed, 16 Jul 2014 14:56:42 -0700
X-Google-Sender-Auth: U47S4gL7BuqyFBaGyK2EyxVbatg
Message-ID: <CAGXu5j+1C7HnVz7WW3si_rpOw2OBMz1KQB1a9ynrncgUH_1RfQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] seccomp: Refactor the filter callback and the API
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41253
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

On Wed, Jul 16, 2014 at 1:56 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Jul 16, 2014 at 1:12 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> The reason I did this is to add a seccomp API that will be usable
>>> for an x86 fast path.  The x86 entry code needs to use a rather
>>> expensive slow path for a syscall that might be visible to things
>>> like ptrace.  By splitting seccomp into two phases, we can check
>>> whether we need the slow path and then use the fast path in if the
>>> filter allows the syscall or just returns some errno.
>>>
>>> As a side effect, I think the new code is much easier to understand
>>> than the old code.
>>
>> I'd agree. The #idefs got a little weirder, but the actual code flow
>> was much easier to read. I wonder if "phase1" and "phase2" should be
>> renamed "pretrace" and "tracing" or something more meaningful? Or
>> "fast" and "slow"?
>
> Queue the bikeshedding :)
>
> I like "phase1" and "phase2" because it makes it clear that phase1 has
> to come first.  But I'd be amenable to counterarguments.

That works. I didn't have a strong feeling about it. I was just
wondering if there was a good way to self-document that phase1 is on
the fast path, and phase2 was on the slow path for tracing. The
existing comments really should be sufficient, though.

You mentioned architectures providing "sd" directly. I wonder if that
new optional ability should be mentioned in the Kconfig help text that
defines what's needed for an arch to support SECCOMP_FILTER?

-Kees

-- 
Kees Cook
Chrome OS Security
