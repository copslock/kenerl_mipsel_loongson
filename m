Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 19:57:27 +0200 (CEST)
Received: from mail-oa0-f47.google.com ([209.85.219.47]:48350 "EHLO
        mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859936AbaFYR5VqUj9F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 19:57:21 +0200
Received: by mail-oa0-f47.google.com with SMTP id n16so2512855oag.20
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XvISSv+kTP+chhzICwZ1sySB2SILkoNNlhIbBVfPXHw=;
        b=XNzBCqFWC6GSqmm5wrrJL8q4cyMr1rGVH5Lj8x+JJBF7Fw2B1j0/Nwd3nY7qZqlVRB
         qhNXaVnV8TQADhUkj4XQ/6T4UZ+EkfYfoR3T3JDN0EP3rJ2NGgipHy/mwdXabtubDA5z
         8ox37D0X/tsvOQeqyp6FH+VRCKL88GA07zmLeNOodW3eNF9Rk7i5qgWdkFFA3q2wgNeu
         hu63ukXfRs06x+XveAkYtyL9/SblgCZU9U6BoKITDqj+TQEV1HW1J5+qjExMcO/YyJB9
         ZIH8u9eCTODjRZlEykT2h/o+vXlukmQ59+B9NY1nainNmerdY1nSf0LRb+xLpNFbtmhn
         1Z2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XvISSv+kTP+chhzICwZ1sySB2SILkoNNlhIbBVfPXHw=;
        b=SUNrd4ruWgixFoY1lHQsERN6jRw2x+WDBIR4KPCopLxYtw4r0CUS/mHnECK2GG8sl4
         E8jLNXa5eV//brhmJ53dFD9ewqZNCKOYWwtYJB+TJAmSb2zh5yl84tG/HsTa1i0/lVsE
         CYDcp1DXxmoWzSlmAfqm711VKJd2fkhBduF+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XvISSv+kTP+chhzICwZ1sySB2SILkoNNlhIbBVfPXHw=;
        b=VQVfcXsJHT2BORCLZUYhBYTGjHHifGs0LPXKz/x3pg95iH8t3S+gccGSwU7Esz/yop
         2Q4YscHJ5d1TxKAIoTBAnsqBN2aBrhxYvJ0NHklFOeaLcEpDDUZ2YWrP6zsmqozNtep+
         rSAhq0OgAgSqo1+2MSYmCpdmouYBr/x7Zb0JMG3lpB8jboyBpfH/vzyLrUF3IHaupJ5l
         pz6WGXoTtNpgGi0DnW9OLYzlJXZdkSr1RlzUJQq1ZlrmgtlYwztQY3N6haIOAuIx4IMx
         /2ZCVRfhygiYct704j37xysyjTr2r+e1sjShMr/Dc+AUpNaeLDxPyNBSWm3XqKycMqbr
         agbA==
X-Gm-Message-State: ALoCoQmKXF2kCdZDwU9Q9lftF1W1MiBvY7GQesdSxiFXq/JuhGOXMVbNpo6r0r0jzXO4gZtkkGz6
MIME-Version: 1.0
X-Received: by 10.60.175.34 with SMTP id bx2mr9745496oec.49.1403719035555;
 Wed, 25 Jun 2014 10:57:15 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 25 Jun 2014 10:57:15 -0700 (PDT)
In-Reply-To: <20140625172410.GA17133@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <1403642893-23107-10-git-send-email-keescook@chromium.org>
        <20140625142121.GD7892@redhat.com>
        <CAGXu5jJtLrjbobZC1FD4WV-Jm2p7cRGa1aSPK-d_isnfCZAHdA@mail.gmail.com>
        <20140625165209.GA14720@redhat.com>
        <CAGXu5jLHDew1fifGY_mWgwcH7evm0T8rqSnBrw4XpoAXGK+t-Q@mail.gmail.com>
        <20140625172410.GA17133@redhat.com>
Date:   Wed, 25 Jun 2014 10:57:15 -0700
X-Google-Sender-Auth: Y_RnnhWMDXw3HCi12hhr1c66dok
Message-ID: <CAGXu5jKkLS3++_dtWHnjWudVvaSR9DRwjNG3q00SmSy6XoCMaw@mail.gmail.com>
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
X-archive-position: 40827
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

On Wed, Jun 25, 2014 at 10:24 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/25, Kees Cook wrote:
>>
>> On Wed, Jun 25, 2014 at 9:52 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> >
>> > Yes, at least this should close the race with suid-exec. And there are no
>> > other users. Except apparmor, and I hope you will check it because I simply
>> > do not know what it does ;)
>> >
>> >> I wonder if changes to nnp need to "flushed" during syscall entry
>> >> instead of getting updated externally/asynchronously? That way it
>> >> won't be out of sync with the seccomp mode/filters.
>> >>
>> >> Perhaps secure computing needs to check some (maybe seccomp-only)
>> >> atomic flags and flip on the "real" nnp if found?
>> >
>> > Not sure I understand you, could you clarify?
>>
>> Instead of having TSYNC change the nnp bit, it can set a new flag, say:
>>
>>     task->seccomp.flags |= SECCOMP_NEEDS_NNP;
>>
>> This would be set along with seccomp.mode, seccomp.filter, and
>> TIF_SECCOMP. Then, during the next secure_computing() call that thread
>> makes, it would check the flag:
>>
>>     if (task->seccomp.flags & SECCOMP_NEEDS_NNP)
>>         task->nnp = 1;
>>
>> This means that nnp couldn't change in the middle of a running syscall.
>
> Aha, so you were worried about the same thing. Not sure we need this,
> but at least I understand you and...
>
>> Hmmm. Perhaps this doesn't solve anything, though? Perhaps my proposal
>> above would actually make things worse, since now we'd have a thread
>> with seccomp set up, and no nnp. If it was in the middle of exec,
>> we're still causing a problem.
>
> Yes ;)
>
>> I think we'd also need a way to either delay the seccomp changes, or
>> to notice this condition during exec. Bleh.
>
> Hmm. confused again,

I mean to suggest that the tsync changes would be stored in each
thread, but somewhere other than the true seccomp struct, but with
TIF_SECCOMP set. When entering secure_computing(), current would check
for the "changes to sync", and apply them, then start the syscall. In
this way, we can never race a syscall (like exec).

>> What actually happens with a multi-threaded process calls exec? I
>> assume all the other threads are destroyed?
>
> Yes. But this is the point-of-no-return, de_thread() is called after the execing
> thared has already passed (say) check_unsafe_exec().
>
> However, do_execve() takes cred_guard_mutex at the start in prepare_bprm_creds()
> and drops it in install_exec_creds(), so it should solve the problem?

I can't tell yet. I'm still trying to understand the order of
operations here. It looks like de_thread() takes the sighand lock.
do_execve_common does:

prepare_bprm_creds (takes cred_guard_mutex)
check_unsafe_exec (checks nnp to set LSM_UNSAFE_NO_NEW_PRIVS)
prepare_binprm (handles suid escalation, checks nnp separately)
    security_bprm_set_creds (checks LSM_UNSAFE_NO_NEW_PRIVS)
exec_binprm
    load_elf_binary
        flush_old_exec
            de_thread (takes and releases sighand->lock)
        install_exec_creds (releases cred_guard_mutex)

I don't see a way to use cred_guard_mutex during tsync (which holds
sighand->lock) without dead-locking. What were you considering here?

-Kees

-- 
Kees Cook
Chrome OS Security
