Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA12950
	for <pstadt@stud.fh-heilbronn.de>; Thu, 30 Sep 1999 01:45:13 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA4215578; Wed, 29 Sep 1999 16:37:42 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA74941
	for linux-list;
	Wed, 29 Sep 1999 16:28:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA74726
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Sep 1999 16:28:42 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA4193193
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Sep 1999 16:28:37 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id SAA18981;
	Wed, 29 Sep 1999 18:02:13 -0500
Date: Wed, 29 Sep 1999 18:00:41 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Pete Young <pete@alien.bt.co.uk>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Latest versions of kernel, other tools
In-Reply-To: <m11WMIK-001kxeC@mail.alien.bt.co.uk>
Message-ID: <Pine.LNX.3.96.990929175856.27357B-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Wed, 29 Sep 1999, Pete Young wrote:
> Dear gurus,
> 
> I have an Indy which I set up back in May, running kernel version
> 2.2.1 (29th March 1999) . Hardhat Release 5.1 distribution.
> 
> I've just been looking around on ftp://ftp.linux.sgi.com/pub/ for
> a newer version with no success. Can someone tell me where I should
> be looking for updates, and also whether there are any packages which
> I should also update?  I seem to recall a message about binutils
> being significantly improved, is there anything else?
> 
> The latest version of the mailing list archive stops on July 25: if there
> have been any announcements after then, my memory has not been up to the job!

I think the current version is 2.2.12.  There is also a 2.3, but I don't
recall which revision.  They are all available from the CVS archive.  Use
the tag "linux_2_2" to get a 2.2 tree.  HTH

-Andrew 
