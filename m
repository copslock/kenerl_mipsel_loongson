Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 20:16:56 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:58119 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122958AbSIDSQz>; Wed, 4 Sep 2002 20:16:55 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g84IGb605836;
	Wed, 4 Sep 2002 11:16:37 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Dominic Sweetman" <dom@algor.co.uk>, "Jun Sun" <jsun@mvista.com>,
	"Linux-MIPS" <linux-mips@linux-mips.org>
Subject: RE: Interrupt handling....
Date: Wed, 4 Sep 2002 11:16:37 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIEEMFCIAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.GSO.3.96.1020904185544.10619L-100000@delta.ds2.pg.gda.pl>
Importance: Normal
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 86
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

Okay... What type of information do you need?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: Maciej W. Rozycki [mailto:macro@ds2.pg.gda.pl]
> Sent: Wednesday, September 04, 2002 10:03 AM
> To: Matthew Dharm
> Cc: Dominic Sweetman; Jun Sun; Linux-MIPS
> Subject: Re: Interrupt handling....
>
>
> On Wed, 4 Sep 2002, Matthew Dharm wrote:
>
> > And this is the heart of the problem.  I set up an
> ioremap, so I thought
> > that the TLB exception handler would fix this for me.  It
> looks like that
> > code won't do anything if the exception was generated
> from an interrupt...
> > Or am I reading it wrong?  I'm not an expert on the TLB code...
>
>  The kernel memory is unswappable so a PTE is always
> available.  If the
> TLB refill handler cannot fetch it for some reason, then
> there is a bug
> somewhere.  It might be helpful if you narrowed it down a
> bit -- refills
> work correctly for modules, including interrupt handlers,
> and they reside
> in KSEG2.
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
>
