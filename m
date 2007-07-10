Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 15:37:33 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:16390 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021625AbXGJOha (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jul 2007 15:37:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 37463E1C69;
	Tue, 10 Jul 2007 16:37:26 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8bNPRPP0pLOn; Tue, 10 Jul 2007 16:37:26 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E24ECE1C65;
	Tue, 10 Jul 2007 16:37:25 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6AEbWuZ025807;
	Tue, 10 Jul 2007 16:37:32 +0200
Date:	Tue, 10 Jul 2007 15:37:30 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] DEC: Fix modpost warning.
In-Reply-To: <20070710130409.GA14723@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0707101524490.18036@blysk.ds.pg.gda.pl>
References: <S20022577AbXGJLug/20070710115036Z+13637@ftp.linux-mips.org>
 <Pine.LNX.4.64N.0707101401001.18036@blysk.ds.pg.gda.pl>
 <20070710130409.GA14723@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3621/Tue Jul 10 15:01:04 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 10 Jul 2007, Ralf Baechle wrote:

> >  It looks like a bogus warning -- I presume it comes from a reference from 
> > "sercons" to serial_console_setup() -- but the driver is going away, so I 
> > could not care less...
> 
> Yes, the root cause was the reference to serial_console_setup.  It's hard
> to teach modpost that this reference is bogus so I fixed the driver instead.
> Other console drivers had the same issue.

 I would not call this change a fix -- the cure is worse than the disease.

 We should maintain a table of references to ignore for modpost then.  It 
should be discarded together with other init data and given the number of 
such references it would be rather minuscule compared to code held in 
memory unnecessarily throughout the boot cycle of the system just to 
satisfy a debugging tool.  Which is a very useful one, no doubt, but 
please do not forget about the common sense.

  Maciej
