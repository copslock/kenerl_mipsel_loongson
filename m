Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Sep 2002 23:13:16 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:17930 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122958AbSIFVNP>; Fri, 6 Sep 2002 23:13:15 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g86LD8617579;
	Fri, 6 Sep 2002 14:13:08 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: RE: LOADADDR and low physical addresses?
Date: Fri, 6 Sep 2002 14:13:08 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIEENICIAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-reply-to: <20020906135324.D1382@mvista.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

Yes, the having two devices at the same physical address might be a
problem, but one I _might_ be able to work around.  Not only do I have
a large bank of SDRAM, but I also have a small bank of on-chip SRAM.

So I'm thinking that the map will go (starting from 0) like this:
on-chip SRAM, control registers, main memory

And this is where I think the add_memory_region() magic might need to
happen.  Do I need to add the on-chip SRAM and control registers using
add_memory_region()?  Is it going to be okay to have a large and
mis-aligned bank of SDRAM?

Questions abound.  Needless to say, I'm going to have some choice
words with the chip designers over this...

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Jun Sun [mailto:jsun@mvista.com]
> Sent: Friday, September 06, 2002 1:53 PM
> To: Matthew Dharm
> Cc: Linux-MIPS; jsun@mvista.com
> Subject: Re: LOADADDR and low physical addresses?
>
>
> On Fri, Sep 06, 2002 at 01:04:28PM -0700, Matthew Dharm wrote:
> > So, I've got an interesting problem... which has forced
> me to look at
> > the use of the LOADADDR variable in the Makefile, and try
> (quickly) to
> > brush up on my linker scripting...
> >
> > Basically I've got a processor with on-chip registers
> that need to be
> > located in the first 512MByte of _physical_ address.  To
> make things
> > difficult, they cannot be re-located once placed (configuration is
> > done by a hardware config stream at reset).  It's only 16KBytes of
> > address, but since I recall that linux on mips can't
> (well, probably
> > can't) handle discontiguous memory maps (we discussed this about a
> > year ago, I think), I was looking for a good place to put them.
> >
> > Now, I think my problems are solved if the LOADADDR
> variable works the
> > way I think it does -- that the kernel loads at that
> address, and only
> > uses memory from that point upwards.  So, if my LOADADDR is
> > 0x80100000, then the first 0x100000 won't get used.  Of
> course, the
> > exception vectors are there, but that doesn't take up
> that much space.
> > So there should be a chunk of address space I can use for other
> > things, like this register bank.
> >
> > Yes? No?  Is my understanding even close?
> >
>
> That is right.
>
> The only catch is that if you make LOADADDR very high (as
> in the case
> system ram starts at a high address), the kernel page
> table will be very high too.  It starts from phys address 0.
>
> Also if you map your control registers at near-zero phy
> address, don't you
> also have system RAM there too?  Normally it is not ok to have two
> devices decoded at the same phys address.
>
> > P.S. Of course, if this is right, then I need to figure out the
> > proper/best way to use the add_memory_region() function....
>
> Unless I misunderstand something here, I don't think you need
> to mess with add_memory_region().
>
> Jun
>
