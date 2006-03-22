Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2006 10:40:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:49067 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133655AbWCVKkh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Mar 2006 10:40:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.5/8.13.4) with ESMTP id k2MAoRkd004493;
	Wed, 22 Mar 2006 10:50:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.5/8.13.5/Submit) id k2MAoQoN004492;
	Wed, 22 Mar 2006 10:50:26 GMT
Date:	Wed, 22 Mar 2006 10:50:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Srinivas Kommu <kommu@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: how to get a process backtrace from kernel gdb?
Message-ID: <20060322105026.GA3129@linux-mips.org>
References: <4420940B.9030605@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4420940B.9030605@hotmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 21, 2006 at 04:02:19PM -0800, Srinivas Kommu wrote:

> I'm running gdb on vmlinux connected to a remote target (2.4 kernel). I 
> have the task_struct address of 'current' and other processes. Is it 
> possible to get a symbolic stack trace of the kernel stack? Where is the 
> kernel stack located? I tried to print (task_struct->reg29)[13]. Is this 
> the PC?

I assume you meant task_struct->reg29)[31] which is the address at which
the process is going to resume execution when it's time has arrived.  But
in most cases this address isn't terribly interesting.  So we have two
cases here:

 o $31 pointing to ret_from_fork
   This is a new born process which will begin it's active life of
   execution on a CPU at ret_from_fork.  This is where the resume function
   will jump to which may well be not the scheduler function.
 o Otherwise:
   The thread is regaining the CPU and the resume() call is going to return
   straight to it's caller, kernel/sched.c:context_switch() which inlined
   into schedule() and what we actually want is schedule's caller, so we
   dig through the scheduler's stack frame.  To make things more
   entertaining the stack frame will change with configuration options and
   compiler used, so we basically have to disassemble the stackframe.

   For get_wchan We repeat that exercise in the cases we one of the other
   scheduler functions may have called schedule() until we reach a
   non-schedule function.  So now we have a pointer that actually points to
   something interesting, a driver or other kernel subsystem.

The whole thing is a bit of a mindbender.  Why?  The scheduler is designed
to deliver best possible performance and we've not compromized on
performance to make the job of backtracing any easier.

> PS. I broke into gdb using a hotkey on the serial console; so the gdb 
> backtrace shows the serial driver.

In which you need to be extra careful about the validity of any pointer
you might encounter.

  Ralf
