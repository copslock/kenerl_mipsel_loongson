Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 17:55:50 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:20962 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026363AbXJDQzr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 17:55:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l94Gtksx026970;
	Thu, 4 Oct 2007 17:55:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l94GtkOA026966;
	Thu, 4 Oct 2007 17:55:46 +0100
Date:	Thu, 4 Oct 2007 17:55:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
Message-ID: <20071004165546.GA23610@linux-mips.org>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org> <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl> <20071004130318.GC28928@linux-mips.org> <Pine.LNX.4.64N.0710041459270.10573@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710041459270.10573@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 03:13:01PM +0100, Maciej W. Rozycki wrote:

> > I think historically we had something like chkslot() first in the code
> > for the Galileo/Marvell bridges where it's needed due the brainddead
> > abuse of device 31 - any access to that will crash the system.  From that
> > point on chkslot checking spread across the PCI code like the measles in
> > a kindergarden.
> 
>  Does the Galileo/Marvell do anything else with the device #31 than what 
> is recommended by the PCI spec as a way to issue special cycles?  We need 
> to be careful about the device #31 in general; it is seldom used anyway as 
> there are only 20 IDSEL lines defined by the standard and they are usually 
> mapped starting from the device #0.

It's documented somewhere in their specs.  Whatever, it ends crashing
the system so device 31 is hands off.

  Ralf
