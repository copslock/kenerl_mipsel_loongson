Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jun 2008 21:14:20 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:40692 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20026543AbYFHUOS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Jun 2008 21:14:18 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m58KEFcc022536;
	Sun, 8 Jun 2008 22:14:15 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m58KE6pu022532;
	Sun, 8 Jun 2008 21:14:06 +0100
Date:	Sun, 8 Jun 2008 21:14:06 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
cc:	Luke -Jr <luke@dashjr.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: bcm33xx port
In-Reply-To: <484C38A6.7080503@mips.com>
Message-ID: <Pine.LNX.4.55.0806082103320.15673@cliff.in.clinika.pl>
References: <200806072113.26433.luke@dashjr.org> <200806072332.06460.luke@dashjr.org>
 <Pine.LNX.4.55.0806081332560.15673@cliff.in.clinika.pl> <200806081357.02601.luke@dashjr.org>
 <484C38A6.7080503@mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 8 Jun 2008, Kevin D. Kissell wrote:

> > The RI error spits out a bunch of info, including epc which presumably points 
> > to the instruction causing the problem: ac85ffc0; this is 'sw a1,-64(a0)'
> >   
> But unless the processor itself is actually defective, there is no way that
> a  SW instruction can cause an RI exception.  Sometimes a kernel crash
> is so violent that the kernel stack frame cannot be reliably decoded by
> the crash dump code, and this would appear to be one of those cases.
> I find the address of 0xac85ffc0 to be a bit suspicious, myself.  That's
> a kseg1 (non-cacheable identity map) address for physical address
> 0x0c85ffc0, which would be legitimate (though suspicious) if you had
> 256MB of RAM, but the boot log quote you posted earlier suggests
> that you've only got 16M.  Is there really memory of some kind at
> that address?  Are you calling routines in a boot ROM from Linux?

 Well, 0xac85ffc0 is the instruction word corresponding to 'sw a1,-64(a0)'.
:)  The actual address of the failure is apparently 0x004e010c, which is
pretty much a standard location somewhere within a user executable proper.

  Maciej
