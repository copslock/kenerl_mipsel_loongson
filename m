Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 15:01:13 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:49332 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225315AbUAMPBM>;
	Tue, 13 Jan 2004 15:01:12 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1AgQ2W-0000Zh-Pn; Tue, 13 Jan 2004 10:01:08 -0500
Date: Tue, 13 Jan 2004 10:01:08 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Nathan Field <ndf@ghs.com>
Cc: linux-mips@linux-mips.org
Subject: Re: ptrace induced instruction cache bug?
Message-ID: <20040113150108.GA7144@nevyn.them.org>
References: <Pine.LNX.4.44.0401121806240.1969-300000@zcar.ghs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401121806240.1969-300000@zcar.ghs.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 12, 2004 at 06:34:57PM -0800, Nathan Field wrote:
> I'm writing a debugger that uses the Linux ptrace API for process control
> and I think I've found a bug in ptrace in MIPS Linux. The specific
> situation that breaks horribly with my debugger is quite complex, so I
> wrote a little testbed to show the problem. The code and a sample Makefile
> are attached. You can build the example for x86 or MIPS. I have some
> things in there for PPC but I haven't ported it fully yet. Basically the
> problem seems to be that writing a breakpoint (instruction 0xd), running 
> to the breakpoint, replacing the breakpoint with the original instruction 
> and then resuming sometimes results in the process halting on the same 
> address, even though there isn't a breakpoint there anymore. If you resume 
> again, or wait for a "while" after removing the breakpoint everything 
> works fine. I believe the problem is probably linked to some sort of 
> problem with the kernel not flushing the instruction cache, but that's 
> just a guess.

It sounds reasonable.  I've encountered this problem in the past also,
but never with the Pro 2.1 / MIPS release which is what you're using. 
I don't see anything obviously wrong with your test code, either.

> I'd guess that this problem has been fixed in later versions of the 
> kernel. If anyone can point me to a 2.4 release with this fixed I'd like 
> to know about it. I tried building the cvs checkout but the build failed. 
> It looks like I'll need a newer toolchain than the one I got from 
> MontaVista[1].
> 
> I'm using a stock MontaVista distribution for the MIPS Malta 4Kc in big
> endian mode, downloaded from their site a couple of days ago. I recompiled
> the kernel with the arch/mips/configs/defconfig-malta, but haven't changed 
> any options yet. Since that could be hard to classify here are some 
> details about my system:

Yes, you will need a newer toolchain.  Honestly, I'm baffled as to why
a Pro 2.1 toolchain was available from our web site at all, unless you
got it via an old product subscription... it should have been Pro 3.0,
which uses GCC 3.2 and a more recent binutils.  But I don't have any
control over these things :)

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
