Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id UAA24310
	for <pstadt@stud.fh-heilbronn.de>; Wed, 4 Aug 1999 20:43:26 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02201; Wed, 4 Aug 1999 11:35:05 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA90496
	for linux-list;
	Wed, 4 Aug 1999 11:30:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA31210
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 4 Aug 1999 11:29:51 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from ruvild.bun.falkenberg.se (ruvild.bun.falkenberg.se [194.236.80.7]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA09321
	for <linux@cthulhu.engr.sgi.com>; Wed, 4 Aug 1999 11:29:49 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m11C5nv-00159XC@ruvild.bun.falkenberg.se> (Debian Smail3.2.0.102)
	for linux@cthulhu.engr.sgi.com; Wed, 4 Aug 1999 20:30:19 +0200 (CEST) 
Date: Wed, 4 Aug 1999 20:30:19 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Mike Hill <mikehill@hgeng.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Floptical Drive
Message-ID: <19990804203018.A6702@thepuffingroup.com>
References: <E138DB347D10D3119C630008C79F5DEC07EB75@BART>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <E138DB347D10D3119C630008C79F5DEC07EB75@BART>; from Mike Hill on Wed, Aug 04, 1999 at 02:03:18PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> When I try to add msdos or vfat filesystem support to the kernel (latest
> CVS) I get the following failure:

Linus broke all filesystems some time ago, this is not MIPS specific.

Try the 2.2 kernel instead, I think they should be ok.

Ulf
