Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA86855 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Jun 1999 07:35:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA95298
	for linux-list;
	Fri, 25 Jun 1999 07:33:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA14932
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 25 Jun 1999 07:33:53 -0700 (PDT)
	mail_from (andy@derfel99.freeserve.co.uk)
Received: from mail1.svr.pol.co.uk (mail1.svr.pol.co.uk [195.92.193.18]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA06563
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jun 1999 07:33:52 -0700 (PDT)
	mail_from (andy@derfel99.freeserve.co.uk)
Received: from modem-86.neptunium.dialup.pol.co.uk ([62.136.46.86] helo=snafu)
	by mail1.svr.pol.co.uk with smtp (Exim 2.12 #1)
	id 10xX38-0005fp-00
	for linux@cthulhu.engr.sgi.com; Fri, 25 Jun 1999 15:33:50 +0100
Message-ID: <002701bebf17$cd9e4fd0$0a02030a@snafu>
From: "Andrew Linfoot" <andy@derfel99.freeserve.co.uk>
To: <linux@cthulhu.engr.sgi.com>
References: <19990622032859.B6955@thepuffingroup.com> <19990622152145.A1059@uni-koblenz.de> <19990623014923.A8953@thepuffingroup.com> <19990625002853.D17220@uni-koblenz.de>
Subject: Re: File corruption
Date: Fri, 25 Jun 1999 15:34:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I have been running 2.2.1 on my indy for about 3 weeks now and have
encountered problems like this,
in fact i am surprised at how stable the box is, i have been doing some
quite large builds of qt, kde and the like too. If this is reproducible then
i would be prepared to experiment on one of my boxes.

The only gripe i have is that the scsi driver breaks when i attach external
devices, any ideas?

Andy
----- Original Message -----
From: Ralf Baechle <ralf@uni-koblenz.de>
To: <linux@cthulhu.engr.sgi.com>
Sent: Thursday, June 24, 1999 11:28 PM
Subject: Re: File corruption


> On Wed, Jun 23, 1999 at 01:49:23AM +0200, Ulf Carlsson wrote:
>
> > > And under which kernel version did this start to happen?
> >
> > 2.2.1 I think.
>
> Are you shure?  The problem Alan is tracking started to hit from 2.2.7 on.
> If 2.2.1 already starts making these kind of troubles then we probably
> track two different problems.
>
> > Unfortunately I don't have IRIX.  However, I have a 133 MHz R4600 CPU
with 512 k
> > board cache.  I have two 1 Gb SCSI driver connected.
>
> Is this a low-mem configuration?  The problem Alan is tracking apparently
> seems to hit low mem systems more often.
>
>   Ralf
>
