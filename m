Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 23:17:45 +0000 (GMT)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:63810 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8225480AbUAOXRo>;
	Thu, 15 Jan 2004 23:17:44 +0000
Received: from rekin.icm.edu.pl (rekin.icm.edu.pl [192.168.1.132])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.6/icm) with ESMTP id i0FNHV4p020769
	for <linux-mips@linux-mips.org>; Fri, 16 Jan 2004 00:17:31 +0100 (CET)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1AhGk4-0001jD-00
	for <linux-mips@linux-mips.org>; Fri, 16 Jan 2004 00:17:36 +0100
Date: Fri, 16 Jan 2004 00:17:36 +0100
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: Current 2.4 CVS (2.4.24-pre2) doesn't boot on SGI Indy
Message-ID: <20040115231735.GA6619@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040115141427.GA28546@icm.edu.pl> <Pine.LNX.4.21.0401151816540.3511-100000@www.marty44.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0401151816540.3511-100000@www.marty44.net>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Thu, Jan 15, 2004 at 06:19:36PM +0100, Martin Boehme wrote:
> Hello,
> 
> is your indy a R4k?

Yes, it's an R4600@133MHz.

> If so, I had the same problems. On R5k it works.
> There was some talking and some updates of R4k last two weeks. Look in
> the archives.
> Well, let's wait for the next commit to the offical kernel tree.

Well, it appears something has been broken during the last 2 months.
Good to know I'm not alone in this.

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>                                                 
Interdisciplinary Centre for Mathematical and Computational Modelling                               
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810                               
