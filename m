Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA90291 for <linux-archive@neteng.engr.sgi.com>; Sun, 13 Jun 1999 09:58:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA89260
	for linux-list;
	Sun, 13 Jun 1999 09:55:45 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA66271
	for <linux@engr.sgi.com>;
	Sun, 13 Jun 1999 09:55:42 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA02160
	for <linux@engr.sgi.com>; Sun, 13 Jun 1999 09:55:39 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-17.uni-koblenz.de [141.26.131.17])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id SAA13049
	for <linux@engr.sgi.com>; Sun, 13 Jun 1999 18:55:33 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id SAA11746;
	Sun, 13 Jun 1999 18:55:25 +0200
Date: Sun, 13 Jun 1999 18:55:23 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: CVS
Message-ID: <19990613185518.A11493@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've just commited Linux 2.2.8 into the CVS archive.  Once this is
finished I'll create a branch named linux_2_2 for the 2.2 development
in the archive.  If you just do ``cvs update'' you'll stay on the
mainline of the development, that is 2.3.  If you want to work with
the 2.2 sources then you'll have to add the option ``-r linux_2_2''
to your next cvs update or cvs co command.

I'm already running 2.2.9 and 2.3.1 on my Indy but the checkin is that
slow that I won't commit these versions into the CVS archive now.

  Ralf
