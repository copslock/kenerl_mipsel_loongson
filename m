Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 11:13:12 +0000 (GMT)
Received: from gw.icm.edu.pl ([IPv6:::ffff:212.87.0.39]:15955 "EHLO
	atol.icm.edu.pl") by linux-mips.org with ESMTP id <S8225299AbUA3LNL>;
	Fri, 30 Jan 2004 11:13:11 +0000
Received: from rekin.icm.edu.pl (rekin.icm.edu.pl [192.168.1.132])
	by atol.icm.edu.pl (8.12.6/8.12.6/rzm-4.6/icm) with ESMTP id i0UBCthp014310
	for <linux-mips@linux-mips.org>; Fri, 30 Jan 2004 12:12:55 +0100 (CET)
Received: from rathann by rekin.icm.edu.pl with local (Exim 3.35 #1 (Debian))
	id 1AmWa0-00026w-00
	for <linux-mips@linux-mips.org>; Fri, 30 Jan 2004 12:12:56 +0100
Date: Fri, 30 Jan 2004 12:12:56 +0100
From: "Dominik 'Rathann' Mierzejewski" <rathann@icm.edu.pl>
To: linux-mips@linux-mips.org
Subject: Re: linux 2.4 and Indy
Message-ID: <20040130111255.GB7501@icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040129102215.GC17760@ballina> <4018E322.9030801@gentoo.org> <20040130105903.GA12562@ballina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130105903.GA12562@ballina>
User-Agent: Mutt/1.3.28i
Return-Path: <rathann@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rathann@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Fri, Jan 30, 2004 at 11:59:03AM +0100, Jorik Jonker wrote:
[...]
> Hmm, that's strange, I believe that should do the trick, but when I checkout
> a tree (cvs -z3 -d:.. co -r linux_2_4 -D 'December 10 2003' linux), I still
> get a 'half-booting' kernel. Shall I try to checkout an even older one, until
> something is starting to work, or is something else going wrong?

I have a working 5th December 2003 kernel running on R4600 V2.0, but since
there were no changes between 5th and 11th December, I'd suspect that yours
should boot fine, too. Did you check if the files you checked out are really
not later than 11th December?

-- 
Dominik 'Rathann' Mierzejewski <rathann@icm.edu.pl>                                                 
Interdisciplinary Centre for Mathematical and Computational Modelling                               
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810                               
