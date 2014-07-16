Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 23:28:05 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:64887 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861047AbaGPV2D6Viwc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 23:28:03 +0200
Received: by mail-lb0-f171.google.com with SMTP id l4so1082218lbv.2
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 14:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/VFzfV1IbkKnHFEjMK193f9uPw2xix5oyX71cxNyqUw=;
        b=LllTzO1A4oWbgZ/+Lge0P1UZxn9XlvAVLiDVLwhFdTJnn8pxwTCZawYirqcWsFi7LQ
         7fiINeL32/4GcRKusnuQgl7NYzEO25iJ6qLMD16vnlJK/rPLy0908+7Y1zN/Y5T4oyRi
         X7RuBLMIIrvCA7KqsWNdy/UZTjbFTgY9FyXGnC+dl97miyCIOCuzBVLZGsjVKJf0H7ed
         u0VhWB9zd0bFbl29Kn9xte/aH4JTdkEzhD3r9qTk29BRFoIYz7atQoWmghzFHNwUOws6
         A0QjIo7xRDeSUFQIpWV+IYARjTAoMv29PS1ZGUEBV//aimjaBI4qktcEsZmucu8ZcPfu
         m4bw==
X-Gm-Message-State: ALoCoQlDZpXbu6aQrHyG70Ay5MsaCqIrTO5x6R8tr0yn6zQaZ2drAV8On9kWbTsaMCYS+GhPbXqq
X-Received: by 10.112.63.65 with SMTP id e1mr5576968lbs.81.1405546078303; Wed,
 16 Jul 2014 14:27:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Wed, 16 Jul 2014 14:27:38 -0700 (PDT)
In-Reply-To: <CAGXu5jKMwiAxeCVZVPS72XWCd2KhiR-uc4VFKT0mvD9s-cTO_Q@mail.gmail.com>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
 <20140711164931.GA18473@redhat.com> <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
 <CALCETrVXgA9a2f7VwnCYW4_XB+JAPRSR8xsuH_ZYbA82=ZozRw@mail.gmail.com>
 <CAGXu5j+r-CpJiXipCT=j09+ZfJjF9jTc3kuZFAH3ZxgUEvktTA@mail.gmail.com>
 <CALCETrX48nuR6wqEV4Nu47BF4Z3XFvBpYer_fzwaqJdi0fpdKw@mail.gmail.com> <CAGXu5jKMwiAxeCVZVPS72XWCd2KhiR-uc4VFKT0mvD9s-cTO_Q@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 16 Jul 2014 14:27:38 -0700
Message-ID: <CALCETrUXRszBEhB7aOu6nXtCj09zofY_b_5BUNbJk-EFefA6fw@mail.gmail.com>
Subject: Re: [PATCH v10 0/11] seccomp: add thread sync ability
To:     Kees Cook <keescook@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41240
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

On Wed, Jul 16, 2014 at 2:23 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jul 16, 2014 at 12:45 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> In seccomp_prepare_user_filter, would it make sense to return -EINVAL
>> if !user_filter?  That will make it slightly more pleasant to
>> implement TSYNC-without-change if anyone ever wants it.  (This isn't
>> really necessary -- it's just slightly more polite.)
>
> I can't do this since EFAULT is already used to detect seccomp
> capabilities from userspace.

Aha.  In that case, can you (separately) send a prctl.2 manpage patch
documenting that?  Also, I'm pretty sure you can get away with doing
this for seccomp(2) -- EINVAL and ENOSYS are easily distinguishable,
but the current behavior is IMO also fine if documented.

--Andy
