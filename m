Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2003 03:05:53 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:42685 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225240AbTAWDFw>;
	Thu, 23 Jan 2003 03:05:52 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h0N15uG8012753;
	Wed, 22 Jan 2003 17:05:57 -0800
Received: from melbourne.sgi.com (speed.melbourne.sgi.com [134.14.55.174]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA00592; Thu, 23 Jan 2003 14:05:44 +1100
Message-ID: <3E2F5C08.444341D6@melbourne.sgi.com>
Date: Thu, 23 Jan 2003 14:05:44 +1100
From: Greg Banks <gnb@melbourne.sgi.com>
Organization: SGI Australian Software Group
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-6mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@sgi.com>
CC: Ralf Baechle <ralf@linux-mips.org>,
	Andrew Clausen <clausen@melbourne.sgi.com>,
	linux-mips@linux-mips.org
Subject: Re: debian's mips userland on mips64
References: <20030122073006.GF6262@pureza.melbourne.sgi.com> <20030122124540.A31505@sgi.com> <20030122134506.A12847@linux-mips.org> <20030122150919.A32202@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <gnb@melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnb@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:
> 
> On Wed, Jan 22, 2003 at 01:45:06PM +0100, Ralf Baechle wrote:
> > There is a 32-bit ptrace compatibility syscall already and last I tried
> > it was working quite well for strace.
> 
> Indeed.  Didn't even check whether mips64 has it already implemented..

Actually 32bit strace on a 64bit kernel is working *most* of the time, so
there must be a 32bit ptrace syscall which is mostly working.  But...

1.  There is a problem with tracing rt_sigaction() where the signal set
    argument is being misinterpreted either in ptrace or strace.  The
    result is an application buffer overflow in strace which causes it
    to lose track of which processes it's tracing.  This may be entirely
    an strace issue but presumably it doesn't happen on 32bit kernels,
    so the fix (when Andrew figures it out) may require strace to know
    whether it's running on a 64bit kernel.

2.  At some point in the future there may well be 64bit executables which
    we will want to trace with the 32bit strace.  Possibly strace will
    need some sort of modification to dynamically detect whether the
    traced child is 64bit or 32bit.

I'd be very interested to know if anyone's tried running strace on
a mips64 kernel, in particular strace'ing the scp program.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
