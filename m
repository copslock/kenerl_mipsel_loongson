Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 05:41:09 +0100 (BST)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:58575 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8226113AbVGAEks>; Fri, 1 Jul 2005 05:40:48 +0100
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (sccrmhc11) with ESMTP
          id <2005070104403001100lsrpfe>; Fri, 1 Jul 2005 04:40:30 +0000
Message-ID: <42C4CA23.7080301@gentoo.org>
Date:	Fri, 01 Jul 2005 00:44:19 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
References: <20050630173409Z8226102-3678+735@linux-mips.org> <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org> <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org>
In-Reply-To: <20050701035105.GA9601@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
> I don't think glibc 2.3.5 worked for mips64.  But I haven't checked it
> in a long time.  Try CVS HEAD of glibc instead.
> 
> Other than that, you're on your own - building glibc is extremely error
> prone.
> 

I'm thiking this is more a possible oddity/bug in the kernel.  It may be glibc 
related, but I'm no concrete interpreter of strace output.

That said, I tried geoman's conftest.c snippet in an o32/glibc userland, 
n32/glibc userland, and o32/uclibc userland just to see if there was any difference.

The commonalities between all three was something is happening with 
rt_siguspend/sys32_rt_siguspend.  In o32/glibc and o32/uclibc, calls to 
rt_sigsuspend returned EINTR (interrupted system call).  o32 itself generates a 
silent SIGBUS (only seen in strace output.  o32/uclibc seems to complete 
(reaches exit(0)), but its rt_sigsuspend calls were also returning EINTR. 
n32/glibc was the one that generates the Oops message (w/o locking the system up).

The only differences was that o32/glibc and n32/glibc both SIGBUS/SIGSEG, while 
o32/uclibc seems to complete.  This could point to a glibc problem.

Below is the snipped output from strace and ksymoops on n32 (cause strace 
doesn't seem to work in n32 yet):

o32/glibc:
clone(child_stack=0x10003010, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND) 
= 9954
write(4, "*\260b \0\0\0\5\0\0\0\0*\257\352H*\253\3H*\253\200\0\4"..., 148) = 148
rt_sigprocmask(SIG_SETMASK, NULL, [32], 16) = 0
write(4, "*\265\20\200\0\0\0\0\0\0\0\0\0@\10\240\0\0\0\0\200\0\0"..., 148) = 148
rt_sigprocmask(SIG_SETMASK, NULL, [32], 16) = 0
rt_siguspend([] <unfinished ...>
--- SIGRT_0 (Unknown signal 32) @ 0 (0) ---
<... rt_siguspend resumed> )            = -1 EINTR (Interrupted system call)
sigreturn()                             = ? (mask now ~[HUP INT QUIT ILL IOT 
KILL BUS ALRM TERM USR1 CHLD PWR URG IO CONT TTOU PROF XFSZ 32 33 34 35 37 38 39 
40 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 
68 74 77 78 79 80 81 83 84 85 86 87 88 89 90 91 92 94 95 96 99 100 101 105 108 
110 112 114 115 116 117 118 119 120 121 122 123 124 125 126])
--- SIGBUS (Bus error) @ 0 (0) ---
+++ killed by SIGBUS +++


n32/glibc:
 >>$31; a80000002001abc4 <do_signal32+1f4/298>

 >>PC;  00000000 Before first symbol

Trace; a80000002001ade8 <_sys32_rt_sigsuspend+180/1a8>
Trace; a80000002001e7f4 <handle_sysn32+54/a0>
Trace; a80000002001e7f4 <handle_sysn32+54/a0>


o32/uclibc:
clone(child_stack=0x100030c0, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND) 
= 10004
write(4, "\0\0\0\0\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 148) = 148
rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 16) = 0
write(4, "*\263\363\300\0\0\0\0\0\0\0\0\0@\0070\0\0\0\0\200\0\0\0"..., 148) = 148
rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 16) = 0
rt_siguspend([] <unfinished ...>
--- SIGRT_0 (Unknown signal 32) @ 0 (0) ---
<... rt_siguspend resumed> )            = -1 EINTR (Interrupted system call)
sigreturn()                             = ? (mask now [TRAP IOT FPE BUS PIPE 
CHLD PROF RT_1 RT_3 RT_4 RT_5 RT_6 RT_7 RT_9 RT_10 RT_68 RT_69 RT_71 RT_72 RT_73])
rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 16) = 0
rt_siguspend([] <unfinished ...>
--- SIGRT_0 (Unknown signal 32) @ 0 (0) ---
<... rt_siguspend resumed> )            = -1 EINTR (Interrupted system call)
sigreturn()                             = ? (mask now [TRAP IOT FPE BUS PIPE 
CHLD PROF RT_1 RT_3 RT_4 RT_5 RT_6 RT_7 RT_9 RT_10 RT_68 RT_69 RT_71 RT_72 RT_73])
write(4, "*\263\363\300\0\0\0\1\0\0\4\2\0@\0070\0\0\0\0\200\0\0\0"..., 148) = 148
write(4, "*\263\363\300\0\0\0\2\0\0\0\0*\2571T*\257iT*\257i\10\0"..., 148) = 148
rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 16) = 0
rt_siguspend([] <unfinished ...>
--- SIGRT_0 (Unknown signal 32) @ 0 (0) ---
<... rt_siguspend resumed> )            = -1 EINTR (Interrupted system call)
sigreturn()                             = ? (mask now [TRAP IOT FPE BUS PIPE 
CHLD PROF RT_1 RT_3 RT_4 RT_5 RT_6 RT_7 RT_9 RT_10 RT_68 RT_69 RT_71 RT_72 RT_73])
wait4(10004, NULL, __WCLONE, NULL)      = 10004
exit(0)                                 = ?


Thoughts?


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
