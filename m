Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FMQVnC003045
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 15:26:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FMQVGb003044
	for linux-mips-outgoing; Wed, 15 May 2002 15:26:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from host099.momenco.com (IDENT:root@jeeves.momenco.com [64.169.228.99])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FMQKnC003039
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 15:26:25 -0700
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g4FMQ8326132;
	Wed, 15 May 2002 15:26:18 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Kip Walker" <kwalker@broadcom.com>
Cc: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: RE: MIPS 64?
Date: Wed, 15 May 2002 15:26:08 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAICEACCHAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <3CE2DDEB.5DA6E868@broadcom.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Right....

So, how should my boot code convey that info?  With more
add_memory_region() calls?  Is that really all I need?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Kip Walker
> Sent: Wednesday, May 15, 2002 3:15 PM
> To: Matthew Dharm
> Cc: Linux-MIPS
> Subject: Re: MIPS 64?
>
>
> Matthew Dharm wrote:
> >
> > I don't suppose anyone has a primer or white paper on the
> High Memory
> > stuff?  i.e. Applications, requirements, or a quick HOWTO?
>
> Well, the CONFIG option is at the bottom of the Machine
> Selection menu.
> With a fairly recent 2.4 or 2.5 kernel, it should build at work.
> Basically, if your firmware/boot code conveys info about
> regions above
> physical address 0x1fffffff, the kernel will allocate "struct page"
> entries for it, and add them to the pool of allocatable memory.  The
> kernel gets at them by mapping them into Kseg2/Kseg3 temporarily.
>
> turn it on, see what happens!  I haven't looked for a primer.
>
> Kip
>
