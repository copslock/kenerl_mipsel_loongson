Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Dec 2003 15:40:00 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:31906 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225373AbTLHPjk>;
	Mon, 8 Dec 2003 15:39:40 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1ATNTx-0007A3-3y; Mon, 08 Dec 2003 10:39:33 -0500
Date: Mon, 8 Dec 2003 10:39:33 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Mark and Janice Juszczec <juszczec@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: cross debugging r3912 cpu with gdb
Message-ID: <20031208153932.GA27486@nevyn.them.org>
References: <LAW10-F527kP31wEf2X00017cd3@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LAW10-F527kP31wEf2X00017cd3@hotmail.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 08, 2003 at 12:48:44PM +0000, Mark and Janice Juszczec wrote:
> 
> Daniel
> 
> >
> >Then what ARE you using on the target?
> >
> 
> I have a kernel, busybox (for init and sh) and kaffe+associated files.  
> These have all been cross compiled from i386 for mipsel-linux using gcc 
> (2.95 or 3.0).
> 
> >You have to connect to some particular debug stub.  That determines
> >what protocol to use.
> >
> 
> 
> I wanted to test starting the whole thing up and connecting with gdb before 
> trying to actually debug anything.  So, I haven't begun to worry about 
> debug stubs.

GDB has to connect _to_ something :)  If you don't have a stub, nothing
on your target speaks the GDB protocol.

> Frankly, I'm confused as to where they'd go.  It seems to me I want to let 
> the kernel start up on the pda and then use gdb to tell it to start running 
> kaffe.  If that's true, I need debug stubs in kaffe.  Am I completely wrong 
> with this idea?

Yes.  I recommend you read the GDB manual, on the section describing
gdbserver.  GDB doesn't connect to the kernel at all, you start a
gdbserver process on the target with the path to kaffe.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
