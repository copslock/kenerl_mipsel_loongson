Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 23:17:33 +0200 (CEST)
Received: from mail-la0-f50.google.com ([209.85.215.50]:36892 "EHLO
        mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861309AbaGPVRbh68OB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 23:17:31 +0200
Received: by mail-la0-f50.google.com with SMTP id gf5so975033lab.9
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 14:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=x0FSzUHqy2SlvJS+kOHywPx+B+Dt/Ygvzd1mAckkMac=;
        b=QksbdEv3yl8MsPSqIN2cCt9zctDTuukkGSGyz1oAoChO9ssy5o7tjet1DQXepJAkSv
         L0Cv+fwqcvNk6jbP+GcAPARa9VcJw9b9fg2qPQZg0bWncxk2dMj8VEOYXGJA2OJiv6z8
         23HxtJhjig5TKv+g93SMvQQ87pwEQZt82Emn4AZ1n9l2niwHmSvpfbg1JQuNkbHPxN6w
         RkPqu1VYVtmsR5gqTPOkIBE/9nLAsFX3lJBb6lgTHhzm2r7hfhd+U4QOXOZg+fh4IPr1
         XI3hzNQSltAnzMGO5ouMCCjVuv33W0JIukpxaYwtkkUKGrN0nKlXNxEtAZX83Y8Ri9RZ
         PWrA==
X-Gm-Message-State: ALoCoQm1NOa3K9AqPbgnCk/ZtJmKo1Z6BqalMKRJ9XTDkD6SsXoJwVTO7Z8A/j0UfA02PPLXe7F/
X-Received: by 10.112.150.106 with SMTP id uh10mr61582lbb.11.1405545445741;
 Wed, 16 Jul 2014 14:17:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Wed, 16 Jul 2014 14:17:05 -0700 (PDT)
In-Reply-To: <CAGXu5jJx8Wk-pZvhJY4xA=oywCZDLH3CLiLZ0wrBVqEqSaYT4A@mail.gmail.com>
References: <cover.1405452484.git.luto@amacapital.net> <CAGXu5jJx8Wk-pZvhJY4xA=oywCZDLH3CLiLZ0wrBVqEqSaYT4A@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 16 Jul 2014 14:17:05 -0700
Message-ID: <CALCETrVVJ-FRFFDs685zjHvqQCeaBYY49QZbj4rAe+Q7yEF10Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] Two-phase seccomp and x86 tracing changes
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
X-archive-position: 41238
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

On Wed, Jul 16, 2014 at 1:41 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> This is both a cleanup and a speedup.  It reduces overhead due to
>> installing a trivial seccomp filter by 87%.  The speedup comes from
>> avoiding the full syscall tracing mechanism for filters that don't
>> return SECCOMP_RET_TRACE.
>>
>> This series works by splitting the seccomp hooks into two phases.
>> The first phase evaluates the filter; it can skip syscalls, allow
>> them, kill the calling task, or pass a u32 to the second phase.  The
>> second phase requires a full tracing context, and it sends ptrace
>> events if necessary.
>>
>> Once this is done, I implemented a similar split for the x86 syscall
>> entry work.  The C callback is invoked in two phases: the first has
>> only a partial frame, and it can request phase 2 processing with a
>> full frame.
>>
>> Finally, I switch the 64-bit system_call code to use the new split
>> entry work.  This is a net deletion of assembly code: it replaces
>> all of the audit entry muck.
>>
>> In the process, I fixed some bugs.
>>
>> If this is acceptable, someone can do the same tweak for the
>> ia32entry and entry_32 code.
>>
>> This passes all seccomp tests that I know of, except for the ones
>> that don't work on current kernels.
>
> After fighting a bit with merging this with the tsync series, I can
> confirm this all behaves nicely on x86_64 and ARM.
>

I'll hold off on v3 until your stuff lands.

--Andy

> -Kees
>
> --
> Kees Cook
> Chrome OS Security



-- 
Andy Lutomirski
AMA Capital Management, LLC
