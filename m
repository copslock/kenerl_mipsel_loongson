Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 22:12:42 +0200 (CEST)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:58463 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861312AbaGPUMjPECll (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 22:12:39 +0200
Received: by mail-ie0-f176.google.com with SMTP id tr6so1402473ieb.21
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aZpk+Ojm/NfZP5r9pz8kw4pY/bG08fmb4LSVaCkLViA=;
        b=KcAM52XNEb0wRU5KPAXRk2sepJYTky/262Ufs5py0yO4YLZQK/MNDrZpiWgku5TuS/
         DoKg6BDWhsOjeE4jt8diadVEZAbjj5C6Gq7PKboRYRTdXuDR9zYuMf7nGmtF1ukUiZRZ
         G64+EkTM60ZLEXVkItiVm8IsvflUgOyatv/UcP5JEsM3lXD8edWntdzUuWYGpFWbv+bb
         k+U8YclQwNR9MiBjT5SsPXouCTSn+eHXFd+YJmo5JDizUuJX6czIO9XUCInTLlysjHL7
         BXu5Q5rmW9c1h173yRq4+wX5ESQ6hRKHikisE8wvXJQUGczCbPzrbQKn8h9rEYY4c/Dn
         42wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aZpk+Ojm/NfZP5r9pz8kw4pY/bG08fmb4LSVaCkLViA=;
        b=EoTogsFhnz7Kxv+qTvAoO/j+UDdmo+bWpfGa4xctl561uSf8v75o0UZYPEHj8H3l7h
         5S5nKtB9hInF2iWOsCW6Z2xe93tyg5mB4C+2gSRLwTMfOo/i/d6LRuCO11tV8BBdt8qx
         i15cRZmTmWi4PseyNxTvWdh+TSVPqYiEIasfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aZpk+Ojm/NfZP5r9pz8kw4pY/bG08fmb4LSVaCkLViA=;
        b=BQ5D8rP7uHQwIJ78iheIZgd0cuXbCtSp9XtgDr8QxC++ARmulUbwy8Fv/2SFUXy0bG
         pgiEK7RheUrhzpoTcULhgboam2fGvevWkaDA7Rrt7pFVnrHlN25SvfCrSM9LstTgmrla
         L88mfZ0Riicz499SCf7hUUh7LbDjmbgBImM0j5qCJHpoX4hHkeYMylWTaDHU4Tjtjejf
         GdXpT7QeBVTKAMkthdmmY4gLVwhk8lK0syPQ0NzTOw39kVJAzWWoqW3qCa0rw56w3bWe
         A9KEasnzlJZWzz21tkRaFUBRK11lxSECbq3oURulKDjgBwglqPFCAiWkIm9241R1xfod
         Eenw==
X-Gm-Message-State: ALoCoQlojIwtdqmYhQfouD+oLppg2aYFPFyny/J+duy6UEjp3X09L6c6nYe9mKSFmw6zyepghcHw
MIME-Version: 1.0
X-Received: by 10.60.80.229 with SMTP id u5mr38943958oex.62.1405541552982;
 Wed, 16 Jul 2014 13:12:32 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 16 Jul 2014 13:12:32 -0700 (PDT)
In-Reply-To: <4f153feea35430104d6d1a7c83805fccbffdf089.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
        <4f153feea35430104d6d1a7c83805fccbffdf089.1405452484.git.luto@amacapital.net>
Date:   Wed, 16 Jul 2014 13:12:32 -0700
X-Google-Sender-Auth: Aq3U3qzSYSqXVB6-nq_Til3cAX0
Message-ID: <CAGXu5jK0v=dtPNY4Y2m7D01peeNoBSDq8zowgLu_rjZe41=eUg@mail.gmail.com>
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
X-archive-position: 41232
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

On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> The reason I did this is to add a seccomp API that will be usable
> for an x86 fast path.  The x86 entry code needs to use a rather
> expensive slow path for a syscall that might be visible to things
> like ptrace.  By splitting seccomp into two phases, we can check
> whether we need the slow path and then use the fast path in if the
> filter allows the syscall or just returns some errno.
>
> As a side effect, I think the new code is much easier to understand
> than the old code.

I'd agree. The #idefs got a little weirder, but the actual code flow
was much easier to read. I wonder if "phase1" and "phase2" should be
renamed "pretrace" and "tracing" or something more meaningful? Or
"fast" and "slow"?

> This has one user-visible effect: the audit record written for
> SECCOMP_RET_TRACE is now a simple indication that SECCOMP_RET_TRACE
> happened.  It used to depend in a complicated way on what the tracer
> did.  I couldn't make much sense of it.

I think this change is okay. The only way to get the audit record to
report SIGSYS before was to have an additional signal come in and kill
it while the tracer was working on it. Which is confusing too. I like
this way better.

-Kees

-- 
Kees Cook
Chrome OS Security
