Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id PAA14298
	for <pstadt@stud.fh-heilbronn.de>; Mon, 27 Sep 1999 15:25:45 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA20360; Mon, 27 Sep 1999 06:22:10 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA83546
	for linux-list;
	Mon, 27 Sep 1999 06:16:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA97621
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 27 Sep 1999 06:16:53 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA2879197
	for <linux@cthulhu.engr.sgi.com>; Mon, 27 Sep 1999 06:16:52 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id IAA27212;
	Mon, 27 Sep 1999 08:16:48 -0500
Date: Mon, 27 Sep 1999 08:15:13 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Bob Pielock <bpielock@ulink.net>
cc: "'linux@cthulhu.engr.sgi.com'" <linux@cthulhu.engr.sgi.com>
Subject: Re: Indigo 2 / Redhat 5.1
In-Reply-To: <07E3A5CCB88FD2119A6E0000F83098114774E9@dragon.ulink.net>
Message-ID: <Pine.LNX.3.96.990927081234.23905A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


You should have no problems getting the HardHat distrobution running on an
Indigo2.  You might need to compile your own kernel from the CVS tree; I
am not sure if any of the pre-compiled versions on www.linux.sgi.com have
Indigo2 support in them.  However, there is currently no graphics support
for the Indigo2 so you will need to use a serial console for installation.
This also means there is no X support.

-Andrew

On Mon, 27 Sep 1999, Bob Pielock wrote:
> Hi I have a few questions about installing Linux on an Indigo system.
> First off, I was wondering if anyone has ever attempted this before, if so
> please email me about any problems you may have had.
> Second, if no one has, could someone suggest anyhting that might come
> up durring the process of doing so? Right now my box is running
> IRIX 6.2, and I was thinking about getting a second hard drive just
> for the linux instalation, does anyone have a better way to dothis?
> How well is GL supported in Linux? Will the X server start?
