Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA43207 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Jun 1998 13:05:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA43745
	for linux-list;
	Wed, 10 Jun 1998 13:04:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA12608
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 10 Jun 1998 13:04:09 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id NAA12000
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Jun 1998 13:04:07 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id NAA14970
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Jun 1998 13:04:05 -0700 (PDT)
Received: from netscape.com ([205.217.243.67]) by dredd.mcom.com
          (Netscape Messaging Server 3.52)  with ESMTP id AAA5EC4;
          Wed, 10 Jun 1998 13:04:03 -0700
Message-ID: <357EE6C1.A424FC67@netscape.com>
Date: Wed, 10 Jun 1998 16:04:17 -0400
From: Mike Shaver <shaver@netscape.com>
Organization: Mozilla Dot Weenies
X-Mailer: Mozilla 4.1 [en] (X11; I; Linux 2.0.34 i686)
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>,
        Ulf Carlsson <grimsy@zigzegv.ml.org>, linux@cthulhu.engr.sgi.com
Subject: Re: cvs
References: <Pine.LNX.3.95.980609154442.12506E-100000@lager.engsoc.carleton.ca> <357DA057.AB9EF73B@netscape.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver wrote:
> I'll do that right now...

And I did (almost right away, even!).

cvs -d :pserver:cvs@linus.linux.sgi.com:/cvs login
(password is "cvs")
cvs -d :pserver:cvs@linus.linux.sgi.com:/cvs co linux

Although CVS doesn't appear to be honouring the CVSROOT/readers file,
:pserver: checkins don't succeed because there's no /var/tmp in the
chroot'd area.  Not optimal, but it keeps things safe for now.

Mike

-- 
190678.54 157843.71
