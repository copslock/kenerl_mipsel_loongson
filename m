Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5FJ6Mt26623
	for linux-mips-outgoing; Fri, 15 Jun 2001 12:06:22 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5FJ6Lk26620
	for <linux-mips@oss.sgi.com>; Fri, 15 Jun 2001 12:06:21 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 413017D9; Fri, 15 Jun 2001 21:06:20 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D2D7C42FF; Fri, 15 Jun 2001 21:04:33 +0200 (CEST)
Date: Fri, 15 Jun 2001 21:04:33 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: 2.4.5 in cvs - Did anyone try ?
Message-ID: <20010615210433.A4282@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,
i am  just trying 2.4.5 on an Indy and i have no luck. The kernel
gets confused very fast on the root ext2 filesystem the 2.4.3 continues
to boot from. It is spitting our "EXT2: Bit already set for inode x"
and hangs in a tight loop.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
