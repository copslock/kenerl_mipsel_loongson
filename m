Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2002 15:35:27 +0100 (CET)
Received: from p508B591D.dip.t-dialin.net ([80.139.89.29]:21941 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122123AbSKUOf0>; Thu, 21 Nov 2002 15:35:26 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gALEZ1t27567;
	Thu, 21 Nov 2002 15:35:01 +0100
Date: Thu, 21 Nov 2002 15:35:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mysterious page fault in _syscall3..
Message-ID: <20021121153501.B26919@linux-mips.org>
References: <20021121133307.10571.qmail@webmail35.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021121133307.10571.qmail@webmail35.rediffmail.com>; from atulsrivastava9@rediffmail.com on Thu, Nov 21, 2002 at 01:33:07PM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 21, 2002 at 01:33:07PM -0000, atul srivastava wrote:

> 2.but immediately after sys_execve returns the value, i get a 
> sudden page fault producing a imposible register dump ( epc status 
> and cause all zero)

Check the cache and TLB code for your architecture.  Read it 10 times if
necessary because bugs in that code can have extremly subtle effects.

> though i haven't read fully the gcc info page and acquanited with 
> nasty  asm code of _syscall3 in unistd.h , but does execve enters 
> sys_execve directly by macro expansion in _syscall3 ..or there are 
> relevant steps in between.?

I recommend to not use the _syscall macros in userspace _at_all.  They've
been written for use by kernelspace; getting them bullet proof for
userspace as well has been a big pain over the years.  I know, you're
doing this for testing only but even then you're not safe ...

In general the use of all kernel header files for userspace applications
is a dangerous idea ...

> what kind of problem i am facing ?
> is this problem with saving & restoring , corruption
> or in _syscall3..?

_syscallX() is pure userspace stuff.  Any bugs in that area should only
result in your process but not the entire system crashing.

> any possibility of write buffer and pipeline hazard..?

Write buffer stuff is only relevant for dealing with external agents that
is SMP or I/O which doesn't seem related to your case.

Double check the cache code for your CPU.  There are lots of creative
implementations of caches out there that need special treatment in the
kernel.

(That was the political correct version of speaking about those cache
designs.  My prefered wording about this issue can't be posted in any
public forum ;-)

> I have tried with interrupts disabled in sys_execve just for 
> checking prupose..
> would taking support of BDI2000 kind of debuggers will be 
> helpful?

The Linux/MIPS kernel has been ported and debugged entirely using printk
and even more important by just look at the source.

  Ralf
