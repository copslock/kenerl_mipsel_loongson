Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 09:00:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55114 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991957AbcHaHATDJ0me (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 09:00:19 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CC78531A78E7B;
        Wed, 31 Aug 2016 08:00:00 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 31 Aug
 2016 08:00:02 +0100
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers per
 syscall
To:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
 <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
 <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com>
 <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
 <20160830152955.17633511@gandalf.local.home>
 <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
 <20160830165830.5e494c43@gandalf.local.home>
 <CALCETrW_bnmqBRp3qWoaWUu=m7Bi19VcH9kMBifyL06JuGGVzg@mail.gmail.com>
 <20160830180328.4e579db3@gandalf.local.home>
 <CALCETrWjpcKqFHvxS35Csd3An1QNMXW8yiHChuWfuWTvVu8_ig@mail.gmail.com>
 <20160830183030.3e9f67f0@gandalf.local.home>
 <CALCETrWx+1Pdob8mU_X1hOWPWqj31ihVL3Z1R0PqjVeExZ_HAA@mail.gmail.com>
 <20160830192818.4e16a674@gandalf.local.home>
CC:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <3b84605d-406e-6372-28d1-9b5c83ba70ef@imgtec.com>
Date:   Wed, 31 Aug 2016 09:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160830192818.4e16a674@gandalf.local.home>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

On 31.08.2016 01:28, Steven Rostedt wrote:
> On Tue, 30 Aug 2016 16:09:04 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>> But none of this should be a problem at all for MIPS, right?  AFAICT
>> the only problem for MIPS is that there *is* a mapping from metadata
>> to nr.  If that mapping got removed, MIPS should just work, right?
>
> Wait, where's the mapping of metadata to nr. I don't see that, nor do I
> see a need for that. The issue is that we have metadata that expresses
> how to record a syscall, and we map syscall nr to metadata, because
> when tracing is active, the only thing we have to find that metadata is
> the syscall nr.
>
> Now if a syscall nr has more than one way to record (a single nr for
> multiple syscalls), then we get into trouble. That's why we have
> trouble with compat syscalls. The same number maps to different
> syscalls, and we don't know how to differentiate that.

Generally it looks like the MIPS case is more simple than other arches - 
as the syscall numbers for different ABIs are not overlapping, so when 
trying to get syscall metadata the number is sufficient.
It's just a case that the current code doesn't handle correctly (and 
just to makes things worse, while the compat syscalls are not supported 
at the moment for any arch, because of how the syscalls are numbered, 
tracing for native 64-bit code is currently broken).

But I agree with all the earlier comments that the current solution 
isn't very nice - and even though my patch would solve the issue for 
MIPS, all the existing issues would still remain elsewhere.


>>
>> For x86 compat, I think that adding arch should be sufficient.
>> Specifically, rather than having just one enter_syscall_files array,
>> have one per audit arch.  Then call syscall_get_arch() as well as
>> syscall_get_nr() and use both to lookup the metadata.  AFAIK this
>> should work on all architectures, although you might need some arch
>> helpers to enumerate all the arches and their respective syscall
>> tables (and max syscall nrs).
>
> OK, if the regs can get us to the arch, then this might work.
>
> That is, perhaps we can have multiple tables (not really sure how to
> make that happen in an arch agnostic way), and then have two functions:
>
> trace_get_syscall_nr(current, regs)
> trace_get_syscall_arch(current, regs)
>
> Although, that "arch" may be confusing.
>
> -- Steve
>
