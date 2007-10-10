Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 13:18:21 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:33167 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022111AbXJJMSN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 13:18:13 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 1B3F240175;
	Wed, 10 Oct 2007 14:17:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id GuJ0ApsPWLrd; Wed, 10 Oct 2007 14:17:33 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 46EF5400BA;
	Wed, 10 Oct 2007 14:17:33 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9ACHZtS012927;
	Wed, 10 Oct 2007 14:17:35 +0200
Date:	Wed, 10 Oct 2007 13:17:31 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <20071010085343.GA31184@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710101303460.9821@blysk.ds.pg.gda.pl>
References: <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de>
 <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org>
 <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl>
 <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl>
 <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl>
 <20071010085343.GA31184@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4521/Wed Oct 10 09:58:01 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 10 Oct 2007, Ralf Baechle wrote:

> >  As long as the user is indeed capable of knowing what the exact CPU type 
> > is.  I have been told replacing R4X00 with a choice like R4000, R4400, 
> > R4600, R4700 may already be too much of a hassle.
> 
> Four choices is too much; after all these four marketing names are really
> just 4 variants of two fairly similar processors.  Doable?  Yes.  A useful
> improvment?  I doubt, otoh users of those old machines count every cycle
> by hand still ;-)

 Except from the note on cycle counting ;-) I do agree these days and 
about the only place that cares about the subtleties of the R4k models are 
the TLB handlers which we have now solved with the current approach.

> One of the things I'm trying to achieve is to get rid of all the use of
> CONFIG_CPU_MIPS32_R1 and similar processor symbols in code coming to a
> point where selection of one of those symbols in Kconfig only means to
> optimize a kernel for the selected core without sacrificing compatibility.

 Well, these options should really be used to select the "-march=" option 
only.  We have some places, such as <asm/stackframe.h>, where the 
dependency is tough to eliminate, but that is definitely the right 
direction.

> (But of course the few machines that support processors with multiple ISAs
> spoil that plan a little ..)

 Well, they have cp0.prid and cp0.config* registers at their disposal.

> >  I do not think we happen to handle this scenario -- the more interesting 
> > configurations that could benefit do not support the cp0.ebase register 
> > making per-CPU handlers quite a challenge (i.e. the cost would exceed the 
> > benefit).
> 
> It's doable but there is little point.  Ebase is an R2 feature and who
> on earth would mix pre-R2 and R2 cores in a SOC now that R2 is established
> for a few years?

 I have actually thought of one of your pet SGI machine setups -- where 
the CPUs are mixed and are either MIPS III or MIPS IV each.  I do not 
recall you mentioning the exception vector range of RAM being local to the 
CPU cards, so I am assuming the handlers are always shared.

  Maciej
