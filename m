Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 18:11:00 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64564 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859928AbaFYQK6TrhSc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 18:10:58 +0200
Received: by mail-lb0-f174.google.com with SMTP id u10so2009864lbd.19
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 09:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=VLidyI6X/biA2c4RvWH4/qMyKt3Hbvzy7s8E6VLJDXo=;
        b=Tpq573IN2wpS+NmfafuLwB9H3a3+lNs4Cs6cD3jrJWOLT6p5CXCFJobFacOawlXi/3
         DO4BUhVJDpptXDE34+A0FeCEwCFbzZo6Iry57s4Fhdc9+C0i1fibOcUiU+2XSBNcW/7o
         RfFYzsQrhqQs4V3dIXjMwYUT8keuMWlbZoH7WSYpoOAvs2q3FtGkCRAIDpfwDgn0ZQRa
         pOvKEdk29C8gXG9xeu8UybZH39lfho/RW14Sdv6WL2ZrUbt2RfNI0Ptef1ewawoFFqvq
         /2YgY6qKpqVv/Z44bPVT1R2GN/QL0UYLYkAAJ8cll1Ri9SKnbWtsBwtTZ8E2GyrD8QTZ
         IHjg==
X-Gm-Message-State: ALoCoQnARydN3QM52DnlRxLpMJQyqB842IqkJQPAjM3SW6u0f7USoJrrNrq++udoTVpCObZ7DEN9
X-Received: by 10.152.23.42 with SMTP id j10mr6539305laf.19.1403712652572;
 Wed, 25 Jun 2014 09:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Wed, 25 Jun 2014 09:10:32 -0700 (PDT)
In-Reply-To: <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-6-git-send-email-keescook@chromium.org> <20140625135121.GB7892@redhat.com>
 <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 25 Jun 2014 09:10:32 -0700
Message-ID: <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
To:     Kees Cook <keescook@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40815
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

On Wed, Jun 25, 2014 at 7:51 AM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jun 25, 2014 at 6:51 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> On 06/24, Kees Cook wrote:
>>>
>>> +static inline void seccomp_assign_mode(struct task_struct *task,
>>> +                                    unsigned long seccomp_mode)
>>> +{
>>> +     BUG_ON(!spin_is_locked(&task->sighand->siglock));
>>> +
>>> +     task->seccomp.mode = seccomp_mode;
>>> +     set_tsk_thread_flag(task, TIF_SECCOMP);
>>> +}
>>
>> OK, but unless task == current this can race with secure_computing().
>> I think this needs smp_mb__before_atomic() and secure_computing() needs
>> rmb() after test_bit(TIF_SECCOMP).
>>
>> Otherwise, can't __secure_computing() hit BUG() if it sees the old
>> mode == SECCOMP_MODE_DISABLED ?
>>
>> Or seccomp_run_filters() can see ->filters == NULL and WARN(),
>> smp_load_acquire() only serializes that LOAD with the subsequent memory
>> operations.
>
> Hm, actually, now I'm worried about smp_load_acquire() being too slow
> in run_filters().
>
> The ordering must be:
> - task->seccomp.filter must be valid before
> - task->seccomp.mode is set, which must be valid before
> - TIF_SECCOMP is set
>
> But I don't want to impact secure_computing(). What's the best way to
> make sure this ordering is respected?

Remove the ordering requirement, perhaps?

What if you moved mode into seccomp.filter?  Then there would be
little reason to check TIF_SECCOMP from secure_computing; instead, you
could smp_load_acquire (or read_barrier_depends, maybe) seccomp.filter
from secure_computing and pass the result as a parameter to
__secure_computing.  Or you could even remove the distinction between
secure_computing and __secure_computing -- it's essentially useless
anyway to split entry hook approaches like my x86 fastpath prototype.

--Andy
