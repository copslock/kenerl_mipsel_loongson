Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11MhL019866
	for linux-mips-outgoing; Fri, 1 Feb 2002 14:43:21 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11MhDd19853;
	Fri, 1 Feb 2002 14:43:13 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g11LhAX12217;
	Fri, 1 Feb 2002 13:43:10 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, "Carsten Langgaard" <carstenl@mips.com>,
   <hjl@lucon.org>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: fsck fails on latest 2.4 kernel
Date: Fri, 1 Feb 2002 13:43:10 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIEEDKCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020116235232.A2760@dea.linux-mips.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hrm... Looks like I'm getting bitten by this bug also.

I'm using H.J.'s toolchain RPMs for building the userspace
applications, but the same tools as Carsten for building the kernel.
I guess that combination doesn't work, either.

Unfortunately, the RPMs that H.J. has put on oss.sgi.com won't install
on my system -- wrong version of RedHat.  And I don't see the source
to his toolchain RPMs, so I can't rebuild it myself for the local
libraries.

Any suggestions on what the best approach is?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Ralf Baechle
> Sent: Wednesday, January 16, 2002 11:53 PM
> To: Carsten Langgaard
> Cc: linux-mips@oss.sgi.com
> Subject: Re: fsck fails on latest 2.4 kernel
>
>
> On Thu, Jan 17, 2002 at 08:25:56AM +0100, Carsten Langgaard wrote:
>
> > > Don't use these for building userspace apps.
> >
> > I'm only building the kernel with these.
> > What are you using for building the kernel ?
>
> Exactly the binaries which I put on oss.  I know that in
> the meantime
> various problems with them have shown up so I'm waiting for the next
> official binutils release to replace them.
>
>   Ralf
>
