Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id QAA08913
	for <pstadt@stud.fh-heilbronn.de>; Mon, 23 Aug 1999 16:47:43 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA03120; Mon, 23 Aug 1999 07:44:50 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA77493
	for linux-list;
	Mon, 23 Aug 1999 07:38:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA06680
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 23 Aug 1999 07:38:14 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA00351
	for <linux@cthulhu.engr.sgi.com>; Mon, 23 Aug 1999 07:38:13 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id JAA31771;
	Mon, 23 Aug 1999 09:38:09 -0500
Date: Mon, 23 Aug 1999 09:35:57 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Bill Bradford <mrbill@frenzy.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Indigo2 status?
In-Reply-To: <19990821193536.A16860@frenzy.com>
Message-ID: <Pine.LNX.3.96.990823092957.20918A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Sat, 21 Aug 1999, Bill Bradford wrote:
> Has anyone heard anything about the status of SGI Linux on an Indigo2?
> I've got this box here with 128mb and Extreme graphics, and am wishing
> I could fire up Linux on it....

Well, you won't be able to use your graphics card yet, but you can still
get it up and running.  Set yourself up with a serial console, and follow
the installation instructions on http://www.linux.sgi.com/ and off you go.
You'll probably want to build your own kernel from the CVS arvhive, as it
will have more recent changes.  Support for the (E)ISA bus should be
coming along sometime this week.

-Andrew
