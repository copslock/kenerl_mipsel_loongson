Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 18:43:47 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:53772 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226487AbVGKRn1>; Mon, 11 Jul 2005 18:43:27 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1AD54E1C65; Mon, 11 Jul 2005 19:44:17 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31636-10; Mon, 11 Jul 2005 19:44:16 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id CA9EEE1C64; Mon, 11 Jul 2005 19:44:16 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6BHiLnx030212;
	Mon, 11 Jul 2005 19:44:21 +0200
Date:	Mon, 11 Jul 2005 18:44:31 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050711173104.GM2765@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0507111840580.22410@blysk.ds.pg.gda.pl>
References: <20050711170613Z8226486-3678+2546@linux-mips.org>
 <20050711173104.GM2765@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/976/Mon Jul 11 12:09:22 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 11 Jul 2005, Ralf Baechle wrote:

> > Log message:
> > 	Who needs module versions?
> 
> Generally considered a good idea ...

 Generally most useful for binary-only modules.  Do we have any for the 
DECstation?  If you update "vmlinux", you can also update modules.  Other 
platforms get away without versioning by default -- I see no reason to be 
different here.

  Maciej
