Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 14:27:33 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:33797 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022113AbXHBN1a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 14:27:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 98C1DE1C75;
	Thu,  2 Aug 2007 15:27:26 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U3SphRYG9+F7; Thu,  2 Aug 2007 15:27:26 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3B7B0E1C63;
	Thu,  2 Aug 2007 15:27:26 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l72DRYcC025624;
	Thu, 2 Aug 2007 15:27:34 +0200
Date:	Thu, 2 Aug 2007 14:27:29 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <46B1D2F7.8000002@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0708021349040.22591@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
 <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl>
 <46B0B6B4.5090103@ru.mvista.com> <Pine.LNX.4.64N.0708011737170.20314@blysk.ds.pg.gda.pl>
 <46B0BD99.6070901@ru.mvista.com> <Pine.LNX.4.64N.0708020945020.22591@blysk.ds.pg.gda.pl>
 <46B1D2F7.8000002@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi,

> > It does not help too much with a 32-bit virtual address space indeed.
> > Though I gather it has to be very sparsely populated as 16MiB is enough to
> > cover the whole configuration space of a single PCI bus tree.  Thus it has 
> 
>    Hm, maybe 16 MiB would be enough indeed, as the Alchemy CPUs are known to
> not support bus masters behind PCI bridges...

 That is unrelated -- for configuration accesses (assuming the basic 
configuration space) you need: 8 bits for the bus number + 5 bits for the 
device number + 3 bits for the function number + 8 bits for the register 
number.  The total is 24 bits.  It is up to hardware to sort it out and 
put the right bits on the bus.

  Maciej
