Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 20:06:40 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:60750 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860198AbaG2R4MBX4ox (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 19:56:12 +0200
Received: by mail-lb0-f173.google.com with SMTP id p9so8966lbv.32
        for <linux-mips@linux-mips.org>; Tue, 29 Jul 2014 10:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/YEdEIpYmbL5GSxbp77/Q/U5SJQpmCtwyvnE/c9hMns=;
        b=gdjiH7apseiqNK02MQ98eXOXvoqXg7I7gCSRZPXQ3qJDKGzFz/ObPhy3mD3Q+qFUuD
         1//RdsNU23x9qT00wXtPOjL6urioCT/0ttBy1mxtTZnusPTeWJK8YZt6tkwhqaBd3lLp
         vNsaAv9MqrcrHSQ+ITK5fhv4GvF+GENr5tLiePmjJvVIhTxlLs6g/CxqAj7GrJwaxcPC
         7Mj9+L4OZqIi1WnxXoF5JaetYGHvcvkHGET7y4qh2g0MFVVnClmlxm9iLpBYVYpkhIdF
         3drmUq+wnkGgegkEKwgU6PHeXu3LJcjd4WX1pgt1NsWLMCULQAFJM5KbFGLdmx7DPEu8
         NUSQ==
X-Gm-Message-State: ALoCoQlSAZGRJa4m0GJ0Tn+ylsngCsAKyQDQY9alp7b20gAoQTC1ttF4icJVOWNEIIkbXVbdYFWy
X-Received: by 10.152.29.202 with SMTP id m10mr4309744lah.4.1406656566340;
 Tue, 29 Jul 2014 10:56:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Tue, 29 Jul 2014 10:55:46 -0700 (PDT)
In-Reply-To: <20140729173136.GA2808@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com> <CALCETrWUFo_zXcAZja-vdL4_MgJDd=1ed5Vt54eyUuim930xAw@mail.gmail.com>
 <20140729165416.GA967@redhat.com> <CALCETrWBU-=zqLTCP7B1feZ9J-e4u-Boic+e1EEn1rL-ijeEKg@mail.gmail.com>
 <20140729173136.GA2808@redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 29 Jul 2014 10:55:46 -0700
Message-ID: <CALCETrVP-P+EJ6YJ=CZL_gyA1r8O9eogUNTik7_31_SA+Pj3pg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] x86: Split syscall_trace_enter into two phases
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41793
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

On Tue, Jul 29, 2014 at 10:31 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 07/29, Andy Lutomirski wrote:
>>
>> On Tue, Jul 29, 2014 at 9:54 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> >
>> > Yes, just to trigger the slow path, I guess.
>> >
>> >> I'll update the code to call user_exit iff TIF_NOHZ is
>> >> set.
>> >
>> > Or perhaps it would be better to not add another user of this (strange) flag
>> > and just call user_exit() unconditionally(). But, yes, you need to use
>> > from "work = flags & (_TIF_WORK_SYSCALL_ENTRY & ~TIF_NOHZ)" then.\
>>
>> user_exit looks slow enough to me that a branch to try to avoid it may
>> be worthwhile.  I bet that explicitly checking the flag is
>> actually both faster and clearer.
>
> I don't think so (unless I am confused again), note that user_exit() uses
> jump label. But this doesn't matter. I meant that we should avoid TIF_NOHZ
> if possible because I think it should die somehow (currently I do not know
> how ;). And because it is ugly to check the same condition twice:
>
>         if (work & TIF_NOHZ) {
>                 // user_exit()
>                 if (context_tracking_is_enabled())
>                         context_tracking_user_exit();
>         }
>
> TIF_NOHZ is set if and only if context_tracking_is_enabled() is true.
> So I think that
>
>         work = current_thread_info()->flags & (_TIF_WORK_SYSCALL_ENTRY & ~TIF_NOHZ);
>
>         user_exit();
>
> looks a bit better. But I won't argue.

I don't get it.  context_tracking_is_enabled is global, and TIF_NOHZ
is per-task.  Isn't this stuff determined per-task or per-cpu or
something?

IOW, if one CPU is running something that's very heavily
userspace-oriented and another CPU is doing something syscall- or
sleep-heavy, then shouldn't only the first CPU end up paying the price
of context tracking?

>
>> That's what I did for v4.
>
> I am going to read it today. Not that I think I can help or find something
> wrong.
>
> Oleg.
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
