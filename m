Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA10497 for <linux-archive@neteng.engr.sgi.com>; Sun, 13 Jun 1999 14:11:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA34400
	for linux-list;
	Sun, 13 Jun 1999 14:10:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA79467
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 13 Jun 1999 14:10:41 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA03606
	for <linux@cthulhu.engr.sgi.com>; Sun, 13 Jun 1999 14:10:31 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-9.uni-koblenz.de [141.26.131.9])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA20497
	for <linux@cthulhu.engr.sgi.com>; Sun, 13 Jun 1999 23:10:24 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA28218;
	Sun, 13 Jun 1999 23:10:13 +0200
Date: Sun, 13 Jun 1999 23:10:13 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: CVS
Message-ID: <19990613231013.C11493@uni-koblenz.de>
References: <19990613185518.A11493@uni-koblenz.de> <19990613203140.A8276@thepuffingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990613203140.A8276@thepuffingroup.com>; from Ulf Carlsson on Sun, Jun 13, 1999 at 08:31:40PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jun 13, 1999 at 08:31:40PM +0200, Ulf Carlsson wrote:

> On Sun, Jun 13, 1999 at 06:55:23PM +0200, Ralf Baechle wrote:
> > I've just commited Linux 2.2.8 into the CVS archive.  Once this is
> > finished I'll create a branch named linux_2_2 for the 2.2 development
> > in the archive.  If you just do ``cvs update'' you'll stay on the
> > mainline of the development, that is 2.3.  If you want to work with
> > the 2.2 sources then you'll have to add the option ``-r linux_2_2''
> > to your next cvs update or cvs co command.
> > 
> > I'm already running 2.2.9 and 2.3.1 on my Indy but the checkin is that
> > slow that I won't commit these versions into the CVS archive now.
> 
> I would appreciate if it was possible to continue using 32 bit code on the Indy,
> even if you add 64 bit code. Maybe we can add it as an option in the kernel
> configuration scripts?

I'll implement MIPS64 as a new architecture just like sparc64 is different
from sparc.  The changes are too big and I finally want to use the
freedem to use all the tricks in the box.  It also means that we'll have
some more of a maintenance pain for the common code for mips and mips64.

  Ralf
