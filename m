Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jan 2004 16:14:31 +0000 (GMT)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:5476 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8225342AbUAWQOX>;
	Fri, 23 Jan 2004 16:14:23 +0000
Received: from rekin.icm.edu.pl (rekin.icm.edu.pl [192.168.1.132])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.6/icm) with ESMTP id i0NGEACM032313
	for <linux-mips@linux-mips.org>; Fri, 23 Jan 2004 17:14:10 +0100 (CET)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1Ak3wg-0006Ec-00
	for <linux-mips@linux-mips.org>; Fri, 23 Jan 2004 17:14:10 +0100
Date: Fri, 23 Jan 2004 17:14:10 +0100
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: Current 2.4 CVS (2.4.24-pre2) doesn't boot on SGI Indy
Message-ID: <20040123161410.GC20047@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040115141427.GA28546@icm.edu.pl> <Pine.LNX.4.21.0401151816540.3511-100000@www.marty44.net> <20040115231735.GA6619@icm.edu.pl> <4007386F.80207@gentoo.org> <20040115172602.H18368@mvista.com> <20040116115053.GA18099@icm.edu.pl> <20040120130625.GA24435@icm.edu.pl> <20040120162800.GA29792@icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120162800.GA29792@icm.edu.pl>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Tue, Jan 20, 2004 at 05:28:01PM +0100, Dominik 'Rathann' Mierzejewski wrote:
> On Tue, Jan 20, 2004 at 02:06:26PM +0100, Dominik 'Rathann' Mierzejewski wrote:
> [...]
> > OK, I've narrowed it down to sometime between 20031205 and 20031214, but
> > since there were no commits between 20031204 and 20031211, it has to be one
> > of these:
> > 
> > 6242 2003/12/11 01:29:17 linux_2_4 ralf Fix a bunch of long standing bugs
> > and performance clear_page issues: - Fi .....
> [...] 
> 
> Found it! After applying the above patch, the kernel no longer goes
> past the "Freeing unused kernel memory" stage. So for now I'm sticking
> with the 20031205 kernel.

Could someone please look into this?

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>                                                 
Interdisciplinary Centre for Mathematical and Computational Modelling                               
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810                               
