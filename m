Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PLUiA29607
	for linux-mips-outgoing; Mon, 25 Feb 2002 13:30:44 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PLUc929604
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 13:30:38 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1PKUcR21061;
	Mon, 25 Feb 2002 12:30:38 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Kevin Paul Herbert" <kph@ayrnetworks.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: RE: Is this a toolchain bug?
Date: Mon, 25 Feb 2002 12:30:38 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIGEMACFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <a05100303b8a033ebf33b@[192.168.1.5]>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Well, that fixes it.  The driver works out-of-the-box with just some
minor makefile modifications.

So, we've got a problem somewhere in the module handling.  Either the
symbol wasn't being relocated properly, or it wasn't being allocated
properly, or something.  I'm not an expert in this region of the
kernel, but my guess is that we're going to see this more and more
often, so someone with a clue should take a look at this.

I'm more than willing to help, as I seem to be the only person with a
100% reproducable situation.  But I really have no idea even where to
begin looking... my expertise ends right about at objdump, and even
then I'm not certain how some of that data should look for loadable
modules.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Kevin Paul Herbert
> Sent: Monday, February 25, 2002 10:36 AM
> To: Matthew Dharm; Linux-MIPS
> Subject: Re: Is this a toolchain bug?
>
>
> At 5:57 PM -0800 2/22/02, Matthew Dharm wrote:
> >
> >The toolchain I'm using is the one from oss.sgi.com by H.J. Liu
> >(toolchain-20011020-1).  Because of the way the e1000
> driver Makefile
> >works, I'm actually compiling it using the native compiler
> on-target.
> I just tossed out most of intel's makefile so that I could build it
> as part of our cross-build (hosted on RedHat i386),
> building it as a
> module. When I was using the 3.0 driver, I hacked it to be
> built with
> the kernel (not a module at all). It was just a few minutes of
> makefile hacking, and may save you some grief.
>
> There is a driver V4.0.7? I *just* picked up 3.5 a little while
> ago... can you point me at where on intel's website you got your
> driver?
>
> Thanks,
> Kevin
> --
>
