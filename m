Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6IFJ6Rw001949
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 08:19:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6IFJ62q001948
	for linux-mips-outgoing; Thu, 18 Jul 2002 08:19:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6IFJ0Rw001938
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 08:19:01 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.11.6) with ESMTP id g6IFJYt24042;
	Thu, 18 Jul 2002 17:19:34 +0200
Received: (from karel@localhost)
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) id RAA18230;
	Thu, 18 Jul 2002 17:19:34 +0200 (MET DST)
From: Karel van Houten <karel@kpn.com>
Message-Id: <200207181519.RAA18230@sparta.research.kpn.com>
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card?
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Thu, 18 Jul 2002 17:19:33 +0200 (MET DST)
Cc: vhouten@kpn.com ("Houten K.H.C. van (Karel)"), linux-mips@oss.sgi.com
In-Reply-To: <Pine.GSO.3.96.1020718160853.14993C-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Jul 18, 2002 04:27:31 PM
X-Url: http://www-lsdm.research.kpn.com/~karel
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Maciej,

> 
>  It would be great if you could check if the driver works for the /200's
> onboard PMAZ-A.  If it worked there, I'd suspect a bug in the NCR53C8x
> support core.  But please don't put a second PMAZ-A into your /200 -- for
> an unclear reason the driver only supports a single I/O ASIC-based HBA and
> a single additional PMAZ-A board.  All PMAZ-A boards share operational
> variables with one another, so using more than a single one leads to data
> corruption.

I have a 5000/200 running fine with the same kernel (the one without
your patch). Or did you mean WITH your patch? The only problem
is that delo can't handle the different prom in the /200, so that
system has to boot over the network, but can use the local disks just fine.

Regards,
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
