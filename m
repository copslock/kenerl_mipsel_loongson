Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id SAA20652
	for <pstadt@stud.fh-heilbronn.de>; Thu, 8 Jul 1999 18:52:10 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA4947568; Thu, 8 Jul 1999 09:46:55 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA44181
	for linux-list;
	Thu, 8 Jul 1999 09:40:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA46724
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 8 Jul 1999 09:40:11 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA00199
	for <linux@cthulhu.engr.sgi.com>; Thu, 8 Jul 1999 09:40:09 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id LAA09120;
	Thu, 8 Jul 1999 11:40:06 -0500
Date: Thu, 8 Jul 1999 11:50:22 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Nate Pearlstein <npearl@clubfed.sgi.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: challenge s install woes.
In-Reply-To: <3784C234.F6500BC6@clubfed.sgi.com>
Message-ID: <Pine.LNX.3.96.990708114826.21657A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Thu, 8 Jul 1999, Nate Pearlstein wrote:
> 
> I tried to boot using the installfs as the root file system but it
> immediately launches the install program, I'm trying to use the nfsroot
> to get at my /dev/sdb1 so that I can remove the /etc/securettys file.
> 

in the /sbin directory on the nfsroot area, do a "cp sh init".  This will
install ash as the init program.  

-Andrew
