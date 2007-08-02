Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 15:21:25 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:56069 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022151AbXHBOVX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 15:21:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 4FB72E1C75;
	Thu,  2 Aug 2007 16:21:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HLd5lGvHUOG9; Thu,  2 Aug 2007 16:21:19 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id EF151E1C63;
	Thu,  2 Aug 2007 16:21:18 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l72ELRsb031622;
	Thu, 2 Aug 2007 16:21:27 +0200
Date:	Thu, 2 Aug 2007 15:21:23 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <46B1E5F2.6050202@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0708021518310.22591@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
 <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl>
 <46B0B6B4.5090103@ru.mvista.com> <46B0BE52.4000302@ru.mvista.com>
 <Pine.LNX.4.64N.0708021024200.22591@blysk.ds.pg.gda.pl> <46B1D3CE.6070507@ru.mvista.com>
 <Pine.LNX.4.64N.0708021428290.22591@blysk.ds.pg.gda.pl> <46B1E5F2.6050202@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3847/Thu Aug  2 13:26:26 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Aug 2007, Sergei Shtylyov wrote:

> > If you want an example, then please have a look at phylib, where in the 
> 
>    No.  I don't feel like rewriting IDE/libata cores. ;-)

 Apparently nobody does, but the lone idea of some code out there to do 
all the PIO transfers in the interrupt context does not seem terribly 
fortunate.  Other bits like this may benefit as a side effect.

  Maciej
