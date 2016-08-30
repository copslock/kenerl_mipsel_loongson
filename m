Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 10:14:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50786 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990451AbcH3IOvovpqe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 10:14:51 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BCE0FFF2845AB;
        Tue, 30 Aug 2016 09:14:32 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 09:14:34 +0100
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers per
 syscall
To:     Andy Lutomirski <luto@amacapital.net>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
 <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
CC:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com>
Date:   Tue, 30 Aug 2016 10:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54837
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



On 30.08.2016 01:55, Andy Lutomirski wrote:
> On Aug 29, 2016 11:30 AM, "Marcin Nowakowski"
> <marcin.nowakowski@imgtec.com> wrote:
>>
>> Syscall metadata makes an assumption that only a single syscall number
>> corresponds to a given method. This is true for most archs, but
>> can break tracing otherwise.
>>
>> For MIPS platforms, depending on the choice of supported ABIs, up to 3
>> system call numbers can correspond to the same call - depending on which
>> ABI the userspace app uses.
>
> MIPS isn't special here.  x86 does the same thing.  Why isn't this a
> problem on x86?
>

Hi Andy,

My understanding is that MIPS is quite different to what most other 
architectures do ...
First of all x86 disables tracing of compat syscalls as that didn't work 
properly because of wrong mapping of syscall numbers to syscalls:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=f431b634f

Moreover, when trace_syscalls is initialised, the syscall metadata is 
updated to include the right syscall numbers. That uses 
arch_syscall_addr method, which has a default implementation in 
kernel/trace/trace_syscalls.c:

unsigned long __init __weak arch_syscall_addr(int nr)
{
         return (unsigned long)sys_call_table[nr];
}

that works for x86 and only uses 'native' syscalls, ie. for x86_64 will 
not map any of the ia32_sys_call_table entries. So on one hand we have 
the code that disables tracing for x86_64 compat, on the other we only 
ensure that the native calls are mapped.
It is quite different for MIPS where syscall numbers for different ABIs 
have distinct call numbers, so the following code maps the syscalls
(for O32 -> 4xxx, N64 -> 5xxx, N32 -> 6xxx):

unsigned long __init arch_syscall_addr(int nr)
{
         if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + 
__NR_N32_Linux_syscalls)
                 return (unsigned long)sysn32_call_table[nr - 
__NR_N32_Linux];
         if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + 
__NR_64_Linux_syscalls)
                 return (unsigned long)sys_call_table[nr - __NR_64_Linux];
         if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + 
__NR_O32_Linux_syscalls)
                 return (unsigned long)sys32_call_table[nr - 
__NR_O32_Linux];
         return (unsigned long) &sys_ni_syscall;
}

As a result when init_ftrace_syscalls() loops through all the possible 
syscall numbers,  it first finds an O32 implementation, then N64 and 
finally N32. As the current code doesn't expect multiple references to a 
given syscall number, it always overrides the metadata with the last 
found - as a result only N32 syscalls are mapped.
This is generally unexpected and wrong behaviour, and to makes things 
worse - since when N32 support is enabled, it overwrites N64 entries, it 
becomes impossible to trace native syscalls.

 > Also, you seem to be partially reinventing AUDIT_ARCH here.  Can you
 > use that and integrate with syscall_get_arch()?

Please correct me if I don't understand what you meant here, but I don't 
see how these can be integrated ...
For MIPS syscall_get_arch() properly determines arch type and calling 
convention, but that information is not enough to determine what call 
was made and how to map it to syscall metadata from another calling 
convention.

Marcin
