Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 16:22:18 +0000 (GMT)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:19581 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8225496AbUA1QWS>;
	Wed, 28 Jan 2004 16:22:18 +0000
Received: from rekin.icm.edu.pl (rekin.icm.edu.pl [192.168.1.132])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.6/icm) with ESMTP id i0SGM7MM027098
	for <linux-mips@linux-mips.org>; Wed, 28 Jan 2004 17:22:07 +0100 (CET)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1AlsS4-0000Hv-00
	for <linux-mips@linux-mips.org>; Wed, 28 Jan 2004 17:22:04 +0100
Date: Wed, 28 Jan 2004 17:22:04 +0100
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: [patch] pg-r4k.c bugs for R4600 rev.2.0
Message-ID: <20040128162203.GA998@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040115231735.GA6619@icm.edu.pl> <4007386F.80207@gentoo.org> <20040115172602.H18368@mvista.com> <20040116115053.GA18099@icm.edu.pl> <20040120130625.GA24435@icm.edu.pl> <20040120162800.GA29792@icm.edu.pl> <20040123161410.GC20047@icm.edu.pl> <Pine.LNX.4.55.0401261659540.14505@jurand.ds.pg.gda.pl> <20040126170028.GA15176@linux-mips.org> <20040128013723.GA17887@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128013723.GA17887@linux-mips.org>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Wed, Jan 28, 2004 at 02:37:23AM +0100, Ralf Baechle wrote:
> On Mon, Jan 26, 2004 at 06:00:28PM +0100, Ralf Baechle wrote:
> 
> > Looks good, so please feel free to apply.
> > 
> > I just bent the kernel for my R4600 v2.0 machine (RM200) into shape again
> > and will test it later; will let you know if there's any problems.
> 
> I still have problems with R5000 and R4600 V2.0 with the CVS kernel ...

Still not good on my R4600 v2.0 either. I mean it boots, but throws an
malloc: "assertion botched" in parse.y:3258 (I think) and then, while
trying to shutdown the system (init 0), it throws several oopses in fault.c
"do_page_fault, line 206". I'll try to provide more info tomorrow. Now I
have to run.

Thanks and HAND.

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>                                                 
Interdisciplinary Centre for Mathematical and Computational Modelling                               
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810                               
