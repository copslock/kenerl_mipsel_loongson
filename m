Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA78353 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Mar 1999 08:14:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA22357
	for linux-list;
	Fri, 12 Mar 1999 08:14:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA47482
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 12 Mar 1999 08:13:59 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from vera.dpo.uab.edu (Vera.dpo.uab.edu [138.26.1.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA01985
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Mar 1999 11:13:54 -0500 (EST)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu by vera.dpo.uab.edu (LSMTP for Windows NT v1.1a) with SMTP id <0.05DF7F30@vera.dpo.uab.edu>; Fri, 12 Mar 1999 10:13:49 -0600
Date: Fri, 12 Mar 1999 09:59:59 -0600 (CST)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: darkaeon@cubicsky.com
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Indigo2 & Linux
In-Reply-To: <36E85AC2.25F7C9B0@kotetsu.cubicsky.com>
Message-ID: <Pine.LNX.3.96.990312095443.14950B-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Thu, 11 Mar 1999, Steve Martin wrote:
> I'm curious as to what the current progress is with Linux and the
> Indigo2(R4400SC 150Mhz Elan)
> Also, I remember hearing something about running Xsgi on Linux, has that
> been successfully(not stable, just enough to see it start up, maybe not
> usable) done yet?
> 
> --
> ..
> Steve Martin,
> Axial, http://www.cubicsky.com

Just as a quick note, to where I am on the Indigo2.  I have gotten it to
boot the kernel off of the network and start initializing devices.  It
will even send out packets over ethernet, but I do not have working
interrupts yet so it doesn't ever see any response.  For the most part, it
dies on "Trying to mount root filesystem".  I should have something
working not too long after I get some docs.

-Andrew  
