Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2003 05:04:26 +0000 (GMT)
Received: from p508B6290.dip.t-dialin.net ([IPv6:::ffff:80.139.98.144]:57548
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224847AbTAWFEZ>; Thu, 23 Jan 2003 05:04:25 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0N54Jn20808;
	Thu, 23 Jan 2003 06:04:19 +0100
Date: Thu, 23 Jan 2003 06:04:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: Christoph Hellwig <hch@sgi.com>,
	Andrew Clausen <clausen@melbourne.sgi.com>,
	linux-mips@linux-mips.org
Subject: Re: debian's mips userland on mips64
Message-ID: <20030123060419.B17280@linux-mips.org>
References: <20030122073006.GF6262@pureza.melbourne.sgi.com> <20030122124540.A31505@sgi.com> <20030122134506.A12847@linux-mips.org> <20030122150919.A32202@sgi.com> <3E2F5C08.444341D6@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E2F5C08.444341D6@melbourne.sgi.com>; from gnb@melbourne.sgi.com on Thu, Jan 23, 2003 at 02:05:44PM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 23, 2003 at 02:05:44PM +1100, Greg Banks wrote:

> Actually 32bit strace on a 64bit kernel is working *most* of the time, so
> there must be a 32bit ptrace syscall which is mostly working.  But...
> 
> 1.  There is a problem with tracing rt_sigaction() where the signal set
>     argument is being misinterpreted either in ptrace or strace.  The
>     result is an application buffer overflow in strace which causes it
>     to lose track of which processes it's tracing.  This may be entirely
>     an strace issue but presumably it doesn't happen on 32bit kernels,
>     so the fix (when Andrew figures it out) may require strace to know
>     whether it's running on a 64bit kernel.

Strace source is pretty evil ...

> 2.  At some point in the future there may well be 64bit executables which
>     we will want to trace with the 32bit strace.  Possibly strace will
>     need some sort of modification to dynamically detect whether the
>     traced child is 64bit or 32bit.
> 
> I'd be very interested to know if anyone's tried running strace on
> a mips64 kernel, in particular strace'ing the scp program.

[...]
ioctl(2, TCGETS, 0x7fff7858)            = -1 EINVAL (Invalid argument)
rt_sigaction(SIGPIPE, {0x10000000, [], 0x4055f4}, {SIG_DFL}, 16) = 0
pipe([0, 0])                            = 3
pipe([268437928, 721805232])            = 5
pipe([720500616, 2147449192])           = 7
close(3)                                = 0
[...]

  Ralf
