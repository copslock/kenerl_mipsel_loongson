Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA94698 for <linux-archive@neteng.engr.sgi.com>; Fri, 4 Jun 1999 13:01:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA54389
	for linux-list;
	Fri, 4 Jun 1999 12:58:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA20160
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 4 Jun 1999 12:58:16 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from vera.dpo.uab.edu (Vera.dpo.uab.edu [138.26.1.12]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA00859
	for <linux@cthulhu.engr.sgi.com>; Fri, 4 Jun 1999 12:58:14 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu by vera.dpo.uab.edu (LSMTP for Windows NT v1.1a) with SMTP id <0.AB12B880@vera.dpo.uab.edu>; Fri, 4 Jun 1999 14:58:13 -0500
Date: Fri, 4 Jun 1999 15:07:52 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Indigo2 patch
In-Reply-To: <Pine.LNX.3.96.990603145441.7770B-200000@mdk187.tucc.uab.edu>
Message-ID: <Pine.LNX.3.96.990604150413.11196B-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Thu, 3 Jun 1999, Andrew R. Baker wrote:
> 
> Here is the latest patch for the Indigo2, it looks good so far...
> Things still left to do:
> 	allow 8254 timer acks (it actually works on the Indigo2)
> 	clean up IRQ data structure
> 	enable 2nd SCSI controller
> 
> I am going to work on these once I get back from USENIX.	


BTW, with this patch, I have managed to successfully boot my Indigo2 and
have gone as far as installing hardhat on it.  It hasn't crashed so far,
even after I got it up to a load average of 164... ;)  However, I do
consistently get "signal 11" errors while trying to compile a kernel on
it.

Please beat it up as much as possible and let me know what I still need to
do.  ;)

-Andrew
