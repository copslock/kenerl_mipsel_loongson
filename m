Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0V2Nr332136
	for linux-mips-outgoing; Wed, 30 Jan 2002 18:23:53 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0V2Nkd32133
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 18:23:46 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0V1NhX02382;
	Wed, 30 Jan 2002 17:23:43 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Matthew Dharm" <mdharm@momenco.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: RE: More data: I've made a CVS build that doesn't crash!
Date: Wed, 30 Jan 2002 17:23:43 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIEECOCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIAECMCFAA.mdharm@momenco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Well, I'm closer... and more confused.

I've managed to make a 2.4.3 build which does not exhibit any of the
instability or crashing... but I did it by disabling half of the
memory!

In linux/arch/mips/gt64120/momenco_ocelot/setup.c is some code to read
a PLD and add a memory region.  64MByte is already added much earlier,
and now we're adding the rest.  The board I'm testing on is 128MByte,
so it tries to add another 64MByte region which is physically
contiguous to the first region.

As far as I can tell, all of my memory works perfectly.  I'm going to
do some more tests, but both vxWorks and OpenBSD run on this board
without any problems.

So, can anyone think of some likely culprits for what is wrong here?
Some piece of code which only works with addresses under 64MByte,
perhaps?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Matthew Dharm
> Sent: Wednesday, January 30, 2002 3:02 PM
> To: Linux-MIPS
> Subject: More data: I've made a CVS build that doesn't crash!
>
>
> So, after much trial and error, I've managed to make a build out of
> the CVS repository that works and doesn't crash.
>
> I managed to build the linux_2_4_2 tag with the attached
> patch -- the
> patch just fixes up two lines of source code to match new parameter
> definitions.  Nothing really fancy.  But this kernel is rock-solid,
> and the linux_2_4_3 tag is very crash-prone.
>
> Of course, lots of stuff changed in between all this... so I'm still
> pouring over the diffs to see what is causing this.  Anyone
> with some
> helpful suggestions is encouraged to speak up.
>
> Someone with CVS checking authority might want to check in
> the patch,
> just so other people can build 2.4.2 more easily.
>
> Matt
>
> --
> Matthew D. Dharm                            Senior Software Designer
> Momentum Computer Inc.                      1815 Aston Ave.
>  Suite 107
> (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> Momentum Works For You                      www.momenco.com
>
