Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 16:32:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59352 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026236AbXJDPcR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 16:32:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l94FWHIA010546;
	Thu, 4 Oct 2007 16:32:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l94FWHft010545;
	Thu, 4 Oct 2007 16:32:17 +0100
Date:	Thu, 4 Oct 2007 16:32:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
Message-ID: <20071004153217.GF6897@linux-mips.org>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org> <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl> <20071004130318.GC28928@linux-mips.org> <1191508413.10050.26.camel@scarafaggio> <20071004151951.GD6897@linux-mips.org> <Pine.LNX.4.64N.0710041624450.10573@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710041624450.10573@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 04:27:57PM +0100, Maciej W. Rozycki wrote:

> On Thu, 4 Oct 2007, Ralf Baechle wrote:
> 
> > The entire testing done by chkslot() is probably not needed, so I suggest
> > you try to simply dump the thing entirely and test.
> 
>  Exactly what I wrote too. :-)  Though I would imagine it was introduced 
> for a reason, like a bug in the host bridge or something, as already 
> suggested.  Otherwise what would the point have been?

I suspect cut-and-paste-o-mania, probably originally started by the
necessity of doing so for the Galileo chips.

  Ralf
