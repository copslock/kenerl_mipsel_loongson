Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15LvfA16018
	for linux-mips-outgoing; Tue, 5 Feb 2002 13:57:41 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15LvUA16012
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 13:57:32 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id DAF41590A9; Tue,  5 Feb 2002 16:49:21 -0500 (EST)
Message-ID: <02a001c1ae90$43748d40$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <sjhill@cotw.com>
Cc: "linux-mips" <linux-mips@oss.sgi.com>
References: <200202051747.SAA21696@copsun18.mips.com> 	<3C6044A7.13FEB2E2@cotw.com> <1012943709.10659.106.camel@zeus> <3C604D73.88F1CDCE@cotw.com>
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
Date: Tue, 5 Feb 2002 16:58:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----- Original Message -----
From: "Steven J. Hill" <sjhill@cotw.com>
To: "Pete Popov" <ppopov@pacbell.net>
Cc: "Hartvig Ekner" <hartvige@mips.com>; "linux-mips"
<linux-mips@oss.sgi.com>
Sent: Tuesday, February 05, 2002 4:24 PM
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?


> Pete Popov wrote:
> >
> > I'm not sure if it's a "little" though.  Ralf has already done the work
> > for 64bit memory support on 32bit kernels, but that only works currently
> > on 64bit CPUs.  I started hacking on the 64bit memory patch to get it to
> > work on 32bit processors, but had to put that aside for a few weeks. I
> > hope to get back to it soon.
> >
> Sure, the "little" is a relative term. As far as your patch is concerned,
> you are essentially trying to use a true 32-bit processor (my definition
> being that it is not a 64-bit processor running in 32-bit mode), to
address
> address more than 4GB of physical memory. I don't see how that is possible
> with just the MMU and TLB unless you are using chip selects and customm
> logic.

As already mentioned, a MIPS TLB entry typically can point with 36 bits
(that's 67TB of address space?) at physical memory.  If you have more than
2^31 bytes of physical memory, then a single process can't map all of
physical memory into it's address space, but it can map in pages (using TLB
entries) from anywhere within the 36-bit physical memory space.

In other words, process address space doesn't limit physical address space.
Only TLB capability limits physical address space.

And right, KSEG0 and KSEG1 can only get at the low 0.5GB of physical memory.
You can imagine that KSEG0 is implemented with a single hardwired TLB entry
that maps virtual address 0x80000000 to physical address 0x0, 0.5GB wide.

The only way to get to physical memory above 0.5GB is through a TLB entry.

Regards,
Brad
