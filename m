Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 10:39:24 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:29703 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021963AbXHBJjW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 10:39:22 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6EFB0E1C6D;
	Thu,  2 Aug 2007 11:39:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J5Ub4yO326nt; Thu,  2 Aug 2007 11:39:19 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 06C9FE1C66;
	Thu,  2 Aug 2007 11:39:19 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l729dOUh000557;
	Thu, 2 Aug 2007 11:39:24 +0200
Date:	Thu, 2 Aug 2007 10:39:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <46B0BE52.4000302@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0708021024200.22591@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
 <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl>
 <46B0B6B4.5090103@ru.mvista.com> <46B0BE52.4000302@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Aug 2007, Sergei Shtylyov wrote:

> >    No, I don't.  But that was why the original code preferred the wired
> > entry approach over ioremap() -- not to map a whole range...
> 
>    Not the only one: dynamic ioremap() seems to be impossible in interrupt
> context.

 Well, ioremap() may sleep indeed.  How about using a softirq then?  
Broken hardware (=one that requires PCI configuration accesses from the 
IRQ context) is not an excuse to extend the breakage over to software.

  Maciej
