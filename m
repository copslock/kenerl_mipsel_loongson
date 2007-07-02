Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jul 2007 15:34:45 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:13828 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022861AbXGBOen (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Jul 2007 15:34:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B19C1E1CA3;
	Mon,  2 Jul 2007 16:34:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GjcjJRgtplr7; Mon,  2 Jul 2007 16:34:32 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 618E6E1C6B;
	Mon,  2 Jul 2007 16:34:32 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l62EYi2A017930;
	Mon, 2 Jul 2007 16:34:45 +0200
Date:	Mon, 2 Jul 2007 15:34:40 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: O2 RM7000 Issues
In-Reply-To: <4687DCE2.8070302@gentoo.org>
Message-ID: <Pine.LNX.4.64N.0707021531090.15096@blysk.ds.pg.gda.pl>
References: <4687DCE2.8070302@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3574/Mon Jul  2 10:07:06 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 1 Jul 2007, Kumba wrote:

> I've got a feeling this is likely a problem in the kernel more than it is a
> problem in the userland, but the question is how to go about determining which
> and where.  The RM7K's are pretty rare, so I imagine there's probably a few
> undiscovered quirks in the code (notably the SC code in
> arch/mips/mm/sc-rm7k.c). 

 FYI, I had problems with the secondary cache of this CPU the last time I 
tried it with a Malta too -- random hangs of user processes.  So far I 
have had no time to dig into it unfortunately.

  Maciej
