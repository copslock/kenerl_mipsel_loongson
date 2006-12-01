Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 23:22:34 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:35150 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S28573770AbWLAXW3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2006 23:22:29 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Trouble with System V IPC on n32.
Date:	Fri, 1 Dec 2006 15:22:19 -0800
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D4B5F37@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Trouble with System V IPC on n32.
Thread-Index: AccVn4woxnreGnt4Qeu5SryUvIlOVg==
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Hey everyone,

I'm investigating why shmat() isn't working for me. I'm running glibc
2.5 with glibc-ports 2.5, n32 ABI, on a 2.6.17.7 kernel.

What happens is that the underlying do_shmat() works, but then
ultimately, the glibc function fails, and errno is EFAULT.

I suspect that something is screwing up above do_shmat() related to 32
versus 64 bit issues.

The thing is, that glibc uses the sys_ipc dispatcher system call to call
shmat and other functions. On MIPS, this is only defined in the o32
system call table. 

The dispatch opcode for the shmat service uses a
pointer-to-user-space-pointer argument, but it doesn't look like the
implementation of sys_ipc has no corresponding compat_sys_ipc flavor
which understands that.

I don't even know where glibc is getting the __NR_ number for the
sys_ipc call, since it should not be visible from the <asm/unistd.h>
kernel header if the O32 ABI isn't being used, but it might just be
defining it for itself. (Glibc tends to do stupid things like that:
#ifndef __NR_some_syscall ... #define __NR_some_syscall <wild-ass-guess>
... #endif).

So I have an unconfirmed suspicion that the n32 glibc might actually be
landing into the o32 sys_ipc (a suspiction which I'm about to test right
away).

Would it be reasonable to write a compat_sys_ipc, and wire that into the
n32 system call table, or am I barking up the wrong tree?  Also wouldn't
the o32 syscall table need such a compat_sys_ipc also? If o32 user space
makes calls to a 64 bit sys_ipc, I don't see how some of those calls can
work. 

I'd be in favor of just making a single do_ipc function which takes an
extra parameter that indicates whether the client is 32 or 64. The
sys_ipc and compat_sys_ipc can just be stub wrappers which call that one
with the correct value of that parameter. Then those cases in sys_ipc
which are sensitive to 32/64 issues can implement variation based on
that flag, all at the cost of a few cycles.

I don't feel like fixing glibc to avoid using the IPC dispatcher. Mainly
because the glibc code is harder to work with, and I would want this to
be right. I.e. adding the right files under the right sysdeps/* etc.
