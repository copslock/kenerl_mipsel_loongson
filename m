Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 15:04:23 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:10259 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224990AbUKXPES>; Wed, 24 Nov 2004 15:04:18 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7B659E1C7E; Wed, 24 Nov 2004 16:04:08 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22444-04; Wed, 24 Nov 2004 16:04:08 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 279F5E1C7C; Wed, 24 Nov 2004 16:04:08 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAOF4HOI026284;
	Wed, 24 Nov 2004 16:04:18 +0100
Date: Wed, 24 Nov 2004 15:04:10 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Manish Lachwani <mlachwani@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
In-Reply-To: <20041124094423.GB21039@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0411241451290.843@blysk.ds.pg.gda.pl>
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be>
 <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de>
 <20041122070117.GB25433@linux-mips.org> <41A283BD.3080300@mvista.com>
 <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl> <41A29DCF.8030308@mvista.com>
 <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl>
 <20041124014057.GE902@rembrandt.csv.ica.uni-stuttgart.de>
 <20041124094423.GB21039@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/590/Wed Nov 17 22:03:52 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 24 Nov 2004, Ralf Baechle wrote:

> > >  	default:
> > >  		/*
> > >  		 * Others are assumed to have one cycle mtc0 hazard,
> > > -		 * and one cycle tlbwr hazard.
> > > +		 * and one cycle tlbwr hazard or to understand ehb.
> > >  		 * XXX: This might be overly general.
> > >  		 */
> > > -		i_nop(p);
> > > +		i_ehb(p);
> > >  		i_tlbwr(p);
> > > -		i_nop(p);
> > > +		i_ehb(p);
> > >  		break;
> > 
> > Does r24k really need both delays? If not, it should get its own case.

 Good point -- "eret" is a hazard barrier, too, so the second "ehb" is not
needed.  For any release 2 implementation, actually.

> > Probably it should be separated even if it is identical, the code above
> > is nothing but a guess based on preexisting code.
> 
> I would suggest to default to EHB only for architecture revision 2.  For
> any pre-V2 processor the outcome of a default case is basically luck and
> so I would suggest to just panic and force people to read their CPU
> manual.

 Agreed.  We should probably verify these few "traditional" CPUs to be
handled explicitly ourselves, though, as there is no one else to look 
after them.

  Maciej
