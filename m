Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA74758 for <linux-archive@neteng.engr.sgi.com>; Wed, 28 Apr 1999 10:42:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA85111
	for linux-list;
	Wed, 28 Apr 1999 10:41:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA00771
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 28 Apr 1999 10:41:33 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03164
	for <linux@cthulhu.engr.sgi.com>; Wed, 28 Apr 1999 13:41:32 -0400 (EDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA29453;
	Wed, 28 Apr 1999 13:42:23 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 28 Apr 1999 13:42:22 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Chris Pezzee <cpezzee@microsoft.com>
cc: "'linux@engr.sgi.com'" <linux@cthulhu.engr.sgi.com>
Subject: Re: using ec3 on a Challenge S
In-Reply-To: <BB61526CDE70D2119D0F00805FBECA2F664CBA@RED-MSG-55>
Message-ID: <Pine.LNX.3.96.990428133838.9204B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 28 Apr 1999, Chris Pezzee wrote:
> The situation:
>   I inherited 20+  SGI Challenge S machines that I would like to use for 
>   web test clients and/or DIPC personal projects.  I would like to use
>   the second Ethernet port (ec3 in Irix) for something other than dust
>   collection.  I've read the list-archive, and there was a brief mention
>   of adding some probing code to the driver but that was all.
> 
> What I'd like to know:
>   Is anyone working on this right now?

I'm reasonably sure that nobody has started.

>   If not, I'd love to try to get this working, but I haven't done any driver
> work before, 
>   so where's a good place to start?

You should probably try to figure out where on the GIO64 that is located,
it shouldn't be too difficult with some guidance from folks at SGI.  What
ethernet controller is on there exactly?

At some point I was going to inherit such a card for my Indy (which would
replace my Newport temporarily), but I never got the card, and have been
busy with other things.  I wouldn't mind looking at this though.

- Alex
