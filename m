Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 15:33:19 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:54542 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022120AbXHBOdM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 15:33:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 4734DE1C75;
	Thu,  2 Aug 2007 16:33:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MlBeG5JAVeid; Thu,  2 Aug 2007 16:33:08 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id EB06FE1C71;
	Thu,  2 Aug 2007 16:33:07 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l72EXFVM000380;
	Thu, 2 Aug 2007 16:33:15 +0200
Date:	Thu, 2 Aug 2007 15:33:11 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <46B1E716.6070807@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0708021521440.22591@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
 <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl>
 <46B0B6B4.5090103@ru.mvista.com> <Pine.LNX.4.64N.0708011737170.20314@blysk.ds.pg.gda.pl>
 <46B0BD99.6070901@ru.mvista.com> <Pine.LNX.4.64N.0708020945020.22591@blysk.ds.pg.gda.pl>
 <46B1D2F7.8000002@ru.mvista.com> <Pine.LNX.4.64N.0708021349040.22591@blysk.ds.pg.gda.pl>
 <46B1E716.6070807@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3847/Thu Aug  2 13:26:26 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 2 Aug 2007, Sergei Shtylyov wrote:

>    Yeah, that the format of type 1 cycles.

 Well, that is how it is presented to software on many systems.  The type 
1 cycle format actually differs a little bit, as the two least significant 
bits of the register number are passed to byte enables and when presented 
to the bus they are replaced with a fixed code that denotes the cycle 
type.

>    Unfortunately, Alchemy designers were too lazy to implement a simple
> translation scheme for type 0 cycles. They probably though that with 36-bit
> bus the may not limit themselves... :-)

 Yes, some people seem to think the abundance of resources exempts them 
from properly architecting their designs, sigh...

 On the other hand, the decision to identity-map the PCI config space in 
the physical address space of the processor rather than only making it 
accessible through a pair of an address and a data register was good IMO.

  Maciej
