Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UKngn21677
	for linux-mips-outgoing; Wed, 30 Jan 2002 12:49:42 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UKnYd21673;
	Wed, 30 Jan 2002 12:49:35 -0800
Received: from host099.momenco.com (www.momenco.com [64.169.228.99]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAB02959; Wed, 30 Jan 2002 11:47:20 -0800 (PST)
	mail_from (mdharm@momenco.com)
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0UJX6X00553;
	Wed, 30 Jan 2002 11:33:06 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: RE: Does Linux invalidate TLB entries?
Date: Wed, 30 Jan 2002 11:33:06 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIOECICFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020130120250.C3313@dea.linux-mips.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Damn.  The entire line of processors from the RM7000 to the 7000A,
7000B, 7061A, and 7065A all have a bug which involves invalid TLB
entries.

I've sent the errata to Ralf only for review.  Basically, under
certain circumstances the processor will take the "TLB refill"
exception vector instead of the "TLB invalid" vector.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@oss.sgi.com]
> Sent: Wednesday, January 30, 2002 3:03 AM
> To: Matthew Dharm
> Cc: Linux-MIPS
> Subject: Re: Does Linux invalidate TLB entries?
>
>
> On Tue, Jan 29, 2002 at 05:03:42PM -0800, Matthew Dharm wrote:
>
> > I'm still trying to track down the cause of all my
> problems, so I'm
> > going over the RM7000 errata.
> >
> > I see one here that I'm not sure if it's a problem or
> not.  It only
> > applies to OSes which invalidate TLB entries and thus
> will cause TLB
> > Invalid exceptions (as opposed to a TLB refill exception,
> I think).
> >
> > So, does Linux invalidate TLBs?  I've been looking at the
> code, and I
> > think the answer is 'no', but I'm not really sure.
>
> Yes, Linux may create TLB entries with V=0.
>
>   Ralf
>
