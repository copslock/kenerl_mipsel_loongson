Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 13:28:14 +0000 (GMT)
Received: from p508B62C3.dip.t-dialin.net ([IPv6:::ffff:80.139.98.195]:135
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225316AbTKDN2C>; Tue, 4 Nov 2003 13:28:02 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id hA4DS1sY005961;
	Tue, 4 Nov 2003 14:28:01 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hA4DS1Mr005960;
	Tue, 4 Nov 2003 14:28:01 +0100
Date: Tue, 4 Nov 2003 14:28:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Adeel Malik <AdeelM@quartics.com>
Cc: linux-mips@linux-mips.org
Subject: Re: How to request an IRQ for NMI on MIPS Processor
Message-ID: <20031104132801.GA5297@linux-mips.org>
References: <10C6C1971DA00C4BB87AC0206E3CA38264F543@1aurora.enabtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10C6C1971DA00C4BB87AC0206E3CA38264F543@1aurora.enabtech>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 04, 2003 at 05:58:32PM +0500, Adeel Malik wrote:

> Hi Ralph,
        ^^

Who is that guy? ;-)

> 	   Thanks for the reply. Yes you are right that NMI isn't meant to
> be used as a regular IRQ of MIPS Processor. But somehow the board designer
> connected the External Interrupt from video capture device to the NMI and
> now I am thinking as how to how implement the Interrupt handler routine for
> the NMI of MIPS processor. Do you think that we need to re-route the Board
> or there may be some patch available describing the implementation of
> Interrupt handler for NMI of MIPS 4Kc.

As I said the NMI goes through the firmware so the way how to handle the
NMI on your specific board is entirely upto the firmware.  This is also
why you don't find much code related to NMIs in Linux.

I think it's highly desirable to fix this little hardware problem even
though that is going to involve some cost.  To look at things a bit more
from the Linux side:

 - NMI may even interrupt a previous NMI.  Again that means you'll lose your
   previous state, dead.
 - NMI means you have to paranoidly check the interrupt code.

Hmm...  Here's a little idea.  Bits 8 and 9 in the status and cause
registers are for the MIPS sofware interrupt bits which Linux doesn't use
at all.  NMI could use those so on return from NMI a normal maskable
interrupt would be triggered.  That would minimize the NMI path and
complications that could arise from it's not-maskability.

  Ralf
