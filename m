Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 21:54:27 +0200 (CEST)
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33086 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992009AbcH3TyU208Jj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 21:54:20 +0200
Received: by mail-ua0-f180.google.com with SMTP id l94so52125342ual.0
        for <linux-mips@linux-mips.org>; Tue, 30 Aug 2016 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=taQUK56ry7Ai+Zo9NdSD1hyJutcjYknEjiSZSMGTBiI=;
        b=zhgT0kRRaK2HeyFEzekIdsPkII79LoiuAYDVBCX07ZHvGmUJoEX7ppa1qqosywWdhE
         qaKxXJCPazhq8d6cd2+t9stk8tfAa0mEk+U6bfXJW65+Y6+9oYDOzGKLfEnU9t/v9+Gu
         6YwjrBqHI8lRbjK/8i2eMU3tm3ahIep6OP/hMsZK2puVT2cliNeJcsK1Yjdj1ZnvFTvr
         qmDZp3BRsNZhW2id9JtHrFwVQ7cz1IU8NymB+JReL/E0tRKb7M2WPsxUrn6vRlIZPyUZ
         sK4E3ueBuznmGOUTnSK+0vLuFWV2ESmTpLISysQu4gnrWBVMJ833LLjmNfHqNYv+cP/W
         O99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=taQUK56ry7Ai+Zo9NdSD1hyJutcjYknEjiSZSMGTBiI=;
        b=K0uD/DSfCV6WgYz9qxUAL8PAdITlixG1jKuWBy68cx2r52l/HzttjSvT0f0vkIX5mr
         Gv812t7DNOmIYGjvlUvn7VhQcBkBufEzc3EEeQZFWCMoyXVg9w1Oq528fR8Qj4lKq8TL
         wfbsq8iP4hts2/QehDSpanRCXoqaTkhHet/RhMcGS8nRqC07zT3occT0gUOPsLPHBZD0
         FoECJGdBJqZKfLIODzSuFEvCova62gwf0QjBSM/KpsV86zvzezrfEqKeTTZXUEnd6v8B
         A7svwzTI3RRd/kvLs3CuDbqGvXvzHmpjz53wLjns8f8KWHTk9hxJNIxoc+0IJ3XAISva
         2AGQ==
X-Gm-Message-State: AE9vXwOoiiIrI6vKllbonzooD27sFnBxoAoHj2sc0frQUeIG94FFBlkUtteZ+etYSskqS5YlcyolA3B7XaEceDhE
X-Received: by 10.176.3.203 with SMTP id 69mr1617035uau.9.1472586853854; Tue,
 30 Aug 2016 12:54:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.76.146 with HTTP; Tue, 30 Aug 2016 12:53:53 -0700 (PDT)
In-Reply-To: <20160830152955.17633511@gandalf.local.home>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
 <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
 <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com> <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
 <20160830152955.17633511@gandalf.local.home>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 30 Aug 2016 12:53:53 -0700
Message-ID: <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers per syscall
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54870
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

On Tue, Aug 30, 2016 at 12:29 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 30 Aug 2016 11:52:39 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>> Okay, I think I see what's going on.  init_ftrace_syscalls() does:
>>
>>         meta = find_syscall_meta(addr);
>>
>> Unless I'm missing some reason why this is a sensible thing to do,
>> this seems overcomplicated and incorrect.  There is exactly one caller
>> of find_syscall_meta() and that caller knows the syscall number.  Why
>> doesn't it just look up the metadata by *number* instead of by syscall
>> implementation address?  There are plenty of architectures for which
>> multiple logically different syscalls can share an implementation
>> (e.g. pretty much everything that calls in_compat_syscall()).
>
> The problem is that the meta data is created at the syscalls
> themselves. Look at all the macro magic in include/linux/syscalls.h,
> and search for __syscall_metadata. The meta data is created via linker
> magic, and the find_syscall_meta() is what finds a specific system call
> and the meta data associated with it.

Egads!  OK, I see why this is a mess.

I guess we should be creating the metadata from the syscall tables
instead of from the syscall definitions, but I guess that's currently
a nasty per-arch mess.

Could we at least have an array of (arch, nr) instead of just an array
of nrs in the metadata?

--Andy
