Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0F1RAI28966
	for linux-mips-outgoing; Mon, 14 Jan 2002 17:27:10 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0F1R5g28960
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 17:27:05 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0F0R2X11844;
	Mon, 14 Jan 2002 16:27:02 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Jason Gunthorpe" <jgg@debian.org>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: MIPS64 status?
Date: Mon, 14 Jan 2002 16:27:02 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIKENDCEAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.3.96.1020114165623.28388B-100000@wakko.deltatee.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hrm...

Were you actually using 64-bit addresses on the PCI bus?

My guess is that with some creative address mappings, this could be
done.  The PCI bus itself would use only 32-bit address, but the CPU
would use a base address offset into the >4G range.

Yeah, I could see how that could get ugly...

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Jason Gunthorpe
> Sent: Monday, January 14, 2002 4:00 PM
> To: Matthew Dharm
> Cc: linux-mips@oss.sgi.com
> Subject: RE: MIPS64 status?
>
>
>
> On Mon, 14 Jan 2002, Matthew Dharm wrote:
>
> > Does this mean we could map PCI memory/IO addresses above
> 4G and have
> > it work?
>
> Ooh, don't go there :> We looked at that and actually did
> it then backed
> it out.
>
> The PCI spec (particuarly PCI-X) tries to make it possible, but in a
> general system with PCI sockets/etc it is just is not feasible. PCI
> bridges need to be located below 4G, as do the majority of
> devices made.
> There is also a performance hit for having device registers > 4G.
>
> You'd definately need the mips64 kernel to do that, or use
> ugly wired TLB
> entries with normal mips.
>
> Jason
>
