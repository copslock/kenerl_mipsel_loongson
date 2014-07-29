Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 20:23:01 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:55949 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6838840AbaG2SW5IwaPF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 20:22:57 +0200
Received: by mail-lb0-f177.google.com with SMTP id s7so37811lbd.22
        for <linux-mips@linux-mips.org>; Tue, 29 Jul 2014 11:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=N6ZM/oE4QVUhOBJlbKjazjCoKpNZxf3x8irNVcxf+bI=;
        b=HGeyo8teghhiiSM+xay4lRqM9gW5LQgpuy0Y5FFBE89jdKi17ZhOHFPYjxky/c4IaU
         0H/H9Y+Ml5xy3KeTbr+PYrJ8Jrhfdl3reWxgnaznHYDDmOjoOtrVpggXIjhyAi5hpdHf
         JoXSsg/bw7Lhvo9yfkHGUty6O2gXEZWgcc1Kx1WsFp3icDwWZJEX89asB0eyty1+is+N
         5JUyD0T4jgmDG6cMxxN+axO7oLMzBQF11vpMM8o1hQ7t1CeoILudnf6yrVlhlB2jrG3w
         E5AQbr446W2XYOP6ExjA/T6CcVbDnBaQEU+j2Z/NJPvIpE6eN3sDoDyNEgHXUf+CdBtr
         9dVg==
X-Gm-Message-State: ALoCoQmTDNPimWFDEY0+bcjKSPR9u/MRDVki2UWtP9+ZNpSJ7cHAlvPMEOneoBiAZg4uNCmR5F9A
X-Received: by 10.152.179.137 with SMTP id dg9mr4342696lac.11.1406658171427;
 Tue, 29 Jul 2014 11:22:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Tue, 29 Jul 2014 11:22:31 -0700 (PDT)
In-Reply-To: <20140729181615.GA4950@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com> <CALCETrWUFo_zXcAZja-vdL4_MgJDd=1ed5Vt54eyUuim930xAw@mail.gmail.com>
 <20140729165416.GA967@redhat.com> <CALCETrWBU-=zqLTCP7B1feZ9J-e4u-Boic+e1EEn1rL-ijeEKg@mail.gmail.com>
 <20140729173136.GA2808@redhat.com> <CALCETrVP-P+EJ6YJ=CZL_gyA1r8O9eogUNTik7_31_SA+Pj3pg@mail.gmail.com>
 <20140729181615.GA4950@redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 29 Jul 2014 11:22:31 -0700
Message-ID: <CALCETrVWOOs3HCnQNaqmnn480oQYn3scrWUfR4JJX9+zTxUDRw@mail.gmail.com>
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
X-archive-position: 41796
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

On Tue, Jul 29, 2014 at 11:16 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 07/29, Andy Lutomirski wrote:
>>
>> On Tue, Jul 29, 2014 at 10:31 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> >
>> > I don't think so (unless I am confused again), note that user_exit() uses
>> > jump label. But this doesn't matter. I meant that we should avoid TIF_NOHZ
>> > if possible because I think it should die somehow (currently I do not know
>> > how ;). And because it is ugly to check the same condition twice:
>> >
>> >         if (work & TIF_NOHZ) {
>> >                 // user_exit()
>> >                 if (context_tracking_is_enabled())
>> >                         context_tracking_user_exit();
>> >         }
>> >
>> > TIF_NOHZ is set if and only if context_tracking_is_enabled() is true.
>> > So I think that
>> >
>> >         work = current_thread_info()->flags & (_TIF_WORK_SYSCALL_ENTRY & ~TIF_NOHZ);
>> >
>> >         user_exit();
>> >
>> > looks a bit better. But I won't argue.
>>
>> I don't get it.
>
> Don't worry, you are not alone.
>
>> context_tracking_is_enabled is global, and TIF_NOHZ
>> is per-task.  Isn't this stuff determined per-task or per-cpu or
>> something?
>>
>> IOW, if one CPU is running something that's very heavily
>> userspace-oriented and another CPU is doing something syscall- or
>> sleep-heavy, then shouldn't only the first CPU end up paying the price
>> of context tracking?
>
> Please see another email I sent to Frederic.
>

I'll add at least this argument in favor of my approach: if context
tracking works at all, then it had better not demand that syscall
entry call user_exit if TIF_NOHZ is *not* set.  So adding the
condition ought to be safe, barring dumb bugs in my code.

--Andy

> Oleg.
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
