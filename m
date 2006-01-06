Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 11:49:32 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:30995 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133571AbWAFLtP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jan 2006 11:49:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6A3B0E1C9B;
	Fri,  6 Jan 2006 12:51:54 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04961-05; Fri,  6 Jan 2006 12:51:54 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 27997E1C81;
	Fri,  6 Jan 2006 12:51:54 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k06Bplme002297;
	Fri, 6 Jan 2006 12:51:47 +0100
Date:	Fri, 6 Jan 2006 11:51:56 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alex Gonzalez <langabe@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Jump/branch to external symbol
In-Reply-To: <c58a7a270601060241u765acb76s61bb30d443c420f1@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0601061147540.25759@blysk.ds.pg.gda.pl>
References: <c58a7a270601060241u765acb76s61bb30d443c420f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1231/Thu Jan  5 23:51:25 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 6 Jan 2006, Alex Gonzalez wrote:

> I am happy with the patch for binutils-2.15, and I would need a
> solution for binutils-2.13.
> 
> Can anybody offer any help?

 Well, the most obvious solution is upgrading to the current release, 
which is 2.16.1 now.  Otherwise you are probably on your own -- 2.15 is 
already somewhat old and 2.13 is ancient.

  Maciej
