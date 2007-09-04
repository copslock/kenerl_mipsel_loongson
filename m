Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 13:48:48 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:45731 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20024743AbXIDMsk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 13:48:40 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 16455846CB;
	Tue,  4 Sep 2007 14:42:32 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1ISXjj-0002Mq-Ff; Tue, 04 Sep 2007 13:42:31 +0100
Date:	Tue, 4 Sep 2007 13:42:31 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Nigel Stephens <nigel@mips.com>, yshi <yang.shi@windriver.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
Message-ID: <20070904124231.GB848@networkno.de>
References: <46DD1CD1.5040306@windriver.com> <006901c7eeda$d8049a50$10eca8c0@grendel> <1188901951.4106.16.camel@yshi.CORP> <006f01c7eee5$bbe77c60$10eca8c0@grendel> <20070904115527.GA848@networkno.de> <46DD49B9.2090306@mips.com> <00a601c7eeed$d8095aa0$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a601c7eeed$d8095aa0$10eca8c0@grendel>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> > >> In that case, your core is a 4Kc and not a 4KEc.    
> > >
> > > Not quite true, early revisions of the 4KEc were only release 1. This
> > > seems to be a bug in arch/mips/cpu-probe.c:
> > >
> > > static inline void cpu_probe_mips(struct cpuinfo_mips *c)
> > > {
> > >         decode_configs(c);
> > >         switch (c->processor_id & 0xff00) {
> > >         case PRID_IMP_4KC:
> > >                 c->cputype = CPU_4KC;
> > >                 break;
> > >         case PRID_IMP_4KEC:
> > >                 c->cputype = CPU_4KEC;
> > >                 break;
> > >         case PRID_IMP_4KECR2:
> > >                 c->cputype = CPU_4KEC;
> > >                 break;
> > > ...
> > >
> > > The type for PRID_IMP_4KEC should be CPU_4KC.
> > >
> > >   
> > 
> > Maybe the probing code should read the ISA revision level from the AR 
> > bits (12:10) of the Config0 register to figure out which revision of the 
> > ISA is implemented.
> 
> It does.

Indeed.

> c->cputype isn't what needs to be modulated here, it's c->isa_level,
> which gets decoded as part of decode_configs(), as near as I can tell correctly
> in the most recent source tree I've got. And it's isa_level that's being tested
> by the cpu_has_mips32r2 et. al. macros.

Unless it got hardcoded in include/asm-mips/mach-foo/cpu-features-override.h.
Maybe Windriver has a local patch which does that by accident.


Thiemo
