Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2003 10:30:23 +0100 (BST)
Received: from wiprom2mx1.wipro.com ([IPv6:::ffff:203.197.164.41]:58621 "EHLO
	wiprom2mx1.wipro.com") by linux-mips.org with ESMTP
	id <S8225072AbTGYJaV>; Fri, 25 Jul 2003 10:30:21 +0100
Received: from m2vwall5.wipro.com (m2vwall5.wipro.com [10.115.50.5])
	by wiprom2mx1.wipro.com (8.12.9/8.12.9) with SMTP id h6P9PjxX000399
	for <linux-mips@linux-mips.org>; Fri, 25 Jul 2003 14:56:04 +0530 (IST)
Received: from blr-m3-msg.wipro.com ([10.114.50.99]) by blr-m1-bh2.wipro.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Fri, 25 Jul 2003 14:55:44 +0530
Received: from wipro.com ([10.114.5.253]) by blr-m3-msg.wipro.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Fri, 25 Jul 2003 14:55:42 +0530
Message-ID: <3F20F795.464D14EB@wipro.com>
Date: Fri, 25 Jul 2003 14:55:41 +0530
From: Rahul Pande <rahul.pande@wipro.com>
Reply-To: rahul.pande@wipro.com
Organization: WIPRO
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: MIPS <linux-mips@linux-mips.org>
Subject: pthread issues
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jul 2003 09:25:42.0110 (UTC) FILETIME=[B7ECF7E0:01C3528E]
Return-Path: <rahul.pande@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rahul.pande@wipro.com
Precedence: bulk
X-list: linux-mips

Hi,

    I am trying to run a pthread based application on the AMD au1500
mips processor for linux version 2.4.21pre. The pthread_create function
does not return, i am attaching the strace of the process, where
pthread_create() is the call after the write statement "Creating a
thread". The thread seems to go into a sigsuspend mode after doing a
clone() and it never seems to return from there and so the thread
creation operation does not complete.

    Are there any patches that i need to apply or Are there any specific
define flags to be enabled for compilation. Please let me know if i can
run thread applications on mips.

Thanks and Regards,
          rahul





write(1, "Creating a thread\n", 18Creating a thread
)     = 18
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) =
0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) =
0
brk(0x10003000)                         = 0x10003000
pipe([721840640, 4230684])              = 4
clone(child_stack=0x100027a8,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND)
 = 385
[pid   384] write(5, "\200\373\363*\5\0\0\0\0\0\0\0\377\377\377\377
y\377\177"..
., 148 <unfinished ...>
[pid   385] rt_sigprocmask(SIG_SETMASK, ~[TRAP 33],  <unfinished ...>
[pid   384] <... write resumed> )       = 148
[pid   385] <... rt_sigprocmask resumed> NULL, 16) = 0
[pid   384] rt_sigprocmask(SIG_SETMASK, NULL,  <unfinished ...>
[pid   385] read(4,  <unfinished ...>
[pid   384] <... rt_sigprocmask resumed> [32], 16) = 0
[pid   385] <... read resumed>
"\200\373\363*\5\0\0\0\0\0\0\0\377\377\377\377 y\
377\177"..., 148) = 148
[pid   384] write(5,
"\300\235\272*\0\0\0\0\0\0\0\0\244|\265*\260\345\300*\0"...
, 148 <unfinished ...>
[pid   385] poll( <unfinished ...>
[pid   384] <... write resumed> )       = 148
[pid   385] <... poll resumed> [{fd=4, events=POLLIN, revents=POLLIN}],
1, 2000)
 = 1
[pid   384] rt_sigprocmask(SIG_SETMASK, NULL,  <unfinished ...>
[pid   385] getppid( <unfinished ...>
[pid   384] <... rt_sigprocmask resumed> [32], 16) = 0
[pid   385] <... getppid resumed> )     = 384
[pid   384] sigsuspend(~[HUP INT QUIT TRAP IOT EMT FPE KILL SEGV USR1]
<unfinish
ed ...>
[pid   385] read(4,
"\300\235\272*\0\0\0\0\0\0\0\0\244|\265*\260\345\300*\0"...,
 148) = 148
[pid   385] old_mmap(0x7f600000, 2097152,
PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PR
IVATE|MAP_ANONYMOUS, -1, 0) = 0x7f600000
[pid   385] mprotect(0x7f600000, 4096, PROT_NONE) = 0
[pid   385] clone(child_stack=0x7f7ffbe0,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CL
ONE_SIGHAND|0x21) = 386
[pid   386] getpid()                    = 386
[pid   386] rt_sigprocmask(SIG_SETMASK, [32], NULL, 16) = 0
[pid   386] rt_sigprocmask(SIG_SETMASK, NULL, [32], 16) = 0
[pid   386] sigsuspend(~[HUP INT QUIT ILL IOT BUS SEGV TSTP] <unfinished
...>
[pid   385] kill(383, SIGRT_0)          = -1 ESRCH (No such process)
[pid   385] poll([{fd=4, events=POLLIN}], 1, 2000) = 0
[pid   385] getppid()                   = 384
[pid   385] poll( <unfinished ...>
