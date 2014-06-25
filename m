Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 16:51:33 +0200 (CEST)
Received: from mail-ob0-f170.google.com ([209.85.214.170]:54622 "EHLO
        mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816417AbaFYOvbTxR2C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 16:51:31 +0200
Received: by mail-ob0-f170.google.com with SMTP id uz6so2228644obc.29
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FNRwftFuANuIfX/LBvzGK/EiALT+SoPX0f2P2wYXV/M=;
        b=PHrT7Oni4yxEmN3iI0jy2KuCSTBMnAg/DDXSTImJQ8ha+iJm9QGr+osIoyV80NFeHJ
         uBXmFCXPi/k6W5iPnw4/z++FtnNp7HibdczK6KvvSkKEtQHWrCB6NibsDeAWVlCXFsBV
         KjBFuLbVjExi5fyQ18aZNEhtqghaBtH5GMjNsA3yOp0bjPALsqRg3nqVB2hV7M0nVZ0f
         wOSnEkT3mLdU4MYQue2wlGRwi4rV83w3bwp0ITzdaGN+b9YPHVyIxbxxGXWEbM2oiV8V
         zUAQBWrv2lZTi6P9MOzACySOxDJO8C3FM5FWUuEGluQNuoOSUkE5F7I3b6zwb0Zpaoj4
         Jt+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FNRwftFuANuIfX/LBvzGK/EiALT+SoPX0f2P2wYXV/M=;
        b=J82Wuz1bft7xnF+aWMEnL1ZJhkgPwcVftTXmRccnvTksDMP6SWe/lRCTDtP0JmZycI
         q/lMwRaL4yUa3aPeS+wxfjN7RNmPPEgPGRFLg3bJI6MmZXoPbo3YaGcMMFzxwoyULEVf
         9j2PO47QYOK4TYGD/yWepqRvQTKtIGozBgImQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FNRwftFuANuIfX/LBvzGK/EiALT+SoPX0f2P2wYXV/M=;
        b=l53oRxZVWMOhi5MD2/gcEssibs3trZqgQstvDBX2rlqF+e4SUI3KKJQKMhK3FLhVi1
         9m5jhD1pzOcEv5+S6L9lFru5CXpqOOmoQdc2VekYHHu8ZdaMibzCxKpzdpe/fthieKiF
         mloZRnKwyEyyioOHpIWqR0flFZjM+oaRdiPtS9+IMPOttUecvWw0FJhAh7FlYhh7cXNj
         gR64kO/Uxvf0Q46YxJB7y+sa/KsUaWBIYq4jXYm80HD8yptcAA48/o5XD5qiloFSk4WI
         D4Ai/g0tcwXLbZ6UU6jTg9w7Sdd1TeMIwqhPwIOcGW36f5eV4F5aV2Fo1kkRNelEhsxM
         9AWg==
X-Gm-Message-State: ALoCoQlhR5vNRq3I6ljp4BFtA/vURHNcJpklngeqg7K4JV/HgxXnSLWpl7LJwvLsm0dQzf8VqtUB
MIME-Version: 1.0
X-Received: by 10.60.143.37 with SMTP id sb5mr8531664oeb.38.1403707885258;
 Wed, 25 Jun 2014 07:51:25 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 25 Jun 2014 07:51:25 -0700 (PDT)
In-Reply-To: <20140625135121.GB7892@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
        <1403642893-23107-6-git-send-email-keescook@chromium.org>
        <20140625135121.GB7892@redhat.com>
Date:   Wed, 25 Jun 2014 07:51:25 -0700
X-Google-Sender-Auth: RCNeIVkYTQv2tceTvFHUOTo4kcM
Message-ID: <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
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
X-archive-position: 40812
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

On Wed, Jun 25, 2014 at 6:51 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/24, Kees Cook wrote:
>>
>> +static inline void seccomp_assign_mode(struct task_struct *task,
>> +                                    unsigned long seccomp_mode)
>> +{
>> +     BUG_ON(!spin_is_locked(&task->sighand->siglock));
>> +
>> +     task->seccomp.mode = seccomp_mode;
>> +     set_tsk_thread_flag(task, TIF_SECCOMP);
>> +}
>
> OK, but unless task == current this can race with secure_computing().
> I think this needs smp_mb__before_atomic() and secure_computing() needs
> rmb() after test_bit(TIF_SECCOMP).
>
> Otherwise, can't __secure_computing() hit BUG() if it sees the old
> mode == SECCOMP_MODE_DISABLED ?
>
> Or seccomp_run_filters() can see ->filters == NULL and WARN(),
> smp_load_acquire() only serializes that LOAD with the subsequent memory
> operations.

Hm, actually, now I'm worried about smp_load_acquire() being too slow
in run_filters().

The ordering must be:
- task->seccomp.filter must be valid before
- task->seccomp.mode is set, which must be valid before
- TIF_SECCOMP is set

But I don't want to impact secure_computing(). What's the best way to
make sure this ordering is respected?

-Kees

-- 
Kees Cook
Chrome OS Security
