Received:  by oss.sgi.com id <S305172AbQCGE3w>;
	Mon, 6 Mar 2000 20:29:52 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:54909 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305162AbQCGE3a>; Mon, 6 Mar 2000 20:29:30 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id UAA07960; Mon, 6 Mar 2000 20:32:44 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA46930
	for linux-list;
	Mon, 6 Mar 2000 20:12:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA37755
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Mar 2000 20:12:26 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA06911
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Mar 2000 20:12:25 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lithium (lithium.tucc.uab.edu [138.26.15.219])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id WAA11556;
	Mon, 6 Mar 2000 22:12:24 -0600
Date:   Mon, 6 Mar 2000 22:12:24 -0600 (CST)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@lithium
To:     Linux SGI <linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: FP emulation patch available
Message-ID: <Pine.LNX.3.96.1000306220330.12659B-100000@lithium>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


I have made a patch against the 2.2.13 CVS kernel from the patch that
Kevin Kissell (sp?) put out earlier.  This patch is a subset of Kevin's
patch.  It includes the following pieces:

1) FPU emulation support
2) removal of the MIPS instruction bitfields (replaced with macros)
3) mips_cpu stucture and C based cpu identification

I think a gdb segment snuck in there too.

The patch is available at:
http://www.dpo.uab.edu/~andrewb/2.2.diff.2000.03.06

Could interested parties please look at it and provide more testing than
me and my Indigo2.  My next goal is to intergrate the FP unimplemented
exception code into the FPU emulation framework.  I then shall see about
moving it all to 2.3 (I may move parts sooner if necessary).  

Comments appreciated,

Andrew

P.S.  Ralf & others, since I keep changing desktop machines I do not
believe I have submit access to CVS anymore.  If this patch is
satisfactory, could one of you submit it to the archive for me?
