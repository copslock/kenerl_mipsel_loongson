Received:  by oss.sgi.com id <S553987AbRAYTAT>;
	Thu, 25 Jan 2001 11:00:19 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:58363 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553984AbRAYS74>;
	Thu, 25 Jan 2001 10:59:56 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0PIugI19148;
	Thu, 25 Jan 2001 10:56:42 -0800
Message-ID: <3A70777B.F86123A5@mvista.com>
Date:   Thu, 25 Jan 2001 10:59:07 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Florian Lohoff <flo@rfc822.org>
CC:     linux-mips@oss.sgi.com
Subject: Re: OOps - very obscure
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org> <20010125134331.A11489@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Florian,

What is the kernel version?  Your symptom seems to remind me the corrupted s0
bug in several syscalls. The bug is fixed around test9 I believe.  Check for
"save_static_function(sys_sigsuspend);" statement in arch/mips/kernel/signal.c
file.  If you have it, then you don't have the bug.


Jun

Florian Lohoff wrote:
> 
> On Wed, Jan 24, 2001 at 04:59:19PM +0100, Florian Lohoff wrote:
> 
> > Decoded this is:
> 
> > >>RA;  00000000 Before first symbol
> > >>PC;  00000000 Before first symbol
> > Trace; 88028344 <sys_nanosleep+190/24c>
> > Trace; 8800fa88 <stack_done+1c/38>
> 
> I am trying to track this down a bit more:
> 
> with strace (very old version)
> 
> rt_sigaction(34, {SIG_DFL}, NULL, 16)   = 0
> rt_sigprocmask(SIG_BLOCK, [], NULL, 16) = 0
> sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
> sched_yield(0x7d1, 0x2ac95d24, 0x1, 0, 0x2acfad50) = 0
> sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
> sched_yield(0x7d1, 0x2ac95d24, 0x1, 0, 0x2acfad50) = 0
> sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
> sched_yield(0x7d1, 0x2ac95d24, 0x1, 0, 0x2acfad50) = 0
> sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
> sched_yield(0x7d1, 0x2ac95d24, 0x1, 0, 0x2acfad50) = 0
> sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149
> [... repeated this 2 lines ...]
> 
> Every 1000 lines or something:
> 
> nanosleep({0, 2000001}, NULL)           = 0
> 
> But with strace it doesnt crash it seems at least not within 10 Minutes
> i let it run ...
> 
> Flo
> --
> Florian Lohoff                  flo@rfc822.org             +49-5201-669912
>      Why is it called "common sense" when nobody seems to have any?
