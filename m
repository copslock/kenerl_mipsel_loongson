Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 16:18:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:16797 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038959AbXBWQSo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 16:18:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1NGIgJU025523;
	Fri, 23 Feb 2007 16:18:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1NGIe7p025522;
	Fri, 23 Feb 2007 16:18:40 GMT
Date:	Fri, 23 Feb 2007 16:18:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	sathesh_edara2003@yahoo.co.in, rajat.noida.india@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: unaligned access
Message-ID: <20070223161840.GA23178@linux-mips.org>
References: <20070223.123630.92584856.nemoto@toshiba-tops.co.jp> <005701c7573f$6aca0890$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005701c7573f$6aca0890$10eca8c0@grendel>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 23, 2007 at 09:18:59AM +0100, Kevin D. Kissell wrote:

> One thing about the current, system-call based interface that is kind-of
> cool, and different from both what you propose and what was described
> as being implemented for ARM, is that Ralf's scheme is per-thread.
> I don't know if that power really outweighs the ease-of-use aspect
> of being able to manipuate it from the shell command line, but it's 
> not something to throw away lightly.  I have no issues with moving
> the log data, should it be resurrected, from syslog to /sys/kernel/whatever,
> though.

There are two different things here that need to be sorted out - but for
years nobody noticed so this never really did show up on the radar:

 o sysmips is really a compatibility interface meant to support software
   that did originate on IRIX, RISC/os and maybe even MIPS/os.  But
   sysmips(MIPS_FIXADE,...) is a new operation that I came up with for
   Linux.  So I'd like this interface to die.
 o sysmips(MIPS_FIXADE, ...) does control only the fixup operation of the
   kernel on a per thread base.  Loggin is not controlled by it; that was
   available in the dark past only as a compile time option.
 o The MIPS_FIXADE setting is inherited across clone and fork.  I could
   almost bet no software relying on this feature is actually explicitly
   enabling it.  Maybe the default should be off to make programmers
   aware of this kind of issue in their code?
 o The MIPS_FIXADE setting is valid for both kernel and user mode.  So if
   for example the TCP stack is taking an unaligned exception to process
   an incoming packet, it will look at the setting of the process that just
   happens to be running on the CPU.
 o I think it would be handy to have a method to externally control the
   MIPS_FIXADE setting of a process.
 o Logging unaligned accesses is a dangerous thing; it can easily reach
   a DoS-like volume.

  Ralf
