Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2003 16:08:33 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:21905 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225240AbTL2QIa>;
	Mon, 29 Dec 2003 16:08:30 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1AazwN-0003iY-0h; Mon, 29 Dec 2003 11:08:23 -0500
Date: Mon, 29 Dec 2003 11:08:22 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Mark and Janice Juszczec <juszczec@hotmail.com>
Cc: kevink@mips.com, linux-mips@linux-mips.org
Subject: Re: gdbserver and Re: hardware questions
Message-ID: <20031229160822.GA14229@nevyn.them.org>
References: <Law10-F22bcHeTHOF2m00063144@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law10-F22bcHeTHOF2m00063144@hotmail.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 29, 2003 at 03:31:36PM +0000, Mark and Janice Juszczec wrote:
> 
> Kevin, et al
> 
> 
> >
> >If you want more of a "large format" mipsel platform
> >to experiment with, you might be able to find an old
> >"RISC PC" from Siemens or NEC with an R4000
> >configured little-endian to run NT.  Maybe Ralf has
> >one in his attic he'd care to sell you. ;o)
> >
> 
> Ralf?
> 
> >I don't know that it's the root of your problem, but
> >you should definitely get getty/shells off of whatever
> >serial port you're trying to use for debug.
> 
> If I have no shell running on the serial port, how would I start gdbserver? 
> Would I have to hard code it into the kernel somehow?

Try changing /etc/inittab to disable the getty, and starting gdbserver
from the system startup scripts in /etc/rc*.  I'm assuming you have
some other way than that shell on ttyS0 to modify the filesystem :)

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
