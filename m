Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIKUl104958
	for linux-mips-outgoing; Tue, 18 Dec 2001 12:30:47 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBIKUfo04955
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 12:30:42 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBIJUFR32459;
	Tue, 18 Dec 2001 17:30:15 -0200
Date: Tue, 18 Dec 2001 17:30:15 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: jim@jtan.com, linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011218173015.B28080@dea.linux-mips.net>
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <3C1F868C.492E155B@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1F868C.492E155B@mvista.com>; from jsun@mvista.com on Tue, Dec 18, 2001 at 10:10:20AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 18, 2001 at 10:10:20AM -0800, Jun Sun wrote:

> It seems like i82365.c implies a PCI device.  If this is true, then things do
> make sense here.
> 
> Just setting iomem_resource.end to 0xffffffff should get you by resource range
> problem.

Certainly not as that is the default.

> It has nothing to isa_slot_offset here.  I don't know about the history of
> isa_slot_offset, but it appears to be faint effort to allow the access to what
> is called "ISA memory" space on PC.  This region, if it ever exists, should
> never be a separate region on a MIPS machine.  It should just be the beginning
> part of PCI Memory space.
> 
> Ralf, we should just delete isa_slot_offset to avoid any further confusions.

No way as long as there are (E)ISA systems :-(

  Ralf
