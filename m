Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2010 18:39:07 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12459 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491087Ab0JTQjE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Oct 2010 18:39:04 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cbf1b470000>; Wed, 20 Oct 2010 09:39:35 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 20 Oct 2010 09:39:20 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 20 Oct 2010 09:39:20 -0700
Message-ID: <4CBF1B1E.6050804@caviumnetworks.com>
Date:   Wed, 20 Oct 2010 09:38:54 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Camm Maguire <camm@maguirefamily.org>
CC:     debian-mips@lists.debian.org,
        Frederick Isaac <freddyisaac@gmail.com>, gcl-devel@gnu.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: recent SIGBUS/SIGSEGV mips kernel bug
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>        <4C93993E.7030008@caviumnetworks.com>   <8762y49k1k.fsf@maguirefamily.org>      <4C93D86D.5090201@caviumnetworks.com>   <87fwx4dwu5.fsf@maguirefamily.org>      <4C97D9A1.7050102@caviumnetworks.com>   <87lj6te9t1.fsf@maguirefamily.org>      <4C9A8BC9.1020605@caviumnetworks.com>   <4C9A9699.6080908@caviumnetworks.com>   <87pqvbs7oa.fsf@maguirefamily.org>      <4CB88D2C.8020900@caviumnetworks.com> <87r5fksxby.fsf_-_@maguirefamily.org>
In-Reply-To: <87r5fksxby.fsf_-_@maguirefamily.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2010 16:39:20.0405 (UTC) FILETIME=[583CB850:01CB7075]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/20/2010 08:22 AM, Camm Maguire wrote:
> Greetings!  Recent mips (aka gabrielli sid) appears to have a new
> SIGBUS/SIGSEGV bug.  Briefly, attempted writes to pages mprotected
> read-only occasionally pass a SIGBUS instead of SIGSEGV to the
> sigaction handler.  In such an instance, the code of the siginfo
> structure is 128, and the fault address is not filled in.  This
> behavior appears to hinge on writing from the floating point registers
> into the protected memory.
>

What processor is it running on?  Specifically does it have hardware 
floating point, or are the floating point instructions being emulated in 
the kernel?

It is conceivable that it is an FPU emulator bug.

David Daney


> strace:
>
> 30717 mprotect(0x2f59000, 4096, PROT_READ|PROT_EXEC) = 0
> 30717 mprotect(0x2f5a000, 745472, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
> 30717 mprotect(0x3010000, 323584, PROT_READ|PROT_EXEC) = 0
> 30717 mprotect(0x305f000, 548864, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
> 30717 mprotect(0x30e5000, 1220608, PROT_READ|PROT_EXEC) = 0
> 30717 mprotect(0x320f000, 53559296, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
> 30717 mprotect(0x6523000, 53739520, PROT_READ|PROT_EXEC) = 0
> 30717 mprotect(0x9863000, 60375040, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
> 30717 mprotect(0x6523000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
> 30717 --- SIGSEGV (Segmentation fault) @ 0 (0) ---  /* good */
> 30717 mprotect(0x31fb000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
> 30717 rt_sigreturn(0xdc5e80)            = -1 EPERM (Operation not permitted)
> 30717 --- SIGSEGV (Segmentation fault) @ 0 (0) ---  /* good */
> 30717 mprotect(0x9862000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
> 30717 rt_sigreturn(0xdc5e80)            = -1 EBADF (Bad file descriptor)
> 30717 --- SIGBUS (Bus error) @ 0 (0) ---  /* bad handler call */
>
> Here are the gdb details:
>
> (gdb) frame 28
> #28 0x004a3e98 in memprotect_handler (sig=10, code=2140765848,
>      scp=0x7f997f18, addr=0xfdb6c0 "\b") at sgbc.c:1687
> 1687	  segmentation_catcher(0);
> (gdb) p faddr
> $1 = 0x0
> (gdb) p/x *((siginfo_t *)code )
> $2 = {si_signo = 0xa, si_code = 0x80, si_errno = 0x0, __pad0 = 0x7f997e98,
>    _sifields = {_pad = {0x0, 0x0, 0x7f997eb4, 0x7f997fd4, 0x2167b80,
>        0x233c5b8, 0xde5e80, 0xbbec80, 0x65f8a80, 0x7f997ed0, 0x4951a8,
>        0xbbec80, 0xffffffff, 0x7f997ee0, 0x495170, 0xbbec80, 0x65f8a48,
>        0x7f997ef0, 0x4951a8, 0xbbec80, 0xffffffff, 0x7f997f00, 0x495170,
>        0xbbec80, 0x31ecc48, 0x7f997f10, 0xfdead4, 0x7f997f18, 0x454ebc},
>      _kill = {si_pid = 0x0, si_uid = 0x0}, _timer = {si_tid = 0x0,
>        si_overrun = 0x0, si_sigval = {sival_int = 0x7f997eb4,
>          sival_ptr = 0x7f997eb4}}, _rt = {si_pid = 0x0, si_uid = 0x0,
>        si_sigval = {sival_int = 0x7f997eb4, sival_ptr = 0x7f997eb4}},
>      _sigchld = {si_pid = 0x0, si_uid = 0x0, si_status = 0x7f997eb4,
>        si_utime = 0x7f997fd4, si_stime = 0x2167b80}, _sigfault = {
>        si_addr = 0x0}, _sigpoll = {si_band = 0x0, si_fd = 0x0}}}
> (gdb) up
> #29<signal handler called>
> (gdb) up
> #30 0x004484e8 in fSaset1 (x=0x29b5930, i=0, val=0x2d8d870) at array.c:231
> 231	      (x->lfa.lfa_self[i]) = Mlf(val);
> (gdb) p/x x->lfa.lfa_self
> $3 = 0x9861ff0
> (gdb) disassemble
>     0x004484d8<+1352>:	lwc1	$f0,12(v1)
>     0x004484dc<+1356>:	move	at,at
>     0x004484e0<+1360>:	lwc1	$f1,8(v1)
>     0x004484e4<+1364>:	move	at,at
> =>  0x004484e8<+1368>:	swc1	$f0,4(v0)
>     0x004484ec<+1372>:	swc1	$f1,0(v0)
> (gdb) i reg v1
> v1: 0x2d8d870
> (gdb) i reg f1
> f1:  0x3fa2056c flt: 1.26579046
> (gdb) i reg f0
> f0:  0x8f1afe4f flt: -7.64176427e-30   dbl: 0.035197632283140316
> (gdb) i reg v0
> v0: 0x9861ff0
>
> How should this be filed?
>
> Take care,
