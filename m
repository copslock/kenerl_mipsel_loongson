Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2004 11:51:09 +0000 (GMT)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:35881 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8225507AbUAPLvI>;
	Fri, 16 Jan 2004 11:51:08 +0000
Received: from rekin.icm.edu.pl (rekin.icm.edu.pl [192.168.1.132])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.6/icm) with ESMTP id i0GBot4p006342
	for <linux-mips@linux-mips.org>; Fri, 16 Jan 2004 12:50:56 +0100 (CET)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1AhSV3-0004nB-00
	for <linux-mips@linux-mips.org>; Fri, 16 Jan 2004 12:50:53 +0100
Date: Fri, 16 Jan 2004 12:50:53 +0100
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: Current 2.4 CVS (2.4.24-pre2) doesn't boot on SGI Indy
Message-ID: <20040116115053.GA18099@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040115141427.GA28546@icm.edu.pl> <Pine.LNX.4.21.0401151816540.3511-100000@www.marty44.net> <20040115231735.GA6619@icm.edu.pl> <4007386F.80207@gentoo.org> <20040115172602.H18368@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115172602.H18368@mvista.com>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Thu, Jan 15, 2004 at 05:26:02PM -0800, Jun Sun wrote:
> On Thu, Jan 15, 2004 at 08:03:43PM -0500, Kumba wrote:
> > Dominik 'Rathann' Mierzejewski wrote:
[...] 
> > I have a 2.4.23 kernel I used from a 20031128 CVS snapshot that works 
> > fine, but a 2.4.23 20031214 snapshot didn't work (on an R4400@250MHz 
> > I2), so likely the problem was introduced sometime between those dates. 
> >   Might help for tracking down the issue.

Thanks, that'll be useful.

> If you like to know what changes had been made during that period,
> you may find my tracking tool useful.  Just select the 2.4 branch
> and enter the date range, it will give you all the changes in 
> patch format.  So you can also find out who is the lamer! :)
> 
> http://linux.junsun.net/xcvs/xcvs_linux_mips

Excellent tool! Thank you very much. I'll try and identify the offending
patch today.

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>                                                 
Interdisciplinary Centre for Mathematical and Computational Modelling                               
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810                               
