Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 11:43:02 +0000 (GMT)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:29088 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8225219AbUBCLnC>;
	Tue, 3 Feb 2004 11:43:02 +0000
Received: from rekin.icm.edu.pl (rekin.icm.edu.pl [192.168.1.132])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.6/icm) with ESMTP id i13Bgphp032519
	for <linux-mips@linux-mips.org>; Tue, 3 Feb 2004 12:42:51 +0100 (CET)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1AnyxB-0007Ev-00
	for <linux-mips@linux-mips.org>; Tue, 03 Feb 2004 12:42:53 +0100
Date: Tue, 3 Feb 2004 12:42:53 +0100
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: R4600 V1.7 errata
Message-ID: <20040203114252.GA27810@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org> <20040131030435.GA24228@linux-mips.org> <20040131141027.GA11048@ballina> <20040201045258.GA4601@linux-mips.org> <20040203113928.GA28340@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203113928.GA28340@linux-mips.org>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Tue, Feb 03, 2004 at 12:39:28PM +0100, Ralf Baechle wrote:
[...] 
> Jorik was so friendly to track down the patch in CVS that broke the R4600
> V1.7 back in time.  With that as a start it was fairly easy to isolate the
> problem further.  Seems we became victim of some erratum that affects the
> operation of indexed I-cache flushes only.  Last night I commited a patch
> that provides an optimized solution for the problem.

I assume it's safe to test it now? I'll build it for my R4600 V2.0 and
report in a while. Stay tuned.

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>                                                 
Interdisciplinary Centre for Mathematical and Computational Modelling                               
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810                               
