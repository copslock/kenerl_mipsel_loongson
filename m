Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA79284 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Jul 1998 08:59:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA84097
	for linux-list;
	Thu, 2 Jul 1998 08:59:12 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA85888
	for <linux@engr.sgi.com>;
	Thu, 2 Jul 1998 08:59:08 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA10994
	for <linux@engr.sgi.com>; Thu, 2 Jul 1998 08:59:04 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@dali.uni-koblenz.de [141.26.5.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id RAA23124
	for <linux@engr.sgi.com>; Thu, 2 Jul 1998 17:58:57 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id RAA00707;
	Thu, 2 Jul 1998 17:58:33 +0200
Message-ID: <19980702175832.A637@uni-koblenz.de>
Date: Thu, 2 Jul 1998 17:58:32 +0200
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, linux-kernel@vger.rutgers.edu
Subject: MIPS kernel patch, source and binary rpms.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I'm currently uploading a kernel patch which fixes the reported corruption
of rlogin and http sessions, source rpms of XFree, egcs, gcc and joe,
a big pile of big endian "mipseb" rpms and a small pile of little endian
"mipsel" and "noarch" rpms.

People with an account on linus.linux.sgi.com can get the stuff from
~ralf/for-alex/, before we move them online for anonymous ftp on
ftp.linux.sgi.com.  During the next hours you'll also be able to get
them from dali.uni-koblenz.de via anon ftp.

Don't look to hard at the kernel patch, it's not nice at all to our
benchmarks but at least it is correct - I just didn't have more than a
couple of minutes to hack, compile and test it since Linux hacking has
lower priority than all my real live duties like job, uni etc. :-(

Happy hacking,

  Ralf
