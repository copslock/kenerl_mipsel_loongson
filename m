Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA69627 for <linux-archive@neteng.engr.sgi.com>; Mon, 25 Jan 1999 10:50:19 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA93940
	for linux-list;
	Mon, 25 Jan 1999 10:49:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA90802
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 25 Jan 1999 10:49:06 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn (dialup151-2-41.swipnet.se [130.244.151.105]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA00104
	for <linux@cthulhu.engr.sgi.com>; Mon, 25 Jan 1999 13:49:03 -0500 (EST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m105wWD-00158gC@calypso.saturn> (Debian Smail3.2.0.102)
	for linux@cthulhu.engr.sgi.com; Thu, 28 Jan 1999 19:50:21 +0100 (CET) 
Date: Thu, 28 Jan 1999 19:50:21 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: HAL2 support.
Message-ID: <19990128195021.A897@bun.falkenberg.se>
Mail-Followup-To: Alex deVries <adevries@engsoc.carleton.ca>,
	Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990128004527.A1266@bun.falkenberg.se> <Pine.LNX.3.96.990125122018.21345K-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <Pine.LNX.3.96.990125122018.21345K-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Jan 25, 1999 at 01:12:55PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> First, many thanks for the files.
> 
> Do you mind if I cvs upload them to the SGI kernel mailing list?

CVS upload them to the mailing list, I don't get your point here. I have CVS
access so I may upload them if I want to, and I can post it to the mailing list
if you want me to. But it feels like too much people would laugh at me if I
posted it at the moment.. I'll atleast get it through the compiler once again.

> Do you mind if we hold this discussion on the SGI list once I do that?

Sure, I actually forgot to group reply, that's why this discussion isn't
(wasn't) on the list :-)

> Next, I was hoping you could explain this bit of code to me, I don't quite
> see how it's right from the docs.  I'm looking at page 13 of the HAL2
> docs.

Does something else bother you than the incorrect type? I can't see anything
else being wrong here.

[snip]

> typedef volatile unsigned long hpcreg;

How stupid! I thought I had checked that it was unsigned short.. ;)
My spacing depends on that..

> Next, your spacing isn't quite right I don't think. I think it needs to
> be:
> 
> typedef volatile __u16 hal_reg;
> 
> struct hal2_ctrl_regs {
>         hal_reg _unused0[8];
>         hal_reg isr;             /* 0x10 Status Register */
>         hal_reg _unused1[7];
>         hal_reg rev;             /* 0x20 Revision Register */
>         hal_reg _unused2[7];
>         hal_reg iar;             /* 0x30 Indirect Address Register */
>         hal_reg _unused3[7];
>         hal_reg idr0;            /* 0x40 Indirect Data Register 0 */
>         hal_reg _unused4[7];
>         hal_reg idr1;            /* 0x50 Indirect Data Register 1 */
>         hal_reg _unused5[7];
>         hal_reg idr2;            /* 0x60 Indirect Data Register 2 */
>         hal_reg _unused6[7];
>         hal_reg idr3;            /* 0x70 Indirect Data Register 3 */
> } *h2_ctrl = (hal2_ctrl_regs *) H2_CTRL_PIO;

And this line should actually be:

} *h2_ctrl = (hal2_ctrl_regs *) KSEG1ADDR(H2_CTRL_PIO);

> Does that make sense, or otherwise, what was your thought on this?

It probably does, I have found two bugs so far.

- Ulf
