Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA83216 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Jul 1998 18:18:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA48413
	for linux-list;
	Wed, 15 Jul 1998 18:17:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA30623
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Jul 1998 18:17:38 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA11190
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 18:17:36 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-01.uni-koblenz.de [141.26.249.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA28385
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 03:17:33 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA02046;
	Thu, 16 Jul 1998 02:56:59 +0200
Message-ID: <19980716025659.G388@uni-koblenz.de>
Date: Thu, 16 Jul 1998 02:56:59 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>, Dong Liu <dliu@npiww.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: libpthread of hard hat still doesn't work
References: <199807152348.TAA00114@pluto.npiww.com> <Pine.LNX.3.95.980715193313.22020K-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.95.980715193313.22020K-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Jul 15, 1998 at 07:33:24PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jul 15, 1998 at 07:33:24PM -0400, Alex deVries wrote:

> What were you doing to produce this error?

Alex, this problem is known and fixed in my home source tree.  There is
a second problem that prevents kernel threads from being used.  It's
that clone(3), the library wrapper for clone(2), the syscall, is buggy
and I haven't yet fixed that.

We'll provide updated packages for HH 5.1 with this and other things fixed.

  Ralf
