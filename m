Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1203fa22123
	for linux-mips-outgoing; Fri, 1 Feb 2002 16:03:41 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1203Yd22114;
	Fri, 1 Feb 2002 16:03:34 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g11N3VX12727;
	Fri, 1 Feb 2002 15:03:31 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: "Ralf Baechle" <ralf@oss.sgi.com>, "Carsten Langgaard" <carstenl@mips.com>,
   <linux-mips@oss.sgi.com>
Subject: RE: fsck fails on latest 2.4 kernel
Date: Fri, 1 Feb 2002 15:03:31 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIOEDLCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020201145244.B15521@lucon.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Okay... I'm a moron.  I totally missed that SRPM after looking more
than 3 times.

Maybe I need stronger coffee....

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of H . J . Lu
> Sent: Friday, February 01, 2002 2:53 PM
> To: Matthew Dharm
> Cc: Ralf Baechle; Carsten Langgaard; linux-mips@oss.sgi.com
> Subject: Re: fsck fails on latest 2.4 kernel
>
>
> On Fri, Feb 01, 2002 at 01:43:10PM -0800, Matthew Dharm wrote:
> > Hrm... Looks like I'm getting bitten by this bug also.
> >
> > I'm using H.J.'s toolchain RPMs for building the userspace
> > applications, but the same tools as Carsten for building
> the kernel.
> > I guess that combination doesn't work, either.
> >
> > Unfortunately, the RPMs that H.J. has put on oss.sgi.com
> won't install
> > on my system -- wrong version of RedHat.  And I don't see
> the source
> > to his toolchain RPMs, so I can't rebuild it myself for the local
> > libraries.
>
> My toolchain source rpm is on oss.sgi.com:
>
> ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/SRPMS/toolchain-
> 20011020-1.src.rpm
>
>
> H.J.
>
