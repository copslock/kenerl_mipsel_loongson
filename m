Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id UAA07731
	for <pstadt@stud.fh-heilbronn.de>; Thu, 8 Jul 1999 20:56:33 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA06295; Thu, 8 Jul 1999 11:50:05 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA89963
	for linux-list;
	Thu, 8 Jul 1999 11:46:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA43986
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 8 Jul 1999 11:46:48 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA04369
	for <linux@cthulhu.engr.sgi.com>; Thu, 8 Jul 1999 11:46:46 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id NAA28270;
	Thu, 8 Jul 1999 13:46:35 -0500
Date: Thu, 8 Jul 1999 13:56:50 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Bill Bradford <mrbill@frenzy.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Indigo2 status?
In-Reply-To: <19990708120428.A5358@frenzy.com>
Message-ID: <Pine.LNX.3.96.990708135430.21839A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Thu, 8 Jul 1999, Bill Bradford wrote:
> Has there been any progress on the Indigo2 port?

The CVS tree now has support for it.  Most recently, support for the
second SCSI controller has been added.  Graphics support is still
non-existent.  (Use a serial console for initial setup.)  

-Andrew
