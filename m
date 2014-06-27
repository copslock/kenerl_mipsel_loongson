Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 22:57:10 +0200 (CEST)
Received: from mail-ob0-f170.google.com ([209.85.214.170]:50057 "EHLO
        mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860046AbaF0U4yjCxHu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2014 22:56:54 +0200
Received: by mail-ob0-f170.google.com with SMTP id uz6so6226464obc.15
        for <linux-mips@linux-mips.org>; Fri, 27 Jun 2014 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Q+l77jpjX/sZyuCrJlsWoLGg/wE+oaKoXIuR2bIJa0c=;
        b=BdW5lO22vsxxl7jZFeKlaSD81FPUCc+a6R7kh154cYCJIkjtevCZbFzgCJ2Eux/vug
         CE5qKTpOYEtTgmkKXosUWHWfgWa0P55EkhBQwu5kK297A6wZ1eCtEUs0j56LeATcngKB
         c2/xbLMi1+9NzRlvK/quxgBsYZoHv8tXVmrENuPBKIyvWnOymof7qMcCK+PMRja9IEFO
         ZhsjM6zSHtyDwKwlLNZalEXsMhZqT2UEQvSWNworrzHPFViXhEs+r9tZ8jKdQlvJgPWT
         jk+81K92VFt5tC9iWFu+i10maCvzsBUGO1JkjAG11ThcJ9kr9kF0H68ZqCXjKfOLTWg4
         hl7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Q+l77jpjX/sZyuCrJlsWoLGg/wE+oaKoXIuR2bIJa0c=;
        b=CGzUJoKZQHcNPYZDjIIs1V49P44dnXkI+G4DwCsCTv0M5RDcCwCKXInDWsH/CN73yJ
         0mpQC6TSIjUYjqDzZN7fdeZ317fCyD017d15aEWl903SZ5kc6R1Hkam13Kfg1uvL1p6m
         DmUA5Nc+vUVelrciCr+EnZosUL54btO+G9c+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Q+l77jpjX/sZyuCrJlsWoLGg/wE+oaKoXIuR2bIJa0c=;
        b=bhWfWYy9CZFAM9r1hfpT8+1qWEWaPgmHdDQoLs2OR7xCfnQeKCrql7yG+w9EKm+a2g
         nbucayYeF5LPjH/a26zQDxTvnWT84ZMTx3peqzBbuAugmCm6lQcmvBytkTXhnanrtBMt
         5q2kwOuRABm7v/vOwT/V23K3WWNNGmIDb7403Qto3QmXSO6BnzGKvktUZypVFKZ/YKuA
         sMXHsDSDkEBX4l10UDhcPfmWmnbauvvAUpnidoaqYNBySqq7dwxIxJ1U9QZlul3eYHqV
         vbvFTozLq9aIrlJsipd8CHAHOMi9ya7Y1t6okYO38i3sBAjg76fpnpigEi16ntocmxR0
         N1CQ==
X-Gm-Message-State: ALoCoQlfqVLgMj/F1d7UqeGcJnkCg7dpQbgw5FQOCN8y8Lpfc6tdfnGm/EjfMh5HQJJKteVYqFUJ
MIME-Version: 1.0
X-Received: by 10.182.81.99 with SMTP id z3mr13775988obx.79.1403902606916;
 Fri, 27 Jun 2014 13:56:46 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Fri, 27 Jun 2014 13:56:46 -0700 (PDT)
In-Reply-To: <20140627195559.GA31661@redhat.com>
References: <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
        <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
        <20140625173245.GA17695@redhat.com>
        <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
        <20140625175136.GA18185@redhat.com>
        <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
        <CALCETrVNwhWSPNiBiZmgP1nD9zLJPTk6cH0yo=85rbxTPTYFRg@mail.gmail.com>
        <CAGXu5jLavA8FJD8m-1y4wO0uzh3qvvMmajAg0Lrr1Cn_Om3a3w@mail.gmail.com>
        <20140627192753.GA30752@redhat.com>
        <CALCETrVbJqfG6oBaZEjj7H3pPa1oVJx6QXAYc5zZ6o-niV=WKQ@mail.gmail.com>
        <20140627195559.GA31661@redhat.com>
Date:   Fri, 27 Jun 2014 13:56:46 -0700
X-Google-Sender-Auth: pUW8GcfQARe8nbSPsvc5-gYYfhQ
Message-ID: <CAGXu5j+M+MHkxNMSaQ+RqYrty=1Fgur6_duSnL8DAZ_SazeJ7w@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
From:   Kees Cook <keescook@chromium.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40883
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

On Fri, Jun 27, 2014 at 12:55 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/27, Andy Lutomirski wrote:
>>
>> On Fri, Jun 27, 2014 at 12:27 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>> > On 06/27, Kees Cook wrote:
>> >>
>> >> It looks like SMP ARM issues dsb for rmb, which seems a bit expensive.
>> >> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204g/CIHJFGFE.htm
>> >>
>> >> ...
>> >>
>> >> I really want to avoid adding anything to the secure_computing()
>> >> execution path. :(
>> >
>> > I must have missed something but I do not understand your concerns.
>> >
>> > __secure_computing() is not trivial, and we are going to execute the
>> > filters. Do you really think rmb() can add the noticeable difference?
>> >
>> > Not to mention that we can only get here if we take the slow syscall
>> > enter path due to TIF_SECCOMP...
>> >
>>
>> On my box, with my fancy multi-phase seccomp patches, the total
>> seccomp overhead for a very short filter is about 13ns.  Adding a full
>> barrier would add several ns, I think.
>
> I am just curious, does this 13ns overhead include the penalty from the
> slow syscall enter path triggered by TIF_SECCOMP ?
>
>> Admittedly, this is x86, not ARM, so comparisons here are completely
>> bogus.  And that read memory barrier doesn't even need an instruction
>> on x86.  But still, let's try to keep this fast.
>
> Well, I am not going to insist...
>
> But imo it would be better to make it correct in a most simple way, then
> we can optimize this code and see if there is a noticeable difference.
>
> Not only we can change the ordering, we can remove the BUG_ON's and just
> accept the fact the __secure_computing() can race with sys_seccomp() from
> another thread.
>
> If nothing else, it would be much simpler to discuss this patch if it comes
> as a separate change.

Yeah, the way I want to go is to add the rmb() for now (it gets us
"correctness"), and then later deal with any potential performance
problems on ARM at a later time. (At present, I'm unable to perform
any timings on ARM -- maybe next week.)

I will send the v9 series in a moment here...

-Kees

-- 
Kees Cook
Chrome OS Security
