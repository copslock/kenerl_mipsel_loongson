Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7FGHVRw006662
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 15 Aug 2002 09:17:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7FGHVo0006661
	for linux-mips-outgoing; Thu, 15 Aug 2002 09:17:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-116.ka.dial.de.ignite.net [62.180.196.116])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7FGHMRw006652
	for <linux-mips@oss.sgi.com>; Thu, 15 Aug 2002 09:17:24 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7FGJqw10543;
	Thu, 15 Aug 2002 18:19:52 +0200
Date: Thu, 15 Aug 2002 18:19:52 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Kjeld Borch Egevang <kjelde@mips.com>
Cc: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: N32 support in 64-bit MIPS Linux
Message-ID: <20020815181952.B10199@linux-mips.org>
References: <Pine.LNX.4.44.0208151140060.2195-100000@coplin19.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208151140060.2195-100000@coplin19.mips.com>; from kjelde@mips.com on Thu, Aug 15, 2002 at 12:06:31PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 15, 2002 at 12:06:31PM +0200, Kjeld Borch Egevang wrote:

> I would like to hear your opinion on this.
> 
> Currently we have the N64 interface which is the basic interface to the
> kernel. Then we have the O32 interface which is implemented as a separate
> set of syscalls in unistd.h and proper conversion in the kernel.
> 
> Now, how can we support N32? Many syscalls will work if N32 is treated the
> same way as O32. This will of course mean, that O32 must be compiled in in
> order to support N32. But e.g. a syscall like:
> 
> int _llseek(unsigned int fd, unsigned long offset_high, unsigned long 
> offset_low, loff_t *result, unsigned int whence);
> 
> needs special treatment since loff_t is a long long (passed in a single
> register for N32) and there are 6 arguments (all passed in registers for
> N32, passed in registers and on the stack for O32).
> 
> Should we simply add 235 new syscall numbers to unistd.h named 
> __NR_LinuxN32...?

o32 currently has 240 syscalls.  Of these a good number is simply
junk.  No syscall(2), oldstat(2), oldfstat(2), no experimental
UNIX Version 7 bs like mpx(2) for new ABIs; away with stupid multiplexor
calls like socketcall(2) and funny intelisms like vm86(2).  That's
the first cleanup I'm planning.

For what will be left over, N32 and N64 use the same subroutine calling
interface we'll be able to share most if not all syscalls between the two.
llseek(2) is just one example.

  Ralf
