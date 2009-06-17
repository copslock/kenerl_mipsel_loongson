Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 17:39:44 +0200 (CEST)
Received: from gateway-1237.mvista.com ([63.81.120.158]:56249 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492880AbZFQPjg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 17:39:36 +0200
Received: from tanderson2xp (nexus.az.mvista.com [10.50.1.161])
	by hermes.mvista.com (Postfix) with ESMTP
	id 43E8B1ACBB; Wed, 17 Jun 2009 08:37:51 -0700 (PDT)
From:	"Tim Anderson" <tanderson@mvista.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: [PATCH 2/5] Extend IPI handling to CPU number
Date:	Wed, 17 Jun 2009 08:36:08 -0700
Message-ID: <6968DC16EA224848A8E9F0DBC4EEE98E@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
In-Reply-To: <20090617081412.GB13467@linux-mips.org>
Thread-Index: AcnvI7gybdWEttWyQ3e4/AZP9ua9BAAPX74w
Return-Path: <tanderson@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanderson@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf,

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> Sent: Wednesday, June 17, 2009 1:14 AM
> To: Tim Anderson
> Cc: linux-mips@linux-mips.org
> Subject: Re: [PATCH 2/5] Extend IPI handling to CPU number
> 
> On Tue, Jun 16, 2009 at 04:58:28PM -0700, Tim Anderson wrote:
> 
> > diff --git a/arch/mips/kernel/irq-gic.c b/arch/mips/kernel/irq-gic.c
> > index 1d6ac92..5cf003d 100644
> > --- a/arch/mips/kernel/irq-gic.c
> > +++ b/arch/mips/kernel/irq-gic.c
> > @@ -245,6 +245,10 @@ static void __init gic_basic_init(void)
> >  		if (cpu == X)
> >  			continue;
> >  
> > +		if (cpu == 0 && i != 0 && _intrmap[i].intrnum == 0 &&
> > +			 _intrmap[i].ipiflag == 0)
>                         ^
>                         wrong indentation

Good Point I will correct this and resubmit.

> 
> > +			continue;
> > +
> 
>   Ralf
> 
