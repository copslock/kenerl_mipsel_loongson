Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UMODV24673
	for linux-mips-outgoing; Wed, 30 Jan 2002 14:24:13 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UMO7d24669
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 14:24:07 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0ULNuX01124;
	Wed, 30 Jan 2002 13:23:56 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Justin Carlson" <justincarlson@cmu.edu>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: Does Linux invalidate TLB entries?
Date: Wed, 30 Jan 2002 13:23:56 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIOECKCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1012423478.2356.9.camel@gs256.sp.cs.cmu.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The errata, unfortunately, doen't say.

It does say that the suggested workaround is to use the TLBP operation
to look for a matching but invalid entry, and then branch to the
invalid handler if necessary.

It also says that the CP0 Cause, EPC, BadVaddr and ENHI will wold the
values for the dstream TLB exception.  In other words, it's all set up
for the invalid exception, but it jumps to the refill exception
instead.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Justin Carlson [mailto:justincarlson@cmu.edu]
> Sent: Wednesday, January 30, 2002 12:45 PM
> To: Matthew Dharm
> Cc: linux-mips@oss.sgi.com
> Subject: RE: Does Linux invalidate TLB entries?
>
>
> On Wed, 2002-01-30 at 14:33, Matthew Dharm wrote:
> > Damn.  The entire line of processors from the RM7000 to the 7000A,
> > 7000B, 7061A, and 7065A all have a bug which involves invalid TLB
> > entries.
> >
> > I've sent the errata to Ralf only for review.  Basically, under
> > certain circumstances the processor will take the "TLB refill"
> > exception vector instead of the "TLB invalid" vector.
>
> What's the behavior if the invalid entry is not fixed up
> and we replay
> the offending instruction?  If there's a guarantee that it
> won't take
> the wrong vector repeatedly, then this would be trivial to
> fix (and may
> not need one at all for correctness).
>
> -Justin
>
>
