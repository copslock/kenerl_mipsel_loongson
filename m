Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA65674 for <linux-archive@neteng.engr.sgi.com>; Mon, 29 Jun 1998 03:47:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA51097
	for linux-list;
	Mon, 29 Jun 1998 03:47:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA05229
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 29 Jun 1998 03:47:12 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de ([141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA07548
	for <linux@cthulhu.engr.sgi.com>; Mon, 29 Jun 1998 03:47:02 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA05957
	for <linux@cthulhu.engr.sgi.com>; Mon, 29 Jun 1998 12:46:52 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id MAA01248;
	Mon, 29 Jun 1998 12:46:15 +0200
Message-ID: <19980629124615.A422@uni-koblenz.de>
Date: Mon, 29 Jun 1998 12:46:15 +0200
To: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>,
        linux@cthulhu.engr.sgi.com
Subject: Re: hmmmm.... nice job!!
References: <19980629205224.A1023@life.nthu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980629205224.A1023@life.nthu.edu.tw>; from Francis M. J. Hsieh on Mon, Jun 29, 1998 at 08:52:24PM +0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jun 29, 1998 at 08:52:24PM +0800, Francis M. J. Hsieh wrote:

> I just installed this nice/impressive OS in our indy, the network speed
> is faster than it is on irix6.2.

[makes a notch into his Indy's keyboard ...]

>  - possible no sound support (beep ?)

Yes, that's still missing and as far as just the equivalent of the
PC beeper is affected I'd call it a feature ;-)

>  - (sometimes) a strange garbage image, about 1 character size in the
>    lowerleft corner of the screen

Yes, and there are some more artefacts in the console code, aside of it's
afully slow speed.  As Alan already mentioned it's time to reimplement the
console code for the Indy, this time based on abscon.  And just yesterday
Thomas who already did the abscon support for the G364 board (Magnum 4000),
volunteered to implement this for the Newport.

  Ralf
