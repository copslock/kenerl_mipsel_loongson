Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 12:22:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19404 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860088AbaGRKWoZRyEI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 12:22:44 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C5A2D679AFEB1;
        Fri, 18 Jul 2014 11:22:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 18 Jul 2014 11:22:37 +0100
Received: from [192.168.154.109] (192.168.154.109) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 18 Jul
 2014 11:22:36 +0100
Message-ID: <53C8F56C.5070706@imgtec.com>
Date:   Fri, 18 Jul 2014 11:22:36 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Kees Cook <keescook@chromium.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: MIPS seccomp and changing syscalls
References: <CAGXu5jJJ7dqC-or=ZhKKj8=eA5itKX4aLRsnxmFZvwnyRcrUrw@mail.gmail.com>
In-Reply-To: <CAGXu5jJJ7dqC-or=ZhKKj8=eA5itKX4aLRsnxmFZvwnyRcrUrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.109]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

Hi Kees,

On 07/17/2014 11:29 PM, Kees Cook wrote:
> Hi,
> 
> I recently fixed a bug in seccomp on ARM that I think may be present
> in the MIPS implementation too. In arch/mips/kernel/ptrace.c
> syscall_trace_enter, the syscall variable is used (and returned), but
> the syscall may be changed by either secure_computing or
> tracehook_report_syscall_entry (via ptracers which can block and
> change the registers). (I would note that "ret" is also set but never
> used, so tracehook_report_syscall_entry failures actually won't get
> noticed.)
> 
> The discussion about this bug on ARM is here:
> https://lkml.org/lkml/2014/6/20/439

Thanks for letting us know.
Right, I believe MIPS will have the same problem and a similar patch to
Will Deacon's one will fix it properly. Would you like to submit one for
MIPS too? Otherwise I can do it myself.

> 
> I don't yet have a working MIPS environment to test this on, but it
> feels like the same bug. (Though, for testing, what's the right way to
> change syscall during PTRACE_SYSCALL? On x86 it's the orig_ax
> register, on ARM it's a arch-specific ptrace function
> (PTRACE_SET_SYSCALL).

For MIPS, the syscall numbers is in the v0 register ($2). But the o32
ABI also has the syscall() system call. So in case of indirect system
calls, the real system call is the first argument of syscall(), which is
register a0 ($4). See syscall_get_nr in arch/mips/include/asm/syscall.h

-- 
markos
