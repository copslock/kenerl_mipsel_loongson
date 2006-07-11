Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2006 03:53:54 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:50092 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133905AbWGKCxp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Jul 2006 03:53:45 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1G08Na-0001nx-Hr; Mon, 10 Jul 2006 22:53:42 -0400
Date:	Mon, 10 Jul 2006 22:53:42 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
Message-ID: <20060711025342.GA6898@nevyn.them.org>
References: <Pine.LNX.4.64N.0607071607520.25285@blysk.ds.pg.gda.pl> <20060708.011245.82794581.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0607071715360.25285@blysk.ds.pg.gda.pl> <20060710.235553.48797818.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710.235553.48797818.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 10, 2006 at 11:55:53PM +0900, Atsushi Nemoto wrote:
> On Fri, 7 Jul 2006 17:58:44 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > 	mfc0	k0, CP0_CAUSE
> > 	MFC0	k1, CP0_EPC
> > 	bltz	k0, handle_ri_slow	/* if delay slot */
> > 	 lui	k0, 0x7c03
> 
> I noticed that checking for CP0_CAUSE.BD is unneeded, since we are
> checking the instruction code anyway and "rdhwr" does not have a delay
> slot.  I removed the checking on the "take 2" patch I just sent.

Isn't BD "this instruction is in a delay slot", not "this instruction
has a delay slot"?  It affects where we go when we return.

BTW, if the fast emulation can't handle rdhwr in a delay slot, please
report a bug on GCC asking it not to put rdhwr in delay slots by
default.  It's probably worthwhile.

-- 
Daniel Jacobowitz
CodeSourcery
