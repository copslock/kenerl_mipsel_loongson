Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 23:16:12 +0200 (CEST)
Received: from mail-la0-f43.google.com ([209.85.215.43]:52989 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861309AbaGPVQJvKZ0n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 23:16:09 +0200
Received: by mail-la0-f43.google.com with SMTP id hr17so1089401lab.16
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 14:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ifj5LpsXxdC7EENI6KTHWWas6GJlu9fIwMrgc7NO6rc=;
        b=PQ+Mc0UNnQrZNVqptr3utRbmLTF0iravixBF4SNiZLKYsi+kQhM2a4yxIisGlvChWK
         0YUyQgtQXx4NPlJluqlW9D8ReEuXuCG3aofnylYcVvZGKortXomG42DbdEY2kq+BdVkH
         G4xVJOoU82cngwbQG/yGcFtOWMvlKBphPX6qWoXN7heCcOaFdrU6k9d/yBUPk6L96T3c
         kKV74+d3osip/3aaroCwfNUUFkvH+8I7/qQxT3dnMV33Zn8/P5vOhaCMybpYqT/2UFTQ
         wwkkNpB/RPx4fJ+ZxGMXbHnhJjurqMMgfC7iOqenkuLqZ+K1tde/GGEo7aISsm1QQO2r
         0Tmg==
X-Gm-Message-State: ALoCoQkWig8hSUBfeZJ/VqBnEoheXpV47c0gGXRWE+AwyV6/UmNC6dZVX31VqQjR1zRqU/BxgdoI
X-Received: by 10.112.54.197 with SMTP id l5mr4978412lbp.103.1405545364483;
 Wed, 16 Jul 2014 14:16:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Wed, 16 Jul 2014 14:15:44 -0700 (PDT)
In-Reply-To: <CAGXu5jJornzMJjyPXVZB_eYi-FRet=bXcJWJDa1vnB_oU9ZA_Q@mail.gmail.com>
References: <cover.1405452484.git.luto@amacapital.net> <bd4e2efb7cd97f2bf9d4f1e2065f16c9091d799a.1405452484.git.luto@amacapital.net>
 <CAGXu5jJornzMJjyPXVZB_eYi-FRet=bXcJWJDa1vnB_oU9ZA_Q@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 16 Jul 2014 14:15:44 -0700
Message-ID: <CALCETrWuWxZANoKAR=FG55EOHtzvTHmc3euMdtf8yfibtK-QYw@mail.gmail.com>
Subject: Re: [PATCH 5/7] x86: Split syscall_trace_enter into two phases
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
X-archive-position: 41237
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

On Wed, Jul 16, 2014 at 1:21 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>
>> +
>> +               ret = seccomp_phase1(&sd);
>> +               if (ret == SECCOMP_PHASE1_SKIP) {
>> +                       regs->orig_ax = -ENOSYS;
>
> Before, seccomp didn't touch orig_ax on a skip. I don't see any
> problem with this, and it's probably more clear this way, but are you
> sure there aren't unexpected side-effects from this?

It's necessary to cause the syscall to be skipped -- see syscall_trace_enter.

That being said, setting it to -ENOSYS is nonsense and probably
confused you at least as much as it confused me.  It should be
regs->orig_ax = -1.

--Andy
