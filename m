Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id RAA03450
	for <pstadt@stud.fh-heilbronn.de>; Mon, 27 Sep 1999 17:33:00 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA04970; Mon, 27 Sep 1999 08:28:24 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA15506
	for linux-list;
	Mon, 27 Sep 1999 08:20:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA38925
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 27 Sep 1999 08:20:32 -0700 (PDT)
	mail_from (brett@madhouse.org)
Received: from caligula.madhouse.org ([216.160.90.69]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id IAA2786927
	for <linux@cthulhu.engr.sgi.com>; Mon, 27 Sep 1999 08:20:31 -0700 (PDT)
	mail_from (brett@madhouse.org)
Received: (qmail 7835 invoked by uid 509); 27 Sep 1999 15:26:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Sep 1999 15:26:02 -0000
Date: Mon, 27 Sep 1999 08:26:02 -0700 (PDT)
From: brett <brett@madhouse.org>
To: "Andrew R. Baker" <andrewb@uab.edu>
cc: Bob Pielock <bpielock@ulink.net>,
        "'linux@cthulhu.engr.sgi.com'" <linux@cthulhu.engr.sgi.com>
Subject: Re: Indigo 2 / Redhat 5.1
In-Reply-To: <Pine.LNX.3.96.990927081234.23905A-100000@mdk187.tucc.uab.edu>
Message-ID: <Pine.LNX.3.96.990927082459.7833A-100000@caligula.madhouse.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I think he was wondering about indigo boxes not indigo 2 boxes.  I know
they aren't supported currently (a shame considering that i have two under
my desk) but are there any plans to support them at all.

b

-----------------------------------------------
brett wagner	|	brett@madhouse.org
get committed!	|	http://www.madhouse.org
-----------------------------------------------

On Mon, 27 Sep 1999, Andrew R. Baker wrote:

> 
> You should have no problems getting the HardHat distrobution running on an
> Indigo2.  You might need to compile your own kernel from the CVS tree; I
> am not sure if any of the pre-compiled versions on www.linux.sgi.com have
> Indigo2 support in them.  However, there is currently no graphics support
> for the Indigo2 so you will need to use a serial console for installation.
> This also means there is no X support.
> 
> -Andrew
> 
> On Mon, 27 Sep 1999, Bob Pielock wrote:
> > Hi I have a few questions about installing Linux on an Indigo system.
> > First off, I was wondering if anyone has ever attempted this before, if so
> > please email me about any problems you may have had.
> > Second, if no one has, could someone suggest anyhting that might come
> > up durring the process of doing so? Right now my box is running
> > IRIX 6.2, and I was thinking about getting a second hard drive just
> > for the linux instalation, does anyone have a better way to dothis?
> > How well is GL supported in Linux? Will the X server start?
> 
> 
