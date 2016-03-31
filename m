Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 10:57:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21606 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025135AbcCaI5k3ihyq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Mar 2016 10:57:40 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6ADDD7E934532;
        Thu, 31 Mar 2016 09:57:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 09:57:33 +0100
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 31 Mar
 2016 09:57:33 +0100
Subject: Re: [PATCH v2 0/6] MIPS seccomp_bpf self test and fixups
To:     Kees Cook <keescook@chromium.org>
References: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
 <CAGXu5jLJEHzB3ST63g0fApVP4-OWwCT5UcqguAMNoGy-aQXgew@mail.gmail.com>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        "Eric B Munson" <emunson@akamai.com>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Will Drewry <wad@chromium.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <56FCE67D.70800@imgtec.com>
Date:   Thu, 31 Mar 2016 09:57:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLJEHzB3ST63g0fApVP4-OWwCT5UcqguAMNoGy-aQXgew@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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



On 30/03/16 06:06, Kees Cook wrote:
> On Tue, Mar 29, 2016 at 1:35 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>> These patches imporve seccomp support on MIPS.
>>
>> Firstly support is added for building the seccomp_bpf self test for
>> MIPS. The
>> initial results of these tests were:
>>
>> 32bit kernel O32 userspace before: 48 / 48 pass
>> 64bit kernel O32 userspace before: 47 / 48 pass
>>   Failures: TRAP.Handler
>> 64bit kernel N32 userspace before: 44 / 48 pass
>>   Failures: global.mode_strict_support, TRAP.handler,
>> TRACE_syscall.syscall_redirected, TRACE_syscall.syscall_dropped
>> 64bit kernel N64 userspace before: 46 / 48 pass
>>   Failures: TRACE_syscall.syscall_redirected,
>> TRACE_syscall.syscall_dropped
>>
>> The subsequent patches fix issues that were causing the above tests to
>> fail. With
>> these fixes, the results are:
>> 32bit kernel O32 userspace after: 48 / 48
>> 64bit kernel O32 userspace after: 48 / 48
>> 64bit kernel N32 userspace after: 48 / 48
>> 64bit kernel N64 userspace after: 48 / 48
>>
>> Thanks,
>> Matt
>>
>> Changes in v2:
>> - Tested on additional platforms
>> - Replace __NR_syscall which isn't defined for N32 / N64 ABIs
>>
>> Matt Redfearn (6):
>>    selftests/seccomp: add MIPS self-test support
>>    MIPS: Support sending SIG_SYS to 32bit userspace from 64bit kernel
>>    MIPS: scall: Handle seccomp filters which redirect syscalls
>>    seccomp: Get compat syscalls from asm-generic header
>>    MIPS: seccomp: Support compat with both O32 and N32
>>    secomp: Constify mode1 syscall whitelist
>>
>>   arch/mips/include/asm/seccomp.h               | 47 +++++++++++++++------------
>>   arch/mips/kernel/scall32-o32.S                | 11 +++----
>>   arch/mips/kernel/scall64-64.S                 |  3 +-
>>   arch/mips/kernel/scall64-n32.S                | 14 +++++---
>>   arch/mips/kernel/scall64-o32.S                | 14 +++++---
>>   arch/mips/kernel/signal32.c                   |  6 ++++
>>   include/asm-generic/seccomp.h                 | 14 ++++++++
>>   kernel/seccomp.c                              | 13 ++------
>>   tools/testing/selftests/seccomp/seccomp_bpf.c | 30 +++++++++++++++--
>>   9 files changed, 101 insertions(+), 51 deletions(-)
> Thanks for digging into this! Consider all the seccomp pieces:
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> Probably best to carry it all in the MIPS tree, but if you want to me
> take pieces of it into my seccomp tree, I can do that. Up to you. :)
>
> -Kees
>
Thanks Kees. Ralf is going to take it via the MIPS tree.

Matt
