Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QLU0D04617
	for linux-mips-outgoing; Tue, 26 Feb 2002 13:30:00 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QLTt904611
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 13:29:55 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1QKTrR26308;
	Tue, 26 Feb 2002 12:29:53 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Tommy S. Christensen" <tommy.christensen@eicon.com>
Cc: "Kevin Paul Herbert" <kph@ayrnetworks.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: RE: Is this a toolchain bug?
Date: Tue, 26 Feb 2002 12:29:53 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIOEMICFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3C7B63E7.8DFF9D89@eicon.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Either insmod or depmod should complain if it can detect a scenario
like this.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: owner-linux-mips@oss.sgi.com
> [mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Tommy S.
> Christensen
> Sent: Tuesday, February 26, 2002 2:31 AM
> To: Matthew Dharm
> Cc: Kevin Paul Herbert; Linux-MIPS
> Subject: Re: Is this a toolchain bug?
>
>
> Matthew Dharm wrote:
> >
> > So, we've got a problem somewhere in the module handling.
>  Either the
> > symbol wasn't being relocated properly, or it wasn't
> being allocated
> > properly, or something.  I'm not an expert in this region of the
> > kernel, but my guess is that we're going to see this more and more
> > often, so someone with a clue should take a look at this.
>
> To me, this looks like a problem with common symbols that I have run
> into a couple of times (I think it was in i2o).
>
> Compiling with -fno-common or linking with -d worked for me.
> (Or avoid having uninitialized global variables.)
>
> I guess insmod should actually complain in this case ?!
>
>  -Tommy
>
