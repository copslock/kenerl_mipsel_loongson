Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0EL0cN21419
	for linux-mips-outgoing; Mon, 14 Jan 2002 13:00:38 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0EL0Vg21415
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 13:00:31 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0EK01X10310;
	Mon, 14 Jan 2002 12:00:02 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Jason Gunthorpe" <jgg@debian.org>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: MIPS64 status?
Date: Mon, 14 Jan 2002 12:00:01 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIEEMNCEAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.3.96.1020114005113.14010F-100000@wakko.deltatee.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

See, it's answers like this that make me skeptical and confused...

So MIPS64 denotes 64-bit data _and_ address?  Great.  But, what is the
current state of the toolchain?  I mean, what point is having the code
if the tools won't compile it properly?

I guess what I'm looking for is what I should tell someone who wants
to run MIPS Linux 64-bit with 8 gigs of RAM.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@debian.org]
> Sent: Monday, January 14, 2002 12:13 AM
> To: Matthew Dharm
> Cc: linux-mips@oss.sgi.com
> Subject: Re: MIPS64 status?
>
>
>
> On Sun, 13 Jan 2002, Matthew Dharm wrote:
>
> > As I understand it, 64-bit support is really two
> different things:  64-bit
> > data path (i.e. unsigned long long) and 64-bit addressing
> (for more than 4G
> > of RAM).
>
> I suppose you could say that. I think I saw someone post to
> this list
> that they were working on a patch to enable 64 bit
> registers with a 32 bit
> kernel.
>
> > My understanding is that "MIPS64" generally refers to a
> kernel which
> > supports a 64-bit data path, but we're still limited to
> 32-bit addressing.
> > Is that correct?
>
> The mips64 tree in CVS is one that is a 64 bit addressing
> capable kernel.
> AFAIK the linx convention is that <foo>64 refers to
> addressing (which
> probably impiles register width too :>)
>
> I'm not sure what the current state of the ELF64 MIPS toolchain is.
>
> Jason
>
