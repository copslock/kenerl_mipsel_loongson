Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACCGg018524
	for linux-mips-outgoing; Mon, 12 Nov 2001 04:16:42 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fACCGd018519
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 04:16:40 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fACCFSv04426;
	Mon, 12 Nov 2001 23:15:28 +1100
Date: Mon, 12 Nov 2001 23:15:28 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel]Re: i8259.c in big endian
Message-ID: <20011112231528.D3949@dea.linux-mips.net>
References: <Pine.LNX.4.10.10111081348000.13456-100000@transvirtual.com> <3BEC20D5.AD6ABBA6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEC20D5.AD6ABBA6@mvista.com>; from jsun@mvista.com on Fri, Nov 09, 2001 at 10:30:45AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Nov 09, 2001 at 10:30:45AM -0800, Jun Sun wrote:

> isa_slot_offset is an obselete garbage.  Can someone do Ralf's a favor and
> send him a patch to get rid of it (as if he can't do it himself :-0) ?

Nope.  Somebody could fix isa_{read,write}[bwl] to use isa_slot_offset.
Right now all the ISA functions are broken.  So in case you're ISA drivers
seem to work that's the proof that they're broken *evil grin* :-)

  Ralf
