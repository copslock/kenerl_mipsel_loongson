Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 16:16:24 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3847 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037551AbWHUPQW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Aug 2006 16:16:22 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 27BEAF6E17;
	Mon, 21 Aug 2006 17:16:18 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iMkV-YC-NLBA; Mon, 21 Aug 2006 17:16:17 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id BFEF2F6483;
	Mon, 21 Aug 2006 17:16:17 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.7/8.13.1) with ESMTP id k7LFGQtR012308;
	Mon, 21 Aug 2006 17:16:26 +0200
Date:	Mon, 21 Aug 2006 16:16:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] qemu does not have dcache aliases
In-Reply-To: <20060821.225910.108307053.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0608211612090.17504@blysk.ds.pg.gda.pl>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl>
 <20060821.225910.108307053.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1700/Mon Aug 21 14:08:16 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 21 Aug 2006, Atsushi Nemoto wrote:

> >  Hmm, it looks like a bug in QEMU -- we should definitely implement them!
> 
> Well, the QEMU cpu has 2-way 2kB dcache... does not have aliasing
> anyway. :-)

 I don't think emulating a bigger cache so that we can add aliases should 
be *that* difficult.  Adding aliases themselves might be a bit trickier, 
but the gain would certainly justify the hassle, wouldn't it?

  Maciej
