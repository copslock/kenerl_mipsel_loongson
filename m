Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id EAA13312
	for <pstadt@stud.fh-heilbronn.de>; Sat, 18 Sep 1999 04:16:39 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA08504; Fri, 17 Sep 1999 19:06:14 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA99388
	for linux-list;
	Fri, 17 Sep 1999 19:00:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [150.166.40.92])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA55000;
	Fri, 17 Sep 1999 19:00:32 -0700 (PDT)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id TAA03150;
	Fri, 17 Sep 1999 19:00:32 -0700
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From: "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14306.62016.387993.940148@liveoak.engr.sgi.com>
Date: Fri, 17 Sep 1999 19:00:32 -0700 (PDT)
To: Rory Hunter <roryh@dcs.ed.ac.uk>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: grumph
In-Reply-To: <37E2D941.4410F25@dcs.ed.ac.uk>
References: <37E2D941.4410F25@dcs.ed.ac.uk>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Rory Hunter writes:
 > Hi,
 > 
 > Please enlighten me, is it standard practice under
 > IRIX to have /bin as a symlink?

     Yes.  Since the standard IRIX installation combines root and /usr,
/bin points to /usr/bin and /usr/bin contains most of the usual
commands (or symlinks to commands) used by non-privileged users.
