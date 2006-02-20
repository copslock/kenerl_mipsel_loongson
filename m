Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 16:51:52 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:5124 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133594AbWBTQvm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 16:51:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1DE33F5FA7;
	Mon, 20 Feb 2006 17:58:33 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23265-01; Mon, 20 Feb 2006 17:58:32 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B97F5F5965;
	Mon, 20 Feb 2006 17:58:32 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k1KGwW2r028783;
	Mon, 20 Feb 2006 17:58:32 +0100
Date:	Mon, 20 Feb 2006 16:58:37 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
In-Reply-To: <20060220142807.GM29098@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0602201633260.13723@blysk.ds.pg.gda.pl>
References: <20060219234318.GA16311@deprecation.cyrius.com>
 <20060219234757.GW10266@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
 <20060220142807.GM29098@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88/1293/Sun Feb 19 17:40:25 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 20 Feb 2006, Martin Michlmayr wrote:

> I disagree with you - it's obvious from the name of the config option
> (MTD_MS02NV) what the module will be called and people who compile
> their own kernels should know.  More importantly, no other description
> in this Kconfig file mentions anything like this.  However, since
> there seems to be no Kconfig "writing style", I guess it must as well
> be added.  But I guess the MTD folks removed it for a reason.

 I can't recall if I noticed it being removed and I have no idea who 
removed it and why.  I seem to have no access to the MTD CVS tree right 
now, so I can't check the history of the file.

> Still NAK, i.e. should I send the following patch to the MTD list, or
> ok to remove?

 Well, descriptions for some drivers mention how the module is going to be 
called and others do not.  I'd prefer too much information was available 
rather than too little.  I don't think people should be forced to chase 
Makefiles trying to determine module names.  I don't insist though -- I 
fear the driver has too few users to care. ;-)

  Maciej
