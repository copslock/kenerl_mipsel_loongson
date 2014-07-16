Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 22:42:01 +0200 (CEST)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:58598 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861313AbaGPUl7EH4eg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 22:41:59 +0200
Received: by mail-ie0-f175.google.com with SMTP id x19so1464688ier.20
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uAOsU0ngntYpEwd4GHWMCDk8h6E67DeEfkehY6+gwGM=;
        b=gKo/6iM1TvcqSeTiboDV/vt9f9IaQxOqYzNeWUXMBYBYMjQraBfGyiiW4Bdo75R3R+
         U0zFyRC29nWkXA4eA6Wh2zUN1bjy9pg9cYnhP3ZfQYvhxjbIGv6h2HLrpk53l78k8Ou4
         TJcFx064S+zZc6Vy0KEEWkqXKoKbpUdbbGnjWn8TL5rMyRVl9fl04MwZGBhMUQCiwkgz
         pGkjNtaFku6fwha/wB3AvVnxkj3ibw4exVPewP3UzDFVSV6kjIiTvs9fGNlsIZTio7DK
         fXWVSizBexN6l7yyg7yDCu0XeT8X0jYyK39lK3qKYqEy1PIHsietyw9uXqrkrwj7keum
         VZTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uAOsU0ngntYpEwd4GHWMCDk8h6E67DeEfkehY6+gwGM=;
        b=HLtIREU8D1+9CVnSieLhQImiALmcZjB3TB98n+f7rGPwjtb/HGFghpEIy7YQE7upV3
         RbvQNXqn8pYyr1mZ04swB9SjkZLKU8TAj1g8MG/I0DP7NiLZAiNZ2Fc0i7nbH4v/25qj
         MCskyTgpA7i0nXw4nncLFBemZfZhWdLIorQm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uAOsU0ngntYpEwd4GHWMCDk8h6E67DeEfkehY6+gwGM=;
        b=Q8aN6WiUN0NHBknMbXV97rasprs/08CW5BItprbiIJm0j+/WZAwvCpxdbTuGNkQcg+
         XkoTRsTlUOqDwJySkDryt6ycaNz6+mPuQovEa56g8FcABvRINCUDYpYDCuOWd4CKOWys
         ImS9KgXP6O6zeXgVVZTA0LUpzS29oMDyQCTcwuGrJpBRIipha9ktqlT8kbmcFNq0DSHI
         tN01RDPqw+Hwm7z3VyqxxAkHGCFx4XMBRKfUSaix5lV+ihzuZcMm9V2ZkbgzLe2sRsIr
         lTy6WZ3Pw/aH4/ENte71MvOoiGHqMBBNq0kDLkVZQ3zvTPoQvHk4vBX/gYOzJSG92qF9
         TsuQ==
X-Gm-Message-State: ALoCoQlQTqniypB/CM4zFKl1XKZt8GQEcTszHxztRYZ6QalRUzf8zA/qte63Fpz3n422h02RQ4A6
MIME-Version: 1.0
X-Received: by 10.60.174.3 with SMTP id bo3mr38921839oec.31.1405543312849;
 Wed, 16 Jul 2014 13:41:52 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 16 Jul 2014 13:41:52 -0700 (PDT)
In-Reply-To: <cover.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
Date:   Wed, 16 Jul 2014 13:41:52 -0700
X-Google-Sender-Auth: YFMJZA4pOuGgGlJxPEbYlW3pQ_g
Message-ID: <CAGXu5jJx8Wk-pZvhJY4xA=oywCZDLH3CLiLZ0wrBVqEqSaYT4A@mail.gmail.com>
Subject: Re: [PATCH 0/7] Two-phase seccomp and x86 tracing changes
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
X-archive-position: 41234
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
> This is both a cleanup and a speedup.  It reduces overhead due to
> installing a trivial seccomp filter by 87%.  The speedup comes from
> avoiding the full syscall tracing mechanism for filters that don't
> return SECCOMP_RET_TRACE.
>
> This series works by splitting the seccomp hooks into two phases.
> The first phase evaluates the filter; it can skip syscalls, allow
> them, kill the calling task, or pass a u32 to the second phase.  The
> second phase requires a full tracing context, and it sends ptrace
> events if necessary.
>
> Once this is done, I implemented a similar split for the x86 syscall
> entry work.  The C callback is invoked in two phases: the first has
> only a partial frame, and it can request phase 2 processing with a
> full frame.
>
> Finally, I switch the 64-bit system_call code to use the new split
> entry work.  This is a net deletion of assembly code: it replaces
> all of the audit entry muck.
>
> In the process, I fixed some bugs.
>
> If this is acceptable, someone can do the same tweak for the
> ia32entry and entry_32 code.
>
> This passes all seccomp tests that I know of, except for the ones
> that don't work on current kernels.

After fighting a bit with merging this with the tsync series, I can
confirm this all behaves nicely on x86_64 and ARM.

-Kees

-- 
Kees Cook
Chrome OS Security
