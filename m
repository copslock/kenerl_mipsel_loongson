Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACIW3c02359
	for linux-mips-outgoing; Mon, 12 Nov 2001 10:32:03 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACIVx002356;
	Mon, 12 Nov 2001 10:31:59 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fACIXGB11827;
	Mon, 12 Nov 2001 10:33:16 -0800
Message-ID: <3BF0159A.D5DAF75B@mvista.com>
Date: Mon, 12 Nov 2001 10:31:54 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: James Simmons <jsimmons@transvirtual.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel]Re: i8259.c in big endian
References: <Pine.LNX.4.10.10111081348000.13456-100000@transvirtual.com> <3BEC20D5.AD6ABBA6@mvista.com> <20011112231528.D3949@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Fri, Nov 09, 2001 at 10:30:45AM -0800, Jun Sun wrote:
> 
> > isa_slot_offset is an obselete garbage.  Can someone do Ralf's a favor and
> > send him a patch to get rid of it (as if he can't do it himself :-0) ?
> 
> Nope.  Somebody could fix isa_{read,write}[bwl] to use isa_slot_offset.
> Right now all the ISA functions are broken.  So in case you're ISA drivers
> seem to work that's the proof that they're broken *evil grin* :-)

I doubt if there is any MIPS machine using standard PC ISA bus that is *not*
on a PCI bus ...

Jun
