Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0F0PxL27404
	for linux-mips-outgoing; Mon, 14 Jan 2002 16:25:59 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0F0Pmg27397;
	Mon, 14 Jan 2002 16:25:48 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0ENPiX11538;
	Mon, 14 Jan 2002 15:25:44 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: MIPS64 status?
Date: Mon, 14 Jan 2002 15:25:44 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAICENCCEAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020114150554.A29242@dea.linux-mips.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf --

Thanks for the info.  Too bad "MIPS64" and "mips64" sound exactly the
same on the telephone.

But, I need to be pedantic, just to be clear on a couple of
questions...

So, the "mips64" kernel can use 64-bits of address, for RAM >4G?
But, the apps running are always 32-bit?
Does this mean that any individual application can only use 4G of
memory, tho you could have several applications in physical memory
doing this? (i.e. multiple applications using 1G of RAM each, but not
swapping to disk?)
Does this mean we could map PCI memory/IO addresses above 4G and have
it work?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Ralf Baechle
> Sent: Monday, January 14, 2002 3:06 PM
> To: Matthew Dharm
> Cc: linux-mips@oss.sgi.com
> Subject: Re: MIPS64 status?
>
>
> On Sun, Jan 13, 2002 at 09:13:23PM -0800, Matthew Dharm wrote:
>
> > As I understand it, 64-bit support is really two
> different things:  64-bit
> > data path (i.e. unsigned long long) and 64-bit addressing
> (for more than 4G
> > of RAM).
>
> Right but due to the CPU architecture of pre-MIPS64 CPUs
> they always come
> together unless the software does funny attempts at
> truncating OS support
> to just 32-bit.  So the 32-bit kernel gives you none of the
> two, the mips64
> kernel both.
>
> > My understanding is that "MIPS64" generally refers to a
> kernel which
> > supports a 64-bit data path, but we're still limited to
> 32-bit addressing.
> > Is that correct?
>
> MIPS64 is MIPS's MIPS64 processor architecture, mips64 is
> the 64-bit kernel.
> That may sound like nitpicking but it's important to
> understand that both
> are not the same.
>
> > I suspect that this is very much a toolchain issue, as I
> don't think gcc
> > will generate 64-bit addressing code.
>
> Gcc is fine; the problem are binutils, that is as and ld.
> As a result of
> the gcc problems we don't have a 64-bit userspace either so
> all software
> running on 64-bit kernels is currently old 32-bit software
> running in
> compatibility mode.
>
>   Ralf
>
