Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2003 16:31:38 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:65439 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225258AbTK1Pep>;
	Fri, 28 Nov 2003 15:34:45 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1APkdm-0001jC-Me; Fri, 28 Nov 2003 10:34:42 -0500
Date: Fri, 28 Nov 2003 10:34:42 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Vince Bridgers <vbridgers@bandspeed.com>
Cc: linux-mips@linux-mips.org
Subject: Re: backtrace issues on GDB 5.3
Message-ID: <20031128153442.GA6624@nevyn.them.org>
References: <F2DE90354F0ED94EB7061060D9396547B98C49@mars.bandspeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2DE90354F0ED94EB7061060D9396547B98C49@mars.bandspeed.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 27, 2003 at 07:26:59AM -0600, Vince Bridgers wrote:
> I'm using GDB 5.3 for mipsel cross-compiled on an x86 box running RedHat
> 7.3. When I try to use the backtrace capability from GDB most of the
> time I do not get a full stack context - I usually just get the function
> I'm in at the time. I'm using GCC 3.2 to compile the kernel,
> cross-compiled the same way. I've tried making sure the
> omit-frame-pointer option and the "no instruction schedule" options are
> on for when we do source level debugging with no joy.  
> 
> Does backtrace work for GCC and GDB cross compiled for mipsel? If so,
> can someone briefly outline the "known good" configuration (GCC/GDB
> versions, + relevant configuration options)?

Not excellently, but definitely better - try the most recent GDB
release.

I have a number of ugly local patches that I hope to clean up for 6.1,
if I have time.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
