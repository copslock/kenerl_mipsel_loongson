Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA46485 for <linux-archive@neteng.engr.sgi.com>; Wed, 19 Aug 1998 17:09:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA80819
	for linux-list;
	Wed, 19 Aug 1998 17:08:33 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA29460
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Aug 1998 17:08:31 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de ([141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA24292
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Aug 1998 17:08:30 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-28.uni-koblenz.de [141.26.249.28])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA08261
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Aug 1998 02:08:28 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA00779;
	Thu, 20 Aug 1998 02:07:03 +0200
Message-ID: <19980820020702.B388@uni-koblenz.de>
Date: Thu, 20 Aug 1998 02:07:02 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>,
        Ulf Carlsson <grim@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: [PATCH] sc
References: <199808192003.WAA13671@calypso.saturn> <Pine.LNX.3.96.980819161628.4406D-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.980819161628.4406D-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Aug 19, 1998 at 04:16:52PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Aug 19, 1998 at 04:16:52PM -0400, Alex deVries wrote:

> If there's no objections from the MIPS kernel hackers here, I'll apply
> this to the CVS.

Don't, it wont work for non-SC CPUs.

  Ralf
