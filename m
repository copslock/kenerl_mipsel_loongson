Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2005 11:59:22 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:42513 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3457227AbVLTL7E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Dec 2005 11:59:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id DF40CF59F7;
	Tue, 20 Dec 2005 13:00:04 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05337-08; Tue, 20 Dec 2005 13:00:04 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A1510F59F4;
	Tue, 20 Dec 2005 13:00:02 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id jBKBxutK014829;
	Tue, 20 Dec 2005 12:59:56 +0100
Date:	Tue, 20 Dec 2005 12:00:05 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix local_irq_save()/local_irq_restore() when
 CONFIG_CPU_MIPSR2 & CONFIG_IRQ_CPU
In-Reply-To: <1135056739.9874.95.camel@sakura.staff.proxad.net>
Message-ID: <Pine.LNX.4.64N.0512201153350.25567@blysk.ds.pg.gda.pl>
References: <1135056739.9874.95.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1213/Mon Dec 19 15:48:34 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 20 Dec 2005, Maxime Bizon wrote:

> But "flags" comes directly from di, which according to mips instruction
> set, saves whole status content, not just IE bit.
> 
> Attached patch to fix this.

 Or alternatively something like this: 
"http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.LNX.4.61L.0507121626370.14155%40blysk.ds.pg.gda.pl", 
for consistency with the other variants.  It looks like we are the only 
two who care...

  Maciej
