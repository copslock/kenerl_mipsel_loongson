Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 01:09:37 +0200 (CEST)
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35019 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991859AbcH3XJbWzVeh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 01:09:31 +0200
Received: by mail-ua0-f169.google.com with SMTP id i32so59537715uai.2
        for <linux-mips@linux-mips.org>; Tue, 30 Aug 2016 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6ZsFUC6pekcg+rLk1+mR0cHL5pM+4JIqUHvXEgLjGSM=;
        b=IdylhruGnzetv317A8Y2MDHVRb12J0+pi1Hctmo+RjV/Bum/4W/nqQmdsTCYDor7UN
         A6mVvphi7ELSBN2e4bkIQmu7YcoBLPpkfsbwl3lJdk+hc0erFoDDwgll2d2XumcOW9jz
         pi8jUbsIHP7vvrkAX1/RWStx3C/guhkT6F6A+76dn4yzl3s4GDh+SRQA3oCnaFzG2Tmn
         HjT2eb6uyaZvhJD2Ev1ehy9weoM4ASNg/qP55J7SDI6sY/8++zOZpMLSkZkv4GvPgEZM
         RCnD3BWc6ksAhQq+eCkCQzw4nst+jksREwM1y54nx8iB4jdrXAQpDcsueuoK3Pr986PI
         ICJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6ZsFUC6pekcg+rLk1+mR0cHL5pM+4JIqUHvXEgLjGSM=;
        b=Z5dz3DWyNcWdxOaXXy1bn/HZRVV4csIzGEC6f20zCYbplJAlg84yZlFcQSnN01YNwE
         4YRpgxuhTS95dodjWqGpwyDUpO3fNhxn/DubsAK1DUZq114f7hsqgE65rXvRr2Ki9LXY
         KphQS4Dnw3VJrvYuy6zHd729GsdVrpqwgzKY9CPM9CAybabm33FCEFSp+bK9IHzx2n3N
         H+nEk9TxmPIlppvZUGsMkxVcC2g1eIx3v6kbfXygSReaZ3YcdELJnMieba1xGdhXX+WA
         l6ATk2n+uDxNHKfmJLDuBwNkbXJzyoRzxgy6MQ/oKpCLcihrDyO3MvPoXKl0wfTgziQa
         um2w==
X-Gm-Message-State: AE9vXwPJ9O7hdwdd+DuSLstWOttQ78DjMK65BC4iDJ0hl7U2W/EWfhiv2ZQo6DLjaLrpe7HTLWbNuas5BG3W/pXP
X-Received: by 10.31.14.212 with SMTP id 203mr3251491vko.137.1472598565267;
 Tue, 30 Aug 2016 16:09:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.76.146 with HTTP; Tue, 30 Aug 2016 16:09:04 -0700 (PDT)
In-Reply-To: <20160830183030.3e9f67f0@gandalf.local.home>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
 <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
 <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com> <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
 <20160830152955.17633511@gandalf.local.home> <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
 <20160830165830.5e494c43@gandalf.local.home> <CALCETrW_bnmqBRp3qWoaWUu=m7Bi19VcH9kMBifyL06JuGGVzg@mail.gmail.com>
 <20160830180328.4e579db3@gandalf.local.home> <CALCETrWjpcKqFHvxS35Csd3An1QNMXW8yiHChuWfuWTvVu8_ig@mail.gmail.com>
 <20160830183030.3e9f67f0@gandalf.local.home>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 30 Aug 2016 16:09:04 -0700
Message-ID: <CALCETrWx+1Pdob8mU_X1hOWPWqj31ihVL3Z1R0PqjVeExZ_HAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers per syscall
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54876
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

On Tue, Aug 30, 2016 at 3:30 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 30 Aug 2016 15:08:19 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>> On Tue, Aug 30, 2016 at 3:03 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Tue, 30 Aug 2016 14:45:05 -0700
>> > Andy Lutomirski <luto@amacapital.net> wrote:
>> >
>> >> I wonder: could more of it be dynamically allocated?  I.e. statically
>> >> generate metadata with args and name and whatever but without any nr.
>> >> Then dynamically allocate the map from nr to metadata?
>> >
>> > Any ideas on how to do that?
>>
>> This might be as simple as dropping the syscall_nr field from
>> syscall_metadata.  I admit I'm not familiar with this code at all, but
>> I'm not really sure why that field is needed.  init_ftrace_syscalls is
>> already dynamically allocating an array that maps nr to metadata, and
>> I don't see what in the code actually needs that mapping to be
>> one-to-one or needs the reverse mapping.
>
> The issue is that the syscall trace points are called by a single
> location, that passes in the syscall_nr, and we need a way to map that
> syscall_nr to the metadata.
>
> System calls are really a meta tracepoint. They share a single real
> tracepoint called raw_syscalls:sys_enter and raw_syscalls:sys_exit.
> When you enable a system call like sys_enter_read, what really happens
> is that the sys_enter tracepoint is attached with a function called
> ftrace_syscall_enter().
>
> This calls trace_get_syscall_nr(current, regs), to extract the actual
> syscall_nr that was called. This is used to find the "file" that is
> mapped to the system call (the tracefs file that enabled the system
> call).
>
>         trace_file = tr->enter_syscall_files[syscall_nr];
>
> And the meta data (what is used to tell us what to save) is found with
> the syscall_nr_to_meta() function.
>
> Now the metadata is used to extract the arguments of the system call:
>
>  syscall_get_arguments(current, regs, 0, sys_data->nb_args,
>         etnry->args);
>
> As well as the size needed.
>
> There's no need to map syscall meta to nr, we need a way to map the nr
> to the syscall metadata, and when there's more than a one to one
> mapping, we need a way to differentiate that in the raw syscall
> tracepoints.

But none of this should be a problem at all for MIPS, right?  AFAICT
the only problem for MIPS is that there *is* a mapping from metadata
to nr.  If that mapping got removed, MIPS should just work, right?

For x86 compat, I think that adding arch should be sufficient.
Specifically, rather than having just one enter_syscall_files array,
have one per audit arch.  Then call syscall_get_arch() as well as
syscall_get_nr() and use both to lookup the metadata.  AFAIK this
should work on all architectures, although you might need some arch
helpers to enumerate all the arches and their respective syscall
tables (and max syscall nrs).

--Andy
