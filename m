Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIKLwi04694
	for linux-mips-outgoing; Tue, 18 Dec 2001 12:21:58 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIKLro04691;
	Tue, 18 Dec 2001 12:21:53 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBIJLdB17551;
	Tue, 18 Dec 2001 11:21:39 -0800
Message-ID: <3C1F9747.60DFB70@mvista.com>
Date: Tue, 18 Dec 2001 11:21:43 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jim@jtan.com
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <20011218162506.A24659@dea.linux-mips.net> <20011218135712.B11726@neurosis.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jim Paris wrote:
 
> How so?  See the memory map I just sent in my other mail.  Should I be
> adding isa_slot_offset to calls to check/request/release_mem_region?
> Or should I make a isa_{check,request,release}_mem_region that adds
> this in?  In which case, doesn't that turn /proc/iomem into a general
> memory map rather than an I/O memory map?
> 

My understanding is that it is from PCI memory space perspective.  System ram
is mapped at lower range.

> > > 4) it can use ioremap, and then read[bwl] and write[bwl] with the result
> > >  - this fails with the current ioremap; neither ioremap nor read/write[bwl]
> > >    take isa_slot_offset into account
> >
> > And that's right because isa_slot_offset is used by the isa_{read,write}[bwl]
> > functions which do not require ioremap having been called before.  You're
> > (fortunately ...) using PCI and PCI drivers are required to use ioremap.
> 
> No, I'm not using PCI, but it's calling ioremap anyway.  So, yes, I
> suppose I could change the driver to not call ioremap and use
> isa_{read,write}[bwl] (since doing both adds KSEG1 twice).
> But why shouldn't ioremap + {read,write}[bwl] also work?
> If it did, I wouldn't have to touch the driver.

It seems like the driver assumes the ISA device is accessed through a PCI bus,
in which case the code would work.

Jun
