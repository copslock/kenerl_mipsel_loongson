Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIKb1V05349
	for linux-mips-outgoing; Tue, 18 Dec 2001 12:37:01 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIKavo05344;
	Tue, 18 Dec 2001 12:36:57 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBIJalB18623;
	Tue, 18 Dec 2001 11:36:47 -0800
Message-ID: <3C1F9AD2.1269192E@mvista.com>
Date: Tue, 18 Dec 2001 11:36:50 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Jim Paris <jim@jtan.com>, linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <20011218162506.A24659@dea.linux-mips.net> <3C1F9608.E4E32E18@mvista.com> <20011218173118.C28080@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Tue, Dec 18, 2001 at 11:16:24AM -0800, Jun Sun wrote:
> 
> > I see.  So isa_slot_offset is for isa_read/isa_write, although I still don't
> > see what kind of drivers would use isa_read/isa_write.
> 
> Dumb answer - ISA drivers.
> 

(Hmm, do you mean "dumb question"? :-0)  

I was thinking most ISA dirvers should simply use inb/outb to access ioports.
Don't really any ISA devices have their own memory space.  But, anyway, who
can still remember those dark ages?

Jun
