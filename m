Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f81GA9C14664
	for linux-mips-outgoing; Sat, 1 Sep 2001 09:10:09 -0700
Received: from fe000.worldonline.dk (fe000.worldonline.dk [212.54.64.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f81GA5d14661
	for <linux-mips@oss.sgi.com>; Sat, 1 Sep 2001 09:10:06 -0700
Received: (qmail 31316 invoked by uid 0); 1 Sep 2001 16:09:59 -0000
Received: from 213.237.49.98.skovlyporten.dk (HELO tuxedo.skovlyporten.dk) (213.237.49.98)
  by fe000.worldonline.dk with SMTP; 1 Sep 2001 16:09:59 -0000
Received: by tuxedo.skovlyporten.dk (Postfix, from userid 501)
	id 5739E7CF9; Sat,  1 Sep 2001 18:10:09 +0200 (CEST)
Date: Sat, 1 Sep 2001 18:10:09 +0200
From: Lars Munch <lars@segv.dk>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: set_except_vector question
Message-ID: <20010901181009.A13883@tuxedo.skovlyporten.dk>
References: <20010901165842.B13357@tuxedo.skovlyporten.dk> <010401c132fe$610d0610$3501010a@ltc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <010401c132fe$610d0610$3501010a@ltc.com>; from brad@ltc.com on Sat, Sep 01, 2001 at 11:54:26AM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

What do you mean by "synthesizing a jump"?

My CPU is a 5Kc and it has a DIVEC which is set to the mipsIRQ function in
/arch/mips64/mips-boards/generic/mipsIRQ.S to handle interrupts. But I still do
not understand the address manipulation which is done before storing the
function pointer (handler).

Thanks
Lars Munch

On Sat, Sep 01, 2001 at 11:54:26AM -0400, Bradley D. LaRonde wrote:
> Looks like it is synthesizing a jump (j) instruction to forward interrupt
> exceptions to the interrupt handler for cpus that have a dedicated interrupt
> vector (DIVEC).  arch/mips/kernel/setup.c sets the DIVEC option for certain
> cpus.
> 
> Regards,
> Brad
> 
> ----- Original Message -----
> From: "Lars Munch" <lars@segv.dk>
> To: <linux-mips@oss.sgi.com>
> Sent: Saturday, September 01, 2001 10:58 AM
> Subject: set_except_vector question
> 
> 
> > Hi
> >
> > I have been looking at the set_except_vector function in
> > arch/mips[64]/kernel/traps.c and wondering why the handler
> > address is changed/recalculated before it is stored:
> >
> > *(volatile u32 *)(KSEG0+0x200) = 0x08000000 | (0x03ffffff & (handler >>
> 2));
> >
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > Could someone please enlighten me?
> >
> > Thanks
> > Lars Munch
> >
> 
