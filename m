Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 16:05:26 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:51413 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024112AbXJAPFS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 16:05:18 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 35997400A9;
	Mon,  1 Oct 2007 17:05:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id EO8orWgHOkgA; Mon,  1 Oct 2007 17:05:13 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 6E7E040040;
	Mon,  1 Oct 2007 17:05:13 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l91F5Hc0027231;
	Mon, 1 Oct 2007 17:05:17 +0200
Date:	Mon, 1 Oct 2007 16:05:11 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	linux-mips@linux-mips.org
Subject: Re: Using PCI bridges on sgi-ip32 [was: Re: Tests of 2.6.23-rc8 on
 SGI O2]
In-Reply-To: <1191141276.7160.44.camel@scarafaggio>
Message-ID: <Pine.LNX.4.64N.0710011559410.27280@blysk.ds.pg.gda.pl>
References: <1190973427.11251.17.camel@scarafaggio> <1191141276.7160.44.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4445/Mon Oct  1 10:32:46 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 30 Sep 2007, Giuseppe Sacco wrote:

> So, should I debug the PCI controller for ip32 (MACE)? What could be the
> problem here? Should I report this kind of problem to a different
> mailing list?

 I suggest you rebuild with CONFIG_PCI_DEBUG enabled and if you are unable 
to deduce the reason from the resulting verbose bootstrap log, then send 
it here so that others may have a look.

  Maciej
