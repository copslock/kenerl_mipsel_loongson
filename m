Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 16:20:49 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:5566 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024841AbXLJQUl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 16:20:41 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id A7085400CE;
	Mon, 10 Dec 2007 17:20:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id b97+h1i+5GXe; Mon, 10 Dec 2007 17:20:34 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 177DA4008C;
	Mon, 10 Dec 2007 17:20:34 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lBAGKc3m006957;
	Mon, 10 Dec 2007 17:20:38 +0100
Date:	Mon, 10 Dec 2007 16:20:27 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Kaz Kylheku <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
Subject: Re: SiByte 1480 & Branch Likely instructions?
In-Reply-To: <20071210153523.GA19384@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0712101614340.1177@blysk.ds.pg.gda.pl>
References: <DDFD17CC94A9BD49A82147DDF7D545C5590CF0@exchange.ZeugmaSystems.local>
 <20071209051450.GA18181@linux-mips.org> <Pine.LNX.4.64N.0712101522100.1177@blysk.ds.pg.gda.pl>
 <20071210153523.GA19384@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/5077/Mon Dec 10 14:59:40 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 10 Dec 2007, Ralf Baechle wrote:

> It would devastate the performance of some binaries.

 I think this is what the deprecation is about. ;-)

> As an intellectual challenge, how far can you strip down a MIPS
> implementation and emulate removed instructions in the kernel ;-)

 Well, going back to MIPS I is certainly achievable (OK, we could keep 
ll/sc for the sake of sanity) and then perhaps a little bit further.  
After all, all of the ALU ops can be done with the NOR op only. ;-)

  Maciej
