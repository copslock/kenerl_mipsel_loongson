Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA9IUus14284
	for linux-mips-outgoing; Fri, 9 Nov 2001 10:30:56 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA9IUp014281;
	Fri, 9 Nov 2001 10:30:51 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fA9IWEB02720;
	Fri, 9 Nov 2001 10:32:14 -0800
Message-ID: <3BEC20D5.AD6ABBA6@mvista.com>
Date: Fri, 09 Nov 2001 10:30:45 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: Ralf Baechle <ralf@oss.sgi.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel]Re: i8259.c in big endian
References: <Pine.LNX.4.10.10111081348000.13456-100000@transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

James Simmons wrote:
> 
> > > > The mips_io_port_base is 0xa0000000. Whereas the i8259 chip is at
> > > > 0xb0000000. The 0xa000000 value could be wrong. I will give it a try.
> > >
> > > As your board must have RAM at physical address zero 0xa0000000 is almost
> > > certainly a wrong value.
> >
> > Your right. The address of 0xb000000 is bogus. This is the value from the
> > old code. I will migrate the code over to the i8259.c stuff now. Thanks.
> 
> Actually looking threw other mips branches now I see what the 0xb000000
> is. It is the isa_port_base.
> 

You are probably referring to isa_slot_offset?

isa_slot_offset is an obselete garbage.  Can someone do Ralf's a favor and
send him a patch to get rid of it (as if he can't do it himself :-0) ?

Jun
