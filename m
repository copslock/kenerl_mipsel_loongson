Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 22:56:56 +0200 (CEST)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:54715 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861327AbaGPU4rY-lgg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 22:56:47 +0200
Received: by mail-lb0-f179.google.com with SMTP id v6so1051541lbi.38
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 13:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3oZkN3cRoyvRrisAQG+36csvzrCEpeliX0ysWhntP58=;
        b=A7UsGLtQHHNyLuHRAXpnlcQWI3U+TUOw8sYscFbYKNIkMKfMvinVBTGNMgw+OGsu1O
         YxSVTg4szUTFQc05XB5H+vtaj76QbXNGuROSK3I1zz6UjrmOPFnUFvDLfeKxLJ+TB6ub
         +lhFKMbjz+g2lniNJUx/pyKXis/323h/5rc/8f3FdEI0De0/8NRM+rWPyyhlzrdgy/gT
         nqEFE0wJnUlmSN8fi8GUiANzyyYrwchO0t/grNyS4gYP0Mq6AevMCwpGL+0ZdiH6twgx
         mer9ghEOZBX7nvXim5eXx/ZwnFz+/zb+NGU1K7OS4JjDXB7BmRqfB4zws2nyJWK5+goc
         W1Bg==
X-Gm-Message-State: ALoCoQlF2jH/SIUs35N/J+RQLFp/ROn/mI9j1wD03ForlLigvzAhquWB17IbvjwDYQ2SUj6o5E2b
X-Received: by 10.112.34.170 with SMTP id a10mr26307342lbj.11.1405544200547;
 Wed, 16 Jul 2014 13:56:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Wed, 16 Jul 2014 13:56:20 -0700 (PDT)
In-Reply-To: <CAGXu5jK0v=dtPNY4Y2m7D01peeNoBSDq8zowgLu_rjZe41=eUg@mail.gmail.com>
References: <cover.1405452484.git.luto@amacapital.net> <4f153feea35430104d6d1a7c83805fccbffdf089.1405452484.git.luto@amacapital.net>
 <CAGXu5jK0v=dtPNY4Y2m7D01peeNoBSDq8zowgLu_rjZe41=eUg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 16 Jul 2014 13:56:20 -0700
Message-ID: <CALCETrW7UEBTprnJdca0X1Vd-bstyQi1LK9GbfUzdr8FFWze9w@mail.gmail.com>
Subject: Re: [PATCH 2/7] seccomp: Refactor the filter callback and the API
To:     Kees Cook <keescook@chromium.org>
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
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41236
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

On Wed, Jul 16, 2014 at 1:12 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> The reason I did this is to add a seccomp API that will be usable
>> for an x86 fast path.  The x86 entry code needs to use a rather
>> expensive slow path for a syscall that might be visible to things
>> like ptrace.  By splitting seccomp into two phases, we can check
>> whether we need the slow path and then use the fast path in if the
>> filter allows the syscall or just returns some errno.
>>
>> As a side effect, I think the new code is much easier to understand
>> than the old code.
>
> I'd agree. The #idefs got a little weirder, but the actual code flow
> was much easier to read. I wonder if "phase1" and "phase2" should be
> renamed "pretrace" and "tracing" or something more meaningful? Or
> "fast" and "slow"?

Queue the bikeshedding :)

I like "phase1" and "phase2" because it makes it clear that phase1 has
to come first.  But I'd be amenable to counterarguments.

>
>> This has one user-visible effect: the audit record written for
>> SECCOMP_RET_TRACE is now a simple indication that SECCOMP_RET_TRACE
>> happened.  It used to depend in a complicated way on what the tracer
>> did.  I couldn't make much sense of it.
>
> I think this change is okay. The only way to get the audit record to
> report SIGSYS before was to have an additional signal come in and kill
> it while the tracer was working on it. Which is confusing too. I like
> this way better.

Thanks :)

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
