Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g01KNB126186
	for linux-mips-outgoing; Tue, 1 Jan 2002 12:23:11 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g01KN6g26183
	for <linux-mips@oss.sgi.com>; Tue, 1 Jan 2002 12:23:06 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id LAA14903;
	Tue, 1 Jan 2002 11:22:23 -0800
Date: Tue, 1 Jan 2002 11:22:23 -0800
From: Jun Sun <jsun@mvista.com>
To: Jim Paris <jim@jtan.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: ISA
Message-ID: <20020101112223.A14847@mvista.com>
References: <Pine.GSO.4.21.0112191456410.28777-100000@vervain.sonytel.be> <E16HSHp-0000ay-00@the-village.bc.nu> <20011221134452.A21586@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011221134452.A21586@neurosis.mit.edu>; from jim@jtan.com on Fri, Dec 21, 2001 at 01:44:52PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Dec 21, 2001 at 01:44:52PM -0500, Jim Paris wrote:
> > Interesting - I'd not considered that. Is ISA and non ISA space seperate on
> > MIPS or is it all rather ambiguous ?
> 
> On my particular machine, system RAM is at 0x00000000, and ISA I/O
> memory is at 0x10000000.  The driver I'm currently trying to work with
> calls check_mem_region with ISA addresses, which of course breaks when
> ISA memory isn't at zero.  One suggestion was to patch the driver to
> use something like
> 
>     check_mem_region(virt_to_phys(ioremap(ISA_address)), ...)
> 
> which might be the best way for now? 

I agree with Geert and think isa_xxx_mem_region is a better approach.
Unfortunately, this requires a change in both dirver and
arch-specific part.

> I think a more generic way to
> abstract away a bus (and support multiple types and numbers of I/O
> busses) is really necessary though.  Some way to register a bus with
> the kernel, and bind particular busses to particular instances of
> drivers, or something.
>

I have talked with somebody before about the address apace idea, which
is rather similar to what you are talking :

1. each address space has an id.
2. kernel pre-defines a couple of well-known ones, 0 for CPU physical, 
   1 for virtual, etc.
3. When drivers discover the devices, they get the address and also
   the address space id where the address resides.
4. there are a set of macro's that converts/maps an address or an
   address region from one space to another.

This generalized form allows multiple-PCI buses to use substractive decoding.
Also removes the 1:1 mapping requirement between PCI memory space and
CPU physical address space.

However, the detailed implementation can be hairy, which is why it 
is still an idea. :-)

Jun
