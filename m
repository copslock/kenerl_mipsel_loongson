Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIKGbf04562
	for linux-mips-outgoing; Tue, 18 Dec 2001 12:16:37 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIKGUo04559;
	Tue, 18 Dec 2001 12:16:30 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBIJGKB17183;
	Tue, 18 Dec 2001 11:16:20 -0800
Message-ID: <3C1F9608.E4E32E18@mvista.com>
Date: Tue, 18 Dec 2001 11:16:24 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Jim Paris <jim@jtan.com>, linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <20011218162506.A24659@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Tue, Dec 18, 2001 at 02:03:44AM -0500, Jim Paris wrote:
> > Date: Tue, 18 Dec 2001 02:03:44 -0500
> > From: Jim Paris <jim@jtan.com>
> > To: Ralf Baechle <ralf@oss.sgi.com>
> > Cc: linux-mips@oss.sgi.com
> > Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
> >
> > > ISA, the good old stonage PC bus system with all it's limitations that also
> > > infected some MIPS systems.
> >
> > Let me restate my problem differently, and perhaps a bit more clearly
> > (as I see it):
> >
> > My system (Vadem Clio 1000, vr4111) has a VG-469 (i82365) PCMCIA
> > controller with IO port space at 0x14000000, and IO memory space
> > at 0x10000000.
> 
> Therefore:
> 
>         set_io_port_base(0xb4000000);
>         isa_slot_offset = 0xb0000000;
> 

I see.  So isa_slot_offset is for isa_read/isa_write, although I still don't
see what kind of drivers would use isa_read/isa_write.

Jun
