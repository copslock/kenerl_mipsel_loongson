Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 19:04:51 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:40455 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226500AbVGKSEe>; Mon, 11 Jul 2005 19:04:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8DCBDF5A4C; Mon, 11 Jul 2005 20:05:22 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04504-05; Mon, 11 Jul 2005 20:05:22 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D696CF59A1; Mon, 11 Jul 2005 20:05:21 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6BI5QY2031323;
	Mon, 11 Jul 2005 20:05:26 +0200
Date:	Mon, 11 Jul 2005 19:05:36 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050711175337.GN2765@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0507111903270.22410@blysk.ds.pg.gda.pl>
References: <20050711170613Z8226486-3678+2546@linux-mips.org>
 <20050711173104.GM2765@linux-mips.org> <Pine.LNX.4.61L.0507111840580.22410@blysk.ds.pg.gda.pl>
 <20050711175337.GN2765@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/976/Mon Jul 11 12:09:22 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 11 Jul 2005, Ralf Baechle wrote:

> If there's a mistake that people can do they will rarely miss that
> opportunity.  Desperate users tend to move modules from their
> distribution into a kernel built from CVS or change kernel config options
> and somehow manage to keep a few modules built with the old options etc.

 Hmm...

> It's no fun receiving bug reports only to later figure out it was just
> a silly pilot error, so for anything that's going to the net I really
> keep that option on.

 Well, I receive virtually zero bug reports for the DECstation.  The code 
must be perfect. ;-)

> Of course I'd disable it for a closed appliance nor do I keep it turned
> on for my own builds.

 We'll see.

  Maciej
