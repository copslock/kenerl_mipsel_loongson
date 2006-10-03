Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 16:16:35 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:12037 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038706AbWJCPQc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 16:16:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 13420F62CC;
	Tue,  3 Oct 2006 17:16:28 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i91M76rkR9YG; Tue,  3 Oct 2006 17:16:27 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id C2374F5BB4;
	Tue,  3 Oct 2006 17:16:27 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k93FGZEr004033;
	Tue, 3 Oct 2006 17:16:35 +0200
Date:	Tue, 3 Oct 2006 16:16:30 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	linux-mips@linux-mips.org
Subject: Re: [RFC] setup.c: get ride of CPHYSADDR()
In-Reply-To: <45227762.8090207@innova-card.com>
Message-ID: <Pine.LNX.4.64N.0610031614550.4642@blysk.ds.pg.gda.pl>
References: <45227762.8090207@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1984/Tue Oct  3 12:01:28 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Franck,

> The following patch is an attempt to remove this macro in setup.c.
> I'm not sure about why sometimes it is used and sometimes it is
> not. By sending this RFC, I hope to get some feedbacks that will shed
> some light on this obscure macro...
> 
> The reason why I'm trying to kick out this macro is that we should
> rely on __pa() for address convertions instead of having several
> helpers that do the same thing but differently. Futermore if some
> tricks are needed for these conversions, they should be done in
> one place.

 Have you verified it works correctly for 64-bit kernels linked at a KSEG0 
address?

  Maciej
