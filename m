Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA06862 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Sep 1998 09:11:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA95880
	for linux-list;
	Thu, 24 Sep 1998 09:10:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA82611
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 24 Sep 1998 09:10:46 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA05786
	for <linux@cthulhu.engr.sgi.com>; Thu, 24 Sep 1998 09:10:45 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id MAA25229;
	Thu, 24 Sep 1998 12:14:34 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 24 Sep 1998 12:14:34 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Rob Lembree <lembree@sgi.com>
cc: Richard Hartensveld <richardh@infopact.nl>, linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
In-Reply-To: <3608103B.6F2844E2@sgi.com>
Message-ID: <Pine.LNX.3.96.980924121402.20033B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 22 Sep 1998, Rob Lembree wrote:
> hmm, I had the same problem on my Indy.  I found that 
> IRIX had stripped the major and minor numbers from the
> device files in the tar distribution -- the answer was to
> untar using Linux, not IRIX (gtar doesn't help), or to 
> manually recreate the dev files.
> Try that, and I bet it fixes it.

You can also just recreate the block devices from within Irix.

- Alex
