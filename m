Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 16:19:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:58563 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026235AbXJDPTw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 16:19:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l94FJpxe010194;
	Thu, 4 Oct 2007 16:19:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l94FJpaf010193;
	Thu, 4 Oct 2007 16:19:51 +0100
Date:	Thu, 4 Oct 2007 16:19:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] enable PCI bridges in MIPS ip32
Message-ID: <20071004151951.GD6897@linux-mips.org>
References: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org> <Pine.LNX.4.64N.0710041316000.10573@blysk.ds.pg.gda.pl> <20071004130318.GC28928@linux-mips.org> <1191508413.10050.26.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1191508413.10050.26.camel@scarafaggio>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 04:33:33PM +0200, Giuseppe Sacco wrote:

> Il giorno gio, 04/10/2007 alle 14.03 +0100, Ralf Baechle ha scritto:
> [...]
> > (of course this all goes far beyond Giuseppe's patch - but the whole
> > ops-mace.c file like so much of the other code in arch/mips/pci isn't
> > exactly an example to be copied.
> > 
> > Ah, one final formality - when sending a patch please add a
> > Signed-off-by: line.  See Documentation/SubmittingPatches in the kernel
> > tree for what this means.
> 
> I'll provide a new patch tomorrow, using inline functions instead of
> macros. About the maximum number of PCI buses, I used 1 since the ip32
> only have 1 slot. If this maximum value should be changed, please let me
> know.

The entire testing done by chkslot() is probably not needed, so I suggest
you try to simply dump the thing entirely and test.

  Ralf
