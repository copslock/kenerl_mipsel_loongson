Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 13:19:45 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:46742 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20024722AbXIDMTg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 13:19:36 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l84CJAm8020653;
	Tue, 4 Sep 2007 05:19:10 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l84CJPLx015870;
	Tue, 4 Sep 2007 05:19:26 -0700 (PDT)
Message-ID: <00a601c7eeed$d8095aa0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Nigel Stephens" <nigel@mips.com>,
	"Thiemo Seufer" <ths@networkno.de>
Cc:	"yshi" <yang.shi@windriver.com>, <linux-mips@linux-mips.org>
References: <46DD1CD1.5040306@windriver.com> <006901c7eeda$d8049a50$10eca8c0@grendel> <1188901951.4106.16.camel@yshi.CORP> <006f01c7eee5$bbe77c60$10eca8c0@grendel> <20070904115527.GA848@networkno.de> <46DD49B9.2090306@mips.com>
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
Date:	Tue, 4 Sep 2007 14:19:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> >> In that case, your core is a 4Kc and not a 4KEc.    
> >
> > Not quite true, early revisions of the 4KEc were only release 1. This
> > seems to be a bug in arch/mips/cpu-probe.c:
> >
> > static inline void cpu_probe_mips(struct cpuinfo_mips *c)
> > {
> >         decode_configs(c);
> >         switch (c->processor_id & 0xff00) {
> >         case PRID_IMP_4KC:
> >                 c->cputype = CPU_4KC;
> >                 break;
> >         case PRID_IMP_4KEC:
> >                 c->cputype = CPU_4KEC;
> >                 break;
> >         case PRID_IMP_4KECR2:
> >                 c->cputype = CPU_4KEC;
> >                 break;
> > ...
> >
> > The type for PRID_IMP_4KEC should be CPU_4KC.
> >
> >   
> 
> Maybe the probing code should read the ISA revision level from the AR 
> bits (12:10) of the Config0 register to figure out which revision of the 
> ISA is implemented.

It does.  c->cputype isn't what needs to be modulated here, it's c->isa_level,
which gets decoded as part of decode_configs(), as near as I can tell correctly
in the most recent source tree I've got. And it's isa_level that's being tested
by the cpu_has_mips32r2 et. al. macros.

            Regards,

            Kevin K.
