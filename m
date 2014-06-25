Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 19:38:45 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:49308 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859928AbaFYRinZMhEB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 19:38:43 +0200
Received: by mail-la0-f54.google.com with SMTP id mc6so1021979lab.13
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 10:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=kPFeV8BMfIyAtu5+k2BcEDDWCnKukOm9IgH9EPMyd0U=;
        b=KJEtv+bSbqKYu1B0bou1RIsoPOrCr6yRD7jHqutwi8pPXGiULj7qfJb4lFUIZKuAHw
         bhnD43mBOb3tyG92dKUQX/de5Yg1E/Twdp4tiwwslvhhCoqH3LfPGgSVLlfI5pMsCfMj
         gafV7yU70gv2KLH2TX0jU+wN37FJOw3kwpeFipH4jNMpPcksY0egrhO9lQ37PM+ublvy
         SjvH4G9R7Ht7S6WASCJvn1g4Ev8OaZBplDFUFrIwo5KBOoxwwkxGj8ElpG7g1ruDqTsQ
         pMqfW1hp9FWAZvC4U8nnitCoPR1I76e1ufy+Ln0sz3e07paG90ny/B0tkdrfp9emGA+4
         UvBA==
X-Gm-Message-State: ALoCoQlcQ0kx5BkaX2MVYw027evAAhMMR3GTd4jgd2Q1BFi0cFwzDnuDtRt1XT4STUcJ+2IJoyQW
X-Received: by 10.152.3.227 with SMTP id f3mr6775120laf.37.1403717917537; Wed,
 25 Jun 2014 10:38:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Wed, 25 Jun 2014 10:38:17 -0700 (PDT)
In-Reply-To: <20140625173245.GA17695@redhat.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-6-git-send-email-keescook@chromium.org> <20140625135121.GB7892@redhat.com>
 <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
 <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
 <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
 <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com> <20140625173245.GA17695@redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 25 Jun 2014 10:38:17 -0700
Message-ID: <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
X-archive-position: 40823
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

On Wed, Jun 25, 2014 at 10:32 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/25, Andy Lutomirski wrote:
>>
>> Write the filter, then smp_mb (or maybe a weaker barrier is okay),
>> then set the bit.
>
> Yes, exactly, this is what I meant. Plas rmb() in __secure_computing().
>
> But I still can't understand the rest of your discussion about the
> ordering we need ;)

Let me try again from scratch.

Currently there are three relevant variables: TIF_SECCOMP,
seccomp.mode, and seccomp.filter.  __secure_computing needs
seccomp.mode and seccomp.filter to be in sync, and it wants (but
doesn't really need) TIF_SECCOMP to be in sync as well.

My suggestion is to rearrange it a bit.  Move mode into seccomp.filter
(so that filter == NULL implies no seccomp) and don't check
TIF_SECCOMP in secure_computing.  Then turning on seccomp is entirely
atomic except for the fact that the seccomp hooks won't be called if
filter != NULL but !TIF_SECCOMP.  This removes all ordering
requirements.

Alternatively, __secure_computing could still BUG_ON(!seccomp.filter).
In that case, filter needs to be set before TIF_SECCOMP is set, but
that's straightforward.

--Andy
