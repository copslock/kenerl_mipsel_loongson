Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 21:14:50 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:53416 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S28578649AbYCUVOr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Mar 2008 21:14:47 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 2445F40075;
	Fri, 21 Mar 2008 22:14:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id Te7BMsomXMld; Fri, 21 Mar 2008 22:14:43 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 32E4B40165;
	Fri, 21 Mar 2008 22:14:43 +0100 (CET)
Received: by piorun.ds.pg.gda.pl (Postfix, from userid 2160)
	id D21BB177CF; Fri, 21 Mar 2008 22:14:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by piorun.ds.pg.gda.pl (Postfix) with ESMTP id CDC85177CE;
	Fri, 21 Mar 2008 21:14:42 +0000 (GMT)
Date:	Fri, 21 Mar 2008 21:14:42 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
X-X-Sender: macro@piorun
To:	Larry Stefani <lstefani@yahoo.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Extraneous line in interrupt.h in 2.6.16.60 kernel?
In-Reply-To: <582735.81620.qm@web38810.mail.mud.yahoo.com>
Message-ID: <alpine.SOC.1.00.0803212103040.3991@piorun>
References: <582735.81620.qm@web38810.mail.mud.yahoo.com>
User-Agent: Alpine 1.00 (SOC 882 2007-12-20)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Larry,

> Am I missing something, or is the second ".set 
> mips32r2  \n" (line 51) redundant?

 You are not missing anything, but it is harmless and the piece of code is 
gone in the current version.  Welcome to the world of MIPS, BTW. :-)

  Maciej
