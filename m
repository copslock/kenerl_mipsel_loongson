Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIK9OJ04390
	for linux-mips-outgoing; Tue, 18 Dec 2001 12:09:24 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIK9Ko04387;
	Tue, 18 Dec 2001 12:09:20 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBIJ96B16569;
	Tue, 18 Dec 2001 11:09:06 -0800
Message-ID: <3C1F9456.C0C7A978@mvista.com>
Date: Tue, 18 Dec 2001 11:09:10 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim@jtan.com
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <3C1F868C.492E155B@mvista.com> <20011218134536.A11726@neurosis.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jim Paris wrote:
> 
> > It seems like i82365.c implies a PCI device.  If this is true, then things do
> > make sense here.
> 
> No, the VG469 (and original i82365) is most definately an ISA device.
> From the manual: "The VG-469 has built in a standard ISA interface ..."
> My machine, as much as I hate it, _does_ have an ISA bus located at
> isa_slot_offset.
> 

Really?!

Hmm, how does the driver access ISA memory area?  I did not find ioremap() nor
readb/writeb stuff.  Usually those two macros are used to access PCI memory
space.  That is the reason I said "the driver implies a PCI device".

If it is purely ISA driver, may it should use isa_read/isa_write macros, in
which case we can make use of isa_slot_offset (maybe isa_slot_offset is useful
after all. :-0)

Jun
