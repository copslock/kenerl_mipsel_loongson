Received:  by oss.sgi.com id <S305202AbQDBQuG>;
	Sun, 2 Apr 2000 09:50:06 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:52295 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQDBQto>;
	Sun, 2 Apr 2000 09:49:44 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA04930; Sun, 2 Apr 2000 09:45:02 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA50848
	for linux-list;
	Sun, 2 Apr 2000 09:41:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA01463
	for <linux@engr.sgi.com>;
	Sun, 2 Apr 2000 09:40:55 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA00383
	for <linux@engr.sgi.com>; Sun, 2 Apr 2000 09:40:48 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C2CE77DD; Sun,  2 Apr 2000 18:40:22 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1D6FD8FC3; Sun,  2 Apr 2000 18:28:33 +0200 (CEST)
Date:   Sun, 2 Apr 2000 18:28:33 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: debian mipsel port status
Message-ID: <20000402182833.C11880@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
i anounced today on the debian-mips list the compilation of the 1000st 
debian-mipsel binary package.

I wont post the full package list but i think  the debian people will setup
an apt-getable area within the next weeks.

Currently no X or gtk based packages are available due to lack of
XFree packages - I dont think ill port the debian 3.3.6 package
but ill start working on XFree4 the next days.

I havent set up an "debian autobuilder" but hopefully will do so 
the next weeks so we will have an up2date distribution all the time.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
