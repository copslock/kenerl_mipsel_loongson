Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 10:12:33 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:39180 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226035AbVF1JMR>; Tue, 28 Jun 2005 10:12:17 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A5873E1C95; Tue, 28 Jun 2005 11:11:46 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02685-04; Tue, 28 Jun 2005 11:11:46 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6A069E1C8A; Tue, 28 Jun 2005 11:11:46 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5S9B1ac018513;
	Tue, 28 Jun 2005 11:11:01 +0200
Date:	Tue, 28 Jun 2005 10:11:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	peter fuerst <pf@net.alphadv.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] blast_scache nop for sc cpus without scache
In-Reply-To: <Pine.LNX.4.21.0506280900370.858-100000@Opal.Peter>
Message-ID: <Pine.LNX.4.61L.0506281006450.13758@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.21.0506280900370.858-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/959/Tue Jun 28 01:00:06 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Jun 2005, peter fuerst wrote:

> Here's what helped me *a lot* when debugging. It's rather ugly, polluting
> printk.c with platform/driver-(cross-)dependent hacks, but output is available
> immediately on kernel startup, and on some machines you just can't do without
> that ;)
> (perhaps someone sometimes will create a clean implementation...)

 Hint, hint!  Please have a look at arch/mips/dec/prom/console.c to see 
how trivial it can be!  (Of course DECstations have a particularly fancy 
piece of firmware -- you may have to do more work with less capable one.)

  Maciej
