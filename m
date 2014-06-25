Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 19:09:09 +0200 (CEST)
Received: from mail-oa0-f52.google.com ([209.85.219.52]:50780 "EHLO
        mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860038AbaFYRJGQCiRX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 19:09:06 +0200
Received: by mail-oa0-f52.google.com with SMTP id j17so2472677oag.11
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=g0o15zrYn6AY8uXfBl5NxTBKzgqKsRTYymb/zSkxkcg=;
        b=NPe/TyZBr3yrGy71xRdOM56g4iw/xmTUMpI6WcRAbBJWKFMxyb3fwf2YtO28AUMy0a
         FIS4QdJ3pPHx7vm6myD1nGLubi3tj7TD+uKwYWXg8ltvPeO84ejENkO/UW38XNdZQMvX
         f8y7Roo94abpLuq/yWkA6KpBWDXurRXefXNv01jC7gEMyvkLRQ75Y8HVJtbFXUEAZY31
         eHtsfRzyv+i8gJayuOsFHhNxtmLzPzWw9QLqA5LB0dIDVevCzvA4zn6mBGUo3v4wetdT
         P2JMW6VrdXCMUv1ivfsPOgW2nsyomsBH9OjdX9kGqtGmhY7Ue+YINhQTYzEEFyskwPLY
         CadA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=g0o15zrYn6AY8uXfBl5NxTBKzgqKsRTYymb/zSkxkcg=;
        b=lB6oIGLsNoXPwzizKr71QhWa7Y9QGVyFTide7CfjxhVLRkZawxuyAI+yMV57uhTGAv
         NSjiikS4GsuE9avDhxxzQqAYM+jziZb/h/3gh8lkk/lKQf6RDK/Ui4VPMz9ZS+5Z9362
         Gt5Fw8Sb3phi9bb8JoKykbKL77aSQvmespADM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=g0o15zrYn6AY8uXfBl5NxTBKzgqKsRTYymb/zSkxkcg=;
        b=SJ3bVTTCI9ROMkjSUeOAO34jTkxRKLVsg68/IHuLPRJRaUa72KkFNJMHdHqe3KuUqF
         TCxLm0jMUoppu8d/LSQhS5w/pxDHJv2AJAxcURMCM1exDfFQR+YAcrwIw/eE5FY7OSrF
         DdAwKf/0sq9vcka2QBxlKT42szyNxnooV7pWVpKnbSB3Uln7GAsf6z1q6exDrGEGkPKj
         3D/e+hx8Tlk9mNXf5xB4g1oH4neQo0p30PDbHxstJA423r949u07rJalmdFzbAPmowlG
         hUo76GJoH/y10x8xI34boh5y49JPtNOdkW0XBvSoF3/0nxZnes2YH5eueo9JQSbZGGdi
         O49A==
X-Gm-Message-State: ALoCoQmJcLOmnsWUi56x0zIZ2YBOXs0Fke5WttmDMtuOoMS6D7WOqGyUZBkeWr53RB/7iKHhIHCo
MIME-Version: 1.0
X-Received: by 10.60.175.34 with SMTP id bx2mr9444178oec.49.1403716140098;
 Wed, 25 Jun 2014 10:09:00 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 25 Jun 2014 10:08:59 -0700 (PDT)
In-Reply-To: <20140625165209.GA14720@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <1403642893-23107-10-git-send-email-keescook@chromium.org>
        <20140625142121.GD7892@redhat.com>
        <CAGXu5jJtLrjbobZC1FD4WV-Jm2p7cRGa1aSPK-d_isnfCZAHdA@mail.gmail.com>
        <20140625165209.GA14720@redhat.com>
Date:   Wed, 25 Jun 2014 10:09:00 -0700
X-Google-Sender-Auth: LyzNbpp1gBF1qXUfuxVtfLNpQuk
Message-ID: <CAGXu5jLHDew1fifGY_mWgwcH7evm0T8rqSnBrw4XpoAXGK+t-Q@mail.gmail.com>
Subject: Re: [PATCH v8 9/9] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
From:   Kees Cook <keescook@chromium.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
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
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40820
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

On Wed, Jun 25, 2014 at 9:52 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/25, Kees Cook wrote:
>>
>> On Wed, Jun 25, 2014 at 7:21 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> >
>> > But. Doesn't this change add a new security hole?
>> >
>> > Obviously, we should not allow to install a filter and then (say) exec
>> > a suid binary, that is why we have no_new_privs/LSM_UNSAFE_NO_NEW_PRIVS.
>> >
>> > But what if "thread->seccomp.filter = caller->seccomp.filter" races with
>> > any user of task_no_new_privs() ? Say, suppose this thread has already
>> > passed check_unsafe_exec/etc and it is going to exec the suid binary?
>>
>> Oh, ew. Yeah. It looks like there's a cred lock to be held to combat this?
>
> Yes, cred_guard_mutex looks like an obvious choice... Hmm, but somehow
> initially I thought that the fix won't be simple. Not sure why.
>
> Yes, at least this should close the race with suid-exec. And there are no
> other users. Except apparmor, and I hope you will check it because I simply
> do not know what it does ;)
>
>> I wonder if changes to nnp need to "flushed" during syscall entry
>> instead of getting updated externally/asynchronously? That way it
>> won't be out of sync with the seccomp mode/filters.
>>
>> Perhaps secure computing needs to check some (maybe seccomp-only)
>> atomic flags and flip on the "real" nnp if found?
>
> Not sure I understand you, could you clarify?

Instead of having TSYNC change the nnp bit, it can set a new flag, say:

    task->seccomp.flags |= SECCOMP_NEEDS_NNP;

This would be set along with seccomp.mode, seccomp.filter, and
TIF_SECCOMP. Then, during the next secure_computing() call that thread
makes, it would check the flag:

    if (task->seccomp.flags & SECCOMP_NEEDS_NNP)
        task->nnp = 1;

This means that nnp couldn't change in the middle of a running syscall.

Hmmm. Perhaps this doesn't solve anything, though? Perhaps my proposal
above would actually make things worse, since now we'd have a thread
with seccomp set up, and no nnp. If it was in the middle of exec,
we're still causing a problem.

I think we'd also need a way to either delay the seccomp changes, or
to notice this condition during exec. Bleh.

What actually happens with a multi-threaded process calls exec? I
assume all the other threads are destroyed?

> But I was also worried that task_no_new_privs(current) is no longer stable
> inside the syscall paths, perhaps this is what you meant? However I do not
> see something bad here... And this has nothing to do with the race above.
>
> Also. Even ignoring no_new_privs, SECCOMP_FILTER_FLAG_TSYNC is not atomic
> and we can do nothing with this fact (unless it try to freeze the thread
> group somehow), perhaps it makes sense to document this somehow.
>
> I mean, suppose you want to ensure write-to-file is not possible, so you
> do seccomp(SECCOMP_FILTER_FLAG_TSYNC, nack_write_to_file_filter). You can't
> assume that this has effect right after seccomp() returns, this can obviously
> race with a sub-thread which has already entered sys_write().
>
> Once again, I am not arguing, just I think it makes sense to at least mention
> the limitations during the discussion.

Right -- this is an accepted limitation. I will call it out
specifically in the man-page; that's a good idea.

-Kees

-- 
Kees Cook
Chrome OS Security
