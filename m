Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 21:20:49 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:52318 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842513AbaGWTUowX-Yi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 21:20:44 +0200
Received: by mail-lb0-f171.google.com with SMTP id l4so1294789lbv.30
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 12:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=fbPctYpleL3aO6PcLm9fMoVEBZPAhJneizCfik1Vxoc=;
        b=ITdv7zyHbdaOsedMZ/VxG9+6izZ2nNHB+esQ/LONzMP4GgkTyZRAgP4dyZvfIZTwGF
         mpG/AGWCmSKpxjJWVRSZJdxTelo7fQPF9vgxLy3w/T9EfyVIogJsBDlApGRRf195PmQs
         NJIVxfhOW+ehUSRdTilUcr4yZDqrFTF1t7VJevRbL4o1+FKgYg1M6xCbcimdHXhAZtHE
         U/ppsGyyTAIFYDjA+haRczXr/E9PJLuf7HWGoUyw3Bg+XkaIUvtNIfACBKrwytiUJ5S/
         a46vuqkHUrAQ7KveUAn7eJ7r7rdo/oBremFhfHaKxhMhWS5bxKoAoB+8hxEi70YZGVng
         AZWw==
X-Gm-Message-State: ALoCoQk0avZzf8mBOAik6SqlvUcace2hFh/NkKeG1zJtnKbm/HgkA9ZZ3h9BYUHYcdsZJLP2QhE2
X-Received: by 10.152.29.200 with SMTP id m8mr4137710lah.4.1406143239029; Wed,
 23 Jul 2014 12:20:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Wed, 23 Jul 2014 12:20:18 -0700 (PDT)
In-Reply-To: <CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com>
References: <cover.1405992946.git.luto@amacapital.net> <CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 23 Jul 2014 12:20:18 -0700
Message-ID: <CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
To:     Kees Cook <keescook@chromium.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
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
X-archive-position: 41551
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

On Tue, Jul 22, 2014 at 12:37 PM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 21, 2014 at 6:49 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> [applies on jmorris's security-next tree]
>>
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
>> This passes all seccomp tests that I know of.  Now that it's properly
>> rebased, even the previously expected failures are gone.
>>
>> Kees, if you like this version, can you create a branch with patches
>> 1-4?  I think that the rest should go into tip/x86 once everyone's happy
>> with it.
>>
>> Changes from v2:
>>  - Fixed 32-bit x86 build (and the tests pass).
>>  - Put the doc patch where it belongs.
>
> Thanks! This looks good to me. I'll add it to my tree.
>
> Peter, how do you feel about this series? Do the x86 changes look good to you?
>

It looks like patches 1-4 have landed here:

https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath

hpa, what's the route forward for the x86 part?

--Andy
