Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACJSko04578
	for linux-mips-outgoing; Mon, 12 Nov 2001 11:28:46 -0800
Received: from mailout03.sul.t-online.de (mailout03.sul.t-online.com [194.25.134.81])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACJSi004575
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 11:28:44 -0800
Received: from fwd06.sul.t-online.de 
	by mailout03.sul.t-online.de with smtp 
	id 163Ml4-0006Uz-06; Mon, 12 Nov 2001 20:28:38 +0100
Received: from void.s.bawue.de (520095841842-0001@[62.227.2.105]) by fmrl06.sul.t-online.com
	with esmtp id 163Mkq-0useEiC; Mon, 12 Nov 2001 20:28:24 +0100
Received: from florian by void.s.bawue.de with local (Exim 3.32 #1 (Debian))
	id 163NCH-0000OF-00; Mon, 12 Nov 2001 20:56:45 +0100
Date: Mon, 12 Nov 2001 20:56:45 +0100
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel]Re: i8259.c in big endian
Message-ID: <20011112205644.B1459@void.s.bawue.de>
Mail-Followup-To: Florian Laws <florian@void.s.bawue.de>,
	Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com,
	linux-mips-kernel@lists.sourceforge.net
References: <Pine.LNX.4.10.10111081348000.13456-100000@transvirtual.com> <3BEC20D5.AD6ABBA6@mvista.com> <20011112231528.D3949@dea.linux-mips.net> <3BF0159A.D5DAF75B@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF0159A.D5DAF75B@mvista.com>
User-Agent: Mutt/1.3.20i
From: Florian Laws <florian@void.s.bawue.de>
X-Sender: 520095841842-0001@t-dialin.net
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 12, 2001 at 10:31:54AM -0800, Jun Sun wrote:
> Ralf Baechle wrote:
> > 
> > On Fri, Nov 09, 2001 at 10:30:45AM -0800, Jun Sun wrote:
> > 
> > > isa_slot_offset is an obselete garbage.  Can someone do Ralf's a favor and
> > > send him a patch to get rid of it (as if he can't do it himself :-0) ?
> > 
> > Nope.  Somebody could fix isa_{read,write}[bwl] to use isa_slot_offset.
> > Right now all the ISA functions are broken.  So in case you're ISA drivers
> > seem to work that's the proof that they're broken *evil grin* :-)
> 
> I doubt if there is any MIPS machine using standard PC ISA bus that is *not*
> on a PCI bus ...

FWIW, there is.
There are some old Siemens RM400 models (1989 vintage) with R3000 CPU and ISA 
bus.

Pretty unlikely that they'll be supportet any time, though... :-(

Florian
