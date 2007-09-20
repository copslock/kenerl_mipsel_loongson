Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 15:23:53 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:24260 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021935AbXITOXo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 15:23:44 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 94C4740090;
	Thu, 20 Sep 2007 16:23:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id e2wMlS79q26C; Thu, 20 Sep 2007 16:23:07 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id DAB1F400C9;
	Thu, 20 Sep 2007 16:23:05 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8KEN8U9013297;
	Thu, 20 Sep 2007 16:23:09 +0200
Date:	Thu, 20 Sep 2007 15:23:03 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jeff Garzik <jgarzik@pobox.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac.c: De-typedef, de-volatile, de-etc...
In-Reply-To: <46F1F2CE.7020300@pobox.com>
Message-ID: <Pine.LNX.4.64N.0709201354320.30788@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709101310030.25038@blysk.ds.pg.gda.pl>
 <46E8B56E.7060705@pobox.com> <Pine.LNX.4.64N.0709131506040.31069@blysk.ds.pg.gda.pl>
 <20070913151452.GB29665@linux-mips.org> <46E95C7F.1050302@pobox.com>
 <Pine.LNX.4.64N.0709141135290.1926@blysk.ds.pg.gda.pl> <46F1F2CE.7020300@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4353/Thu Sep 20 15:47:16 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 20 Sep 2007, Jeff Garzik wrote:

> > You may be pleased (or less so) to hear that the version of sb1250-mac.c in
> > your tree does not even build (because of
> > 42d53d6be113f974d8152979c88e1061b953bd12) and the patch below does not
> > address it.  I ran out of time in the evening, but I will send you a fix
> > shortly.  To be honest I think even with bulk changes it may be worth
> > checking whether they do not break stuff. ;-)
> 
> hrm.  I cannot get this to apply on top of linux-2.6.git,
> netdev-2.6.git#upstream (prior to net-2.6.24 rebase) or
> netdev-2.6.git#upstream (after net-2.6.24 rebase)

 It applies on top of current -mm.  It seems to apply to a copy of 
netdev-2.6.git#upstream that I have got, but I am probably missing 
something...  If I try to clone your repository again I get:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/linux-netdev-2.6.git linux
Initialized empty Git repository in /home/macro/GIT-other/linux-netdev/linux/.git/
fatal: The remote end hung up unexpectedly
fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/linux-netdev-2.6.git' failed.
$

For linux-2.6.git the patch-mips-2.6.23-rc5-20070904-sb1250-mac-typedef-7 
version applies as submitted originally; I can resubmit this one if you 
like.

 I am slowly getting lost and I have another big chunk for sb1250-mac.c 
waiting to be put on top of these...

  Maciej
