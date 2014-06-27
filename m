Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 21:38:42 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:49238 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856090AbaF0TbnJRURA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2014 21:31:43 +0200
Received: by mail-la0-f54.google.com with SMTP id mc6so3327823lab.27
        for <linux-mips@linux-mips.org>; Fri, 27 Jun 2014 12:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=OjQMaLm7AzyPt/Cx4AExH5FubaMpNVTnb/7A2jo8VjQ=;
        b=DfqLngVfYgt7K3zI0F7F3Z7BPn2AMZEM6QCeR1ihK3hwBvNVm/xFGKEZan5l3PdRbd
         j6FVq/hVDyyIaKPGhx2eDJX8ZttvF+OcD36Psi8dIz00APQQSJkgc3vdzLe6NKYF/n+C
         2mCdUN9tuBxZzrz7Zii5qB7q8b3q4Rwmn8Nytroz0Iii3CIzIJ0/YdCXZNnQsUnfS5Rn
         EpU/jUiPx+zpZQtkKQIkFDZbg0yNNKug0kXewzG5e/tvaf/n1mGT8zRF/RWjE2FwhqEL
         i97cr/6hQ49s8NCMq9hO4QjzlWV2i5P2SehdKeaa6iUHvu/tHWnjtxQKmbrIEw5Ruual
         tL4A==
X-Gm-Message-State: ALoCoQmZ1PYl+NMpSp+hKn+5B/r7jwhpQQc8qY0zgbPwxwT6V4pdFJ2kVwGOKK4uiuDZS2suktny
X-Received: by 10.112.91.163 with SMTP id cf3mr16387249lbb.42.1403897497298;
 Fri, 27 Jun 2014 12:31:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Fri, 27 Jun 2014 12:31:16 -0700 (PDT)
In-Reply-To: <20140627192753.GA30752@redhat.com>
References: <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
 <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
 <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
 <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
 <20140625173245.GA17695@redhat.com> <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
 <20140625175136.GA18185@redhat.com> <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
 <CALCETrVNwhWSPNiBiZmgP1nD9zLJPTk6cH0yo=85rbxTPTYFRg@mail.gmail.com>
 <CAGXu5jLavA8FJD8m-1y4wO0uzh3qvvMmajAg0Lrr1Cn_Om3a3w@mail.gmail.com> <20140627192753.GA30752@redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 27 Jun 2014 12:31:16 -0700
Message-ID: <CALCETrVbJqfG6oBaZEjj7H3pPa1oVJx6QXAYc5zZ6o-niV=WKQ@mail.gmail.com>
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
X-archive-position: 40879
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

On Fri, Jun 27, 2014 at 12:27 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/27, Kees Cook wrote:
>>
>> It looks like SMP ARM issues dsb for rmb, which seems a bit expensive.
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204g/CIHJFGFE.htm
>>
>> ...
>>
>> I really want to avoid adding anything to the secure_computing()
>> execution path. :(
>
> I must have missed something but I do not understand your concerns.
>
> __secure_computing() is not trivial, and we are going to execute the
> filters. Do you really think rmb() can add the noticeable difference?
>
> Not to mention that we can only get here if we take the slow syscall
> enter path due to TIF_SECCOMP...
>

On my box, with my fancy multi-phase seccomp patches, the total
seccomp overhead for a very short filter is about 13ns.  Adding a full
barrier would add several ns, I think.

Admittedly, this is x86, not ARM, so comparisons here are completely
bogus.  And that read memory barrier doesn't even need an instruction
on x86.  But still, let's try to keep this fast.

--Andy
