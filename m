Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA54129 for <linux-archive@neteng.engr.sgi.com>; Mon, 4 Jan 1999 08:41:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA79638
	for linux-list;
	Mon, 4 Jan 1999 08:39:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA69149
	for <linux@engr.sgi.com>;
	Mon, 4 Jan 1999 08:39:38 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA01166
	for <linux@engr.sgi.com>; Mon, 4 Jan 1999 08:39:27 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from eddie (ralf@eddie.uni-koblenz.de [141.26.4.17])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with SMTP id RAA08905;
	Mon, 4 Jan 1999 17:39:12 +0100 (MET)
Received: by eddie (SMI-8.6/KO-2.0)
	id RAA15300; Mon, 4 Jan 1999 17:39:08 +0100
Message-ID: <19990104173908.37809@uni-koblenz.de>
Date: Mon, 4 Jan 1999 17:39:08 +0100
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: CVS commit of 2.1.131/MIPS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I had a CVS-crash during my yesterday attempt of commiting Linux patches upto
2.1.131 into the CVS.  As a result both my working copy and the CVS archive
ended up in an ``interesting'' state.  This should be fixed by now;
everobody who did a checkout / upgrade during the last about 24h should now
run a ``cvs update -d -P''.  Sorry for the hazzle.

The G364 driver for the Magnum 4000 will need an update as the low level
interface for frame buffer drivers has changed, so at this time the ports
for Olivetti M700 / Magnum 4000 is broken.

  Ralf
