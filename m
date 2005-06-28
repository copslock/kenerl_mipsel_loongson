Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 10:36:36 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:35299 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226038AbVF1JgU>; Tue, 28 Jun 2005 10:36:20 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j5S9Znt16872;
	Tue, 28 Jun 2005 11:35:50 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 28 Jun 2005 11:35:48 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j5S9Zlk11513;
	Tue, 28 Jun 2005 11:35:47 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Tue, 28 Jun 2005 11:35:47 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
cc:	peter fuerst <pf@net.alphadv.de>, linux-mips@linux-mips.org
Subject: Re: [patch] blast_scache nop for sc cpus without scache
In-Reply-To: <Pine.LNX.4.61L.0506281006450.13758@blysk.ds.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10506281135030.11213-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

>  Hint, hint!  Please have a look at arch/mips/dec/prom/console.c to see 
> how trivial it can be!  (Of course DECstations have a particularly fancy 
> piece of firmware -- you may have to do more work with less capable one.)

Nice to know that you can register a console so early on :)

Both the ImpactSR and Odyssey drivers contain early console code (hint,
hint, pf) so they could be used for this.

Stanislaw
